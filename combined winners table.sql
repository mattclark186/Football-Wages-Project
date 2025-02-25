create table winners(            #creates the table with column headers and data types
year int,
pl_team varchar(255),
pl_wage_rank int,
sa_team varchar(255),
sa_wage_rank int,
ll_team varchar(255),
ll_wage_rank int,
bl_team varchar(255),
bl_wage_rank int,
lu_team varchar(255),
lu_wage_rank int)
;


insert into winners (year)              #manually add the years
values
(2015),(2016),(2017),(2018),(2019),
(2020),(2021),(2022),(2023),(2024)
;


update winners w                     #adds the data from the league winners tables
join lu_winners p
on w.year = p.year
set w.lu_team = p.team,
	w.lu_wage_rank = p.wage_rank
;
    

select * from winners
;
