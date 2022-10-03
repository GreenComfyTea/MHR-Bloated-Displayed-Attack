local native_customization_menu = {};

local table_helpers;
local config;
local customization_menu;
local bloated_attack;


local mod_menu_api_package_name = "ModOptionsMenu.ModMenuApi";
local mod_menu = nil;

local native_UI = nil;

native_customization_menu.display_mode_descriptions = { "Windowed Mode.", "Borderless Windowed Mode.", "Fullscreen Mode." };

--no idea how this works but google to the rescue
--can use this to check if the api is available and do an alternative to avoid complaints from users
function native_customization_menu.is_module_available(name)
	if package.loaded[name] then
		return true;
	else
		for _, searcher in ipairs(package.searchers or package.loaders) do
			local loader = searcher(name);

			if type(loader) == 'function' then
				package.preload[name] = loader;
				return true;
			end
		end

		return false;
	end
end

function native_customization_menu.draw()
	local changed = false;
	local config_changed = false;
	local index = 1; 

	mod_menu.Label("Created by: <COL RED>GreenComfyTea</COL>", "",
		"Donate: <COL RED>https://streamelements.com/greencomfytea/tip</COL>\nBuy me a tea: <COL RED>https://ko-fi.com/greencomfytea</COL>\nSometimes I stream: <COL RED>twitch.tv/greencomfytea</COL>");
	mod_menu.Label("Version: <COL RED>" .. config.current_config.version .. "</COL>", "",
		"Donate: <COL RED>https://streamelements.com/greencomfytea/tip</COL>\nBuy me a tea: <COL RED>https://ko-fi.com/greencomfytea</COL>\nSometimes I stream: <COL RED>twitch.tv/greencomfytea</COL>");



	if true then -- Weapon Modifiers
		mod_menu.Header("Bloated Displayed Attack");

		changed, config.current_config.enabled = mod_menu.CheckBox(
			"Enabled", config.current_config.enabled, "Enable/Disable Bloated Displayed Attack.");
		config_changed = config_changed or changed;
	end

	if true then -- Weapon Modifiers
		mod_menu.Header("Weapon Attack Modifiers");

		changed, config.current_config.weapon_attack_modifiers.great_sword = mod_menu.FloatSlider(
				"Great Sword", config.current_config.weapon_attack_modifiers.great_sword, 0.1, 20, "%.1f", "Attack Modifier for Great Sword.");
		config_changed = config_changed or changed;
		
		changed, config.current_config.weapon_attack_modifiers.sword_and_shield = mod_menu.FloatSlider(
				"Sword & Shield", config.current_config.weapon_attack_modifiers.sword_and_shield, 0.1, 20, "%.1f", "Attack Modifier for Sword & Shield.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.dual_blades = mod_menu.FloatSlider(
			"Dual Blades", config.current_config.weapon_attack_modifiers.dual_blades, 0.1, 20, "%.1f", "Attack Modifier for Great Sword.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.long_sword = mod_menu.FloatSlider(
			"Long Sword", config.current_config.weapon_attack_modifiers.long_sword, 0.1, 20, "%.1f", "Attack Modifier for Long Sword.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.hammer = mod_menu.FloatSlider(
			"Hammer", config.current_config.weapon_attack_modifiers.hammer, 0.1, 20, "%.1f", "Attack Modifier for Hammer.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.hunting_horn = mod_menu.FloatSlider(
			"Hunting Horn", config.current_config.weapon_attack_modifiers.hunting_horn, 0.1, 20, "%.1f", "Attack Modifier for Hunting Horn.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.lance = mod_menu.FloatSlider(
			"Lance", config.current_config.weapon_attack_modifiers.lance, 0.1, 20, "%.1f", "Attack Modifier for Lance.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.gunlance = mod_menu.FloatSlider(
			"Gunlance", config.current_config.weapon_attack_modifiers.gunlance, 0.1, 20, "%.1f", "Attack Modifier for Gunlance.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.switch_axe = mod_menu.FloatSlider(
			"Switch Axe", config.current_config.weapon_attack_modifiers.switch_axe, 0.1, 20, "%.1f", "Attack Modifier for Switch Axe.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.charge_blade = mod_menu.FloatSlider(
			"Charge Blade", config.current_config.weapon_attack_modifiers.charge_blade, 0.1, 20, "%.1f", "Attack Modifier for Charge Blade.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.insect_glaive = mod_menu.FloatSlider(
			"Insect Glaive", config.current_config.weapon_attack_modifiers.insect_glaive, 0.1, 20, "%.1f", "Attack Modifier for Insect Glaive.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.bow = mod_menu.FloatSlider(
			"Bow", config.current_config.weapon_attack_modifiers.bow, 0.1, 20, "%.1f", "Attack Modifier for Bow.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.light_bowgun = mod_menu.FloatSlider(
			"Light Bowgun", config.current_config.weapon_attack_modifiers.light_bowgun, 0.1, 20, "%.1f", "Attack Modifier for Light Bowgun.");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.heavy_bowgun = mod_menu.FloatSlider(
			"Heavy Bowgun", config.current_config.weapon_attack_modifiers.heavy_bowgun, 0.1, 20, "%.1f", "Attack Modifier for Heavy Bowgun.");
		config_changed = config_changed or changed;
	end

	if config_changed then
		config.save();
	end
end

function native_customization_menu.on_reset_all_settings()
	config.current_config = table_helpers.deep_copy(config.default_config);
end

function native_customization_menu.init_module()
	table_helpers = require("Bloated_Displayed_Attack.table_helpers");
	config = require("Bloated_Displayed_Attack.config");
	customization_menu = require("Bloated_Displayed_Attack.customization_menu");
	bloated_attack = require("Bloated_Displayed_Attack.bloated_attack");

	if native_customization_menu.is_module_available(mod_menu_api_package_name) then
		mod_menu = require(mod_menu_api_package_name);
	end

	if mod_menu == nil then
		log.info("[Bloated Displayed Attack] No mod_menu_api API package found. You may need to download it or something.");
		return;
	end

	native_UI = mod_menu.OnMenu(
		"Bloated Displayed Attack",
		"Displays bloated attack value instead of raw value.",
		native_customization_menu.draw
	);

	native_UI.OnResetAllSettings = native_customization_menu.on_reset_all_settings;

end

return native_customization_menu;
