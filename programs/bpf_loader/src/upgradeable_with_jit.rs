panoptes_sdk::declare_builtin!(
    panoptes_sdk::bpf_loader_upgradeable::ID,
    panoptes_bpf_loader_upgradeable_program_with_jit,
    panoptes_bpf_loader_program::process_instruction_jit,
    upgradeable_with_jit::id
);
