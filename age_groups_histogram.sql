select 
	 sex
	,round(avg(charges),2)												as average_charges
from health
group by 1;

select 
	sex
	,count(*)													as number_of_respondents
from health h 
where smoker = 'yes'
group by 1

select 
	 sex
	,count(*) 													as smokers
from health
where smoker = 'yes'
group by 1;


select 
	 sex
	,round(avg(children),2)												as average_nr_of_children
from health
group by 1;

with age_groups
as(
	select
	*,
		case
			when age between 18 and 29 
			then '18-29'
			when age between 30 and 39
			then '30-39'
			when age between 40 and 49
			then '40-49'
			when age between 50 and 59
			then '50-59'
			else '60+'
		end as age_groups
	from health
	),
	 avg_charges				
as(
	select 
		 age_groups
		,round(avg(charges),2)											as average_charges
	from age_groups
	group by 1
	order by 1
 ),
 	nr_of_non_smokers		
 as(
	select 
		 age_groups
		,count(age)												as nr_of_no_smokers					
	from age_groups
	where smoker = 'no'
	group by 1
	order by 1
	),
	nr_of_smokers 				
as(
	select 
		 age_groups
		,count(age_groups.age)											as nr_of_smokers
	from age_groups
	where smoker = 'yes'
	group by 1
	order by 1
	),
	smokers_histogram		
as(
select 	
	 nr_of_smokers.age_groups
	,(nr_of_smokers.nr_of_smokers + nr_of_non_smokers.nr_of_no_smokers) 						as total
	,nr_of_non_smokers.nr_of_no_smokers
	,nr_of_smokers.nr_of_smokers
from nr_of_smokers
join nr_of_non_smokers on nr_of_smokers.age_groups = nr_of_non_smokers.age_groups
	)
select * from smokers_histogram;

select 
	'parents'
	,count(*)		as sum_of
from health h 
where children > 0
union
select
	'childless'
	,count(*)		as sum_of
from health h 
where children = 0;


select 
	children
	,round(avg(charges),2) as avg_charges
from health h 
group by 1
order by 1






