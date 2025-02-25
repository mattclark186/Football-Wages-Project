create table lu_winners(            #creates the table with column headers and data types
year int,
team varchar(255),
wage_rank int)
;


insert into lu_winners (year)              #manually add the years
values
(2015),(2016),(2017),(2018),(2019),
(2020),(2021),(2022),(2023),(2024)
;


insert into lu_winners (team, wage_rank)      #add the teams and wage ranks from the exisiting tables
select squad, Rk from lu_23_24                #(change for each season table)
where `Final Position` = 1
;


#the rows don't align so need to be manipulated

with temp as (                              #creates a temporary table in a cte with an added row number
	select *,
	row_number() over() as rownum
	from lu_winners),

temp2 as (                                  #creates a second temporary table in a cte where the rows are aligned using the row numbers
	select t1.year, t2.team, t2.wage_rank 
    from temp t1
    join temp t2
    on t2.rownum = t1.rownum + 10)

update lu_winners w                   #updates the data in the winners table using the temporary cte table above
join temp2 t
on w.year = t.year
set w.wage_rank = t.wage_rank,
	w.team = t.team
;


delete from lu_winners              #deletes the bottom rows since they're now duplicates
where year is null
;


update lu_winners                         #converts years and wages ranks to number data types
set `Year` = CAST(`Year` AS UNSIGNED),
	`wage_rank` = CAST(`wage_rank` AS UNSIGNED)
;


select * from lu_winners
;
