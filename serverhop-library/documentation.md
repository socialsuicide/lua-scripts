# Serverhop Libary Documentation

## Getting started.
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();
```

## Using functions.
‎‎‎‎‎‎‎‎ㅤ
> ServerHop:Normal()
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

ServerHop:Normal(true, nil);
```
```text
Usage of ServerHop:Normal() - Scrapes JobIDs and saves them into a JSON file before selecting a random JobID to teleport too.

1) Logs:
    Usage: {true, false},
    Action: Outputs logs using rconsoleprint.
2) Amount:
    Usage: {int, nil},
    Action: Scrapes a certain amount of JobIDs (nil = inf).
```

> ServerHop:Dynamic()
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

ServerHop:Dynamic(true, nil)
```
```text
Usage of ServerHop:Dynamic() - Scrapes JobIDs which havent been used in the past hour into a JSON file before selecting a random JobID to teleport too.

1) Logs:
    Usage: {true, false},
    Action: Outputs logs using rconsoleprint.
2) Amount:
    Usage: {int, nil},
    Action: Scrapes a certain amount of JobIDs (nil = inf).
```

### ServerHop:Rejoin()
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

ServerHop:Rejoin(true)
```
```text
Usage of ServerHop:Rejoin() - Rejoins the exact same JobID.

1) Logs:
    Usage: {true, false},
    Action: Outputs logs using rconsoleprint.
```

### ServerHop:LowPing()
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

ServerHop:LowPing(true, nil, 250)
```
```text
Usage of ServerHop:LowPing() - Scrapes JobIDs of servers with below or the inputed ping into a JSON file before selecting a random JobID to teleport too.

1) Logs:
    Usage: {true, false},
    Action: Outputs logs using rconsoleprint.
2) Amount:
    Usage: {int, nil},
    Action: Scrapes a certain amount of JobIDs (nil = inf).
3) Ping:
    Usage: {int, nil},
    Action: Scrapes JobIDs with servers with below or inputed ping (nil = 100).
```

### ServerHop:LowPlayers()
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

ServerHop:LowPlayers(true, nil, 10)
```
```text
Usage of ServerHop:LowPlayers() - Scrapes JobIDs of servers with below or the inputed amount of players.

1) Logs:
    Usage: {true, false},
    Action: Outputs logs using rconsoleprint.
2) Amount:
    Usage: {int, nil},
    Action: Scrapes a certain amount of JobIDs (nil = inf).
3) Players:
    Usage: {int, nil},
    Action: Scrapes JobIDs of servers with below or the inputed amount of players (nil = Half of maxPlayers).
```

### ServerHop:Instant()
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

ServerHop:Instant(true)
```
```text
Usage of ServerHop:Instant() - Instantly joins another JobID without using JSON.

1) Logs:
    Usage: {true, false},
    Action: Outputs logs using rconsoleprint.
```

### ServerHop:JoinJobID()
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

ServerHop:JoinJobID(true)
```
```text
Usage of ServerHop:JoinJobID() - Joins the inputed JobID.

1) Logs:
    Usage: {true, false},
    Action: Outputs logs using rconsoleprint.
2) JobID:
    Usage: {str},
    Action: Joins a inputed JobID.
```

## Examples
