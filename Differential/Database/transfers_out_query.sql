INSERT INTO dbMoi.transfer (squad_id, gameweek, player_fpl_id)
SELECT sgp.squad_id, (sgp.gameweek + 1) gameweek, sgp.fpl_player_id
FROM dbMoi.squad_gameweek_player sgp
WHERE (SELECT COUNT(*) num FROM dbMoi.squad_gameweek_player sgp2 
       WHERE sgp2.squad_id = sgp.squad_id AND sgp2.gameweek = (sgp.gameweek + 1) ) = 15
AND NOT EXISTS (SELECT sgp3.fpl_player_id FROM dbMoi.squad_gameweek_player sgp3
                WHERE sgp3.squad_id = sgp.squad_id AND sgp3.gameweek = (sgp.gameweek + 1) AND sgp3.fpl_player_id = sgp.fpl_player_id)
ORDER BY sgp.squad_id ASC, sgp.gameweek ASC