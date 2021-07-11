panoptes_sdk::declare_builtin!(
    panoptes_sdk::bpf_loader_deprecated::ID,
    panoptes_bpf_loader_deprecated_program,
    panoptes_bpf_loader_program::process_instruction,
    deprecated::id
);
