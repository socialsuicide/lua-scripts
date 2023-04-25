# Serverhop Libary Documentation

## Getting started.
```lua
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();
```

## Using functions.
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
