
* ---------------------------------------------------------------------------- *
* DESCRIPTIVE STATISTICS
* Analysis of individual data
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$datadir\data_chile_paper_1980_2015_2_digits"

* ---------------------------------------------------------------------------- *
* Sample restrictions
* ---------------------------------------------------------------------------- *
* Restrict sample to individuals aged between 15 and 65 years old
drop if age < 15 | age > 65

* ---------------------------------------------------------------------------- *
* Data Cleaning and Variable Creation
* ---------------------------------------------------------------------------- *
* Drop duplicates for individuals based on folio_n20 and mdate
duplicates drop folio_n20 mdate, force

* Set panel data structure
xtset folio_n20 mdate

* Create gender variable based on existing data
by folio_n20: egen gender = max(sex)
replace sex = gender
drop gender
* Clean up the sex variable and create dummies
tab sex, gen(sex)
drop if sex == .

* Clean variable for reason for stopping to work
recode reason_endjob -4=. 88=. 99=. 12=.
label define reason_endjob 1 "Mutuo acuerdo de las partes" 2 "Renuncia" 3 "Vencimiento del contrato o fin del trabajo" 4 "Despido por causa imputable a usted" 5 "Despido por necesidades de la empresa" 6 "Cierre de la empresa" 7 "Encontro un mejor trabajo" 8 "Condiciones de salud" 9 "Se pensiono" 10 "Caso fortuito o fuerza mayor" 11 "Otra"
label values reason_endjob reason_endjob
tab reason_endjob, gen(reason_endjob)

* Clean variable for reason for inactivity
recode reason_inactivity -4=. 88=. 99=. 12=.
label define reason_inactivity 1 "Enfermedad o descapacidad" 2 "Cuidado de los ninos" 3 "Por responsabilidades personales o familiares" 4 "Embarazo" 5 "Estudiaba o se estaba capacitando" 6 "Realizaba la practica" 7 "Quehaceres de hogar" 8 "Jubilado" 9 "No le interesaba trabajar" 10 "Servicio miliar" 11 "Otro"
label values reason_inactivity reason_inactivity
tab reason_inactivity, gen(reason_inactivity)

* Generate dummy variables for tabulation
tab permanent_job, gen(permanent_job)
tab categ_occ, gen(categ_occ)
tab job_contract, gen(job_contract)
tab contributing, gen(contributing)

* Generate informality status variable
gen formal =1 if occ_class_paper ==1 | occ_class_paper ==2 | occ_class_paper ==3 | occ_class_paper ==4
replace formal =0 if occ_class_paper ==7 | occ_class_paper ==8 | occ_class_paper ==9 | occ_class_paper ==10

tab schooling, gen(schooling)

* Clean variables
recode hours_worked -4=. 888=.
recode earnings_net 0=.

g hourlyincome = earnings_net / (hours_worked*52/12) if earnings_net!=. & hours_worked!=.

* ---------------------------------------------------------------------------- *
* Descriptive Statistics
* ---------------------------------------------------------------------------- *

xtsum sex1
xtsum sex1 if occ_class ==1
xtsum sex1 if occ_class ==2
xtsum sex1 if occ_class ==3
xtsum sex1 if occ_class ==4
xtsum sex1 if occ_class_paper ==5
xtsum sex1 if occ_class_paper ==6
xtsum age
xtsum age if occ_class ==1
xtsum age if occ_class ==2
xtsum age if occ_class ==3
xtsum age if occ_class ==4
xtsum age if occ_class_paper ==5
xtsum age if occ_class_paper ==6
xtsum schooling1
xtsum schooling1 if occ_class ==1
xtsum schooling1 if occ_class ==2
xtsum schooling1 if occ_class ==3
xtsum schooling1 if occ_class ==4
xtsum schooling1 if occ_class_paper ==5
xtsum schooling1 if occ_class_paper ==6
xtsum schooling2
xtsum schooling2 if occ_class ==1
xtsum schooling2 if occ_class ==2
xtsum schooling2 if occ_class ==3
xtsum schooling2 if occ_class ==4
xtsum schooling2 if occ_class_paper ==5
xtsum schooling2 if occ_class_paper ==6
xtsum schooling3
xtsum schooling3 if occ_class ==1
xtsum schooling3 if occ_class ==2
xtsum schooling3 if occ_class ==3
xtsum schooling3 if occ_class ==4
xtsum schooling3 if occ_class_paper ==5
xtsum schooling3 if occ_class_paper ==6

xtsum categ_occ1
xtsum categ_occ1 if occ_class ==1
xtsum categ_occ1 if occ_class ==2
xtsum categ_occ1 if occ_class ==3
xtsum categ_occ1 if occ_class ==4
xtsum categ_occ1 if occ_class_paper ==5
xtsum categ_occ1 if occ_class_paper ==6
xtsum categ_occ2
xtsum categ_occ2 if occ_class ==1
xtsum categ_occ2 if occ_class ==2
xtsum categ_occ2 if occ_class ==3
xtsum categ_occ2 if occ_class ==4
xtsum categ_occ2 if occ_class_paper ==5
xtsum categ_occ2 if occ_class_paper ==6
xtsum formal
xtsum formal if occ_class ==1
xtsum formal if occ_class ==2
xtsum formal if occ_class ==3
xtsum formal if occ_class ==4
xtsum formal if occ_class_paper ==5
xtsum formal if occ_class_paper ==6
xtsum permanent_job1
xtsum permanent_job1 if occ_class ==1
xtsum permanent_job1 if occ_class ==2
xtsum permanent_job1 if occ_class ==3
xtsum permanent_job1 if occ_class ==4
xtsum permanent_job1 if occ_class_paper ==5
xtsum permanent_job1 if occ_class_paper ==6
xtsum job_contract1
xtsum job_contract1 if occ_class ==1
xtsum job_contract1 if occ_class ==2
xtsum job_contract1 if occ_class ==3
xtsum job_contract1 if occ_class ==4
xtsum job_contract1 if occ_class_paper ==5
xtsum job_contract1 if occ_class_paper ==6
xtsum contributing1
xtsum contributing1 if occ_class ==1
xtsum contributing1 if occ_class ==2
xtsum contributing1 if occ_class ==3
xtsum contributing1 if occ_class ==4
xtsum contributing1 if occ_class_paper ==5
xtsum contributing1 if occ_class_paper ==6
xtsum hours_worked
xtsum hours_worked if occ_class ==1
xtsum hours_worked if occ_class ==2
xtsum hours_worked if occ_class ==3
xtsum hours_worked if occ_class ==4
xtsum hours_worked if occ_class_paper ==5
xtsum hours_worked if occ_class_paper ==6

xtsum reason_endjob1
xtsum reason_endjob1 if occ_class ==1
xtsum reason_endjob1 if occ_class ==2
xtsum reason_endjob1 if occ_class ==3
xtsum reason_endjob1 if occ_class ==4
xtsum reason_endjob2
xtsum reason_endjob2 if occ_class ==1
xtsum reason_endjob2 if occ_class ==2
xtsum reason_endjob2 if occ_class ==3
xtsum reason_endjob2 if occ_class ==4
xtsum reason_endjob3
xtsum reason_endjob3 if occ_class ==1
xtsum reason_endjob3 if occ_class ==2
xtsum reason_endjob3 if occ_class ==3
xtsum reason_endjob3 if occ_class ==4
xtsum reason_endjob4
xtsum reason_endjob4 if occ_class ==1
xtsum reason_endjob4 if occ_class ==2
xtsum reason_endjob4 if occ_class ==3
xtsum reason_endjob4 if occ_class ==4
xtsum reason_endjob5
xtsum reason_endjob5 if occ_class ==1
xtsum reason_endjob5 if occ_class ==2
xtsum reason_endjob5 if occ_class ==3
xtsum reason_endjob5 if occ_class ==4
xtsum reason_endjob6
xtsum reason_endjob6 if occ_class ==1
xtsum reason_endjob6 if occ_class ==2
xtsum reason_endjob6 if occ_class ==3
xtsum reason_endjob6 if occ_class ==4
xtsum reason_endjob7
xtsum reason_endjob7 if occ_class ==1
xtsum reason_endjob7 if occ_class ==2
xtsum reason_endjob7 if occ_class ==3
xtsum reason_endjob7 if occ_class ==4
xtsum reason_endjob8
xtsum reason_endjob8 if occ_class ==1
xtsum reason_endjob8 if occ_class ==2
xtsum reason_endjob8 if occ_class ==3
xtsum reason_endjob8 if occ_class ==4
xtsum reason_endjob9
xtsum reason_endjob9 if occ_class ==1
xtsum reason_endjob9 if occ_class ==2
xtsum reason_endjob9 if occ_class ==3
xtsum reason_endjob9 if occ_class ==4
xtsum reason_endjob10
xtsum reason_endjob10 if occ_class ==1
xtsum reason_endjob10 if occ_class ==2
xtsum reason_endjob10 if occ_class ==3
xtsum reason_endjob10 if occ_class ==4
xtsum reason_endjob11
xtsum reason_endjob11 if occ_class ==1
xtsum reason_endjob11 if occ_class ==2
xtsum reason_endjob11 if occ_class ==3
xtsum reason_endjob11 if occ_class ==4

* ---------------------------------------------------------------------------- *
* End of Descriptive Statistics do-file
* ---------------------------------------------------------------------------- *
