
* ---------------------------------------------------------------------------- *
* GENERAL DATA SETUP
* Setup for analysis
* ---------------------------------------------------------------------------- *

cap log close 
log using "$resultdir\2_general_data_setup.log", replace

* Clear current data, set directory and load dataset
clear
use "$datadir\data_chile_paper_1980_2015_2_digits_isco88"

* ---------------------------------------------------------------------------- *
* Data Cleaning and Variable Creation
* ---------------------------------------------------------------------------- *
* Drop duplicates for individuals based on folio_n20 and mdate
duplicates drop folio_n20 mdate, force

* Recode and label 'reason_endjob' variable
recode reason_endjob -4=. 88=. 99=. 12=.
label define reason_endjob 1 "Mutuo acuerdo de las partes" 2 "Renuncia" 3 "Vencimiento del contrato o fin del trabajo" 4 "Despido por causa imputable a usted"
label values reason_endjob reason_endjob

* Recode and label 'reason_inactivity' variable
recode reason_inactivity -4=. 88=. 99=. 12=.
label define reason_inactivity 1 "Enfermedad o descapacidad" 2 "Cuidado de los ninos" 3 "Por responsabilidades personales o familiares" 4 "Embarazo" 5 "Estudiaba o se estaba capacitando" 6 "Realizaba la practica" 7 "Quehaceres de hogar" 8 "Jubilado" 9 "No le interesaba trabajar" 10 "Servicio miliar" 11 "Otro"
label values reason_inactivity reason_inactivity
tab reason_inactivity, gen(reason_inactivity)

gen time=mdate
order time,after(mdate)
replace time = time +721
keep folio_n20 time sex act_econ_1digit hours_worked earnings_net mdate_beginning mdate_end age occ_class_paper occ_transition schooling* reason_endjob reason_inactivity
bys folio_n20 occ_transition: egen time_start = min(time)
bys folio_n20 occ_transition: egen time_end = max(time)
duplicates drop folio_n20 occ_transition, force
drop if occ_transition==.

drop mdate_beginning mdate_end
drop time
by folio_n20: egen gender = max(sex)
replace sex = gender
drop if sex==.
drop gender occ_transition
drop if age==.
drop if age<15
drop if age>65
sort folio_n20 time_start
bys folio_n20: gen ligne=_n
recode hours_worked -4=. 888=.
recode earnings_net 0=.
g hourlyincome = earnings_net / (hours_worked*52/12) if earnings_net!=. & hours_worked!=.

* Reshape wide
reshape wide act_econ_1digit hours_worked earnings_net hourlyincome age occ_class_paper time_start time_end reason_endjob reason_inactivity schooling, i(folio_n20) j(ligne)
order folio_n20 sex

forvalues i=1/88 {
gen cat`i' =occ_class_paper`i'
label values cat`i' occ_class_paper
drop occ_class_paper`i'
rename time_start`i' cat`i'_start
rename time_end`i' cat`i'_end
}

order folio_n20 sex cat*

cd "$datadir"
save analysis_transitions_2_digits_isco88_Mihaylov_Tijdens, replace

* ---------------------------------------------------------------------------- *
* End of General Data Setup do-file
* ---------------------------------------------------------------------------- *
