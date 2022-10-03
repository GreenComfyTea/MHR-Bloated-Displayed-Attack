local table_helpers = require("Bloated_Displayed_Attack.table_helpers");
local config = require("Bloated_Displayed_Attack.config");

local customization_menu = require("Bloated_Displayed_Attack.customization_menu");
local native_customization_menu = require("Bloated_Displayed_Attack.native_customization_menu");

local bloated_attack = require("Bloated_Displayed_Attack.bloated_attack");

table_helpers.init_module();
config.init_module();

customization_menu.init_module();

bloated_attack.init_module();

native_customization_menu.init_module();

log.info("[Bloated Displayed Attack] Loaded.");

re.on_draw_ui(function()
	if imgui.button("Bloated Displayed Attack v" .. config.current_config.version) then
		customization_menu.is_opened = not customization_menu.is_opened;
	end
end);

re.on_frame(function()
	if not reframework:is_drawing_ui() then
		customization_menu.is_opened = false;
	end

	if customization_menu.is_opened then
		pcall(customization_menu.draw);
	end
end);