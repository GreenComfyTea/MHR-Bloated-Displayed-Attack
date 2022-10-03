local customization_menu = {};

local table_helpers;
local config;
local bloated_attack;

customization_menu.is_opened = false;
customization_menu.status = "OK";

customization_menu.window_position = Vector2f.new(480, 200);
customization_menu.window_pivot = Vector2f.new(0, 0);
customization_menu.window_size = Vector2f.new(380, 460);
customization_menu.window_flags = 0x10120;

customization_menu.color_picker_flags = 327680;
customization_menu.decimal_input_flags = 33;

function customization_menu.init()
end

function customization_menu.draw()
	imgui.set_next_window_pos(customization_menu.window_position, 1 << 3, customization_menu.window_pivot);
	imgui.set_next_window_size(customization_menu.window_size, 1 << 3);

	customization_menu.is_opened = imgui.begin_window(
		"Bloated Displayed Attack v" .. config.current_config.version, customization_menu.is_opened, customization_menu.window_flags);

	if not customization_menu.is_opened then
		imgui.end_window();
		return;
	end

	imgui.text("Status: " .. tostring(customization_menu.status));

	local changed = false;
	local config_changed = false;
	local index = 1;

	changed, config.current_config.enabled = imgui.checkbox("Enabled", config.current_config.enabled);
	config_changed = config_changed or changed;

	if imgui.tree_node("Weapon Attack Modifiers") then
		changed, config.current_config.weapon_attack_modifiers.great_sword = imgui.drag_float(
				"Great Sword", config.current_config.weapon_attack_modifiers.great_sword, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.sword_and_shield = imgui.drag_float(
				"Sword & Shield", config.current_config.weapon_attack_modifiers.sword_and_shield, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.dual_blades = imgui.drag_float(
			"Dual Blades", config.current_config.weapon_attack_modifiers.dual_blades, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.long_sword = imgui.drag_float(
				"Long Sword", config.current_config.weapon_attack_modifiers.long_sword, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.hammer = imgui.drag_float(
				"Hammer", config.current_config.weapon_attack_modifiers.hammer, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.hunting_horn = imgui.drag_float(
				"Hunting Horn", config.current_config.weapon_attack_modifiers.hunting_horn, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.lance = imgui.drag_float(
				"Lance", config.current_config.weapon_attack_modifiers.lance, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.gunlance = imgui.drag_float(
				"Gunlance", config.current_config.weapon_attack_modifiers.gunlance, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.switch_axe = imgui.drag_float(
				"Switch Axe", config.current_config.weapon_attack_modifiers.switch_axe, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.charge_blade = imgui.drag_float(
				"Charge Blade", config.current_config.weapon_attack_modifiers.charge_blade, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.insect_glaive = imgui.drag_float(
				"Insect Glaive", config.current_config.weapon_attack_modifiers.insect_glaive, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.bow = imgui.drag_float(
				"Bow", config.current_config.weapon_attack_modifiers.bow, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.light_bowgun = imgui.drag_float(
				"Light Bowgun", config.current_config.weapon_attack_modifiers.light_bowgun, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		changed, config.current_config.weapon_attack_modifiers.heavy_bowgun = imgui.drag_float(
				"Heavy Bowgun", config.current_config.weapon_attack_modifiers.heavy_bowgun, 0.1, 0.1, 100, "%.1f");
		config_changed = config_changed or changed;

		imgui.tree_pop();
	end


	imgui.end_window();

	if config_changed then
		config.save();
	end
end

function customization_menu.init_module()
	table_helpers = require("Bloated_Displayed_Attack.table_helpers");
	config = require("Bloated_Displayed_Attack.config");
	bloated_attack = require("Bloated_Displayed_Attack.bloated_attack");

	customization_menu.init();
end

return customization_menu;
