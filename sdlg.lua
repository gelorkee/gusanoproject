print'worm gay xdx'
--| Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer

--| Functions
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

local function getPredictedPosition(player, shootOffset)
    local offsetToPingMult = 1
	pcall(function()
		player = player.Character
		if not player.Character then print("No player to predict position.") return end
	end)
	local playerHRP = player:FindFirstChild("UpperTorso")
	local playerHum = player:FindFirstChild("Humanoid")
	if not playerHRP or not playerHum then
		return Vector3.new(0,0,0), "Could not find the player's HumanoidRootPart."
	end
	
	local playerPosition = playerHRP.Position
	local velocity = Vector3.new()
	velocity = playerHRP.AssemblyLinearVelocity
	local playerMoveDirection = playerHum.MoveDirection
	local playerLookVec = playerHRP.CFrame.LookVector
	local yVelFactor = velocity.Y > 0 and -1 or 0.5
	local predictedPosition
	predictedPosition = playerHRP.Position + ((velocity * Vector3.new(0, 0.5, 0))) * (shootOffset / 15) +playerMoveDirection * shootOffset
	predictedPosition = predictedPosition * (((game.Players.LocalPlayer:GetNetworkPing() * 1000) * ((offsetToPingMult - 1) * 0.01)) + 1)

	return predictedPosition
end

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

-- Instances:

local ShootGUI = Instance.new("ScreenGui")
local ShootButton = Instance.new("TextButton")
local ShootUICorner = Instance.new("UICorner")
local ShootUIPadding = Instance.new("UIPadding")
local ShootUIStroke = Instance.new("UIStroke")

--Properties:

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
ShootButton.Font = Enum.Font.GothamBold
ShootButton.Text = "SHOOT"
ShootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShootButton.TextScaled = true
ShootButton.TextSize = 14.000
ShootButton.TextWrapped = true

dragGUI(ShootButton)

ShootUICorner.CornerRadius = UDim.new(1, 10)
ShootUICorner.Name = "ShootUICorner"
ShootUICorner.Parent = ShootButton

ShootUIPadding.Parent = ShootButton
ShootUIPadding.PaddingLeft = UDim.new(0, 3)
ShootUIPadding.PaddingRight = UDim.new(0, 3)

ShootUIStroke.Parent = ShootButton
ShootUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ShootUIStroke.Color = Color3.fromRGB(255, 255, 255)

ShootButton.Activated:Connect(function()
    local matchMurderer = getMatchMurderer()

    if matchMurderer ~= nil then

        if matchMurderer == LP then return end
            
        local succ, distanceFromPlayer = pcall(function() return (getRoot(getChar(matchMurderer)).Position - getRoot(getChar(LP)).Position).Magnitude end)

        if succ and tonumber(distanceFromPlayer)  <= 150 then
                
            local gun = LP.Character:FindFirstChild("Gun") or LP.Backpack:FindFirstChild("Gun")

            if gun ~= nil then
                    
                if gun.Parent == LP.Backpack then
                    gun.Parent = LP.Character
                end

                task.wait(0.1)
            
                local predictedPosition = getPredictedPosition(matchMurderer, 3.1)
            
                local args = {
                    [1] = 1,
                    [2] = predictedPosition,
                    [3] = "AH2"
                }
                                        
                LP.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(unpack(args))

            end

        end

    end
end)

task.wait(15)
ShootGUI:Destroy()
