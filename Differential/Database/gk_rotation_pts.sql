select p.name, sum(pm.pred_total_pts)/100.0 pred_pts, ps.price/10.0 price
from player_match pm, player p, team_season ts, player_season ps
where pm.player_player_id = ts.gk_player_id
and ts.season = 12 and pm.season = 12
and p._id = ts.gk_player_id
and pm.gameweek >= 23 and ps.season = 12 and ps.player_id = p._id
group by p._id
order by pred_pts desc