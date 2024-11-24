--| Services
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

--| Instances
local ShootGUI = Instance.new("ScreenGui")
local ShootButton = Instance.new("TextButton")
local ShootUICorner = Instance.new("UICorner")
local ShootUIPadding = Instance.new("UIPadding")
local ShootUIStroke = Instance.new("UIStroke")

--| Functions
local function dragGUI(gui)
    task.spawn(function()
        local dragging
        local dragInput
        local dragStart = Vector3.new(0,0,0)
        local startPos
        local function update(input)
            local delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            TweenService:Create(gui, TweenInfo.new(.20), {Position = Position}):Play()
        end
        gui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = gui.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        gui.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end)
end

local function getChar(p)
    local c = p.Character or p.CharacterAdded:Wait()
    return c
end

local function getRoot(char)
    local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return root
end

local function getPlayerRole(plr)
    local role = nil
    local callResponse = ReplicatedStorage.Remotes.Gameplay.GetCurrentPlayerData:InvokeServer()
    for player, pData in pairs(callResponse) do
        if tostring(player) == plr.Name then
            if pData["Dead"] == false then
                if tostring(pData["Role"]):lower() == "zombie" then
                    role = "murderer"
                    break
                elseif tostring(pData["Role"]):lower() == "survivor" then
                    role = "innocent"
                    break
                elseif tostring(pData["Role"]):lower() == "hero" then
                    role = "sheriff"
                    break
                else
                    role = pData["Role"]
                    break
                end
            end
        end
    end
    return role
end

local function getMatchMurderer()
    local found = nil
    for _, player in pairs(Players:GetPlayers()) do
        local playerRole = getPlayerRole(player)
        if tostring(playerRole):lower() == "murderer" then
            found = player
            break
        end
    end
    return found
end

--| Properties
ShootGUI.Name = "ShootGUI"
ShootGUI.Parent = game:GetService("CoreGui")
ShootGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ShootGUI.ResetOnSpawn = false

ShootButton.Name = "ShootButton"
ShootButton.Parent = ShootGUI
ShootButton.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
ShootButton.BackgroundTransparency = 0.200
ShootButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ShootButton.BorderSizePixel = 0
ShootButton.Position = UDim2.new(0, 714, 0, 300)
ShootButton.Size = UDim2.new(0.0560000017, 0, 0.104000002, 0)
ShootButton.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
ShootButton.Text = "SHOOT"
ShootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShootButton.TextScaled = true
ShootButton.TextSize = 14.000
ShootButton.TextWrapped = true

ShootUICorner.CornerRadius = UDim.new(1, 10)
ShootUICorner.Name = "ShootUICorner"
ShootUICorner.Parent = ShootButton

ShootUIPadding.Parent = ShootButton
ShootUIPadding.PaddingLeft = UDim.new(0, 3)
ShootUIPadding.PaddingRight = UDim.new(0, 3)

ShootUIStroke.Parent = ShootButton
ShootUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ShootUIStroke.Color = Color3.fromRGB(255, 255, 255)

dragGUI(ShootButton)

task.wait(6)
ShootGUI:Destroy()
