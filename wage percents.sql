create table wage_pcts(                 #create a table containing a column for wage percentages
year integer,
final_position integer,
team varchar(255),
league varchar(255),
wage_pct_league_total float)
;


alter table lu_23_24                      #add a column for wage percentages to each existing table
add column wage_pct_league_total float
;


with total_wages as (                                 #create a CTE with the total wages spent across the league
select sum(`Annual Wages`) as total_wages
from lu_23_24)
update                                       #populate the wage percentage column with each teams wage spend as a percentage of the league total
lu_23_24 l,
total_wages t
set l.wage_pct_league_total = round(100.0*l.`Annual Wages`/t.total_wages,1)
;


insert into                                                     #insert the data from each table into the wage percentage table
wage_pcts (final_position, team, wage_pct_league_total)
select `Final Position`, squad, wage_pct_league_total
from lu_23_24
;


update wage_pcts                  #fill in the year column
set year = 2024
where year is null
;


update wage_pcts                  #fill in the season column
set league = 'LU'
where league is null
;


select *
from wage_pcts
order by league desc, year desc, final_position
;
