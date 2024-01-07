--//Import Lib
local Library = loadstring(game:HttpGet(("https://raw.githubusercontent.com/SDCLxD/SDCL/main/script.lua")))()

--//Create UI
local Ui = Library:AddWindow("Name", "Game")

--//Create Tab
local Tab = Ui:AddTab("Tab 1")

--//Create Section
local Section = Tab:AddSection("Section")

--//Create Button
Section:AddButton("Print", function(state)
    print("Button")
end)

--//Create Toggle
Section:AddToggle("Toggle", {Toggled = false, Description = "Put false if you don't want a desc."}, function(state)
    print(state)
end)

--//Create Slider
Section:AddSlider("Slider", {Min = 10, Max = 120, DefaultValue = 10}, function(value)
    print(value)
end)

--//Create TextBox
Section:AddTextbox("TextBox", "Hi! Write here.", function(args)
    print(args)
end)

--//Create Dropdown
Section:AddDropdown("DropDown", {
    List = {'1', '2', '3'},
    Default = ''}
end)
