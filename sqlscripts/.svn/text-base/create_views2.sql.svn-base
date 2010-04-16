CREATE OR REPLACE VIEW game_goalies
(game_id, game_date, player_id, name)
AS SELECT game_id, game_date, pg.player_id, name
FROM played_games pg JOIN players p ON (pg.player_id = p.id)
WHERE goalie = 1;
