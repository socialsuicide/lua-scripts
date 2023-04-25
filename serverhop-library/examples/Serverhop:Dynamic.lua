-- Auto collect coins / Game: Saber Simulator

-- First we need to create a variable with the serverhop libary loadstring.
local Serverhop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

-- After that we index into the orb folder getting the descendants
for i, v in pairs(game:GetService("Workspace").CoinsHolder:GetDescendants()) do
    -- We then check if the childs class is a TouchTransmitter
    if v:IsA("TouchTransmitter") then
        -- If it is then we fire the touch interest using are HumanoidRootPart on the item we wanna collect
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
        task.wait()
        firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
    end
end

-- After collecting all orbs we wanna server hop
Serverhop:Dynamic(false, nil) -- We put the first arg to false to disable logs, then we put the second arg to nil to scrape inf servers
