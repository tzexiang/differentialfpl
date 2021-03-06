drop view review_player_predictions_v;
create view review_player_predictions_v as
select p.name, t.name, ps.position, pm.gameweek, t2.name opp_name, pm.total, (pm.pred_total_pts/100) pred_pts
, pm.total - (pm.pred_total_pts/100.0) diff, round((pm.total - (pm.pred_total_pts/100.0))) diff_rounded
from player_season ps, player p, team t, player_match pm, team t2
where p._id = ps.player_id and t._id = p.team_id
and pm.player_player_id = p._id and pm.season=12 and ps.season=12
and pm.gameweek >= 15 and pm.gameweek <=34
and t2._id = pm.opp_team_id
and pred_pts is not null and total is not null and pm.minutes >= 60
order by pred_pts desc