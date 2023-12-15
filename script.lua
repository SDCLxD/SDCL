local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Hacking", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local Tab1 = Window:MakeTab({
	Name = "Tab 1 : Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab1:AddSection({
	Name = "Section 1 : Rifle"
})

Tab1:AddToggle({
	Name = "Rifle Farm",
	Default = false,
	Callback = function(Value)
        getgenv().farm = Value

        function atirar()
            while true and task.wait(.4) do
                local head = game.Workspace.NPCs["Fishman Karate User"].HumanoidRootPart.Position
                local args = {
                    [1] = "reload",
                    [2] = {
                        ["Gun"] = "Rifle"
                    }
                }
                
                game:GetService("ReplicatedStorage").Events.CIcklcon.gunFunctions:InvokeServer(unpack(args))
                local args = {
                    [1] = "fire",
                    [2] = {
                        ["Start"] = CFrame.new(7826.61865, -2129.48486, -17134.5547),
                        ["Gun"] = "Rifle",
                        ["joe"] = "true",
                        ["Position"] = Vector3.new(head.X, head.Y, head.Z)
                    }
                }
                
                game:GetService("ReplicatedStorage").Events.CIcklcon:FireServer(unpack(args))
            end
        end

        while getgenv().farm and task.wait() do
            atirar()
        end
	end    
})

Tab1:AddButton({
	Name = "Fishman",
	Callback = function()
        local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
        local location = CFrame.new(5639.86865, -92.762001, -16611.4688, -1, 0, 0, 0, 1, 0, 0, 0, -1)
        pl.CFrame = location
  	end    
})
