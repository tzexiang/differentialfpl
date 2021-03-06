select v.diff_rounded
, (select round((count(*) * 100.0) / (select count(*) from review_player_predictions_v), 1) from review_player_predictions_v b 
   where b.diff_rounded <= v.diff_rounded and b.diff_rounded >= (0 - v.diff_rounded)) total
from review_player_preds_grouped_v v
where v.diff_rounded >= 0
order by v.diff_rounded asc