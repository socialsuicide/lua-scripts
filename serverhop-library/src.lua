-- hi! feel free to use any of this code for your own projects or use the libary for your projects. i know its a little messy because i rushed it (with no sleep as well 😴) but it works well enough.

local Serverhop = {}; -- init

local API, ServerPages;

local function CreateFiles(FileName, File)
    pcall(function()
        makefolder("ServerHopper")
        makefolder("ServerHopper//".. game.PlaceId)
        writefile("ServerHopper//".. game.PlaceId .."//".. FileName ..".json", File)
    end)
end

function Serverhop:Normal(Logs, Amount)
    if Amount == nil then Amount = tonumber(math.huge) end;
    local JobIDs = {};
    local function FetchJobIDs()
        JobIDs = {os.date("*t").hour};
        local _s = tick();
        if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@CYAN@@") rconsoleprint("[!] Awaiting for ".. Amount .." servers to be scraped. \n") end;
        repeat
            task.wait()
            API = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/".. game.PlaceId .."/servers/Public?sortOrder=Asc&limit=100".. (ServerPages and "&cursor=".. ServerPages or ""))); -- servers api
            for i, v in next, API["data"] do
                if v["id"] ~= game.JobId and v["playing"] ~= v["maxPlayers"] then
                    if #JobIDs < Amount + 1 then
                        table.insert(JobIDs, v["id"])
                    end
                end
            end
            ServerPages = API.nextPageCursor
        until not ServerPages or #JobIDs >= Amount + 1
        if Logs then rconsoleprint("@@CYAN@@") rconsoleprint("[!] Successfully scraped ".. #JobIDs - 1 .." servers in ".. math.round(tick() - _s) .."s. \n") end;
        return true;
    end
    if not isfile("ServerHopper//".. game.PlaceId .."//normal-jobids.json") then
        FetchJobIDs()
        CreateFiles("normal-jobids", game:GetService("HttpService"):JSONEncode(JobIDs))
    end
    JobIDs = game:GetService("HttpService"):JSONDecode(readfile("ServerHopper//".. game.PlaceId .."//normal-jobids.json"))
    if JobIDs[1] ~= os.date("*t").hour then
        FetchJobIDs()
        writefile("ServerHopper//".. game.PlaceId .."//normal-jobids.json", game:GetService("HttpService"):JSONEncode(JobIDs))
    end
    local function RandomJobID()
        return JobIDs[math.random(1, #JobIDs)]
    end
    local SelectedJobID = RandomJobID();
    if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(Status)
        if Status == Enum.TeleportState.Failed then
            if Logs then rconsoleprint("@@LIGHT_RED@@") rconsoleprint("[*] Failed to join ".. SelectedJobID .." finding new server. \n") end;
            SelectedJobID = RandomJobID();
            if Logs then rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
        end
    end)
end

function Serverhop:Dynamic(Logs, Amount)
    if Amount == nil then Amount = tonumber(math.huge) end;
    local JobIDs = {};
    local OldJobIDs = {os.date("*t").hour};
    local function FetchJobIDs()
        JobIDs = {os.date("*t").hour};
        local _s = tick();
        if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@CYAN@@") rconsoleprint("[!] Awaiting for ".. Amount .." servers to be scraped. \n") end;
        repeat
            task.wait()
            API = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/".. game.PlaceId .."/servers/Public?sortOrder=Asc&limit=100".. (ServerPages and "&cursor=".. ServerPages or ""))); -- servers api
            for i, v in next, API["data"] do
                if v["id"] ~= game.JobId and v["playing"] ~= v["maxPlayers"] and not table.find(OldJobIDs, v["id"]) then
                    if #JobIDs < Amount + 1 then
                        table.insert(JobIDs, v["id"])
                    end
                end
            end
            ServerPages = API.nextPageCursor
        until not ServerPages or #JobIDs >= Amount + 1
        if Logs then rconsoleprint("@@CYAN@@") rconsoleprint("[!] Successfully scraped ".. #JobIDs - 1 .." servers in ".. math.round(tick() - _s) .."s. \n") end;
        return true;
    end
    if not isfile("ServerHopper//".. game.PlaceId .."//old_dynamic-jobids.json") then
        CreateFiles("old_dynamic-jobids", game:GetService("HttpService"):JSONEncode(OldJobIDs))
    end
    OldJobIDs = game:GetService("HttpService"):JSONDecode(readfile("ServerHopper//".. game.PlaceId .."//old_dynamic-jobids.json"))
    if not isfile("ServerHopper//".. game.PlaceId .."//dynamic-jobids.json") then
        FetchJobIDs()
        CreateFiles("dynamic-jobids", game:GetService("HttpService"):JSONEncode(JobIDs))
    end
    JobIDs = game:GetService("HttpService"):JSONDecode(readfile("ServerHopper//".. game.PlaceId .."//dynamic-jobids.json"))
    if JobIDs[1] ~= os.date("*t").hour or #JobIDs < 2 then
        FetchJobIDs()
        writefile("ServerHopper//".. game.PlaceId .."//dynamic-jobids.json", game:GetService("HttpService"):JSONEncode(JobIDs))
        if #JobIDs < 2 then
            writefile("ServerHopper//".. game.PlaceId .."//old_dynamic-jobids.json", game:GetService("HttpService"):JSONEncode({os.date("*t").hour}))
        end
    end
    if OldJobIDs[1] ~= os.date("*t").hour then
        FetchJobIDs()
        writefile("ServerHopper//".. game.PlaceId .."//old_dynamic-jobids.json", game:GetService("HttpService"):JSONEncode({os.date("*t").hour}))
    end
    local function RandomJobID()
        return JobIDs[math.random(1, #JobIDs)]
    end
    local SelectedJobID = RandomJobID();
    if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
    table.remove(JobIDs, table.find(JobIDs, SelectedJobID))
    table.insert(OldJobIDs, SelectedJobID)
    writefile("ServerHopper//".. game.PlaceId .."//old_dynamic-jobids.json", game:GetService("HttpService"):JSONEncode(OldJobIDs))
    writefile("ServerHopper//".. game.PlaceId .."//dynamic-jobids.json", game:GetService("HttpService"):JSONEncode(JobIDs))
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(Status)
        if Status == Enum.TeleportState.Failed then
            if Logs then rconsoleprint("@@LIGHT_RED@@") rconsoleprint("[*] Failed to join ".. SelectedJobID .." finding new server. \n") end;
            SelectedJobID = RandomJobID();
            if Logs then rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
            table.remove(JobIDs, table.find(JobIDs, SelectedJobID))
            table.insert(OldJobIDs, SelectedJobID)
            writefile("ServerHopper//".. game.PlaceId .."//old_dynamic-jobids.json", game:GetService("HttpService"):JSONEncode(OldJobIDs))
            writefile("ServerHopper//".. game.PlaceId .."//dynamic-jobids.json", game:GetService("HttpService"):JSONEncode(JobIDs))
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
        end
    end)
end

function Serverhop:Rejoin(Logs)
    if Logs then rconsolename("severhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Rejoining server. \n") end;
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(Status)
        if Status == Enum.TeleportState.Failed then
            if Logs then rconsoleprint("@@LIGHT_RED@@") rconsoleprint("[*] Failed to rejoin. \n") end;
        end
    end)
end

function Serverhop:LowPing(Logs, Amount, Ping)
    if Ping == nil then Ping = 100 end;
    if Amount == nil then Amount = tonumber(math.huge) end;
    local JobIDs = {};
    local function FetchJobIDs()
        JobIDs = {os.date("*t").hour};
        local _s = tick();
        if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@CYAN@@") rconsoleprint("[!] Awaiting for ".. Amount .." servers to be scraped. \n") end;
        repeat
            task.wait()
            API = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/".. game.PlaceId .."/servers/Public?sortOrder=Asc&limit=100".. (ServerPages and "&cursor=".. ServerPages or ""))); -- servers api
            for i, v in next, API["data"] do
                if v["id"] ~= game.JobId and v["playing"] ~= v["maxPlayers"] and v["ping"] ~= nil and v["ping"] <= Ping then
                    if #JobIDs < Amount + 1 then
                        table.insert(JobIDs, v["id"])
                    end
                end
            end
        until not ServerPages or #JobIDs >= Amount + 1
        if Logs then rconsoleprint("@@CYAN@@") rconsoleprint("[!] Successfully scraped ".. #JobIDs - 1 .." servers in ".. math.round(tick() - _s) .."s. \n") end;
        return true;
    end
    if not isfile("ServerHopper//".. game.PlaceId .."//low_ping-jobids.json") then
        FetchJobIDs()
        CreateFiles("low_ping-jobids", game:GetService("HttpService"):JSONEncode(JobIDs))
    end
    JobIDs = game:GetService("HttpService"):JSONDecode(readfile("ServerHopper//".. game.PlaceId .."//low_ping-jobids.json"))
    if JobIDs[1] ~= os.date("*t").hour then
        FetchJobIDs()
        writefile("ServerHopper//".. game.PlaceId .."//low_ping-jobids.json", game:GetService("HttpService"):JSONEncode(JobIDs))
    end
    local function RandomJobID()
        return JobIDs[math.random(1, #JobIDs)]
    end
    local SelectedJobID = RandomJobID();
    if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(Status)
        if Status == Enum.TeleportState.Failed then
            if Logs then rconsoleprint("@@LIGHT_RED@@") rconsoleprint("[*] Failed to join ".. SelectedJobID .." finding new server. \n") end;
            SelectedJobID = RandomJobID();
            if Logs then rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
        end
    end)
end

function Serverhop:LowPlayers(Logs, Amount, Players)
    if Players == nil then for i, v in next, game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games?universeIds=".. game.GameId))["data"] do Players = tonumber(v["maxPlayers"]) / 2 end end;
    if Amount == nil then Amount = tonumber(math.huge) end;
    local JobIDs = {};
    local function FetchJobIDs()
        JobIDs = {os.date("*t").hour};
        local _s = tick();
        if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@CYAN@@") rconsoleprint("[!] Awaiting for ".. Amount .." servers to be scraped. \n") end;
        repeat
            task.wait()
            API = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/".. game.PlaceId .."/servers/Public?sortOrder=Asc&limit=100".. (ServerPages and "&cursor=".. ServerPages or ""))); -- servers api
            for i, v in next, API["data"] do
                if v["id"] ~= game.JobId and v["playing"] ~= v["maxPlayers"] and v["playing"] <= Players then
                    if #JobIDs < Amount + 1 then
                        table.insert(JobIDs, v["id"])
                    end
                end
            end
        until not ServerPages or #JobIDs >= Amount + 1
        if Logs then rconsoleprint("@@CYAN@@") rconsoleprint("[!] Successfully scraped ".. #JobIDs - 1 .." servers in ".. math.round(tick() - _s) .."s. \n") end;
        return true;
    end
    if not isfile("ServerHopper//".. game.PlaceId .."//low_players-jobids.json") then
        FetchJobIDs()
        CreateFiles("low_players-jobids", game:GetService("HttpService"):JSONEncode(JobIDs))
    end
    JobIDs = game:GetService("HttpService"):JSONDecode(readfile("ServerHopper//".. game.PlaceId .."//low_players-jobids.json"))
    if JobIDs[1] ~= os.date("*t").hour then
        FetchJobIDs()
        writefile("ServerHopper//".. game.PlaceId .."//low_players-jobids.json", game:GetService("HttpService"):JSONEncode(JobIDs))
    end
    local function RandomJobID()
        return JobIDs[math.random(1, #JobIDs)]
    end
    local SelectedJobID = RandomJobID();
    if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(Status)
        if Status == Enum.TeleportState.Failed then
            if Logs then rconsoleprint("@@LIGHT_RED@@") rconsoleprint("[*] Failed to join ".. SelectedJobID .." finding new server. \n") end;
            SelectedJobID = RandomJobID();
            if Logs then rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
        end
    end)
end

function Serverhop:Instant(Logs)
    local JobIDs = {};
    for i, v in next, game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/".. game.PlaceId .."/servers/Public?sortOrder=Asc&limit=100"))["data"] do
        if v["id"] ~= game.PlaceId and v["playing"] ~= v["maxPlayers"] then
            table.insert(JobIDs, v["id"])
        end
    end
    local function RandomJobID()
        return JobIDs[math.random(1, #JobIDs)]
    end
    local SelectedJobID = RandomJobID();
    if Logs then rconsolename("serverhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(Status)
        if Status == Enum.TeleportState.Failed then 
            if Logs then rconsoleprint("@@LIGHT_RED@@") rconsoleprint("[*] Failed to join ".. SelectedJobID .." finding new server. \n") end;
            SelectedJobID = RandomJobID();
            if Logs then rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Server hopping to ".. SelectedJobID ..". \n") end;
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, SelectedJobID)
        end
    end)
end

function Serverhop:JoinJobID(Logs, JobID)
    if Logs then rconsolename("severhop-libary.lua ; seth.#0001 - ".. string.format("%02i:%02i %s", ((os.date("*t").hour % 24 - 1) % 12) + 1, os.date("*t").min, os.date("*t").hour % 24 < 12 and "AM" or "PM")) rconsoleprint("@@LIGHT_CYAN@@") rconsoleprint("[#] Attempting to join ".. JobID ..". \n") end;
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, JobID)
    game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(Status)
        if Status == Enum.TeleportState.Failed then 
            if Logs then rconsoleprint("@@LIGHT_RED@@") rconsoleprint("[*] Failed to join ".. JobID ..". \n") end;
        end
    end)
end

return Serverhop;
