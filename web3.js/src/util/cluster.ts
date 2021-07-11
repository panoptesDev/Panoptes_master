const endpoint = {
  http: {
    devnet: 'http://api.devnet.panoptes.com',
    testnet: 'http://api.testnet.panoptes.com',
    'mainnet-beta': 'http://api.mainnet-beta.panoptes.com',
  },
  https: {
    devnet: 'https://api.devnet.panoptes.com',
    testnet: 'https://api.testnet.panoptes.com',
    'mainnet-beta': 'https://api.mainnet-beta.panoptes.com',
  },
};

export type Cluster = 'devnet' | 'testnet' | 'mainnet-beta';

/**
 * Retrieves the RPC API URL for the specified cluster
 */
export function clusterApiUrl(cluster?: Cluster, tls?: boolean): string {
  const key = tls === false ? 'http' : 'https';

  if (!cluster) {
    return endpoint[key]['devnet'];
  }

  const url = endpoint[key][cluster];
  if (!url) {
    throw new Error(`Unknown ${key} cluster: ${cluster}`);
  }
  return url;
}
