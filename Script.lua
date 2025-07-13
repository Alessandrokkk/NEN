-- Wastelane Hack [COMPLETÃO] - por ChatGPT

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "Wastelane Hack [Completo]",
    LoadingTitle = "Carregando...",
    ConfigurationSaving = { Enabled = false }
})

-- =======================
-- ABA: AUTO
-- =======================
local AutoTab = Window:CreateTab("Auto", nil)

AutoTab:CreateToggle({
    Name = "Auto Farm Inimigos",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoFarm = state
        task.spawn(function()
            while getgenv().autoFarm do
                for _, enemy in pairs(workspace:GetDescendants()) do
                    if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy ~= game.Players.LocalPlayer.Character then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                        wait(0.5)
                    end
                end
                task.wait()
            end
        end)
    end,
})

AutoTab:CreateToggle({
    Name = "Auto Pickup (Itens no chão)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoPickup = state
        task.spawn(function()
            while getgenv().autoPickup do
                for _, item in pairs(workspace:GetDescendants()) do
                    if item:IsA("Tool") and item:FindFirstChild("Handle") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item.Handle, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item.Handle, 1)
                    end
                end
                wait(0.2)
            end
        end)
    end,
})

AutoTab:CreateToggle({
    Name = "Auto Respawn",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoRespawn = state
    end,
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    if getgenv().autoRespawn then
        wait(1)
        char:MoveTo(Vector3.new(0, 10, 0))
    end
end)

-- =======================
-- ABA: COMBATE
-- =======================
local CombatTab = Window:CreateTab("Combate", nil)

CombatTab:CreateToggle({
    Name = "Kill Aura (com arma equipada)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().killAura = state
        task.spawn(function()
            while getgenv().killAura do
                local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    for _, enemy in pairs(workspace:GetDescendants()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Name ~= game.Players.LocalPlayer.Name then
                            enemy.Humanoid.Health = 0
                        end
                    end
                end
                wait(0.3)
            end
        end)
    end,
})

CombatTab:CreateToggle({
    Name = "Aimbot (BETA)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().aimbot = state
    end
})

local camera = workspace.CurrentCamera
game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().aimbot then
        local closest, distance = nil, math.huge
        for _, enemy in pairs(workspace:GetDescendants()) do
            if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("Head") then
                local pos, visible = camera:WorldToViewportPoint(enemy.Head.Position)
                if visible then
                    local diff = (Vector2.new(pos.X, pos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                    if diff < distance then
                        closest = enemy
                        distance = diff
                    end
                end
            end
        end
        if closest then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Head.Position)
        end
    end
end)

-- =======================
-- ABA: EXTRAS
-- =======================
local ExtrasTab = Window:CreateTab("Extras", nil)

ExtrasTab:CreateToggle({
    Name = "ESP Inimigos",
    CurrentValue = false,
    Callback = function(state)
        getgenv().espOn = state
        task.spawn(function()
            while getgenv().espOn do
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:FindFirstChild("Humanoid") and not obj:FindFirstChild("ESP") then
                        local esp = Instance.new("BillboardGui", obj)
                        esp.Name = "ESP"
                        esp.Size = UDim2.new(0, 100, 0, 40)
                        esp.Adornee = obj:FindFirstChild("Head") or obj.PrimaryPart
                        esp.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel", esp)
                        txt.Size = UDim2.new(1, 0, 1, 0)
                        txt.Text = obj.Name
                        txt.BackgroundTransparency = 1
                        txt.TextColor3 = Color3.new(1, 0, 0)
                        txt.TextScaled = true
                    end
                end
                wait(1)
            end
            for _, obj in pairs(workspace:GetDescendants()) do
                local esp = obj:FindFirstChild("ESP")
                if esp then esp:Destroy() end
            end
        end)
    end
})

ExtrasTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Callback = function(state)
        if state then
            for _, conn in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
                conn:Disable()
            end
        end
    end,
})

ExtrasTab:CreateButton({
    Name = "Invisibilidade (Experimental)",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Transparency = 1
            for _, p in pairs(char:GetChildren()) do
                if p:IsA("MeshPart") or p:IsA("Part") then
                    p.Transparency = 1
                end
            end
        end
    end,
})

ExtrasTab:CreateButton({
    Name = "FPS Boost",
    Callback = function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") or obj:IsA("PointLight") then
                obj:Destroy()
            end
        end
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 1e10
        game.Lighting.Brightness = 0
    end,
})

-- =======================
-- ABA: UTILITÁRIOS
-- =======================
local UtilTab = Window:CreateTab("Utilitários", nil)

UtilTab:CreateButton({
    Name = "Teleportar para Loja",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(100, 5, 100)
    end,
})

UtilTab:CreateButton({
    Name = "Comprar Tudo",
    Callback = function()
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("BuyItem")
        local itens = {"Magnum", "Espingarda", "Armazém"}
        if remote then
            for _, item in ipairs(itens) do
                remote:FireServer(item)
                wait(0.2)
            end
        else
            warn("RemoteEvent 'BuyItem' não encontrado.")
        end
    end,
})

UtilTab:CreateSlider({
    Name = "Speed Hack",
    Range = {16, 100},
    Increment = 2,
    CurrentValue = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end,
})

UtilTab:CreateToggle({
    Name = "Fly (Celular)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().flying = state
        task.spawn(function()
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local root = char:WaitForChild("HumanoidRootPart")
            local bg = Instance.new("BodyGyro", root)
            local bv = Instance.new("BodyVelocity", root)
            bg.P = 9e4
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            local speed = 50

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

UtilTab:CreateToggle({
    Name = "Kit Médico Infinito",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().medkitLoop = Value
        task.spawn(function()
            while getgenv().medkitLoop do
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") and v.Parent.Name == "Kit Médico" then
                        fireproximityprompt(v)
                    end
                end
                wait(2)
            end
        end)
    end
})
