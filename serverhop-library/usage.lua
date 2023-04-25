-- this will documentation will show the usage of the serverhopper library.
-- these will obviously not work, this is just to showcase the usage of the functions.

ServerHop:Normal(Logs: {true, false}, Amount: {int, nil})
-- Usage of function: scrapes jobids into a file then picks a random jobid.
-- Logs: outputs rconsoleprint responses.
-- Amount: the amount of servers scrapped (nil = inf).

ServerHop:Dynamic(Logs: {true, false}, Amount: {int, nil})
-- Usage of function: scrapes all jobids into a file but the jobids which have already been used.
-- Logs: outputs rconsoleprint responses.
-- Amount: the amount of servers scrapped (nil = inf).

ServerHop:Rejoin(Logs: {true, false})
-- Usage of function: joins the jobid of the lobby you where just in.
-- Logs: outputs rconsoleprint responses.

ServerHop:LowPing(Logs: {true, false}, Amount: {int, nil}, Ping: {int, nil})
-- Usage of function: scrapes all jobids which have the selected ping.
-- Logs: outputs rconsoleprint responses.
-- Amount: the amount of servers scrapped (nil = inf).
-- Ping: scrapes servers with the selected ping. (nil = 100).

ServerHop:LowPlayers(Logs: {true, false}, Amount: int, Players: int)
-- Usage of function: scrapes all jobids which have below the selected player count.
-- Logs: outputs rconsoleprint responses.
-- Amount: the amount of servers scrapped (nil = inf).
-- Players: scrapes servers with the selected player count. (nil = half of the games maxplayers).

ServerHop:Instant(Logs: {true, false})
-- Usage of function: instantly joins another server with no jobid logs.
-- Logs: outputs rconsoleprint responses.

ServerHop:JoinJobID(Logs: {true, false}, JobID: str)
-- Usage of function: attempts to join a inputed jobid.
-- Logs: outputs rconsoleprint responses.
