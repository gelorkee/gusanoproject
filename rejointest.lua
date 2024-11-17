print("[*] Reached github repository")
task.wait(1)
local s2, e2 = pcall(function()
    local cloneref = cloneref or function(o) return o end
    Players = cloneref(game:GetService("Players"))
    local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    
    if not queueteleport then
        print("Not queue teleport?")
        return
    end
    
    local tcheck = false
    Players.LocalPlayer.OnTeleport:Connect(function(teleportState)
        if not tcheck then
            tcheck = true
            queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/gelorkee/gusanoproject/refs/heads/main/rejointest.lua'))()")
        end
    end)

end)
if not s2 then warn('something went wrong 2'); warn(e2); end
