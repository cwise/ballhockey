ALTER TABLE game_players ADD CONSTRAINT fk_gameplayer_2_player FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE;

