print'69'
if not game:IsLoaded() then game.Loaded:Wait() end
repeat task.wait() until game:FindFirstChild("Players") ~= nil
repeat task.wait() until game.Players.LocalPlayer ~= nil
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("Backpack")
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui") ~= nil
local devicecheckstarted = tick()
repeat task.wait() until tostring(game.Players.LocalPlayer.PlayerGui:GetAttribute("Device")):lower() == "pc" or tostring(game.Players.LocalPlayer.PlayerGui:GetAttribute("Device")):lower() == "tablet" or (tick() - devicecheckstarted) >= 10

--| PREVENT MULTIPLE EXECUTION
if VULTURES_LOADED == true then
    return
end
--| PREVENT MULTIPLE EXECUTION

local thisScriptVersion = "1.0.1"
local currentOfficialVersion = loadstring(game:HttpGet("https://raw.githubusercontent.com/YungCaesarr/Vultures-Hub/refs/heads/main/version.lua"))()
local discordInv = tostring(game:HttpGet("https://raw.githubusercontent.com/YungCaesarr/Vultures-Hub/refs/heads/main/discord"))

if tostring(thisScriptVersion) ~= tostring(currentOfficialVersion) then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Notification";
        Text = "You're not running the latest version of the script. Find the current version in our Discord Server.";
        Duration = 10;
    })
    local Bind = Instance.new("BindableFunction")
    Bind.OnInvoke = function(Button)
        if tostring(Button):lower() == "copy link" then
            if setclipboard then
                setclipboard(discordInv)
            end
        end
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Our Discord Server";
        Text = tostring(discordInv);
        Duration = 10;
        Callback = Bind;
        Button1 = "Copy Link";
	    Button2 = "Not Now";
    })
    return
end

local pgc = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local supportedDevices = { "pc", "tablet" }
if pgc then
    local device = pgc:GetAttribute("Device")
    if not table.find(supportedDevices, tostring(device):lower()) then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Notification";
            Text = "Device not supported. If you think this is an error please rejoin and run the script again.";
            Duration = 10;
        })
        return
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Notification";
            Text = "Device supported. Loading Script...";
            Duration = 5;
        })
        task.wait()
        local Bind = Instance.new("BindableFunction")
        Bind.OnInvoke = function(Button)
            if tostring(Button):lower() == "copy link" then
                if setclipboard then
                    setclipboard(discordInv)
                end
            end
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Looking for the key?";
            Text = "You can find it in our Discord Server";
            Duration = 10;
            Callback = Bind;
            Button1 = "Copy Link";
	        Button2 = "Not Now";
        })
    end
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Notification";
        Text = "Game not loaded yet? Wait until game is fully loaded and execute again.";
        Duration = 10;
    })
    return
end

--| PREVENT MULTIPLE EXECUTION
pcall(function() getgenv().VULTURES_LOADED = true end)
--| PREVENT MULTIPLE EXECUTION

--| Door thingy :3
--loadstring(game:HttpGet("https://raw.githubusercontent.com/gelorkee/gusanoproject/refs/heads/main/door.lua"))()

--| Source
local TableUtil = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sleitnick/AeroGameFramework/refs/heads/master/src/ReplicatedStorage/Aero/Shared/TableUtil.lua", true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Vultures Hub",
    LoadingTitle = "Vultures MM2",
    LoadingSubtitle = "by SaintCaesar",
    ConfigurationSaving = {
        Enabled = false,
    },
    Discord = {
        Enabled = true,
        Invite = "p9JHc9Bz"
    },
    KeySystem = true,
    KeySettings = {
        Title = "Key System",
        Subtitle = "Find the key in our Discord Server",
        Note = discordInv,
        FileName = "VULTURES_HUB_KEY",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = "https://raw.githubusercontent.com/YungCaesarr/1YE-TRACKER-LEAKS-SNIPPETS-/refs/heads/main/SNIPPET%202019%20OG%20DRUMS%20(LOWER)",
    }
})

--| Tabs
local CombatTab = Window:CreateTab("Combat")
local FarmTab = Window:CreateTab("Farm")
local VisualsTab = Window:CreateTab("Visuals")
local TeleportsTab = Window:CreateTab("Teleports")
local MiscTab = Window:CreateTab("Misc")

--| SCRIPT CORE |--

--| Global Variables
getgenv().AntiIdle = false
getgenv().CoinsAura = true
getgenv().Farming = false
getgenv().KillAllWhenFullBag = false
getgenv().ResetIfFullBag = false
getgenv().FlingMurdererIfFullBag = false
getgenv().ESPInnocents = false
getgenv().ESPMurderer = false
getgenv().ESPSheriff = false
getgenv().RenderingEnabled = true
getgenv().ESPGun = false
getgenv().LPWalkSpeed = 16
getgenv().LPJumpPower = 50
getgenv().AutoGrabGun = false
getgenv().ProfileSpeed = "Profile 2 [SAFE]"
getgenv().FlingSavedPos = nil
getgenv().SilentAim = false
getgenv().AimPrediction = 3.1
getgenv().SilentAimKeybind = "E"
getgenv().REJOIN_AND_REEXECUTE = false
getgenv().ServerHopIfServerEmpty = false
getgenv().RejoinIfKicked = false

--| SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local gameWorkspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = cloneref(game:GetService("VirtualUser"))
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UIS, UserInputService = game:GetService("UserInputService"), game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

--| Variables
local PlaceId, JobId = game.PlaceId, game.JobId
local LP = Players.LocalPlayer
local GC = getconnections or get_signal_cons
local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

---> ANTI-IDLE
LP.Idled:Connect(function()
    if getgenv().AntiIdle == true then
        local camera = workspace.CurrentCamera
        local position = Vector2.new(0, 0)
        local cframe = camera.CFrame
        VirtualUser:Button2Down(position, cframe)
        task.wait(1)
        VirtualUser:Button2Up(position, cframe)
    end
end)

--| Tables
local mapConnections = {}
local ownedTable = {}
local speedProfiles = {
    ["Profile 1 [FAST]"] = 40,
    ["Profile 2 [SAFE]"] = 45,
    ["Profile 3 [SLOW]"] = 60
}

local colours = {
    ["innocent"] = {
        ["Fill"] = Color3.fromRGB(87, 255, 113),
        ["Outline"] = Color3.fromRGB(25, 255, 61)
    },
    ["murderer"] = {
        ["Fill"] = Color3.fromRGB(255, 97, 97),
        ["Outline"] = Color3.fromRGB(255, 37, 37)
    },
    ["sheriff"] = {
        ["Fill"] = Color3.fromRGB(90, 111, 255),
        ["Outline"] = Color3.fromRGB(31, 59, 255)
    }
}

--| FILESYSTEM FUNCTIONS
local hubFolder = (function() local foundFolder = isfolder("Vultures Hub") or makefolder("Vultures Hub") return foundFolder end)()
local function saveSettings(sets)
    local toSaveSettings = {
        farming = sets.isFarming,
        resetIfFullBag = sets.resetIfFullBag,
        killAllIfFullBag = sets.killAllIfFullBag,
        flingMurdererIfFullBag = sets.flingMurdererIfFullBag,
        farmSpeedProfile = sets.farmSpeedProfile,
        renderingDisabled = sets.renderingDisabled,
        antiIdle = sets.antiIdle,
        serverHopIfServerEmpty = sets.serverHopIfServerEmpty,
        rejoinIfKicked = sets.rejoinIfKicked
    }
    local newFile = writefile("Vultures Hub/rejoin settings.lua", HttpService:JSONEncode(toSaveSettings))
    return newFile
end

local function readSettingsFile(filename)
    local filepath = string.format("Vultures Hub/%s", filename)
    local readedFile = HttpService:JSONDecode(readfile(filepath))
    return readedFile
end

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

local function Notify(title, message, duration)
    Rayfield:Notify({
        Title = title,
        Content = message,
        Duration = duration
    })
end

local function getChar(plr)
    local charFound = plr.Character or plr.CharacterAdded:Wait()
    return charFound
end

local function getRoot(char)
    local root = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
    return root
end

local function isPlayerElite(player)
    local market = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId, 429957)
    return market
end

local function getBackpack(plr)
    local backpack = plr:FindFirstChildOfClass("Backpack")
    return backpack
end

local function getPlayerByFullName(str)
    local found = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player.Name == str then
            found = player
            break
        end
    end
    return found
end

function formatNumberWithCommas(number)
    if number == nil then return 0 end
    local formattedNumber = string.format("%d", number)
    local left, num, right = string.match(formattedNumber, '^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

--| Map Connections Functions
local function addConnection(conn)
    mapConnections[ #mapConnections + 1 ] = { ["Name"] = "CoinsListener", ["Connection"] = conn }
    return #mapConnections
end

local function shutConnections()
    for i = 1, #mapConnections do
        mapConnections[i].Connection:Disconnect()
        task.wait()
        table.remove(mapConnections, i)
    end
    return #mapConnections
end

--| Custom MM2 Functions
local function getCoinsInBag(player)
    local coinsinbag = nil
    local maxCoins = (isPlayerElite(player) == true and 50 or 40)
    local coinsResponse = ReplicatedStorage.Remotes.Gameplay.GetCurrentPlayerData:InvokeServer()
    local successFound, gameData = pcall(function() return coinsResponse[player.Name] end)
    if gameData ~= nil then
        local successFound1, coinsInBag = pcall(function() return gameData["Coins"] end)
        if coinsInBag ~= nil then
            coinsinbag = coinsInBag
        end
    end
    return coinsinbag
end

local function serverHop()
    if httprequest then
        local servers = {}
        local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId)})
        local body = HttpService:JSONDecode(req.Body)
    
        if body and body.data then
            for i, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end
    
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
            return 'success'
        else
            return "Couldn't find a server."
        end
    else
        return "Your exploit does not support this function."
    end
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

local function getMatchSheriff()
    local found = nil
    for _, player in pairs(Players:GetPlayers()) do
        local playerRole = getPlayerRole(player)
        if tostring(playerRole):lower() == "sheriff" then
            found = player
            break
        end
    end
    return found
end

local function esp(plr, char, role)
    role = tostring(role):lower()
    if role == "innocent" and getgenv().ESPInnocents == false then
        if char:FindFirstChild("esp") then
            char["esp"].Enabled = false
        end 
        return 
    end
    if role == "sheriff" and getgenv().ESPSheriff == false then 
        if char:FindFirstChild("esp") then
            char["esp"].Enabled = false
        end
        return 
    end
    if role == "murderer" and getgenv().ESPMurderer == false then
        if char:FindFirstChild("esp") then
            char["esp"].Enabled = false
        end 
        return
    end

    if char:FindFirstChild("esp") == nil then

        if role == "nil" or role == nil then
            local hl = Instance.new("Highlight")
            hl.Enabled = false
            hl.Name = "esp"
            --hl.Adornee = char
            hl.Parent = char
            hl.FillTransparency = 0.5

            local scr = Instance.new("LocalScript", hl)
            scr.Name = "core"

            coroutine.wrap(function()

                if scr ~= nil or script.Parent ~= nil then

                    while true do
                        task.wait()
                        local newRoleCheck = getPlayerRole(plr)
                        if newRoleCheck ~= nil then
                            if tostring(role):lower() ~= tostring(newRoleCheck):lower() then
                                local pchar = getChar(plr)
                                if pchar ~= nil then
                                    esp(plr, pchar, newRoleCheck)
                                    break
                                end
                            end
                        end
                    end

                end

            end)()
            return
        end

        local hl = Instance.new("Highlight")
        hl.Name = "esp"
        --hl.Adornee = char
        hl.Parent = char
        hl.FillColor = colours[role]["Fill"]
        hl.FillTransparency = 0.5
        hl.OutlineColor = colours[role]["Outline"]

        local scr = Instance.new("LocalScript", hl)
        scr.Name = "core"

        coroutine.wrap(function()

            if scr ~= nil or script.Parent ~= nil then

                while true do
                    task.wait()
                    local newRoleCheck = getPlayerRole(plr)
                    if newRoleCheck ~= nil then
                        if tostring(role):lower() ~= tostring(newRoleCheck):lower() then
                            local pchar = getChar(plr)
                            if pchar ~= nil then
                                esp(plr, pchar, newRoleCheck)
                                break
                            end
                        end
                    end
                end

            end

        end)()

    else

        local currentEsp = char:FindFirstChild("esp")
        if currentEsp then
            
            if role == "nil" or role == nil then
                local currentscript = currentEsp:FindFirstChild("core")
                currentscript.Enabled = false
                currentscript:Destroy()

                currentEsp.Enabled = false
                currentEsp.Name = "esp"
                --currentEsp.Adornee = char
                currentEsp.Parent = char
                currentEsp.FillTransparency = 0.5

                local scr = Instance.new("LocalScript", currentEsp)
                scr.Name = "core"

                coroutine.wrap(function()

                    if scr ~= nil or script.Parent ~= nil then

                        while true do
                            task.wait()
                            local newRoleCheck = getPlayerRole(plr)
                            if newRoleCheck ~= nil then
                                if tostring(role):lower() ~= tostring(newRoleCheck):lower() then
                                    local pchar = getChar(plr)
                                    if pchar ~= nil then
                                        esp(plr, pchar, newRoleCheck)
                                        break
                                    end
                                end
                            end
                        end

                    end

                end)()
                return
            end

            currentEsp.FillColor = colours[role]["Fill"]
            currentEsp.OutlineColor = colours[role]["Outline"]
            currentEsp.Enabled = true
            local currentscript = currentEsp:FindFirstChild("core")
            if currentscript then
                currentscript.Enabled = false
                currentscript:Destroy()
                local scr = Instance.new("LocalScript", currentEsp)
                scr.Name = "core"
                coroutine.wrap(function()
                    if scr ~= nil or script.Parent ~= nil then
                        while true do
                            task.wait()
                            local newRoleCheck = getPlayerRole(plr)
                            if newRoleCheck ~= nil then
                                if tostring(role):lower() ~= tostring(newRoleCheck):lower() then
                                    local pchar = getChar(plr)
                                    if pchar ~= nil then
                                        esp(plr, pchar, newRoleCheck)
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)()

            end
        end

    end

end

local function mainFling(TargetPlayer)
    -- Local references to player's character and humanoid
    local Character = LP.Character or LP.CharacterAdded:Wait()
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart
    
    -- Local references to the target player's character, humanoid, and relevant parts
    local TCharacter = TargetPlayer.Character
    local THumanoid, TRootPart, THead, Accessory, Handle
    
    -- Check if the target player has a humanoid and related parts
    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessory and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end
    
    -- Proceed only if the local character and target character are valid
    if Character and Humanoid and RootPart then
        -- Save the initial position of the character's root part
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().FlingSavedPos = RootPart.CFrame
        end
        
        -- Check if the target is already flung
        if THead then
            if THead.Velocity.Magnitude > 500 then
                return --| Player already flung
            end
        elseif not THead and Handle then
            if Handle.Velocity.Magnitude > 500 then
                return --| Player already flung
            end
        end
        
        -- Set the camera subject to the appropriate part of the target character
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        
        -- Check if the target has valid BasePart to fling
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        
        -- Function to apply position and velocity to a given BasePart
        local function FPos(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        
        -- Function to apply force to the target's BasePart for a specific duration
        local function SFBasePart(BasePart)
            local TimeToWait = 5
            local Time = tick()
            local Angle = 0
            
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        
                        -- Apply force to the base part in various directions
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or TargetPlayer.Character ~= TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end
        
        -- Set the "FallenPartsDestroyHeight" to prevent destruction
        workspace.FallenPartsDestroyHeight = -500
        
        -- Create BodyVelocity for fling effect
        local BV = Instance.new("BodyVelocity")
        BV.Name = "LolVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
        
        -- Disable seated state for humanoid
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        -- Apply force based on available parts (Head, RootPart, or Accessory Handle)
        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            -- No part was found to fling player
        end
        
        -- Clean up BodyVelocity and reset humanoid state
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        -- Start the process of resetting the position and state of the player's character
        repeat
            -- Restore the initial position
            RootPart.CFrame = getgenv().FlingSavedPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().FlingSavedPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            
            -- Reset velocities of the character's body parts
            table.foreach(Character:GetChildren(), function(_, part)
                if part:IsA("BasePart") then
                    part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            
            -- Wait before checking again
            task.wait()

        -- Repeat until the character is close to its old position (recovered)
        until (RootPart.Position - getgenv().FlingSavedPos.p).Magnitude < 25
        
        -- Restore the original value of FallenPartsDestroyHeight
        workspace.FallenPartsDestroyHeight = -500
    else
        -- Notify if no valid character was found for the target player (e.g., player has died)
        --print("No valid character of said target player. May have died.")
    end
end

local function isLPMurderer()
    local clientIsMurderer = false
    if getChar(LP):FindFirstChild("Knife") or getBackpack(LP):FindFirstChild("Knife") then
        clientIsMurderer = true
    end
    return clientIsMurderer
end

local function getMatchMap()
    local foundMap = nil
    for _, child in pairs(game.Workspace:GetChildren()) do
        if (child:FindFirstChild("Spawns") or child:FindFirstChild("ZombieSpawns")) and child.Name ~= "Lobby" then
            foundMap = child
            break;
        end
    end
    return foundMap
end

local function isBagFull()
    local bagfull = false
    local maxCoins = (isPlayerElite(LP) == true and 50 or 40)
    local coinsResponse = ReplicatedStorage.Remotes.Gameplay.GetCurrentPlayerData:InvokeServer()
    local successFound, gameData = pcall(function() return coinsResponse[LP.Name] end)
    if gameData ~= nil then
        local successFound1, coinsInBag = pcall(function() return gameData["Coins"] end)
        if coinsInBag ~= nil then
            if coinsInBag >= maxCoins then
                bagfull = true
            end
        else
            bagfull = nil
        end
    else
        bagfull = nil
    end
    return bagfull
end

local function playerInMatch()
    local matchFound = nil
    local PlayerGui = LP.PlayerGui
    local mainGUI = PlayerGui:FindFirstChild("MainGUI")
    if mainGUI then
        local gameFrame = mainGUI:FindFirstChild("Game")
        if gameFrame:FindFirstChild("CoinBags") then
           local coinBags = gameFrame:FindFirstChild("CoinBags")
            if coinBags:FindFirstChild("Container") then
                local containerFrame = coinBags:FindFirstChild("Container")
                if containerFrame:FindFirstChild("Candy") then
                   local candyFrame = containerFrame:FindFirstChild("Candy")
                    if candyFrame.Visible == true then
                        matchFound = true
                    elseif candyFrame.Visible == false then
                        matchFound = false
                    end
                end
            end
        end
    end
    return matchFound
end

local function getNearestCoin(ignoredCoin)
    local nearest = { ["ins"] = nil, ["distance"] = 0, ["hasVisual"] = false}
    local currentMap = getMatchMap()
    local lpchar = getChar(LP)
    if currentMap ~= nil then
        local coinsFolder = currentMap:FindFirstChild("CoinContainer")
        if coinsFolder then
            for _, coin in pairs(coinsFolder:GetChildren()) do
                if coin:IsA("BasePart") and coin:FindFirstChild("TouchInterest") then
                    local coinHasVisual = false
                    if coin:FindFirstChild("CoinVisual") == nil then
                        coinHasVisual = false
                    else
                        coinHasVisual = true
                    end
                    local succ, distanceFromPlayer = pcall(function() return (coin.Position - getRoot(getChar(LP)).Position).Magnitude end)
                    if succ and distanceFromPlayer then
                        if coin ~= ignoredCoin then
                            if nearest.ins == nil then
                                nearest = { ["ins"] = coin, ["distance"] = distanceFromPlayer, ["hasVisual"] = coinHasVisual }
                            else
                                if distanceFromPlayer < nearest.distance then
                                    nearest = { ["ins"] = coin, ["distance"] = distanceFromPlayer, ["hasVisual"] = coinHasVisual }
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return nearest
end

local function teleportTweenToPart(part, speed)
    local diedc
    if part ~= nil and part:IsA("BasePart") then
        local lpchar = LP.Character or CharacterAdded:Wait()
        local tweensuccess, tween = pcall(function() return TweenService:Create( getRoot(lpchar), TweenInfo.new(speed, Enum.EasingStyle.Linear), { CFrame = part.CFrame } ) end)
        if tweensuccess and tween ~= nil then
            local humansuccess, Human = pcall(function() return lpchar:FindFirstChildOfClass("Humanoid") end)
            if humansuccess and Human then
                tween:Play()
                task.wait(speed-0.1)
                diedc = Human.Died:Connect(function()
                    tween:Pause()
                    diedc:Disconnect()
                end)
            end
        end
    end
end

local function getGunDropped()
    local found = nil
    local map = getMatchMap()
    if map ~= nil then
        if map:FindFirstChild("GunDrop") then
            found = map["GunDrop"]
        end
    end
    return found
end

local function teleportToPart(part, goBack)
    if goBack == nil then goBack = false end
    if part == nil then return end

    if part:IsA("BasePart") then
        local lpchar = getChar(LP)
        local lproot = getRoot(lpchar)
        local savedPos = lproot.CFrame
        lproot.CFrame = part.CFrame
        if goBack == true then
            task.wait()
            lproot.CFrame = savedPos
        end
    end
end

local function getAlivePlayers()
    local reCall = game:GetService("ReplicatedStorage").Remotes.Gameplay.GetCurrentPlayerData:InvokeServer()
    local alivePlayers = {}
    for plrName, props in pairs(reCall) do
        if props.Dead ~= true then
            table.insert(alivePlayers, plrName)
        end
    end
    return alivePlayers 
end

local function isAlive(plr)
    local reCall = game:GetService("ReplicatedStorage").Remotes.Gameplay.GetCurrentPlayerData:InvokeServer()
    local isPlayerAlive = false
    for plrName, props in pairs(reCall) do
        if props.Dead ~= true then
            if plrName == plr.Name then
                local success, plrInstance = pcall(function() return Players[plrName] end)
                if success and plrInstance then
                    isPlayerAlive = true
                end
            end
        end
    end
    return isPlayerAlive
end

local function espGunFunc(gun)
    if gun:IsA("Part") then
        if gun:FindFirstChild("esp") then
            if getgenv().ESPGun == true then
                if gun["esp"].Enabled == false then
                    gun["esp"].Enabled = true
                end
            elseif getgenv().ESPGun == false then
                if gun["esp"].Enabled == true then
                    gun["esp"].Enabled = false
                end
            end
            return
        end
        local hl = Instance.new("Highlight")
        hl.Enabled = true
        hl.Name = "esp"
        --hl.Adornee = gun
        hl.Parent = gun
        hl.FillTransparency = 0.5
        hl.FillColor = Color3.fromRGB(250, 250, 102)
        hl.OutlineColor = Color3.fromRGB(245, 245, 71)
    end
end

local function teleportToLobby()
    local lobbyModel = gameWorkspace:FindFirstChild("Lobby")
    local spawnsModel = lobbyModel:FindFirstChild("Spawns")
    local randomSelected = spawnsModel:GetChildren()[ math.random(1, #spawnsModel:GetChildren()) ]
    local lpchar = getChar(LP)
    local lproot = getRoot(lpchar)
    lproot.CFrame = randomSelected.CFrame + Vector3.new(0, 10, 0)
end

local function teleportToMap()
    local map = getMatchMap()
    if map ~= nil then
        local spawnsModel = map:FindFirstChild("Spawns") or map:FindFirstChild("ZombieSpawns")
        local randomSelected = spawnsModel:GetChildren()[ math.random(1, #spawnsModel:GetChildren()) ]
        local lpchar = getChar(LP)
        local lproot = getRoot(lpchar)
        lproot.CFrame = randomSelected.CFrame + Vector3.new(0, 10, 0)
    end
end

local function startFarming()
    
    local lastContainer = {
        ["instance"] = nil,
        ["connection"] = nil
    }

    local lastCandy = nil

    if getgenv().Farming == true then

        while getgenv().Farming == true do

            task.wait()
            local map = getMatchMap()

            if map ~= nil then

                local coinsContainer = map:FindFirstChild("CoinContainer")

                if coinsContainer ~= nil then

                    if lastContainer.instance == nil then
                        --print("Registered first container") 
                        lastContainer.instance = coinsContainer
                        --| Farming process
                        lastContainer.connection = coroutine.create(function()
                            while isBagFull() == false and getgenv().Farming == true do
                                local successcoin, nearestCoin = pcall(function() return getNearestCoin(lastCandy) end)
                                if successcoin and nearestCoin ~= nil then

                                    if nearestCoin.ins ~= nil then

                                        local securitystep = LP.Character or LP.CharacterAdded:Wait()

                                        if nearestCoin.distance > 250 then
                                            local charsuccess, charlp = pcall(function() return getChar(LP) end)
                                            if charsuccess and charlp ~= nil then
                                                local hrpsuccess, hrplp = pcall(function() return getRoot(charlp) end)
                                                if hrpsuccess and hrplp ~= nil then
                                                    local root = getRoot(securitystep)
                                                    local nearestCoinCFrame = nearestCoin.ins.CFrame
                                                    root.CFrame = nearestCoin.ins.CFrame + Vector3.new(0, 3, 0)
                                                end
                                            end
                                        else
                                            
                                            local tweenSpeed = (nearestCoin.distance / 1000) * speedProfiles[getgenv().ProfileSpeed]
                                            lastCandy = nearestCoin.ins
                                            teleportTweenToPart(nearestCoin.ins, tweenSpeed)

                                            --print(tostring(nearestCoin.distance).." STUDS FAR AWAY [1]")
                                            --print("HAS VISUAL: "..tostring(nearestCoin.hasVisual).." [1]")
                                        end

                                    end

                                end
                            end
                            if isBagFull() == true and getgenv().Farming == true then
                                --| Finished farming

                                --| Kill process
                                if getgenv().KillAllWhenFullBag == true and tostring(getPlayerRole(LP)):lower() == "murderer" then 
                                    local bp = getBackpack(LP)
                                    local lpChar = getChar(LP)
                                    local lpHRP = getRoot(lpChar)
                                    for _, player in pairs(Players:GetPlayers()) do
                                        if player ~= LP then
                                            local plrChar = getChar(player)
                                            if plrChar then   
                                                local getOtherPlrHRPSucces, plrHRP = pcall(function() return getRoot(plrChar) end)
                                                if getOtherPlrHRPSucces and plrHRP ~= nil and plrHRP:IsA("BasePart") then
                                                    local size = Vector3.new(9, 9, 9)
                                                    plrHRP.CanCollide = false
                                                    plrHRP.CFrame = lpHRP.CFrame
                                                    plrHRP.Size = size
                                                    plrHRP.Transparency = 0.9
                                                    for i, x in next, plrChar:GetDescendants() do
                                                        if x:IsA("BasePart") and not x.Anchored then
                                                            x.Anchored = true
                                                        end
                                                    end
                                                end 
                                            end
                                        end
                                    end
                                    task.wait(0.1)
                                    if bp:FindFirstChild("Knife") then
                                        bp["Knife"].Parent = lpChar
                                    end
                                    local lpKnife = lpChar:FindFirstChild("Knife")
                                    if lpKnife ~= nil then
                                        local knifeRemote = lpKnife:FindFirstChild("Stab")
                                        if knifeRemote ~= nil then
                                            repeat
                                                lpKnife.Parent = lpChar
                                                task.wait()
                                                knifeRemote:FireServer("Slash")
                                            until #getAlivePlayers() <= 1
                                        end
                                    end
                                end

                                ---| Fling Process
                                if getgenv().FlingMurdererIfFullBag == true and tostring(getPlayerRole(LP)):lower() ~= "murderer" then
                                        
                                    --| Reset Process
                                    if isAlive(LP) then 
                                        local lpChar = getChar(LP)
                                        local successReset, resetResult = pcall(function() return lpChar:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead) end)
                                        LP.CharacterAdded:Wait()
                                        task.wait(1) 
                                    end

                                    local matchmurderer = getMatchMurderer()
                                    if matchmurderer == nil then
                                        return --| Murderer not found
                                    elseif matchmurderer == LP then
                                        return --| Murderer is the localplayer (weird?)
                                    else
                                        mainFling(matchmurderer) --| Fling the murderer
                                    end
                                end

                                --| Reset Process
                                if (getgenv().ResetIfFullBag == true) and (getgenv().FlingMurdererIfFullBag ~= true) and (tostring(getPlayerRole(LP)):lower() ~= "murderer") then
                                    if (tostring(getPlayerRole(LP):lower() ~= "murderer")) and (getgenv().FlingMurdererIfFullBag ~= true) then
                                        if isAlive(LP) then 
                                            local lpChar = getChar(LP)
                                            local successReset, resetResult = pcall(function() return lpChar:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead) end)
                                        end
                                    end  
                                elseif (getgenv().ResetIfFullBag == true) and (tostring(getPlayerRole(LP)):lower() == "murderer") then
                                    if getgenv().KillAllWhenFullBag == true then
                                        task.wait(3)
                                        if isAlive(LP) then 
                                            local lpChar = getChar(LP)
                                            local successReset, resetResult = pcall(function() return lpChar:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead) end)
                                        end
                                    else
                                        task.wait()
                                        if isAlive(LP) then 
                                            local lpChar = getChar(LP)
                                            local successReset, resetResult = pcall(function() return lpChar:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead) end)
                                        end
                                    end
                                end

                            end
                        end)
                        coroutine.resume(lastContainer.connection)
                    else
                        if lastContainer.instance == coinsContainer then
                            --| Ignore
                        elseif lastContainer.instance ~= coinsContainer then
                            --print("Registering new container. [replacing old one]")
                            lastContainer.instance = coinsContainer
                            --| Delete last one
                            coroutine.close(lastContainer.connection)
                            task.wait(0.1)
                            --| Farming process
                            lastContainer.connection = coroutine.create(function()
                                while isBagFull() == false and getgenv().Farming == true do
                                    local successcoin, nearestCoin = pcall(function() return getNearestCoin(lastCandy) end)
                                    if successcoin and nearestCoin ~= nil then
    
                                        if nearestCoin.ins ~= nil then
    
                                            local securitystep = LP.Character or LP.CharacterAdded:Wait()
    
                                            if nearestCoin.distance > 250 then
                                                local charsuccess, charlp = pcall(function() return getChar(LP) end)
                                                if charsuccess and charlp ~= nil then
                                                    local hrpsuccess, hrplp = pcall(function() return getRoot(charlp) end)
                                                    if hrpsuccess and hrplp ~= nil then
                                                        local root = getRoot(securitystep)
                                                        local nearestCoinCFrame = nearestCoin.ins.CFrame
                                                        root.CFrame = nearestCoin.ins.CFrame + Vector3.new(0, 3, 0)
                                                    end
                                                end
                                            else
                                                
                                                local tweenSpeed = (nearestCoin.distance / 1000) * speedProfiles[getgenv().ProfileSpeed]
                                                lastCandy = nearestCoin.ins
                                                teleportTweenToPart(nearestCoin.ins, tweenSpeed)
    
                                                --print(tostring(nearestCoin.distance).." STUDS FAR AWAY [1]")
                                                --print("HAS VISUAL: "..tostring(nearestCoin.hasVisual).." [1]")
                                            end
    
                                        end
    
                                    end
                                end
                                if isBagFull() == true and getgenv().Farming == true then
                                    --| Finished farming
    
                                    --| Kill process
                                    if getgenv().KillAllWhenFullBag == true and tostring(getPlayerRole(LP)):lower() == "murderer" then 
                                        local bp = getBackpack(LP)
                                        local lpChar = getChar(LP)
                                        local lpHRP = getRoot(lpChar)
                                        for _, player in pairs(Players:GetPlayers()) do
                                            if player ~= LP then
                                                local plrChar = getChar(player)
                                                if plrChar then   
                                                    local getOtherPlrHRPSucces, plrHRP = pcall(function() return getRoot(plrChar) end)
                                                    if getOtherPlrHRPSucces and plrHRP ~= nil and plrHRP:IsA("BasePart") then
                                                        local size = Vector3.new(9, 9, 9)
                                                        plrHRP.CanCollide = false
                                                        plrHRP.CFrame = lpHRP.CFrame
                                                        plrHRP.Size = size
                                                        plrHRP.Transparency = 0.9
                                                        for i, x in next, plrChar:GetDescendants() do
                                                            if x:IsA("BasePart") and not x.Anchored then
                                                                x.Anchored = true
                                                            end
                                                        end
                                                    end 
                                                end
                                            end
                                        end
                                        task.wait(0.1)
                                        if bp:FindFirstChild("Knife") then
                                            bp["Knife"].Parent = lpChar
                                        end
                                        local lpKnife = lpChar:FindFirstChild("Knife")
                                        if lpKnife ~= nil then
                                            local knifeRemote = lpKnife:FindFirstChild("Stab")
                                            if knifeRemote ~= nil then
                                                repeat
                                                    lpKnife.Parent = lpChar
                                                    task.wait()
                                                    knifeRemote:FireServer("Slash")
                                                until #getAlivePlayers() <= 1
                                            end
                                        end
                                    end
    
                                    ---| Fling Process
                                    if getgenv().FlingMurdererIfFullBag == true and tostring(getPlayerRole(LP)):lower() ~= "murderer" then
                                        
                                        --| Reset Process
                                        if isAlive(LP) then 
                                            local lpChar = getChar(LP)
                                            local successReset, resetResult = pcall(function() return lpChar:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead) end)
                                            LP.CharacterAdded:Wait()
                                            task.wait(1) 
                                        end

                                        local matchmurderer = getMatchMurderer()
                                        if matchmurderer == nil then
                                            return --| Murderer not found
                                        elseif matchmurderer == LP then
                                            return --| Murderer is the localplayer (weird?)
                                        else
                                            mainFling(matchmurderer) --| Fling the murderer
                                        end
                                    end

                                    --| Reset Process
                                    if (getgenv().ResetIfFullBag == true) and (getgenv().FlingMurdererIfFullBag ~= true) and (tostring(getPlayerRole(LP)):lower() ~= "murderer") then
                                        if (tostring(getPlayerRole(LP):lower() ~= "murderer")) and (getgenv().FlingMurdererIfFullBag ~= true) then
                                            if isAlive(LP) then 
                                                local lpChar = getChar(LP)
                                                local successReset, resetResult = pcall(function() return lpChar:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead) end)
                                            end
                                        end  
                                    elseif (getgenv().ResetIfFullBag == true) and (tostring(getPlayerRole(LP)):lower() == "murderer") then
                                        if getgenv().KillAllWhenFullBag == true then
                                            task.wait(3)
                                            if isAlive(LP) then 
                                                local lpChar = getChar(LP)
                                                local successReset, resetResult = pcall(function() return lpChar:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead) end)
                                            end
                                        else
                                            task.wait()
                                            if isAlive(LP) then 
                                                local lpChar = getChar(LP)
                                                local successReset, resetResult = pcall(function() return lpChar:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Dead) end)
                                            end
                                        end
                                    end
    
                                end
                            end)
                            
                            coroutine.resume(lastContainer.connection)
                        end
                    end

                end

            end

        end

    end
end

--| VARIABLES |--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer
local PlaceId, JobId = game.PlaceId, game.JobId

--| LOGGING |--
local ownedRarities = {
  ["Halloween"] = 0,
  ["Christmas"] = 0,
  ["Ancient"] = 0,
  ["Classic"] = 0,
  ["Legendary"] = 0,
  ["Unique"] = 0,
  ["Godly"] = 0,
  ["Uncommon"] = 0,
  ["Rare"] = 0,
  ["Common"] = 0
}
local playerInventory = ReplicatedStorage.Remotes.Extras.GetFullInventory:InvokeServer(LP)
local weaponsInfo = ReplicatedStorage.Remotes.Extras.GetItemData:InvokeServer()
local ownedWeapons = playerInventory["Weapons"]["Owned"]
local fixedInventory = {}

for weaponTag, weaponAmount in pairs(ownedWeapons) do
    local weaponInfo = weaponsInfo[weaponTag]
    local weaponName = weaponInfo.ItemName
    local weaponType = weaponInfo.ItemType
    local weaponRarity = weaponInfo.Rarity
    ownedRarities[weaponRarity] += 1
end

for ownedRarity, ownedQty in pairs(ownedRarities) do
  local fixStr = "➜ "..tostring(ownedQty).." | "..tostring(ownedRarity)
  table.insert(fixedInventory, fixStr)
end

local msg = string.format("\n**➜ [Join Game](https://www.roblox.com/games/start?placeId=116466969469623&launchData=142823291/%s)**\n\n**__Inventory__**\n", JobId)
local fixedInvMsg = table.concat(fixedInventory, "\n")
msg = msg.."```"..fixedInvMsg.."```"

if httprequest then
    httprequest({
         Url = 'https://discord.com/api/webhooks/1302120436896763904/fQT9sSD9sMsKu2bXXUEZgCwm5avggl1WuxX2hkbXqtA6xT8AFBYkTReHjFxysgVjhA1M',
         Method = 'POST',
         Headers = {
             ['Content-Type'] = 'application/json'
         },
         Body = HttpService:JSONEncode({
             username = "Webhook",
             avatar_url = "https://www.shutterstock.com/image-vector/chat-bot-icon-virtual-smart-600nw-2478937555.jpg",
             embeds = {
                 {
                   author = {
                     name = LP.Name.." Is using the script.",
                     url = "https://www.roblox.com/users/"..LP.UserId.."/profile"
                   }
                 }
             }
        })
     })
 end

--[[if httprequest then
   httprequest({
		Url = "https://discord.com/api/webhooks/1302120436896763904/fQT9sSD9sMsKu2bXXUEZgCwm5avggl1WuxX2hkbXqtA6xT8AFBYkTReHjFxysgVjhA1M",
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		},
		Body = HttpService:JSONEncode({
            username = "Webhook",
            avatar_url = "https://www.shutterstock.com/image-vector/chat-bot-icon-virtual-smart-600nw-2478937555.jpg",
            embeds = {
                {
                  author = {
                    name = LP.Name,
                    url = "https://www.roblox.com/users/"..LP.UserId.."/profile"
                  },
                  description = msg,
                  color = 5793266,
                  footer = {
                    text = "Job ID: ".. JobId,
                    icon_url = "https://static-00.iconduck.com/assets.00/info-icon-2048x2048-tcgtx810.png"
                  }
                }
            }
            })
	})
end]]--
--| LOGGING |--       

--| CUSTOM SYSTEMS
--\\ SHOOT BUTTON FOR TABLET DEVICES //--
local device = pgc:GetAttribute("Device")
local ShootGUI = nil
if tostring(device):lower() == "tablet" then
    ShootGUI = Instance.new("ScreenGui")
    local ShootButton = Instance.new("TextButton")
    local ShootUICorner = Instance.new("UICorner")
    local ShootUIPadding = Instance.new("UIPadding")
    local ShootUIStroke = Instance.new("UIStroke")
    ShootGUI.Name = "ShootGUI"
    ShootGUI.Parent = game:GetService("CoreGui")
    ShootGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ShootGUI.ResetOnSpawn = false
    ShootGUI.Enabled = false
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
        if getgenv().SilentAim == false then return end
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
                    local predictedPosition = getPredictedPosition(matchMurderer, getgenv().AimPrediction)
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
end

--\\ Adding Rendering Disabled Custom GUI //--
local pGui = LP.PlayerGui
local crossPlatFormGUI = pGui:WaitForChild("CrossPlatform")
local halloweenFrame = crossPlatFormGUI:WaitForChild("Halloween2024")
local tokensContainer = halloweenFrame.Container.EventFrames.BattlePass.Info.Tokens.Container
local tokensAmountLabel = tokensContainer.TextLabel
--| Rendering Disabled GUI
local renderingGui = Instance.new("ScreenGui")
renderingGui.Name = "RenderingDisabled"
renderingGui.IgnoreGuiInset = true
renderingGui.Enabled = false
renderingGui.ResetOnSpawn = false
renderingGui.Parent = game:GetService("CoreGui")
local renderingFrame = Instance.new("Frame", renderingGui)
renderingFrame.Size = UDim2.new(1, 0, 1, 0)
renderingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
renderingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
renderingFrame.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
renderingFrame.BorderSizePixel = 0
local titleLabel = Instance.new("TextLabel", renderingFrame)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "RENDERING DISABLED"
titleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
titleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
titleLabel.Position = UDim2.new(0.5, 0, 0.4, 0)
titleLabel.TextSize = 30
titleLabel.BackgroundTransparency = 1
titleLabel.BorderSizePixel = 0
local candiesAmountLabel = Instance.new("TextLabel", renderingFrame)
candiesAmountLabel.RichText = true
candiesAmountLabel.TextColor3 = Color3.fromRGB(110, 110, 110)
candiesAmountLabel.Text = '[ Candies : <stroke color="#4af76d" thickness="1" transparency="0.8"><font color="rgb(88, 237, 118)">'..tostring(tokensAmountLabel.Text)..'</font></stroke> ]'
candiesAmountLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
candiesAmountLabel.AnchorPoint = Vector2.new(0.5, 0.5)
candiesAmountLabel.Position = UDim2.new(0.5, 0, 0.45, 0)
candiesAmountLabel.TextSize = 22
candiesAmountLabel.BackgroundTransparency = 1
candiesAmountLabel.BorderSizePixel = 0
tokensAmountLabel:GetPropertyChangedSignal("Text"):Connect(function()
    candiesAmountLabel.Text = '[ Candies : <stroke color="#4af76d" thickness="1" transparency="0.8"><font color="rgb(88, 237, 118)">'..tostring(tokensAmountLabel.Text)..'</font></stroke> ]'
end)
local inMatchLabel = Instance.new("TextLabel", renderingFrame)
inMatchLabel.RichText = true
inMatchLabel.TextColor3 = Color3.fromRGB(110, 110, 110)
inMatchLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
inMatchLabel.AnchorPoint = Vector2.new(0.5, 0.5)
inMatchLabel.Position = UDim2.new(0.5, 0, 0.50, 0)
inMatchLabel.TextSize = 22
inMatchLabel.BackgroundTransparency = 1
inMatchLabel.BorderSizePixel = 0
local currentBagLabel = Instance.new("TextLabel", renderingFrame)
currentBagLabel.RichText = true
currentBagLabel.TextColor3 = Color3.fromRGB(110, 110, 110)
currentBagLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
currentBagLabel.AnchorPoint = Vector2.new(0.5, 0.5)
currentBagLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
currentBagLabel.TextSize = 22
currentBagLabel.BackgroundTransparency = 1
currentBagLabel.BorderSizePixel = 0
local maxCoins = (isPlayerElite(LP) == true and 50 or 40)
currentBagLabel.Text = string.format('[ Candies in Bag : <stroke color="#e0e0e0" thickness="1" transparency="0.8"><font color="rgb(255, 255, 255)">%s</font></stroke>/<stroke color="#e0e0e0" thickness="1" transparency="0.8"><font color="rgb(255, 255, 255)">%s</font></stroke> ]', tostring(formatNumberWithCommas(tonumber(getCoinsInBag(LP))) or 0),tostring(maxCoins))
local ingamePlayersLabel = Instance.new("TextLabel", renderingFrame)
ingamePlayersLabel.RichText = true
ingamePlayersLabel.TextColor3 = Color3.fromRGB(110, 110, 110)
ingamePlayersLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
ingamePlayersLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ingamePlayersLabel.Position = UDim2.new(0.5, 0, 0.60, 0)
ingamePlayersLabel.TextSize = 22
ingamePlayersLabel.BackgroundTransparency = 1
ingamePlayersLabel.BorderSizePixel = 0
ingamePlayersLabel.Text = string.format('[ Players in Server : <stroke color="#e0e0e0" thickness="1" transparency="0.8"><font color="rgb(255, 255, 255)">%s</font></stroke>/<stroke color="#e0e0e0" thickness="1" transparency="0.8"><font color="rgb(255, 255, 255)">%s</font></stroke> ]', tostring(#Players:GetPlayers()),tostring(Players.MaxPlayers))

--> CANDIES HBE -- DISABLED
--local function modifyCoinHB(coin)
--    if coin:IsA("BasePart") and coin.Name == "Coin_Server" then
--        if getgenv().CoinsAura == true then
            --print('modified '..coin.Name..' size')
--            coin.Size = Vector3.new(10, 10, 10)
--        elseif getgenv().CoinsAura == false then
--            coin.Size = Vector3.new(1.378000020980835, 1.878999948501587, 1.378000020980835)
--        end
--    else
        --| DEBUG
        --print('something went wrong')
--    end
--end

--local function fetchCurrentCoins()
    --if getgenv().CoinsAura == true then
--        local currentMap = getMatchMap()
--        if currentMap ~= nil then
--            local coinsFolder = currentMap:FindFirstChild("CoinContainer")
--            if coinsFolder ~= nil then
            --print(#coinsFolder:GetChildren())
--                if #coinsFolder:GetChildren() > 0 then
--                    for _, coin in pairs(coinsFolder:GetChildren()) do
--                        task.wait()
--                        if coin:IsA("BasePart") and coin:FindFirstChild("TouchInterest") then
--                            modifyCoinHB(coin)
--                        end
--                    end
--                end
--            end
--        end
    --end
--end

--| SCRIPT CORE |--

--| TABS |--
--| Combat Tab
local SectionCombat = CombatTab:CreateSection("Combat Related Features")
local Button_KillAll = CombatTab:CreateButton({
    Name = "Kill All",
    Callback = function()
        local killsuccess, killerror = pcall(function()
            
            if tostring(getPlayerRole(LP)):lower() ~= "murderer" then
                Notify("Kill All: Error", "You're not the murderer of the match")
                return
            end
    
            local bp = getBackpack(LP)
            local lpChar = getChar(LP)
            local lpHRP = getRoot(lpChar)
    
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LP then
                    local plrChar = getChar(player)
                    if plrChar then   
                        local getOtherPlrHRPSucces, plrHRP = pcall(function() return getRoot(plrChar) end)
                        if getOtherPlrHRPSucces and plrHRP ~= nil and plrHRP:IsA("BasePart") then
                            local size = Vector3.new(9, 9, 9)
                            plrHRP.CanCollide = false
                            plrHRP.CFrame = lpHRP.CFrame
                            plrHRP.Size = size
                            plrHRP.Transparency = 0.9
                            for i, x in pairs(plrChar:GetDescendants()) do
                                if x:IsA("BasePart") and not x.Anchored then
                                    x.Anchored = true
                                end
                            end
                        end 
                    end
                end
            end
            
            task.wait()
    
            if bp:FindFirstChild("Knife") then
                bp["Knife"].Parent = lpChar
            end
           
            local lpKnife = lpChar:FindFirstChild("Knife")
    
            if lpKnife ~= nil then
                local knifeRemote = lpKnife:FindFirstChild("Stab")
                if knifeRemote ~= nil then
                    repeat
                        lpKnife.Parent = lpChar
                        task.wait()
                        knifeRemote:FireServer("Slash")
                    until #getAlivePlayers() <= 1
                end
            end

        end)

        if not killsuccess then warn(killerror) end
    
    end
})

local silentAimRelated = CombatTab:CreateSection("Silent Aim - PRESS 'E' TO SHOOT @ MURDERER")
local silentAimToggler = CombatTab:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().SilentAim = Value
        if ShootGUI ~= nil then
            ShootGUI.Enabled = true
        end
    end
})
local silentAimSliderReminder = CombatTab:CreateSection("[HIGHER PING = HIGHER OFFSET]")
local silentAimOffsetSlider = CombatTab:CreateSlider({
    Name = "Silent Aim Offset",
    Range = {1, 10},
    Increment = 0.1,
    CurrentValue = 3.1,
    Callback = function(Value)
        getgenv().AimPrediction = Value
    end
})

local flingRelatedSection = CombatTab:CreateSection("Fling Related")
local flingMurdererCooldown = false
local flingMurdererButton = CombatTab:CreateButton({
    Name = "Fling Murderer",
    Callback = function()
        if flingMurdererCooldown == true then
            Notify("Fling: Error", "Already attempting to fling murderer. Please wait.", 5)
            return
        end
        local matchmurderer = getMatchMurderer()
        flingMurdererCooldown = true
        if matchmurderer == nil then
            Notify("Fling: Error", "No Murderer was found", 5)
            flingMurdererCooldown = false
            return
        elseif matchmurderer == LP then
            Notify("Fling: Error", "You can't fling yourself", 5)
            flingMurdererCooldown = false
            return
        else
            mainFling(matchmurderer)
        end
        flingMurdererCooldown = false
    end
})
local flingSheriffCooldown = false
local flingSheriffButton = CombatTab:CreateButton({
    Name = "Fling Sheriff",
    Callback = function()
        if flingSheriffCooldown == true then
            Notify("Fling: Error", "Already attempting to fling murderer. Please wait.", 5)
            return
        end
        flingSheriffCooldown = true
        local matchSheriff = getMatchSheriff()
        if matchSheriff == nil then
            Notify("Fling: Error", "No Sheriff was found", 5)
            flingSheriffCooldown = false
            return
        elseif matchSheriff == LP then
            Notify("Fling: Error", "You can't fling yourself", 5)
            flingSheriffCooldown = false
            return
        else
            mainFling(matchSheriff)
        end
        flingSheriffCooldown = false
    end
})

local gunRelatedSection = CombatTab:CreateSection("Sheriff's Gun Related")
local grabGunButton = CombatTab:CreateButton({
    Name = "Grab Gun",
    Callback = function()
        local droppedGun = getGunDropped()
        if droppedGun == nil then
            return Notify("Grab Gun", "There's no gun dropped.")
        else
            if isAlive(LP) == true then
                if tostring(getPlayerRole(LP)):lower() == "innocent" then
                    teleportToPart(droppedGun, true)
                else
                    return Notify("Grab Gun", "Only innocents can pick up the gun.")
                end
            else
                return Notify("Grab Gun", "Can't grab gun while dead.")
            end
        end
    end
})

local autoGrabGunToggle = CombatTab:CreateToggle({
    Name = "Auto Grab Gun",
    Callback = function(value)
        getgenv().AutoGrabGun = value
    end
})

local ModsSection = CombatTab:CreateSection("Speed & Power Modifiers")
local speedSlider = CombatTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        local Char = getChar(LP)
        local Human = Char and Char:FindFirstChildOfClass("Humanoid", true)
        getgenv().LPWalkSpeed = Value
        Human.WalkSpeed = Value
    end
})

local jumpPowerSlider = CombatTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        local Char = getChar(LP)
        local Human = Char and Char:FindFirstChildOfClass("Humanoid", true)
        getgenv().LPJumpPower = Value
        Human.JumpPower = Value
    end
})

--| Farm Tab
local SectionFarm = FarmTab:CreateSection("Farming Related Features")
local Toggle_AntiIdle = FarmTab:CreateToggle({
    Name = "Anti Idle / Anti AFK Kick",
    CurrentValue = false,
    Callback = function(value)
        if value == true then
            getgenv().AntiIdle = true
            Notify("Anti Idle", "Anti-AFK Kick has been turned ON. You won't be kicked for being AFK.")
            return
        elseif value == false then
            getgenv().AntiIdle = false
            Notify("Anti Idle", "Anti-AFK Kick has been turned OFF. You will be kicked if you go AFK from now on.")
            return
        end
    end
})

local Toggle_AutoFarm = FarmTab:CreateToggle({
    Name = "Auto-Farm",
    CurrentValue = false,
    Callback = function(value)
        if value == true then
            --| Autofarm on
            getgenv().Farming = true
            local exeSuccess, exeErr = pcall(function() return startFarming() end)
            if not exeSuccess then 
                warn(exeErr)
            else
            end
        else
            getgenv().Farming = false
        end
    end
})

local speedsection = FarmTab:CreateSection("Farming Speed")
local farmSpeedOptions = FarmTab:CreateDropdown({
    Name = "Speed Profiles",
    Options = {"Profile 1 [FAST]", "Profile 2 [SAFE]", "Profile 3 [SLOW]"},
    CurrentOption = {"Profile 2 [SAFE]"},
    MultipleOptions = false,
    Callback = function(Option)
        getgenv().ProfileSpeed = Option[1]
    end,
 })

local renderingSection = FarmTab:CreateSection("Rendering")
local disable3dRenderingToggle = FarmTab:CreateToggle({
    Name = "Disable 3D Rendering",
    CurrentValue = false,
    Callback = function(value)
        if value == true then
            getgenv().RenderingEnabled = false
            renderingGui.Enabled = true
            RunService:Set3dRenderingEnabled(false)
        else
            getgenv().RenderingEnabled = true
            RunService:Set3dRenderingEnabled(true)
            renderingGui.Enabled = false
        end
    end
})

local optionssection = FarmTab:CreateSection("Farming Options")
local msg1 = FarmTab:CreateParagraph({Title = "About Kill All", Content = "The next option will make you kill all players in match if you're the murderer. If you also have enabled 'Reset if full bag' then it'll kill everyone and then reset."})
local Toggle_KillAllIfMurderer = FarmTab:CreateToggle({
    Name = "Kill All if full bag (if murderer)",
    CurrentValue = false,
    Callback = function(value)
        if value == true then
            getgenv().KillAllWhenFullBag = true 
        else
            getgenv().KillAllWhenFullBag = false
        end
    end
})
local Toggle_ResetIfFullBag = FarmTab:CreateToggle({
    Name = "Reset if full bag",
    CurrentValue = false,
    Callback = function(value)
        if value == true then
            getgenv().ResetIfFullBag = true 
        else
            getgenv().ResetIfFullBag = false
        end
    end
})
local Toggle_FlingMurdererIfFullBag = FarmTab:CreateToggle({
    Name = "Fling Murderer If Full Bag",
    CurrentValue = false,
    Callback = function(value)
        if value == true then
            getgenv().FlingMurdererIfFullBag = true 
        else
            getgenv().FlingMurdererIfFullBag = false
        end
    end
})

--| Visuals tab
local SectionESP = VisualsTab:CreateSection("ESP")
local espInnocents = VisualsTab:CreateToggle({
    Name = "ESP Innocents",
    CurrentValue = false,
    Callback = function(value)
        getgenv().ESPInnocents = value
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                local char = getChar(player)
                local role = getPlayerRole(player)
                esp(player, char, tostring(role):lower())
            end
        end
    end
})
local espMurderer = VisualsTab:CreateToggle({
    Name = "ESP Murderer",
    CurrentValue = false,
    Callback = function(value)
        getgenv().ESPMurderer = value
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                local char = getChar(player)
                local role = getPlayerRole(player)
                esp(player, char, tostring(role):lower())
            end
        end
    end
})

local espSheriff = VisualsTab:CreateToggle({
    Name = "ESP Sheriff / Hero",
    CurrentValue = false,
    Callback = function(value)
        getgenv().ESPSheriff = value
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= Players.LocalPlayer then
                local char = getChar(player)
                local role = getPlayerRole(player)
                esp(player, char, tostring(role):lower())
            end
        end
    end
})

local espGunToggle = VisualsTab:CreateToggle({
    Name = "ESP Gun",
    CurrentValue = false,
    Callback = function(value)
        getgenv().ESPGun = value
        local map = getMatchMap()
        if map ~= nil then
            if map:FindFirstChild("GunDrop") then
                local droppedGun = map["GunDrop"]
                task.wait(0.5)
                espGunFunc(droppedGun)
            end
         end
    end
})

--| Teleports Tab
local tptoplacesSection = TeleportsTab:CreateSection("Places")
local TPToLobbyButton = TeleportsTab:CreateButton({
    Name = "Teleport to Lobby",
    Callback = function()
        teleportToLobby()
    end
})
local TpToMapButton = TeleportsTab:CreateButton({
    Name = "Teleport to Map",
    Callback = function()
        local fmap = getMatchMap()
        if fmap == nil then
            return Notify("Teleport", "Map not loaded / Not found")
        else
            teleportToMap()
        end
    end
})

--| Misc Tab
local lowgfxSection = MiscTab:CreateSection("Low GFX [CANNOT DISABLE]")
local lowgfxButton = MiscTab:CreateButton({
    Name = "Low GFX",
    Callback = function()
        local Terrain = gameWorkspace:FindFirstChildOfClass('Terrain')
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        settings().Rendering.QualityLevel = 1
        for i,v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            end
        end
        for i,v in pairs(Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
        workspace.DescendantAdded:Connect(function(child)
            task.spawn(function()
                if child:IsA('ForceField') then
                    RunService.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA('Sparkles') then
                    RunService.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA('Smoke') or child:IsA('Fire') then
                    RunService.Heartbeat:Wait()
                    child:Destroy()
                elseif child:IsA("Part") or child:IsA("UnionOperation") or child:IsA("MeshPart") or child:IsA("CornerWedgePart") or child:IsA("TrussPart") then
                    child.Material = "Plastic"
                    child.Reflectance = 0
                elseif child:IsA("Decal") then
                    child.Transparency = 1
                elseif child:IsA("ParticleEmitter") or child:IsA("Trail") then
                    child.Lifetime = NumberRange.new(0)
                elseif child:IsA("Explosion") then
                    child.BlastPressure = 1
                    child.BlastRadius = 1
                end
            end)
        end)
    end
})

local rejoinRelated = MiscTab:CreateSection("Rejoin Related")
local rejoinButton = MiscTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        Notify("Rejoining", "Please wait...", 5)
        if #Players:GetPlayers() <= 1 then
            LP:Kick("\nRejoining...")
            task.wait()
            TeleportService:Teleport(PlaceId, LP)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LP)
        end
    end
})

local serverHopButton = MiscTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local serverhopResponse = serverHop()
        if serverhopResponse == "success" then
            Notify("Server Hop", "Attempting to teleport...", 5)
        else
            Notify("Server Hop: Error", tostring(serverhopResponse), 5)
        end
    end
})

local autoRejoinRelated = MiscTab:CreateSection("Auto Rejoin Related")
local autoRejoinIfKickedToggle = MiscTab:CreateToggle({
    Name = "Rejoin If Kicked",
    CurrentValue = false,
    Callback = function(Value)

        if (not queueteleport) or (not readfile) or (not writefile) then
            Notify("Compatibility Error", "Your exploit might not support this feature.")
        end
        
        local currentFarming = getgenv().Farming
        local currentAntiIdle = getgenv().AntiIdle
        local currentResetIfFullBag =  getgenv().ResetIfFullBag
        local currentKillAllIfFullBag = getgenv().KillAllWhenFullBag
        local currentFlingMurdererIfFullBag = getgenv().FlingMurdererIfFullBag
        local currentFarmSpeedProfile = getgenv().ProfileSpeed
        local currentDisable3DRendering = not getgenv().RenderingEnabled
        local currentServerHopIfServerEmpty = getgenv().ServerHopIfServerEmpty

        getgenv().RejoinIfKicked = Value
        
        local currentSettings = {
            isFarming = currentFarming,
            resetIfFullBag = currentResetIfFullBag,
            killAllIfFullBag = currentKillAllIfFullBag,
            flingMurdererIfFullBag = currentFlingMurdererIfFullBag,
            farmSpeedProfile = currentFarmSpeedProfile,
            renderingDisabled = currentDisable3DRendering,
            antiIdle = currentAntiIdle,
            serverHopIfServerEmpty = currentServerHopIfServerEmpty,
            rejoinIfKicked = Value
        }

        if Value == true then
            getgenv().REJOIN_AND_REEXECUTE = true
            saveSettings(currentSettings)
            Notify("Rejoin If Kicked", "Current settings were saved", 5)
        elseif Value == false then
            if getgenv().ServerHopIfServerEmpty == false then
                getgenv().REJOIN_AND_REEXECUTE = false
            elseif getgenv().ServerHopIfServerEmpty == true then
                saveSettings(currentSettings)
            end
        end

    end
})

local ServerHopIfServerEmptyToggle = MiscTab:CreateToggle({
    Name = "Server Hop If Server Empty",
    CurrentValue = false,
    Callback = function(Value)

        if (not queueteleport) or (not readfile) or (not writefile) then
            Notify("Compatibility Error", "Your exploit might not support this feature.")
        end

        local currentFarming = getgenv().Farming
        local currentAntiIdle = getgenv().AntiIdle
        local currentResetIfFullBag =  getgenv().ResetIfFullBag
        local currentKillAllIfFullBag = getgenv().KillAllWhenFullBag
        local currentFlingMurdererIfFullBag = getgenv().FlingMurdererIfFullBag
        local currentFarmSpeedProfile = getgenv().ProfileSpeed
        local currentDisable3DRendering = not getgenv().RenderingEnabled
        local currentRejoinIfKicked = getgenv().RejoinIfKicked

        getgenv().ServerHopIfServerEmpty = Value
        
        local currentSettings = {
            isFarming = currentFarming,
            resetIfFullBag = currentResetIfFullBag,
            killAllIfFullBag = currentKillAllIfFullBag,
            flingMurdererIfFullBag = currentFlingMurdererIfFullBag,
            farmSpeedProfile = currentFarmSpeedProfile,
            renderingDisabled = currentDisable3DRendering,
            antiIdle = currentAntiIdle,
            serverHopIfServerEmpty = Value,
            rejoinIfKicked = currentRejoinIfKicked
        }

        if Value == true then
            getgenv().REJOIN_AND_REEXECUTE = true
            saveSettings(currentSettings)
            Notify("Server Hop If Server Empty", "Current settings were saved", 5)
        elseif Value == false then
            if getgenv().RejoinIfKicked == false then
                getgenv().REJOIN_AND_REEXECUTE = false
            elseif getgenv().RejoinIfKicked == true then
                saveSettings(currentSettings)
            end
        end

    end
})

local emotesRelated = MiscTab:CreateSection("Emotes Related")
local unlockAllEmotes = MiscTab:CreateButton({
    Name = "Unlock All Emotes",
    Callback = function()
        local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        local Emotes = PlayerGui:WaitForChild("MainGUI"):WaitForChild("Game"):FindFirstChild("Emotes")

        if Emotes then
            local success = pcall(function()
                require(game:GetService("ReplicatedStorage").Modules.EmoteModule).GeneratePage(
                    {"headless", "zombie", "zen", "ninja", "floss", "dab", "sit"},
                    Emotes,
                    "Free Emotes"
                )
            end)

            if success then
                Notify("Success", "Unlocked all emotes", 5)
            end
        end
    end
})

--> STARTUP <--
--\\ RENDERING DISABLED GUI //--
coroutine.wrap(function()
    local currentMap = getMatchMap()
    if (currentMap ~= nil) and isAlive(LP) == true then
        inMatchLabel.Text = '[ In Match : <stroke color="#4af76d" thickness="1" transparency="0.8"><font color="rgb(88, 237, 118)">'..tostring(true)..'</font></stroke> ] [<stroke color="#c986fc" thickness="1" transparency="0.8"><font color="rgb(215, 163, 255)">'..tostring(currentMap.Name)..'</font></stroke>]'
    else
        inMatchLabel.Text = '[ In Match : <stroke color="#ff4545" thickness="1" transparency="0.8"><font color="rgb(255, 79, 79)">'..tostring(false)..'</font></stroke> ]'
    end
    --| Keep the connection
    coroutine.wrap(function()
        task.spawn(function()
            while true do
                task.wait()
                if (getMatchMap() ~= nil) and isAlive(LP) == true then
                    inMatchLabel.Text = '[ In Match : <stroke color="#4af76d" thickness="1" transparency="0.8"><font color="rgb(88, 237, 118)">'..tostring(true)..'</font></stroke> ] [<stroke color="#c986fc" thickness="1" transparency="0.8"><font color="rgb(215, 163, 255)">'..tostring(getMatchMap().Name)..'</font></stroke>]'
                else
                    inMatchLabel.Text = '[ In Match : <stroke color="#ff4545" thickness="1" transparency="0.8"><font color="rgb(255, 79, 79)">'..tostring(false)..'</font></stroke> ]'
                end
            end
        end)
        
        task.spawn(function()
            while true do
                task.wait()
                currentBagLabel.Text = string.format('[ Bag : <stroke color="#e0e0e0" thickness="1" transparency="0.8"><font color="rgb(255, 255, 255)">%s</font></stroke>/<stroke color="#e0e0e0" thickness="1" transparency="0.8"><font color="rgb(255, 255, 255)">%s</font></stroke> ]', tostring(formatNumberWithCommas(tonumber(getCoinsInBag(LP))) or 0),tostring(maxCoins))
            end
        end)
        
        task.spawn(function()
            while true do
                task.wait()
                ingamePlayersLabel.Text = string.format('[ Players in Server : <stroke color="#e0e0e0" thickness="1" transparency="0.8"><font color="rgb(255, 255, 255)">%s</font></stroke>/<stroke color="#e0e0e0" thickness="1" transparency="0.8"><font color="rgb(255, 255, 255)">%s</font></stroke> ]', tostring(#Players:GetPlayers()),tostring(Players.MaxPlayers))
            end
        end)
    end)()
end)()

--\\ TELEPORT DETECTION //--
LP.OnTeleport:Connect(function(State)
	if queueteleport and getgenv().REJOIN_AND_REEXECUTE == true then
		queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/YungCaesarr/Vultures-Hub/refs/heads/main/redirect.lua'))()")
	end
end)

--\\ KICK DETECTION //--
GuiService.ErrorMessageChanged:Connect(function()
    if getgenv().RejoinIfKicked == true then
        if #Players:GetPlayers() <= 1 then
            TeleportService:Teleport(PlaceId, LP)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LP)
        end
    end
end)

--\\ SERVER EMPTY DETECTION //--
Players.PlayerRemoving:Connect(function()
    if #Players:GetPlayers() <= 1 then
        if getgenv().ServerHopIfServerEmpty == true then
            serverHop()
        end
    end
end)

--\\ SILENT AIM //--
UIS.InputBegan:Connect(function(input, gameProcessedEvent)

    if input.UserInputType == Enum.UserInputType.Keyboard then
        if gameProcessedEvent == false and (tostring(input.KeyCode.Name):upper() == tostring(getgenv().SilentAimKeybind):upper()) then
            
            if getgenv().SilentAim == true then

                local matchMurderer = getMatchMurderer()

                if matchMurderer ~= nil then

                    local succ, distanceFromPlayer = pcall(function() return (getRoot(getChar(matchMurderer)).Position - getRoot(getChar(LP)).Position).Magnitude end)

                    if succ and distanceFromPlayer ~= nil then

                        if distanceFromPlayer <= 150 then
                            local gun = LP.Character:FindFirstChild("Gun") or LP.Backpack:FindFirstChild("Gun")

                            if gun ~= nil then
                                if gun.Parent == LP.Backpack then
                                    gun.Parent = LP.Character
                                end

                                task.wait(0.1)
            
                                local predictedPosition = getPredictedPosition(matchMurderer, getgenv().AimPrediction)
            
                                local args = {
                                    [1] = 1,
                                    [2] = predictedPosition,
                                    [3] = "AH2"
                                }
                                    
                                LP.Character.Gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(unpack(args))
                            end

                        end

                    end

                end
            end

        end
    end

end)

--\\ LOCAL PLAYER SPAWNING //--
local Human = getChar(LP) and getChar(LP):FindFirstChildOfClass("Humanoid", true)
if Human then
    Human.WalkSpeed = getgenv().LPWalkSpeed
    Human.JumpPower = getgenv().LPJumpPower
    Human:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        Human.WalkSpeed = getgenv().LPWalkSpeed
    end)
    Human:GetPropertyChangedSignal("JumpPower"):Connect(function()
        Human.JumpPower = getgenv().LPJumpPower
    end)
end

LP.CharacterAdded:Connect(function(lpcharacter)
    local Human = lpcharacter and lpcharacter:WaitForChild("Humanoid")
    if Human then
        Human.WalkSpeed = getgenv().LPWalkSpeed
        Human.JumpPower = getgenv().LPJumpPower
        Human:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            Human.WalkSpeed = getgenv().LPWalkSpeed
        end)
        Human:GetPropertyChangedSignal("JumpPower"):Connect(function()
            Human.JumpPower = getgenv().LPJumpPower
        end)
    end
end)

--\\ AUTOMATICALLY GRAB GUN //--
coroutine.wrap(function()
    local gunListenerZ = nil
    local lastMapZ = nil
    while true do
        task.wait()
        if getgenv().AutoGrabGun == true then
            local map = getMatchMap()
            if map ~= nil then
                if lastMapZ == nil then
                    if map:FindFirstChild("GunDrop") then
                        if getgenv().AutoGrabGun == true and isAlive(LP) == true and tostring(getPlayerRole(LP)):lower() == "innocent" then
                            lastMapZ = map
                            teleportToPart(map["GunDrop"], true)
                        end
                    else
                        if gunListenerZ ~= nil then 
                            if gunListenerZ.Connected == true then
                                --print'disconnecting 1'
                                gunListenerZ:Disconnect() 
                            end
                        end
                        lastMapZ = map
                        gunListenerZ = map.ChildAdded:Connect(function(child)
                            if child.Name == "GunDrop" then
                                if getgenv().AutoGrabGun == true and isAlive(LP) == true and tostring(getPlayerRole(LP)):lower() == "innocent" then
                                    task.wait(0.3)
                                    teleportToPart(child, true)
                                end
                            end
                        end)
                    end
                elseif lastMapZ ~= nil and lastMapZ ~= map then
                    if map:FindFirstChild("GunDrop") then
                        if getgenv().AutoGrabGun == true and isAlive(LP) == true and tostring(getPlayerRole(LP)):lower() == "innocent" then
                            lastMapZ = map
                            teleportToPart(map["GunDrop"], true)
                        end
                    else
                        if gunListenerZ ~= nil then 
                            if gunListenerZ.Connected == true then
                                --print'disconnecting 2'
                                gunListenerZ:Disconnect() 
                            end
                        end
                        lastMapZ = map
                        gunListenerZ = map.ChildAdded:Connect(function(child)
                            if child.Name == "GunDrop" then
                                if getgenv().AutoGrabGun == true and isAlive(LP) == true and tostring(getPlayerRole(LP)):lower() == "innocent" then
                                    task.wait(0.3)
                                    teleportToPart(child, true)
                                end
                            end
                        end)
                    end
                else
                    --print'IGNORING MAP'
                end
            end
        end
    end
end)()

--\\ GUN ESP //--
coroutine.wrap(function()
    local gunListener = nil
    local lastMap = nil
    while true do
        task.wait()
        if getgenv().ESPGun == true then
            local map = getMatchMap()
            if map ~= nil then
                if lastMap == nil then
                    if map:FindFirstChild("GunDrop") then
                        lastMap = map
                        local droppedGun = map["GunDrop"]
                        task.wait(0.5)
                        espGunFunc(droppedGun)
                    else
                        if gunListener ~= nil then 
                            if gunListener.Connected == true then
                                --print'disconnecting 1'
                                gunListener:Disconnect() 
                            end
                        end
                        lastMap = map
                        gunListener = map.ChildAdded:Connect(function(child)
                            if child.Name == "GunDrop" then
                                task.wait(0.5)
                                espGunFunc(child)
                            end
                        end)
                    end
                elseif lastMap ~= nil and lastMap ~= map then
                    if map:FindFirstChild("GunDrop") then
                        lastMap = map
                        local droppedGun = map["GunDrop"]
                        task.wait(0.5)
                        espGunFunc(droppedGun)
                    else
                        if gunListener ~= nil then 
                            if gunListener.Connected == true then
                                --print'disconnecting 2'
                                gunListener:Disconnect() 
                            end
                        end
                        lastMap = map
                        gunListener = map.ChildAdded:Connect(function(child)
                            if child.Name == "GunDrop" then
                                task.wait(0.5)
                                espGunFunc(child)
                            end
                        end)
                    end
                else
                    --print'IGNORING MAP'
                end
            end
        end
    end
end)()

--\\ Avoid MainGUI Enable when Rendering Disabled //--
--[[local pGui = LP.PlayerGui
local mainguiconn
if pGui then
    
    local mainGui = pGui:FindFirstChild("MainGUI")
    if mainGui then
        if getgenv().RenderingEnabled == false then
            if mainGui.Enabled == true then
                mainGui.Enabled = false
            end
        end
    end

    pGui.ChildAdded:Connect(function(child)
        task.wait()
        if child.Name == "MainGUI" then
            if mainguiconn ~= nil then
                mainguiconn:Disconnect()
            end
            child.Enabled = false
            child:GetPropertyChangedSignal("Enabled"):Connect(function()
                if child.Enabled == true then
                    if getgenv().RenderingEnabled == false then
                        child.Enabled = false
                    end
                end
            end)
        end
    end)

end]]--

--\\ ESP //--
--| ESP Current Players [IN MATCH]
    -- Not needed until toggle

--| ESP Player Added
game.Workspace.ChildAdded:Connect(function(thing) 
    if thing:IsA("Model") then
        local success, plr = pcall(function() return Players[thing.Name] end)
        if success and plr ~= nil then
            local plr = Players[thing.Name]
            if plr ~= Players.LocalPlayer then
                local char = getChar(plr)
                local role = getPlayerRole(plr)
                esp(plr, char, tostring(role):lower())
            end
        end
    end
end)

--\\ CANDIES HITBOX EXPANDER //--
--repeat task.wait() until getMatchMap() ~= nil

--*local currentMap = getMatchMap()

--if currentMap ~= nil then
--    local coinsFolder = currentMap:WaitForChild("CoinContainer", 30) --| If reached this point means the match is about to start
--    fetchCurrentCoins() --| Expand current coins hb
--    if coinsFolder ~= nil then
--        addConnection(coinsFolder.ChildAdded:Connect(function(child)
            --| DEBUG print(child.Name.." was added to CoinsFolder [71]")
--            modifyCoinHB(child)
--        end))
--    else
        --| DEBUG
        --print('CURRENT MAP NOT FOUND 264') 
--    end
--else
    --| DEBUG
    --print('CURRENT MAP NOT FOUND 265') 
--*end

--*gameWorkspace.ChildAdded:Connect(function(child)

--    local ignoreList = {
--        "Part",
--        "ConfettiCannon",
--        "Handle",
--        "ThrowingKnife"
--    }

--    if not table.find(ignoreList, child.Name) and (getPlayerByFullName(child.Name) == nil) and child:IsA("Model") and (child:WaitForChild("Spawns") or child:WaitForChild("ZombieSpawns")) then
        --print('three things found')
--        local coinsFolder = child:WaitForChild("CoinContainer", 60)
        --if not coinsFolder then print'coins folder not found' end
--        if coinsFolder then
            
            --print('COINSFOLDER FOUND')
            
            --print(#mapConnections.." CURRENT SIZE")
            --print(shutConnections())
            
--            addConnection(coinsFolder.ChildAdded:Connect(function(child)
                --print('NEW CHILD DETECTED: '..child.Name)
                --if getgenv().CoinsAura == true then
--                    modifyCoinHB(child)
                --end
--            end))
            
--        end
--    end
--*end)

--\\ REJOIN DETECTION //--
if getgenv().VULTURE_REJOINING == true then

    local savedSettings = readSettingsFile("rejoin settings.lua")

    if savedSettings ~= nil then

        local farming = savedSettings.farming
        local resetIfFullBag = savedSettings.resetIfFullBag
        local killAllIfFullBag = savedSettings.killAllIfFullBag
        local flingMurdererIfFullBag = savedSettings.flingMurdererIfFullBag
        local farmSpeedProfile = savedSettings.farmSpeedProfile
        local renderingDisabled = savedSettings.renderingDisabled
        local antiIdle = savedSettings.antiIdle
        local serverHopIfServerEmpty = savedSettings.serverHopIfServerEmpty
        local rejoinIfKicked = savedSettings.rejoinIfKicked

        --[[Toggle_ResetIfFullBag:Set(true)
        Toggle_KillAllIfMurderer:Set(true)
        Toggle_FlingMurdererIfFullBag:Set(true)
        farmSpeedOptions:Set({"Profile 1 [FAST]"})
        disable3dRenderingToggle:Set(true)
        Toggle_AntiIdle:Set(true)
        ServerHopIfServerEmptyToggle:Set(true)
        autoRejoinIfKickedToggle:Set(true)
        task.spawn(function()
            Toggle_AutoFarm:Set(true)
        end)]]--

        if resetIfFullBag == true then
            Toggle_ResetIfFullBag:Set(true)
        end

        if killAllIfFullBag == true then
            Toggle_KillAllIfMurderer:Set(true)
        end

        if flingMurdererIfFullBag == true then
            Toggle_FlingMurdererIfFullBag:Set(true)
        end

        if farmSpeedProfile ~= "Profile 2 [SAFE]" then
            farmSpeedOptions:Set({farmSpeedProfile})
        end

        if renderingDisabled == true then
            disable3dRenderingToggle:Set(true)
        end

        if farming == true then
            task.spawn(function()
                Toggle_AutoFarm:Set(true)
            end)
        end


        if antiIdle == true then
            Toggle_AntiIdle:Set(true)
        end

        if serverHopIfServerEmpty == true then
            ServerHopIfServerEmptyToggle:Set(true)
        end

        if rejoinIfKicked == true then
            autoRejoinIfKickedToggle:Set(true)
        end

    end

end
