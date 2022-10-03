local bloated_attack = {};

local table_helpers;
local config;

local weapons = {};
local contents_id_data_manager = nil;

local gui_equip_detail_type_def = sdk.find_type_definition("snow.gui.GuiEquipDetail");
local set_weapon_detail_window_method = gui_equip_detail_type_def:get_method("setWeaponDetailWindow");

local weapon_data_param = sdk.find_type_definition("snow.gui.define.WeaponDataParam");
local attack_field_name = "Atk";
local attack_field = weapon_data_param:get_field(attack_field_name);
local weapon_id_field = weapon_data_param:get_field("WeaponId");

local contents_id_data_manager_type_def = sdk.find_type_definition("snow.data.ContentsIdDataManager");
local get_base_data_method = contents_id_data_manager_type_def:get_method("getBaseData");

local weapon_base_data_type_def = sdk.find_type_definition("snow.equip.WeaponBaseData");
local get_player_weapon_type_method = weapon_base_data_type_def:get_method("get_PlWeaponType");

-- setWeaponDetailWindow(snow.gui.define.WeaponDataParam, snow.gui.define.EquipStatusParam, snow.gui.SnowGuiCommonUtility.PageCursor,snow.gui.GuiEquipDetail.EquipDetailWindowType, 
--	System.Boolean, System.Boolean,
--	snow.gui.define.WeaponDataParam, snow.gui.define.EquipStatusParam, snow.data.DataDef.PlEquipSkillId,
--	System.Int32, System.Boolean, snow.data.EquipmentInventoryData)
function bloated_attack.pre_set_weapon_detail_window(weapon_data)
	if not config.current_config.enabled then
		return;
	end

	if contents_id_data_manager == nil then
		contents_id_data_manager = sdk.get_managed_singleton("snow.data.ContentsIdDataManager");
	
		if contents_id_data_manager == nil then
			log.info("[Bloated Displayed Attack] No Contents ID Data Manager");
			return;
		end
	end

	if weapon_data == nil then
		log.info("[Bloated Displayed Attack] No Weapon Data");
		return;
	end

	local weapon_id = weapon_id_field:get_data(weapon_data);
	if weapon_id == nil then
		log.info("[Bloated Displayed Attack] No Weapon ID");
		return;
	end

	local attack = attack_field:get_data(weapon_data);
	if attack == nil then
		log.info("[Bloated Displayed Attack] No Weapon Attack");
		return;
	end

	local weapon_base_data = get_base_data_method:call(contents_id_data_manager, weapon_id);
	if weapon_base_data == nil then
		log.info("[Bloated Displayed Attack] No Weapon Base Data");
		return;
	end

	local weapon_type = get_player_weapon_type_method:call(weapon_base_data);
	if weapon_type == nil then
		log.info("[Bloated Displayed Attack] No Weapon Type");
		return;
	end

	local attack_modifier = bloated_attack.get_attack_modifier_from_weapon_type(weapon_type);
	if attack_modifier == 1 then
		return;
	end

	local bloated_attack = bloated_attack.round(attack * attack_modifier);
	if weapons[weapon_id] == attack then
		return;
	end

	weapon_data:set_field(attack_field_name, bloated_attack);
	weapons[weapon_id] = bloated_attack;
end

function bloated_attack.round(float)
    local int, part = math.modf(float);
    if float == math.abs(float) and part >= .5 then
		return int + 1; -- positive float
    elseif part <= -.5 then
		return int - 1; -- negative float
    end
    return int;
end


function bloated_attack.get_attack_modifier_from_weapon_type(weapon_type)
	if weapon_type == 0 then
		return config.current_config.weapon_attack_modifiers.great_sword;
	elseif weapon_type == 1 then
		return config.current_config.weapon_attack_modifiers.switch_axe;
	elseif weapon_type == 2 then
		return config.current_config.weapon_attack_modifiers.long_sword;
	elseif weapon_type == 3 then
		return config.current_config.weapon_attack_modifiers.light_bowgun;
	elseif weapon_type == 4 then
		return config.current_config.weapon_attack_modifiers.heavy_bowgun;
	elseif weapon_type == 5 then
		return config.current_config.weapon_attack_modifiers.hammer;
	elseif weapon_type == 6 then
		return config.current_config.weapon_attack_modifiers.gunlance;
	elseif weapon_type == 7 then
		return config.current_config.weapon_attack_modifiers.lance;
	elseif weapon_type == 8 then
		return config.current_config.weapon_attack_modifiers.sword_and_shield;
	elseif weapon_type == 9 then
		return config.current_config.weapon_attack_modifiers.dual_blades;
	elseif weapon_type == 10 then
		return config.current_config.weapon_attack_modifiers.hunting_horn;
	elseif weapon_type == 11 then
		return config.current_config.weapon_attack_modifiers.charge_blade;
	elseif weapon_type == 12 then
		return config.current_config.weapon_attack_modifiers.insect_glaive;
	elseif weapon_type == 13 then
		return config.current_config.weapon_attack_modifiers.bow;
	else
		return 1.0;
	end
end

function bloated_attack.init_module()
	table_helpers = require("Bloated_Displayed_Attack.table_helpers");
	config = require("Bloated_Displayed_Attack.config");

	sdk.hook(set_weapon_detail_window_method, function(args)
		bloated_attack.pre_set_weapon_detail_window(sdk.to_managed_object(args[3]));
	end, function(retval)
		return retval;
	end);
end

return bloated_attack;
