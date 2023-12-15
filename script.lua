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

        function quest()
            local data = game.ReplicatedStorage["Stats"..game.Players.LocalPlayer.Name]
            if data.Stats.Level.Value > 189 and data.Quest.CurrentQuest.Value == "None" then
                local speed = 10000
                local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
                local CFrameEnd = CFrame.new(7731.00537, -2175.83203, -17222.9922)
                local info = TweenInfo.new((game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude / speed,Enum.EasingStyle.Linear)
                local tween = game:GetService("TweenService"):Create(pl, info, {CFrame = CFrameEnd})
                tween:Play()
                tween.Completed:Wait()
                if tween.Completed then
                    local args = {
                        [1] = {
                            [1] = "takequest",
                            [2] = "Help becky"
                        }
                    }
                                                
                    game:GetService("ReplicatedStorage").Events.Quest:InvokeServer(unpack(args))
                end
            end
        end

            function shoot()
                while true and task.wait(0.4) do
                    local head = game.Workspace.NPCs["Fishman Karate User"].Head.Position
                    local recarregar = {
                        [1] = "reload",
                        [2] = {
                            ["Gun"] = "Rifle"
                        }
                    }

                    game:GetService("ReplicatedStorage").Events.CIcklcon.gunFunctions:InvokeServer(unpack(recarregar))

                    local atirar = {
                        [1] = "fire",
                        [2] = {
                            ["Start"] = CFrame.new(7837.54395, -2151.33203, -17133.9707),
                            ["Gun"] = "Rifle",
                            ["joe"] = "true",
                            ["Position"] = Vector3.new(head.X, head.Y, head.Z)
                        }
                    }

                    game:GetService("ReplicatedStorage").Events.CIcklcon:FireServer(unpack(atirar))
                end
            end

            function position()
                local vt = 5000
                local pl = game.Players.LocalPlayer.Character.HumanoidRootPart
                local CFrameEnd = CFrame.new(7837.54395, -2151.33203, -17133.9707)
                local info = TweenInfo.new((game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude / vt,Enum.EasingStyle.Linear)
                local tween = game:GetService("TweenService"):Create(pl, info, {CFrame = CFrameEnd})
                tween:Play()
                tween.Completed:Wait()
            end
                    
            while getgenv().farm and task.wait() do
                quest()
                position()
                shoot()
            end
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
