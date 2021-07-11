import React from "react";
import { PanoptesClusterStatsProvider } from "./panoptesClusterStats";

type Props = { children: React.ReactNode };
export function StatsProvider({ children }: Props) {
  return <PanoptesClusterStatsProvider>{children}</PanoptesClusterStatsProvider>;
}
