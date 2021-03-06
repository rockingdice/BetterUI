local _
local LAM = LibStub:GetLibrary("LibAddonMenu-2.0")

local GENERAL_COLOR_WHITE = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_1
local GENERAL_COLOR_GREY = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_2
local GENERAL_COLOR_OFF_WHITE = GAMEPAD_TOOLTIP_COLOR_GENERAL_COLOR_3
local GENERAL_COLOR_RED = GAMEPAD_TOOLTIP_COLOR_FAILED

local changed = false

local function Init(mId, moduleName)
	local panelData = Init_ModulePanel(moduleName, "Inventory Improvement Settings")

	local optionsTable = {
		{
			type = "header",
			name = "|c0066FF[Enhanced Banking]|r Behaviour",
			width = "full",
		},
		{
			type = "checkbox",
			name = "Enable \"Junk\" feature",
			tooltip = "Allows items to be marked as \"junk\" as a filter to de-clutter the inventory",
			getFunc = function() return BUI.Settings.Modules["Inventory"].enableJunk end,
			setFunc = function(value) BUI.Settings.Modules["Inventory"].enableJunk = value end,
			width = "full",
		},
		{
			type = "checkbox",
			name = "Save inventory position",
			tooltip = "Keeps track of the list position on each category for quicker browsing",
			getFunc = function() return BUI.Settings.Modules["Inventory"].savePosition end,
			setFunc = function(value) BUI.Settings.Modules["Inventory"].savePosition = value end,
			width = "full",
		},
        {
            type = "checkbox",
            name = "Enable category wrapping",
            tooltip = "Enables quick access to \"Quickslots\" when you press LB when selecting \"All\"",
            getFunc = function() return BUI.Settings.Modules["Inventory"].enableWrapping end,
            setFunc = function(value) BUI.Settings.Modules["Inventory"].enableWrapping = value end,
            width = "full",
        },
        {
            type = "checkbox",
            name = "Use triggers to move to next item type",
            tooltip = "Rather than skip a certain number of items every trigger press (default global behaviour), this will move to the next item type",
            getFunc = function() return BUI.Settings.Modules["Inventory"].useTriggersForSkip end,
            setFunc = function(value) BUI.Settings.Modules["Inventory"].useTriggersForSkip = value end,
            width = "full",
        },
		{
			type = "header",
			name = "|c0066FF[Enhanced Inventory]|r Display",
			width = "full",
		},
        {
            type = "checkbox",
            name = "Replace \"Value\" with the market's price",
            tooltip = "Replaces the item \"Value\" with either MasterMerchant's price or dataDaedra's market price",
            getFunc = function() return BUI.Settings.Modules["Inventory"].showMarketPrice end,
            setFunc = function(value) BUI.Settings.Modules["Inventory"].showMarketPrice = value end,
            width = "full",
        },
		{
			type = "checkbox",
			name = "Short Currency Format",
			tooltip = "Automatically formats the value column to shorten large numbers and to display the currency with commas.",
			getFunc = function() return BUI.Settings.Modules["Inventory"].useShortFormat end,
			setFunc = function(value) BUI.Settings.Modules["Inventory"].useShortFormat = value
				changed = true
				end,
			width = "full",
			warning="Needs to reload UI."
		},
		{
            type = "checkbox",
            name = "Display character attributes on the switching tooltip?",
            tooltip = "Show the character attributes on the switching tooltip rather than seeing the current equipped item",
            getFunc = function() return BUI.Settings.Modules["Inventory"].displayCharAttributes end,
            setFunc = function(value) BUI.Settings.Modules["Inventory"].displayCharAttributes = value end,
            width = "full",
        },
		{
			type = "checkbox",
			name = "Bind on Equip Protection",
			tooltip = "Show a dialog before equipping Bind on Equip items.",
			getFunc = function () return BUI.Settings.Modules["Inventory"].bindOnEquipProtection end,
			setFunc = function (value) BUI.Settings.Modules["Inventory"].bindOnEquipProtection = value
				changed = true
				end,
			width = "full",
			warning="Needs to reload UI."
		},
		{
			type = "header",
			name = "|c0066FF[Enhanced Inventory]|r Icon",
			width = "full",
		},
		{
			type = "checkbox",
			name = "Item Icon - Unbound Items",
			tooltip = "Show an icon after unbound items.",
			getFunc = function () return BUI.Settings.Modules["Inventory"].showIconUnboundItem end,
			setFunc = function (value) BUI.Settings.Modules["Inventory"].showIconUnboundItem = value
				changed = true end,
			width = "full",
			warning="Needs to reload UI."
		},
		{
			type = "checkbox",
			name = "Item Icon - Enchantment",
			tooltip = "Show an icon after enchanted item.",
			getFunc = function () return BUI.Settings.Modules["Inventory"].showIconEnchantment end,
			setFunc = function (value) BUI.Settings.Modules["Inventory"].showIconEnchantment = value
				changed = true end,
			width = "full",
			warning="Needs to reload UI."
		},
		{
			type = "checkbox",
			name = "Item Icon - Set Gear",
			tooltip = "Show an icon after set gears.",
			getFunc = function () return BUI.Settings.Modules["Inventory"].showIconSetGear end,
			setFunc = function (value) BUI.Settings.Modules["Inventory"].showIconSetGear = value
				changed = true end,
			width = "full",
			warning="Needs to reload UI."
		},
		{
			type = "checkbox",
			name = "Item Icon - Iakoni's Gear Changer",
			tooltip = "Show the first set number in Iakoni's settings.",
			getFunc = function () return BUI.Settings.Modules["Inventory"].showIconIakoniGearChanger end,
			setFunc = function (value) BUI.Settings.Modules["Inventory"].showIconIakoniGearChanger = value
				changed = true end,
			width = "full",
			warning="Needs to reload UI."
		},
		{
			type = "checkbox",
			name = "            Show all sets instead",
			tooltip = "Show all sets if in multiple Iakoni's settings.",
			getFunc = function () return BUI.Settings.Modules["Inventory"].showIconIakoniGearChangerAllSets end,
			setFunc = function (value) BUI.Settings.Modules["Inventory"].showIconIakoniGearChangerAllSets = value
				changed = true end,
			width = "full",
			warning="Needs to reload UI.",
			disabled = function() return not BUI.Settings.Modules["Inventory"].showIconIakoniGearChanger end,  
		},		
		{
			type = "checkbox",
			name = "Item Icon - GamePadBuddy's Status Indicator",
			tooltip = "Show an icon to indicate gear's researchable/known/duplicated/researching/ornate/intricate status.",
			getFunc = function () return BUI.Settings.Modules["Inventory"].showIconGamePadBuddyStatusIcon end,
			setFunc = function (value) BUI.Settings.Modules["Inventory"].showIconGamePadBuddyStatusIcon = value
				changed = true end,
			width = "full",
			warning="Needs to reload UI."
		},
		{ 			
			type = "header", 		
		},		         
		{             
			type = "button",             
			name = "Apply Changes",             
			func = function() ReloadUI() end, 			
			disabled = function() return not changed end,         
		},		 	
	}
	LAM:RegisterAddonPanel("BUI_"..mId, panelData)
	LAM:RegisterOptionControls("BUI_"..mId, optionsTable)
end

function BUI.Inventory.InitModule(m_options)
    m_options["savePosition"] = true
    m_options["enableWrapping"] = true
    m_options["showMarketPrice"] = false
    m_options["useTriggersForSkip"] = false
    m_options["enableJunk"] = false
	m_options["displayCharAttributes"] = true
	m_options["useShortFormat"] = true
	m_options["bindOnEquipProtection"] = true
	m_options["showIconEnchantment"] = true
	m_options["showIconSetGear"] = true
	m_options["showIconUnboundItem"] = true
	m_options["showIconIakoniGearChanger"] = true
	m_options["showIconIakoniGearChangerAllSets"] = false
	m_options["showIconGamePadBuddyStatusIcon"] = true

    return m_options
end


-------------------------------------------------------------------------------------------------------------------------------------------------------
--
--    Finally, the Setup() function which replaces the inventory system with a duplicate that I've heavily modified. Duplication is necessary as I don't
--    have access to the beginning :New() method of ZO_GamepadInventory. Will mess quite a few addons up, but will make GAMEPAD_INVENTORY a reference at the end
--
-------------------------------------------------------------------------------------------------------------------------------------------------------

function BUI.Inventory.Setup()
	Init("Inventory", "Inventory")

	GAMEPAD_INVENTORY = BUI.Inventory.Class:New(BUI_GamepadInventoryTopLevel) -- Bam! Initialise the custom inventory class so it's integrated neatly

	GAMEPAD_INVENTORY_FRAGMENT = ZO_SimpleSceneFragment:New(BUI_GamepadInventoryTopLevel) -- **Replaces** the old inventory with a new one defined in "Templates/GamepadInventory.xml"
    GAMEPAD_INVENTORY_FRAGMENT:SetHideOnSceneHidden(true)

    -- Now update the changes throughout the interface...
    GAMEPAD_INVENTORY_ROOT_SCENE:AddFragmentGroup(FRAGMENT_GROUP.GAMEPAD_DRIVEN_UI_WINDOW)
    GAMEPAD_INVENTORY_ROOT_SCENE:AddFragmentGroup(FRAGMENT_GROUP.FRAME_TARGET_GAMEPAD)
    GAMEPAD_INVENTORY_ROOT_SCENE:AddFragment(GAMEPAD_INVENTORY_FRAGMENT)
    GAMEPAD_INVENTORY_ROOT_SCENE:AddFragment(FRAME_EMOTE_FRAGMENT_INVENTORY)
    GAMEPAD_INVENTORY_ROOT_SCENE:AddFragment(GAMEPAD_NAV_QUADRANT_1_BACKGROUND_FRAGMENT)
    GAMEPAD_INVENTORY_ROOT_SCENE:AddFragment(MINIMIZE_CHAT_FRAGMENT)
    GAMEPAD_INVENTORY_ROOT_SCENE:AddFragment(GAMEPAD_MENU_SOUND_FRAGMENT)


    -- Just some modification to the right tooltip to be cleaner
	ZO_GamepadTooltipTopLevelLeftTooltipContainer.tip.maxFadeGradientSize=10
	
	-- This code allows the player to scroll the tooltips with their mouse
	ZO_GamepadTooltipTopLevelLeftTooltipContainerTip:SetMouseEnabled(true)
	ZO_GamepadTooltipTopLevelLeftTooltipContainerTipScroll:SetMouseEnabled(true)
	ZO_GamepadTooltipTopLevelLeftTooltipContainerTip:SetHandler("OnMouseWheel", function(self, delta) 
		local newScrollValue
		
		if delta > 0 then
			newScrollValue = self.scrollValue - BUI.Settings.Modules["CIM"].rhScrollSpeed
		else
			newScrollValue = self.scrollValue + BUI.Settings.Modules["CIM"].rhScrollSpeed
		end
		
		self.scrollValue = newScrollValue
		self.scroll:SetVerticalScroll(newScrollValue)
	end)
	

	GAMEPAD_TOOLTIPS.tooltips.GAMEPAD_LEFT_TOOLTIP.fragment.control.container:SetAnchor(3,ZO_GamepadTooltipTopLevelLeftTooltip,3,40,-100,0)		


	inv = GAMEPAD_INVENTORY

    if(BUI.Settings.Modules["CIM"].condenseLTooltip) then
        ZO_TOOLTIP_STYLES["topSection"] = {
            layoutPrimaryDirection = "up",
            layoutSecondaryDirection = "right",
            widthPercent = 100,
            childSpacing = 1,
            fontSize = 22,
            height = 64,
            uppercase = true,
            fontColorField = GENERAL_COLOR_OFF_WHITE,
        }

        ZO_TOOLTIP_STYLES["statValuePairStat"] = {
            fontSize = 22,
            uppercase = true,
            fontColorField = GENERAL_COLOR_OFF_WHITE,
        }
        ZO_TOOLTIP_STYLES["statValuePairValue"] =
        {
            fontSize = 30,
            fontColorField = GENERAL_COLOR_WHITE,
        }
        ZO_TOOLTIP_STYLES["title"] = {
            fontSize = 36,
            customSpacing = 8,
            uppercase = true,
            fontColorField = GENERAL_COLOR_WHITE,
        }
        ZO_TOOLTIP_STYLES["bodyDescription"] =    {
            fontSize = 22,
        }
    end
	
	if not SaveEquip ~= nil or not SaveEquip then
	
		ZO_Dialogs_RegisterCustomDialog("CONFIRM_EQUIP_BOE", {
			gamepadInfo =
			{
				dialogType = GAMEPAD_DIALOGS.BASIC,
			},
			title =
			{
				text = SI_SAVE_EQUIP_CONFIRM_TITLE,
			},
			mainText =
			{
				text = SI_SAVE_EQUIP_CONFIRM_EQUIP_BOE,
			},
			buttons =
			{
				[1] =
				{
					text =      SI_SAVE_EQUIP_EQUIP,
					callback =  function(dialog)
						dialog.data.callback()
					end
				},
				
				[2] =
				{
					text =      SI_DIALOG_CANCEL,
				}
			}
		})
	end
end
