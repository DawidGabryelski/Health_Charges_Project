with bmi_classes
as(
	select 
		*,
			case 	
				when bmi between 15.96 and 18.49
				then 'Underweight'
				when bmi between 18.50 and 25.00
				then 'Correct weight'
				when bmi between 25.01 and 29.99
				then 'Overweight'
				when bmi between 30.00 and 34.99
				then '1st level obesity'
				when bmi between 35.00 and 39.99
				then '2nd level obesity'
				else '3rd level obesity'
			end as bmi_classes
	from health
	), smokers_bmi 
as(
	select 
		 bmi_classes
		,count(*) 					as smokers
		,round(avg(charges),2)		as avg_smoker_charges
	from (select 
			* 
			from bmi_classes 
			where smoker ='yes') as smokers
	group by 1
	order by 3
	), no_smokers_bmi 
as(
	select 
		 bmi_classes
		,count(*) 					as no_smokers
		,round(avg(charges),2)		as avg_no_smoker_charges
	from (select 
			* 
			from bmi_classes 
			where smoker ='no') as no_smokers
	group by 1
	order by 3
	)
select 
	smokers_bmi.bmi_classes
	,(smokers_bmi.smokers + no_smokers_bmi.no_smokers) 									as total
	,smokers_bmi.smokers
	,smokers_bmi.avg_smoker_charges
	,no_smokers_bmi.no_smokers
	,no_smokers_bmi.avg_no_smoker_charges
	,round((smokers_bmi.avg_smoker_charges/no_smokers_bmi.avg_no_smoker_charges),2)		as smokers_charge_diffrence
from no_smokers_bmi
join smokers_bmi on smokers_bmi.bmi_classes = no_smokers_bmi.bmi_classes 
order by 6;







	
