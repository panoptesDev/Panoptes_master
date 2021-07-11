panoptes_sdk::declare_builtin!(
    panoptes_sdk::bpf_loader_upgradeable::ID,
    panoptes_bpf_loader_upgradeable_program,
    panoptes_bpf_loader_program::process_instruction,
    upgradeable::id
);
