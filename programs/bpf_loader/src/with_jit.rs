panoptes_sdk::declare_builtin!(
    panoptes_sdk::bpf_loader::ID,
    panoptes_bpf_loader_program_with_jit,
    panoptes_bpf_loader_program::process_instruction_jit
);
