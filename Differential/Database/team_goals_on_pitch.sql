select p.name, pm.player_player_id, pm.fixture_id, pm.pl_team_id, pm.opp_team_id, pm.gameweek, pm.goals, pm.assists, pm.minutes, pm.total
, pm.team_goals_on_pitch, CASE WHEN pm.is_home = 1 THEN f.res_goals_home ELSE f.res_goals_away END f_goals, pm.conceded
from player_match pm, fixture f, player p
where pm.season = 12 and p._id = pm.player_player_id
and f._id = pm.fixture_id
and pm.gameweek <= 33
--and minutes = 90 and ((team_goals_on_pitch is null and (f_goals > 0 or goals > 0)) or team_goals_on_pitch < f_goals)
--and ( (goals > team_goals_on_pitch) or (goals > 0 and team_goals_on_pitch is null) )
--and ( (assists > team_goals_on_pitch) or (assists > 0 and team_goals_on_pitch is null) )
and minutes > 0 and team_goals_on_pitch is null and f_goals > 0
order by pm.pl_team_id asc, p._id asc, pm.gameweek asc