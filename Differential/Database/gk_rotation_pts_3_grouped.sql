select p1.name, p2.name, SUM(pm1.pred_total_pts) p1_pts, SUM(pm2.pred_total_pts) p2_pts
, SUM(CASE WHEN pm1.pred_total_pts >= pm2.pred_total_pts THEN pm1.pred_total_pts ELSE 0 END) p1_pts_use
, SUM(CASE WHEN pm2.pred_total_pts >  pm1.pred_total_pts THEN pm2.pred_total_pts ELSE 0 END) p2_pts_use
, SUM(CASE WHEN pm1.pred_total_pts > pm2.pred_total_pts THEN pm1.pred_total_pts ELSE pm2.pred_total_pts END) total_pts_use
, ps1.price/10.0 p1_price, ps2.price/10.0 p2_price, (ps1.price + ps2.price)/10.0 total_price
from player p1, player_season ps1
   , player p2, player_season ps2
   , team_season ts1, team_season ts2
   , player_match pm1, player_match pm2
where ts1.season = 12 and ts2.season = 12
  and ts1.team_id < ts2.team_id
  and p1._id = ts1.gk_player_id and ps1.player_id = p1._id
  and p2._id = ts2.gk_player_id and ps2.player_id = p2._id
  and ps1.season = 12 and ps2.season = 12
  and pm1.player_player_id = p1._id and pm1.season = 12 and pm1.gameweek >= 23 --and pm1.gameweek <=25
  and pm2.player_player_id = p2._id and pm2.season = 12 and pm2.gameweek >= 23 --and pm2.gameweek <=25
  and pm1.gameweek = pm2.gameweek
  group by ts1.gk_player_id, ts2.gk_player_id
  order by total_pts_use desc