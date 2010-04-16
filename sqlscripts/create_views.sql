CREATE OR REPLACE VIEW
played_games
AS select gp.*, g.game_date
FROM (`game_players` `gp` join `games` `g`) where ((`gp`.`game_id` = `g`.`id`) and (`g`.`game_status_id` = 2) and gp.player_status_id > 2);