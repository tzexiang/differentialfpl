--explain query plan
SELECT p._id _id, p.name name, p.team_id team_id, ps.position position, p.fpl_yellow_flag fpl_yellow_flag
		 		, p.fpl_red_flag fpl_red_flag, p.diff_flag diff_flag, '£'||ps.price||'M' price, pls.points points
		 		, p.picture_code picture_code, (pls.assists * 3) assist_pts, pls.bonus bonus_pts
		 		, (CASE WHEN pls.position <= 2 THEN pls.goals * 6 WHEN pls.position = 3 THEN pls.goals * 5 WHEN pls.position = 4 THEN pls.goals * 4 END) goal_pts
		 		, pls.c_assists_perc_team, p.ticker_string, ps.fpl_id
FROM player p, player_season ps
		 		LEFT OUTER JOIN player_season pls ON pls.season = 11 AND pls.player_id = p._id
		 		WHERE ps.player_id = p._id AND ps.season = 12
		 		AND ps.price <= 12
		 		AND pls.minutes_qual >= 900
		 		ORDER BY pls.c_assists_perc_team DESC
		 		LIMIT 50