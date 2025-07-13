-- Wastelane Hack [COMPLETO] - OrionLib Edition

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source.lua"))()

local Window = OrionLib:MakeWindow({ Name = "Wastelane Hack [COMPLETO]", HidePremium = false, SaveConfig = false, IntroText = "Wastelane Hack" })

-- ======================= -- ABA: AUTO -- ======================= local AutoTab = Window:MakeTab({ Name = "Auto", Icon = "", PremiumOnly = false })

AutoTab:AddToggle({ Name = "Auto Farm Inimigos", Default = false, Callback = function(state) getgenv().autoFarm = state task.spawn(function() while getgenv().autoFarm do for _, enemy in pairs(workspace:GetDescendants()) do if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy ~= game.Players.LocalPlayer.Character then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0) wait(0.5) end end task.wait() end end) end })

AutoTab:AddToggle({ Name = "Auto Pickup (Itens no chão)", Default = false, Callback = function(state) getgenv().autoPickup = state task.spawn(function() while getgenv().autoPickup do for _, item in pairs(workspace:GetDescendants()) do if item:IsA("Tool") and item:FindFirstChild("Handle") then firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item.Handle, 0) firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item.Handle, 1) end end wait(0.2) end end) end })

AutoTab:AddToggle({ Name = "Auto Respawn", Default = false, Callback = function(state) getgenv().autoRespawn = state end })

game.Players.LocalPlayer.CharacterAdded:Connect(function(char) if getgenv().autoRespawn then wait(1) char:MoveTo(Vector3.new(0, 10, 0)) end end)

-- ======================= -- ABA: COMBATE -- ======================= local CombatTab = Window:MakeTab({ Name = "Combate", Icon = "", PremiumOnly = false })

CombatTab:AddToggle({ Name = "Kill Aura (com arma equipada)", Default = false, Callback = function(state) getgenv().killAura = state task.spawn(function() while getgenv().killAura do local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") if tool then for _, enemy in pairs(workspace:GetDescendants()) do if enemy:FindFirstChild("Humanoid") and enemy.Name ~= game.Players.LocalPlayer.Name then enemy.Humanoid.Health = 0 end end end wait(0.3) end end) end })

CombatTab:AddToggle({ Name = "Aimbot (BETA)", Default = false, Callback = function(state) getgenv().aimbot = state end })

local camera = workspace.CurrentCamera

RunService = game:GetService("RunService") RunService.RenderStepped:Connect(function() if getgenv().aimbot then local closest, distance = nil, math.huge for _, enemy in pairs(workspace:GetDescendants()) do if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("Head") then local pos, visible = camera:WorldToViewportPoint(enemy.Head.Position) if visible then local diff = (Vector2.new(pos.X, pos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude if diff < distance then closest = enemy distance = diff end end end end if closest then camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Head.Position) end end end)

-- ======================= -- ABA: EXTRAS -- ======================= local ExtrasTab = Window:MakeTab({ Name = "Extras", Icon = "", PremiumOnly = false })

ExtrasTab:AddToggle({ Name = "ESP Inimigos", Default = false, Callback = function(state) getgenv().espOn = state task.spawn(function() while getgenv().espOn do for _, obj in pairs(workspace:GetDescendants()) do if obj:FindFirstChild("Humanoid") and not obj:FindFirstChild("ESP") then local esp = Instance.new("BillboardGui", obj) esp.Name = "ESP" esp.Size = UDim2.new(0, 100, 0, 40) esp.Adornee = obj:FindFirstChild("Head") or obj.PrimaryPart esp.AlwaysOnTop = true local txt = Instance.new("TextLabel", esp) txt.Size = UDim2.new(1, 0, 1, 0) txt.Text = obj.Name txt.BackgroundTransparency = 1 txt.TextColor3 = Color3.new(1, 0, 0) txt.TextScaled = true end end wait(1) end for _, obj in pairs(workspace:GetDescendants()) do local esp = obj:FindFirstChild("ESP") if esp then esp:Destroy() end end end) end })

ExtrasTab:AddToggle({ Name = "Anti AFK", Default = false, Callback = function(state) if state then for _, conn in pairs(getconnections(game.Players.LocalPlayer.Idled)) do conn:Disable() end end end })

ExtrasTab:AddButton({ Name = "Invisibilidade (Experimental)", Callback = function() local char = game.Players.LocalPlayer.Character if char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.Transparency = 1 for _, p in pairs(char:GetChildren()) do if p:IsA("MeshPart") or p:IsA("Part") then p.Transparency = 1 end end end end })

ExtrasTab:AddButton({ Name = "FPS Boost", Callback = function() for _, obj in pairs(game:GetDescendants()) do if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") or obj:IsA("PointLight") then obj:Destroy() end end game.Lighting.GlobalShadows = false game.Lighting.FogEnd = 1e10 game.Lighting.Brightness = 0 end })

-- ======================= -- ABA: UTILITÁRIOS -- ======================= local UtilTab = Window:MakeTab({ Name = "Utilitários", Icon = "", PremiumOnly = false })

UtilTab:AddButton({ Name = "Teleportar para Loja", Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 5, 100) end })

UtilTab:AddButton({ Name = "Comprar Tudo", Callback = function() local remote = game:GetService("ReplicatedStorage"):FindFirstChild("BuyItem") local itens = {"Magnum", "Espingarda", "Armazém"} if remote then for _, item in ipairs(itens) do remote:FireServer(item) wait(0.2) end else warn("RemoteEvent 'BuyItem' não encontrado.") end end })

UtilTab:AddSlider({ Name = "Speed Hack", Min = 16, Max = 100, Default = 16, Increment = 2, Callback = function(value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value end })

UtilTab:AddToggle({ Name = "Fly (Celular)", Default = false, Callback = function(state) getgenv().flying = state task.spawn(function() local player = game.Players.LocalPlayer local char = player.Character or player.CharacterAdded:Wait() local root = char:WaitForChild("HumanoidRootPart") local bg = Instance.new("BodyGyro", root) local bv = Instance.new("BodyVelocity", root) bg.P = 9e4 bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) local speed = 50

while getgenv().flying and root and root.Parent do
            bg.CFrame = workspace.CurrentCamera.CFrame
            bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
            wait()
        end

        bg:Destroy()
        bv:Destroy()
    end)
end

})

UtilTab:AddToggle({ Name = "Kit Médico Infinito", Default = false, Callback = function(state) getgenv().medkitLoop = state task.spawn(function() while getgenv().medkitLoop do for _, v in pairs(workspace:GetDescendants()) do if v:IsA("ProximityPrompt") and v.Parent.Name == "Kit Médico" then fireproximityprompt(v) end end wait(2) end end) end })

OrionLib:Init()

