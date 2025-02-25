with ranked as (                          #create a CTE with each team ranked by how much they paid in wages
select
*,
row_number() over(partition by league, year order by wage_pct_league_total desc) as wage_rank
from wage_pcts)

select                                    #output the count of final positions of those who paid the most in wages (i.e. wage rank = 1)
    league,
    count(case when final_position = 1 then 1 end) as 1st,
    COUNT(case when final_position = 2 then 1 end) as 2nd,
    COUNT(case when final_position = 3 then 1 end) as 3rd,
    COUNT(case when final_position = 4 then 1 end) as 4th,
    COUNT(case when final_position = 5 then 1 end) as 5th,
    COUNT(case when final_position = 6 then 1 end) as 6th,
    COUNT(case when final_position = 7 then 1 end) as 7th,
    COUNT(case when final_position = 8 then 1 end) as 8th,
    COUNT(case when final_position = 9 then 1 end) as 9th,
    COUNT(case when final_position = 10 then 1 end) as 10th
from ranked t1
where wage_rank = (
    select MIN(wage_rank)
    from ranked t2
    where t2.league = t1.league
)
group by league
order by league
;

