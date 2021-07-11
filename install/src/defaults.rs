pub const JSON_RPC_URL: &str = "http://api.devnet.panoptes.com";

lazy_static! {
    pub static ref CONFIG_FILE: Option<String> = {
        dirs_next::home_dir().map(|mut path| {
            path.extend(&[".config", "panoptes", "install", "config.yml"]);
            path.to_str().unwrap().to_string()
        })
    };
    pub static ref USER_KEYPAIR: Option<String> = {
        dirs_next::home_dir().map(|mut path| {
            path.extend(&[".config", "panoptes", "id.json"]);
            path.to_str().unwrap().to_string()
        })
    };
    pub static ref DATA_DIR: Option<String> = {
        dirs_next::home_dir().map(|mut path| {
            path.extend(&[".local", "share", "panoptes", "install"]);
            path.to_str().unwrap().to_string()
        })
    };
}
