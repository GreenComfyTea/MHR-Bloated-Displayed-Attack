local config = {};
local table_helpers;

config.current_config = nil;
config.config_file_name = "Bloated Displayed Attack/config.json";

config.default_config = {};

function config.init()
	config.default_config = {
		enabled = true,
		weapon_attack_modifiers = {
			great_sword = 4.8,
			sword_and_shield = 1.4,
			dual_blades = 1.4,
			long_sword = 3.3,
			hammer = 5.2,
			hunting_horn = 4.2,
			lance = 2.3,
			gunlance = 2.3,
			switch_axe = 3.5,
			charge_blade = 3.6,
			insect_glaive = 3.1,
			bow = 1.2,
			light_bowgun = 1.3,
			heavy_bowgun = 1.5
		}
	};
end

function config.load()
	local loaded_config = json.load_file(config.config_file_name);
	if loaded_config ~= nil then
		log.info("[Bloated Displayed Attack] config.json loaded successfully");
		config.current_config = table_helpers.merge(config.default_config, loaded_config);
	else
		log.error("[Bloated Displayed Attack] Failed to load config.json");
		config.current_config = table_helpers.deep_copy(config.default_config);
	end
end

function config.save()
	-- save current config to disk, replacing any existing file
	local success = json.dump_file(config.config_file_name, config.current_config);
	if success then
		log.info("[Bloated Displayed Attack] config.json saved successfully");
	else
		log.error("[Bloated Displayed Attack] Failed to save config.json");
	end
end

function config.init_module()
	table_helpers = require("Bloated_Displayed_Attack.table_helpers");

	config.init();
	config.load();
	config.current_config.version = "2.0";
end

return config;
