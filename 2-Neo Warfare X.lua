local notifications = loadstring(game:HttpGet(("https://raw.githubusercontent.com/Nozxoki/NitrixUI/main/2-NitrixNotifs.lua"),true))()

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nozxoki/NitrixUI/main/1-NitrixUI.lua"))()

-- Variables

getrenv().AntiAfkOn = false

getgenv().InstantRepair = false

getgenv().Combat = false

local Players = game:GetService("Players")

local plrs = game.Players:GetChildren()

local vehiclename = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Model").Name

local mods = {51493240, 34897046, 373957983, 581105449, 74359327, 21747109, 850815168, 951633216, 27773815, 1181494786, 156135790, 7050507, 73678056, 174285325, 24990589, 267418769, 14450955, 53042569, 13575190, 1109747353, 26100209, 35072888, 89431198, 839895444, 1536083, 70261613, 299606569, 82182318, 68966801, 32752221, 400192155, 351255201, 4980144, 32982017, 37893312, 603565, 493677451, 1035874382, 77568345, 44624936, 102979377, 22240648, 24377993, 159615617, 1136818645, 24190452, 370054496, 80916464, 41636124, 8566447, 144608264, 37898748, 163610581, 25675324, 109668388, 41487561, 17938990, 43487387, 186087176, 97104916, 19580261, 31844698, 307920883, 24487068, 122180674, 52542498, 4176720, 42870304, 29099758, 40658655, 63603700}

-- Safe


local Safe = library:Window("Safe")

Safe:Button("Extend Radar", function()
    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Model").Specifications.Radar.Value = Vector3.new(999999, 180, 0)
    game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Model").Specifications.Sonar.Value = Vector3.new(999999, 999999, 999999)
    
    notifications:message{
        Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
        Description = "<b><font color='rgb(35, 225, 35)'>Extended Radar</font></b>",
        Icon = 6023426926
    }
end)

Safe:Button("Remove Clouds", function()
    getgenv().RemoveClouds = true
    
    notifications:message{
        Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
        Description = "<b><font color='rgb(35, 225, 35)'>Removed Clouds</font></b>",
        Icon = 6023426926
    }
    
    while true do
        wait()
        if getgenv().RemoveClouds == true then
            for _, child in pairs(game.Workspace.Clouds:GetChildren()) do
                child:Destroy()
            end
        end
    end
end)

Safe:Button("Remove Textures", function()
    local descendants = game.Workspace:GetDescendants()
    
    for index, descendant in pairs(descendants) do
        if descendant:IsA("Texture") then
            descendant:Remove()
        end
    end
    
    for _,v in pairs(workspace:GetDescendants()) do
    if v.ClassName == "Part"
    or v.ClassName == "SpawnLocation"
    or v.ClassName == "WedgePart"
    or v.ClassName == "Terrain"
    or v.ClassName == "MeshPart" then
    v.Material = "Plastic"
    end
    end
    
    notifications:message{
        Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
        Description = "<b><font color='rgb(35, 225, 35)'>Removed Textures</font></b>",
        Icon = 6023426926
    }
    
end)

Safe:Button("Toggle Shadows", function()
    local lighting = game.Lighting
    
    if lighting.GlobalShadows == true then
        lighting.GlobalShadows = false
        
        notifications:message{
            Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
            Description = "<b><font color='rgb(255, 255, 255)'>Shadows: </font> <font color='rgb(225, 35, 35)'>Disabled</font></b>",
            Icon = 6023426926
        }
        
    else
        lighting.GlobalShadows = true
        
        notifications:message{
            Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
            Description = "<b><font color='rgb(255, 255, 255)'>Shadows: </font> <font color='rgb(35, 225, 35)'>Enabled</font></b>",
            Icon = 6023426926
        }
        
    end
end)

-- Unsafe


local Unsafe = library:Window("Unsafe")

Unsafe:Button("Toggle Combat", function()
    local args = {
        [1] = game:GetService("Players").LocalPlayer.Character:FindFirstChild(vehiclename).Specifications
    }
    
    workspace.GlobalFunctions.ToggleCombat:InvokeServer(unpack(args))
end)

Unsafe:Button("Instant Repair", function()
    workspace.GlobalFunctions.WeaponManager:FireServer(null, game:GetService("Players").LocalPlayer.Character:FindFirstChild(vehiclename), "Repair")
end)

Unsafe:Button("Toggle Inf Repair", function()
    if getgenv().InstantRepair == true then
        notifications:message{
            Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
            Description = "<b><font color='rgb(255, 255, 255)'>Infinite Repair: </font> <font color='rgb(225, 35, 35)'>Disabled</font></b>",
            Icon = 6023426926
        }
        game.CoreGui.NitrixUiExtras.StatsUiWindow.Header.Window.InfRepair.Text = "Infinite Repair: Disabled"
        getgenv().InstantRepair = false
    else
        notifications:message{
            Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
            Description = "<b><font color='rgb(255, 255, 255)'>Infinite Repair: </font> <font color='rgb(35, 225, 35)'>Enabled</font></b>",
            Icon = 6023426926
        }
        game.CoreGui.NitrixUiExtras.StatsUiWindow.Header.Window.InfRepair.Text = "Infinite Repair: Enabled"
        getgenv().InstantRepair = true
    end
end)

local Extra = library:Window("Extra")

Extra:Button("Anti AFK", function()
    if getrenv().AntiAfkOn == false then
        
        getrenv().AntiAfkOn = true
        
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
        
        notifications:message{
            Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
            Description = "<b><font color='rgb(255, 255, 255)'>Anti-AFK: </font> <font color='rgb(35, 225, 35)'>Enabled</font></b>",
            Icon = 6023426926
        }
        
        game.CoreGui.NitrixUiExtras.StatsUiWindow.Header.Window.AntiAfk.Text = "Anti AFK: Enabled"
    else
        notifications:message{
            Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
            Description = "<font color='rgb(225, 35, 35)'><b>Anti-AFK Already Enabled</b></font>"
        }
    end
end)

Extra:Button("Toggle Stats GUI", function()
    if game.CoreGui.NitrixUiExtras.Enabled == true then
        game.CoreGui.NitrixUiExtras.Enabled = false
    else
        game.CoreGui.NitrixUiExtras.Enabled = true
    end
end)

Extra:Button("Delete GUI", function()
    getgenv().InstantRepair = false
    
    notifications:message{
        Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
        Description = "<font color='rgb(35, 225, 35)'><b>GUI Deleted</b></font>"
    }
    
    game.CoreGui.NitrixUiExtras:Destroy()
    
    library:Destroy()
end)

-- Stuff

--[[

game.Players.PlayerAdded:Connect(function(plr)
	for i, v in pairs(mods) do
		if plr.UserId == v then
            notifications:message{
                Title = "<font color='rgb(255, 255, 255)'><b>Nitrix Alert!</b></font>",
                Description = "<b><font color='rgb(225, 35, 35)'>A Moderator has joined the game, be careful!</font></b>"
            }
		end
	end
end)

]]

notifications:message{
    Title = "<font color='rgb(255, 255, 255)'><b>Nitrix</b></font>",
    Description = "<b><font color='rgb(35, 225, 35)'>GUI Loaded</font></b>"
}

while true do
	for i, v in pairs(mods) do
		if plr.UserId == v then
            notifications:message{
                Title = "<font color='rgb(255, 255, 255)'><b>Nitrix Alert!</b></font>",
                Description = "<b><font color='rgb(225, 35, 35)'>A Moderator has joined the game, be careful!</font></b>"
            }
            
            game.CoreGui.NitrixUiExtras.StatsUiWindow.Header.Window.Mod.Text = "Mods In Game: Yes"
        else
            game.CoreGui.NitrixUiExtras.StatsUiWindow.Header.Window.Mod.Text = "Mods In Game: No"
		end
	end
	wait()
end

while true do
    if getgenv().InstantRepair == true then
        workspace.GlobalFunctions.WeaponManager:FireServer(null, game:GetService("Players").LocalPlayer.Character:FindFirstChild(vehiclename), "Repair")
    end
    wait()
end
