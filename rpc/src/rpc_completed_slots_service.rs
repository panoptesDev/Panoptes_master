use {
    crate::rpc_subscriptions::RpcSubscriptions,
    panoptes_client::rpc_response::SlotUpdate,
    panoptes_ledger::blockstore::CompletedSlotsReceiver,
    panoptes_sdk::timing::timestamp,
    std::{
        sync::Arc,
        thread::{Builder, JoinHandle},
    },
};

pub struct RpcCompletedSlotsService;
impl RpcCompletedSlotsService {
    pub fn spawn(
        completed_slots_receiver: CompletedSlotsReceiver,
        rpc_subscriptions: Option<Arc<RpcSubscriptions>>,
    ) -> Option<JoinHandle<()>> {
        let rpc_subscriptions = rpc_subscriptions?;
        Some(
            Builder::new()
                .name("panoptes-rpc-completed-slots-service".to_string())
                .spawn(move || {
                    for slots in completed_slots_receiver.iter() {
                        for slot in slots {
                            rpc_subscriptions.notify_slot_update(SlotUpdate::Completed {
                                slot,
                                timestamp: timestamp(),
                            });
                        }
                    }
                })
                .unwrap(),
        )
    }
}
