import React from "react";
import { Cluster, useCluster } from "providers/cluster";
import * as Cache from "providers/cache";
import { Connection, InflationReward, PublicKey } from "@panoptes/web3.js";
import { ActionType } from "providers/block";
import { FetchStatus } from "providers/cache";
import { reportError } from "utils/sentry";

const PAGE_SIZE = 15;

export type Rewards = {
  highestFetchedEpoch?: number;
  lowestFetchedEpoch?: number;
  rewards: (InflationReward | null)[];
  foundOldest?: boolean;
};

export type RewardsUpdate = {
  rewards: (InflationReward | null)[];
  foundOldest?: boolean;
};

type State = Cache.State<Rewards>;
type Dispatch = Cache.Dispatch<RewardsUpdate>;

function reconcile(
  rewards: Rewards | undefined,
  update: RewardsUpdate | undefined
): Rewards | undefined {
  if (update === undefined) {
    return rewards;
  }

  const combined = (rewards?.rewards || [])
    .concat(update.rewards)
    .filter((value) => value !== null);

  const foundOldest = update.foundOldest;

  return {
    rewards: combined,
    highestFetchedEpoch: combined[0]?.epoch,
    lowestFetchedEpoch: combined[combined.length - 1]?.epoch,
    foundOldest,
  };
}

export const StateContext = React.createContext<State | undefined>(undefined);
export const DispatchContext =
  React.createContext<Dispatch | undefined>(undefined);

type RewardsProviderProps = { children: React.ReactNode };

export function RewardsProvider({ children }: RewardsProviderProps) {
  const { url } = useCluster();
  const [state, dispatch] = Cache.useCustomReducer(url, reconcile);

  React.useEffect(() => {
    dispatch({ type: ActionType.Clear, url });
  }, [dispatch, url]);

  return (
    <StateContext.Provider value={state}>
      <DispatchContext.Provider value={dispatch}>
        {children}
      </DispatchContext.Provider>
    </StateContext.Provider>
  );
}

async function fetchRewards(
  dispatch: Dispatch,
  pubkey: PublicKey,
  cluster: Cluster,
  url: string,
  fromEpoch?: number,
  highestEpoch?: number
) {
  dispatch({
    type: ActionType.Update,
    status: FetchStatus.Fetching,
    key: pubkey.toBase58(),
    url,
  });

  const connection = new Connection(url);

  if (!fromEpoch && highestEpoch) {
    fromEpoch = highestEpoch;
  }

  if (!fromEpoch) {
    try {
      const epochInfo = await connection.getEpochInfo();
      fromEpoch = epochInfo.epoch - 1;
    } catch (error) {
      if (cluster !== Cluster.Custom) {
        reportError(error, { url });
      }

      return dispatch({
        type: ActionType.Update,
        status: FetchStatus.FetchFailed,
        key: pubkey.toBase58(),
        url,
      });
    }
  }

  const getInflationReward = async (epoch: number) => {
    try {
      const result = await connection.getInflationReward([pubkey], epoch);
      return result[0];
    } catch (error) {
      if (cluster !== Cluster.Custom) {
        reportError(error, { url });
      }
    }
    return null;
  };

  const requests = [];
  for (let i: number = fromEpoch; i > fromEpoch - PAGE_SIZE; i--) {
    if (i >= 0) {
      requests.push(getInflationReward(i));
    }
  }

  const results = await Promise.all(requests);
  fromEpoch = fromEpoch - requests.length;

  dispatch({
    type: ActionType.Update,
    url,
    key: pubkey.toBase58(),
    status: FetchStatus.Fetched,
    data: {
      rewards: results || [],
      foundOldest: fromEpoch <= 0,
    },
  });
}

export function useRewards(
  address: string
): Cache.CacheEntry<Rewards> | undefined {
  const context = React.useContext(StateContext);

  if (!context) {
    throw new Error(`useRewards must be used within a AccountsProvider`);
  }

  return context.entries[address];
}

export function useFetchRewards() {
  const { cluster, url } = useCluster();
  const state = React.useContext(StateContext);
  const dispatch = React.useContext(DispatchContext);

  if (!state || !dispatch) {
    throw new Error(`useFetchRewards must be used within a AccountsProvider`);
  }

  return React.useCallback(
    (pubkey: PublicKey, highestEpoch?: number) => {
      const before = state.entries[pubkey.toBase58()];
      if (before?.data) {
        fetchRewards(
          dispatch,
          pubkey,
          cluster,
          url,
          before.data.lowestFetchedEpoch
            ? before.data.lowestFetchedEpoch - 1
            : undefined,
          highestEpoch
        );
      } else {
        fetchRewards(dispatch, pubkey, cluster, url, undefined, highestEpoch);
      }
    },
    [state, dispatch, cluster, url]
  );
}