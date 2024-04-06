/********************************************************************************
This file prepares the data to construct the transition rates using the 
Encuesta de Proteccion Social of Chile

These transitions will serve to feed the Multilevel Multistate Event History Models
and our adaptation of the flows approach of Cortes et. al. (2020)
 
We use the following rounds: 2002, 2004, 2006, 2009 and 2015


*********************************************************************************/

/********************************************************************************
First step, we start by cleaning the databases

*******************************************************************************/

clear all
set more off
global data_raw "C:\Users\wp62\OneDrive - University of Kent\Desktop\PHD thesis chapter 3 - Paper Chile\Raw_data_EPS" // Change accordingly 
global data_clean "C:\Users\wp62\OneDrive - University of Kent\Desktop\PHD thesis chapter 3 - Paper Chile\Cleaned_data_EPS" // Change accordingly 
global isco_2_digits "C:\Users\wp62\OneDrive - University of Kent\Desktop\PHD thesis chapter 3 - Paper Chile\ISCO_class_04"

*********************************************************************************/

/************************************    Round     2002     *********************/ 
clear all 
use "$data_raw\2002\base7", replace 

sort folio_n20 orden 

*** Variables to use: 
** viip1am mes de inicio
** viip1aa anio de inicio
** viip1cm mes de finalizacion
** viip1da anio de finalizacion
** viip2 en esa fecha en que situacion se encontraba (buscar trabajando ==3)
** Occupation viip4 - dos digitos
** viip5 Su trabajo principal es: permamnente, temporal, fijo, por tarea o servicio, otra especifique
** viip7 - actividad economica de la empresa - 2 digitos
** viip8 En su ocupación principal, usted trabaja (trabajaba) como
** viip10 En su trabajo principal ¿Ha (Había) firmado contrato de trabajo?
** viip12 ¿Cuántas horas semanales trabaja (trabajaba) en su trabajo principal? 
** viip21 - ¿Se encuentra (encontraba) cotizando en algún sistema previsional?
** The information for this panel is from 1980 to 2002

*- 
*** Recoding and renaming variables 

g month_beginning_work=viip1am  
g year_beginning_work=viip1aa 
g month_end_work=viip1cm  
g year_end_work=viip1da

recode year_beginning_work year_end_work (9999=.)
recode month_beginning_work month_end_work (99=.)

g work_situation=1 if viip2==1 | viip2==2 //unemployment 
replace work_situation=2 if viip2==3 // active 
replace work_situation=3 if viip2==4  // inactive 

g occ_1digit=0 if viip4==0 & work_situation==2
replace occ_1digit=1 if (viip4>=10 & viip4<=19) & work_situation==2
replace occ_1digit=2 if (viip4>=20 & viip4<=29) & work_situation==2 
replace occ_1digit=3 if (viip4>=30 & viip4<=39) & work_situation==2
replace occ_1digit=4 if (viip4>=40 & viip4<=49) & work_situation==2
replace occ_1digit=5 if (viip4>=50 & viip4<=59) & work_situation==2
replace occ_1digit=6 if (viip4>=60 & viip4<=69) & work_situation==2
replace occ_1digit=7 if (viip4>=70 & viip4<=79) & work_situation==2
replace occ_1digit=8 if (viip4>=80 & viip4<=89) & work_situation==2
replace occ_1digit=9 if (viip4>=90 & viip4<=99) & work_situation==2

g occ_2digit=viip4

g permanent_job=1 if viip5==1 & work_situation==2 // permanent 
replace permanent_job=2 if (viip5==2 | viip5==3 | viip5==4) & work_situation==2 //not permanent 

g act_econ_1digit=0 if viip7==0 & work_situation==2
replace act_econ_1digit=1 if (viip7>=10 & viip7<=19) & work_situation==2
replace act_econ_1digit=2 if (viip7>=20 & viip7<=29) & work_situation==2 
replace act_econ_1digit=3 if (viip7>=30 & viip7<=39) & work_situation==2
replace act_econ_1digit=4 if (viip7>=40 & viip7<=49) & work_situation==2
replace act_econ_1digit=5 if (viip7>=50 & viip7<=59) & work_situation==2
replace act_econ_1digit=6 if (viip7>=60 & viip7<=69) & work_situation==2
replace act_econ_1digit=7 if (viip7>=70 & viip7<=79) & work_situation==2
replace act_econ_1digit=8 if (viip7>=80 & viip7<=89) & work_situation==2
replace act_econ_1digit=9 if (viip7>=90 & viip7<=99) & work_situation==2

g categ_occ=1 if (viip8==1 | viip8==2) & work_situation==2 // self employed
replace categ_occ=2 if (viip8==3 | viip8==4 | viip8==5 | viip8==6) & work_situation==2 // employees

g job_contract=1 if (viip10==1 | viip10==2 | viip10==3) & work_situation==2  //contract signed
replace job_contract=2 if (viip10==4 | viip10==5) & work_situation==2 //not contract signed

g hours_worked=viip12 if work_situation==2
recode hours_worked (999=.)

g earnings_net=. // Not included in this round, but available in the others

g contributing=1 if (viip21>=1 & viip21<=6) & work_situation==2 // yes contributing
replace contributing=2 if (viip21==7 | viip21==8) & work_situation==2 // no contributing

g reason_endjob = viip16 // reason for end of contract
g reason_inactivity = viip19 // reason for inactivity

keep folio_n20 orden month_beginning_work year_beginning_work month_end_work year_end_work work_situation occ_1digit occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing reason_endjob reason_inactivity

g round_year=2002

tempfile temp_2002
save `temp_2002'
use "$data_raw\2002\base2", replace 
keep if ip2==1
ren factor weight
recode ip5 (999=.)
keep folio_n20 ip4 ip5 ip9t weight 
merge 1:m folio_n20  using `temp_2002'

keep if _merge==3
drop _merge 

ren ip4 sex 
ren ip5 age  
ren ip9t schooling_02
ren orden order_transition
sort folio_n order_transition 

save "$data_clean\transitions_file_2002", replace


/************************************    Round     2004     *********************/

*** Preparing own 2 isco classification
clear all
import excel using "$isco_2_digits\ISCO_class_2004.xlsx", sheet("Final classification") firstrow clear
tempfile temp_ISCO_class_2004
save `temp_ISCO_class_2004'

use "$data_raw\2004\h_laboral", replace 

merge 1:1 folio_n20 orden using `temp_ISCO_class_2004'

*** Variables to use: 
** b1im mes de inicio
** b1ia anio de inicio
** b1tm mes de finalizacion
** b1ta anio de finalizacion
** b2 en esa fecha en que situacion se encontraba (buscar trabajando==1)
** g_oficio occupation - 1 digito
** b5 Su trabajo principal es: permamnente, temporal, fijo, por tarea o servicio, otra especifique
** g_activ - actividad economica de la empresa - 1 digito
** b7 - En su ocupación principal, usted trabaja (trabajaba) como
** b8 - En su trabajo principal ¿Ha (Había) firmado contrato de trabajo?
** b12 - ¿Cuántas horas semanales trabajaba en este trabajo?
** b11 - Incluyendo descuentos, ¿cuál era el ingreso líquido mensual promedio en este trabajo?
** b17 -¿Se encuentra (encontraba) cotizando en algún sistema previsional?
** b21 reason end of job
** b24 reason inactivity

*** The information for this panel is from 1980 to 2004
*- 
*** Recoding and renaming variables 

g month_beginning_work=b1im 
g year_beginning_work=b1ia 
g month_end_work=b1tm  
g year_end_work=b1ta

recode year_beginning_work year_end_work (9999=.)
recode month_beginning_work month_end_work (99=.)

g work_situation=1 if b2==-4 | b2==2 | b2==3 //unemployment 
replace work_situation=2 if b2==1 // active 
replace work_situation=3 if b2==4  // inactive 

g occ_1digit=0 if (g_oficio==10 | g_oficio==99) & work_situation==2
replace occ_1digit=1 if g_oficio==1 & work_situation==2
replace occ_1digit=2 if g_oficio==2 & work_situation==2
replace occ_1digit=3 if g_oficio==3 & work_situation==2
replace occ_1digit=4 if g_oficio==4 & work_situation==2
replace occ_1digit=5 if g_oficio==5 & work_situation==2
replace occ_1digit=6 if g_oficio==6 & work_situation==2
replace occ_1digit=7 if g_oficio==7 & work_situation==2
replace occ_1digit=8 if g_oficio==8 & work_situation==2
replace occ_1digit=9 if g_oficio==9 & work_situation==2

destring occ_2digit, force replace 

g permanent_job=1 if b5==1 & work_situation==2  // permanent 
replace permanent_job=2 if (b5==2 | b5==3 | b5==4 | b5==5) & work_situation==2  //not permanent

g act_econ_1digit=0 if g_activ==10 & work_situation==2
replace act_econ_1digit=1 if g_activ==1 & work_situation==2
replace act_econ_1digit=2 if g_activ==2 & work_situation==2
replace act_econ_1digit=3 if g_activ==3 & work_situation==2
replace act_econ_1digit=4 if g_activ==4 & work_situation==2
replace act_econ_1digit=5 if g_activ==5 & work_situation==2
replace act_econ_1digit=6 if g_activ==6 & work_situation==2
replace act_econ_1digit=7 if g_activ==7 & work_situation==2
replace act_econ_1digit=8 if g_activ==8 & work_situation==2
replace act_econ_1digit=9 if g_activ==9 & work_situation==2

g categ_occ=1 if (b7==1 | b7==2) & work_situation==2 // self employed
replace categ_occ=2 if (b7==3 | b7==4 | b7==5 | b7==6) & work_situation==2 // employees

g job_contract=1 if b8==1  & work_situation==2 //contract signed
replace job_contract=2 if (b8==-4 | b8==2 | b8==3) & work_situation==2 //not contract signed

g hours_worked=b12
recode hours_worked (999=.)
replace hours_worked=. if hours_worked<0

g earnings_net=b11 if work_situation==2
replace earnings_net=. if earnings_net<0

g contributing=1 if (b17>=1 & b17<=6) & work_situation==2 // yes contributing
replace contributing=2 if (b17==7 | b17==9) & work_situation==2 // no contributing

g reason_endjob=b21
g reason_inactivity=b24

keep folio_n20 orden month_beginning_work year_beginning_work month_end_work year_end_work work_situation occ_1digit occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing reason_endjob reason_inactivity

g round_year=2004

tempfile temp_2004
save `temp_2004'

use "$data_raw\2004\entrevistado", replace 
*keep if ip2==1
ren fact_exp weight
keep folio_n20 a5 a6 a10n weight
merge 1:m folio_n20  using `temp_2004'

keep if _merge==3
drop _merge 

ren a5 sex 
ren a6 age 
ren a10n schooling_04
ren orden order_transition
sort folio_n order_transition 

save "$data_clean\transitions_file_2004", replace 

/************************************    Round     2006     *********************/

clear all 
use "$data_raw\2006\historialaboral", replace 

*** Variables to use 
** b1im mes de inicio
** b1ia anio de inicio
** b1tm mes de finalizacion
** b1ta anio de finalizacion
** b2 en esa fecha en que situacion se encontraba (buscar trabajando==1)
** oficio occupation - 1 digito
** b6 Su trabajo principal es: permamnente, temporal, fijo, por tarea o servicio, otra especifique
** actividad - actividad economica de la empresa - 1 digito
** b8 - En su ocupación principal, usted trabaja (trabajaba) como
** b9 - En su trabajo principal ¿Ha (Había) firmado contrato de trabajo?
** b13 - ¿Cuántas horas semanales trabaja (trabajaba) en su trabajo principal? 
** b12 - ingreso mensual promedio, inluyendo descuentos 
** b18 -¿Se encuentra (encontraba) cotizando en algún sistema previsional?
** b22 Reason end of job
** b25 Reason inactivity

*- 
*** Recoding and renaming variables 

g month_beginning_work=b1im 
g year_beginning_work=b1ia 
g month_end_work=b1tm  
g year_end_work=b1ta

recode year_beginning_work year_end_work (9999=.)
recode month_beginning_work month_end_work (99=.)

g work_situation=1 if b2==2 | b2==3 //unemployment 
replace work_situation=2 if b2==1 // active 
replace work_situation=3 if b2==4  // inactive 

g occ_1digit=0 if (oficio==10 | oficio==99) & work_situation==2
replace occ_1digit=1 if oficio==1 & work_situation==2
replace occ_1digit=2 if oficio==2 & work_situation==2
replace occ_1digit=3 if oficio==3 & work_situation==2
replace occ_1digit=4 if oficio==4 & work_situation==2
replace occ_1digit=5 if oficio==5 & work_situation==2
replace occ_1digit=6 if oficio==6 & work_situation==2
replace occ_1digit=7 if oficio==7 & work_situation==2
replace occ_1digit=8 if oficio==8 & work_situation==2
replace occ_1digit=9 if oficio==9 & work_situation==2

g occ_2digit=.

g permanent_job=1 if b6==1 & work_situation==2 // permanent 
replace permanent_job=2 if (b6==2 | b6==3 | b6==4 | b6==5) & work_situation==2  //not permanent

g act_econ_1digit=0 if activ==0 & work_situation==2 
replace act_econ_1digit=1 if activ==1 & work_situation==2
replace act_econ_1digit=2 if activ==2 & work_situation==2
replace act_econ_1digit=3 if activ==3 & work_situation==2
replace act_econ_1digit=4 if activ==4 & work_situation==2
replace act_econ_1digit=5 if activ==5 & work_situation==2
replace act_econ_1digit=6 if activ==6 & work_situation==2
replace act_econ_1digit=7 if activ==7 & work_situation==2
replace act_econ_1digit=8 if activ==8 & work_situation==2
replace act_econ_1digit=9 if activ==9 & work_situation==2

g categ_occ=1 if (b8==1 | b8==2) & work_situation==2 // self employed
replace categ_occ=2 if (b8==3 | b8==4 | b8==5 | b8==6) & work_situation==2 // employees

g job_contract=1 if b9==1 & work_situation==2  //contract signed
replace job_contract=2 if (b9==2 | b9==3 | b9==9) & work_situation==2 //not contract signed

g hours_worked=b13 if work_situation==2
recode hours_worked (999=.)

g earnings_net=b12 if work_situation==2
replace earnings_net=. if earnings_net<0

g contributing=1 if (b18>=1 & b18<=6) & work_situation==2 // yes contributing
replace contributing=2 if (b18==7 | b18==9) & work_situation==2 // no contributing

g reason_endjob=b22
g reason_inactivity=b25

keep folio_n20 orden month_beginning_work year_beginning_work month_end_work year_end_work work_situation occ_1digit occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing reason_endjob reason_inactivity

g round_year=2006

tempfile temp_2006
save `temp_2006'

use "$data_raw\2006\entrevistado", replace 
*keep if ip2==1
ren factor_EPS06 weight
keep folio_n20 a8 a9 a12n weight
merge 1:m folio_n20  using `temp_2006'

keep if _merge==3
drop _merge 

ren a8 sex 
ren a9 age 
ren a12n schooling_06
ren orden order_transition
sort folio_n order_transition 

save "$data_clean\transitions_file_2006", replace 

/************************************    Round     2009     *********************/

clear all 
use "$data_raw\2009\hlaboral", replace 

*** Variables to use 
** b1im mes de inicio
** b1ia anio de inicio
** b1tm mes de finalizacion
** b1ta anio de finalizacion
** b2 en esa fecha en que situacion se encontraba (buscar trabajando==1)
** oficio - 4 digitos 
** b6 Su trabajo principal es: permamnente, temporal, fijo, por tarea o servicio, otra especifique
** actividad - actividad economica de la empresa - 4 digitos
** b8 - En su ocupación principal, usted trabaja (trabajaba) como
** b9 - En su trabajo principal ¿Ha (Había) firmado contrato de trabajo?
** b9b -La relación contractual de este trabajo es / era del tipo
** b13 - ¿Cuántas horas semanales trabaja (trabajaba) en su trabajo principal? 
** b12 - ingreso mensual promedio, inluyendo descuentos 
** b18 -¿Se encuentra (encontraba) cotizando en algún sistema previsional?
** b22 reason for end of job
** b25 reason for inactivity

*- 
*** Recoding and renaming variables 

g month_beginning_work=b1im 
g year_beginning_work=b1ia 
g month_end_work=b1tm  
g year_end_work=b1ta

recode year_beginning_work year_end_work (9999=.)
recode month_beginning_work month_end_work (99=.)

g work_situation=1 if b2==2 | b2==3 //unemployment 
replace work_situation=2 if b2==1 // active 
replace work_situation=3 if b2==4  // inactive 

tostring oficio, force replace
g occ_2digit = substr(oficio, 1, 2)

destring occ_2digit, force replace 
destring oficio, force replace 

g occ_1digit=0 if oficio==9999 & work_situation==2
replace occ_1digit=1 if (oficio>=1000 & oficio<=1999) & work_situation==2
replace occ_1digit=2 if (oficio>=2000 & oficio<=2999) & work_situation==2
replace occ_1digit=3 if (oficio>=3000 & oficio<=3999) & work_situation==2
replace occ_1digit=4 if (oficio>=4000 & oficio<=4999) & work_situation==2
replace occ_1digit=5 if (oficio>=5000 & oficio<=5999) & work_situation==2
replace occ_1digit=6 if (oficio>=6000 & oficio<=6999) & work_situation==2
replace occ_1digit=7 if (oficio>=7000 & oficio<=7999) & work_situation==2
replace occ_1digit=8 if (oficio>=8000 & oficio<=8999) & work_situation==2
replace occ_1digit=9 if (oficio>=9000 & oficio<=9998) & work_situation==2

g permanent_job=1 if b6==1 & work_situation==2 // permanent 
replace permanent_job=2 if (b6==2 | b6==3 | b6==4 | b6==5) & work_situation==2  //not permanent

g act_econ_1digit=0 if activ==0 & work_situation==2
replace act_econ_1digit=1 if (activ>=1000 & activ<=1999) & work_situation==2
replace act_econ_1digit=2 if (activ>=2000 & activ<=2999) & work_situation==2
replace act_econ_1digit=3 if (activ>=3000 & activ<=3999) & work_situation==2
replace act_econ_1digit=4 if (activ>=4000 & activ<=4999) & work_situation==2
replace act_econ_1digit=5 if (activ>=5000 & activ<=5999) & work_situation==2
replace act_econ_1digit=6 if (activ>=6000 & activ<=6999) & work_situation==2
replace act_econ_1digit=7 if (activ>=7000 & activ<=7999) & work_situation==2
replace act_econ_1digit=8 if (activ>=8000 & activ<=8999) & work_situation==2
replace act_econ_1digit=9 if (activ>=9000 & activ<=9999) & work_situation==2

g categ_occ=1 if (b8==1 | b8==2) & work_situation==2 // self employed
replace categ_occ=2 if (b8==3 | b8==4 | b8==5 | b8==6) & work_situation==2 // employees

g job_contract=1 if b9==1  & work_situation==2 //contract signed
replace job_contract=2 if (b9==2 | b9==3 | b9==8 | b9==9) & work_situation==2 //not contract signed

g hours_worked=b13 if work_situation==2
recode hours_worked (888=.)
recode hours_worked (999=.)

g earnings_net=b12 if work_situation==2
replace earnings_net=. if earnings_net<0

g contributing=1 if (b18>=1 & b18<=6) & work_situation==2 // yes contributing
replace contributing=2 if (b18==7 | b18==8 | b18==9) & work_situation==2 // no contributing

g reason_endjob=b22
g reason_inactivity=b25

keep folio_n20 orden month_beginning_work year_beginning_work month_end_work year_end_work work_situation occ_1digit occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing reason_endjob reason_inactivity

g round_year=2009

tempfile temp_2009
save `temp_2009'

use "$data_raw\2009\entrevistado", replace 
merge m:1 folio_n20 using "$data_raw\Factores de Expansion EPS\factor_EPS2009"
*keep if ip2==1
ren factor_EPS2009 weight
keep folio_n20 a8 a9 a12n weight
merge 1:m folio_n20  using `temp_2009'

keep if _merge==3
drop _merge 

ren a8 sex 
ren a9 age 
ren a12n schooling_09
ren orden order_transition
sort folio_n order_transition 

save "$data_clean\transitions_file_2009", replace 

/************************************    Round     2012     *********************/

clear all 
use "$data_raw\2012\hlaboral", replace 

*** Variables to use: 
** b1im mes de inicio
** b1ia anio de inicio
** b1tm mes de finalizacion
** b1ta anio de finalizacion
** b2 en esa fecha en que situacion se encontraba (buscar trabajando==1)
** b5_cod - occupations 4 digitos 
** b6 Su trabajo principal es: permamnente, temporal, fijo, por tarea o servicio, otra especifique
** b9d_cod - actividad economica de la empresa - 4 digitos
** b8 - En su ocupación principal, usted trabaja (trabajaba) como
** b9a -firmo contrato de trabajo
** b9b -La relación contractual de este trabajo es / era del tipo
** b13 - ¿Cuántas horas semanales trabaja (trabajaba) en su trabajo principal? 
** b12m - ingreso liquido mensual 
** b18 -¿Se encuentra (encontraba) cotizando en algún sistema previsional?
** b22 reason end of job
** b25 reason inactivity

*- 
*** Renaming variables 

g month_beginning_work=b1im 
g year_beginning_work=b1ia 
g month_end_work=b1tm  
g year_end_work=b1ta

recode year_beginning_work year_end_work (9999=.)
recode month_beginning_work month_end_work (99=.)

g work_situation=1 if b2==2 | b2==3 //unemployment 
replace work_situation=2 if b2==1 // active 
replace work_situation=3 if b2==4  // inactive 

tostring b5_cod, force replace
g occ_2digit = substr(b5_cod, 1, 2)

destring occ_2digit, force replace 
destring b5_cod, force replace 

g occ_1digit=0 if b5_cod==9999 & work_situation==2
replace occ_1digit=1 if (b5_cod>=1000 & b5_cod<=1999) & work_situation==2
replace occ_1digit=2 if (b5_cod>=2000 & b5_cod<=2999) & work_situation==2
replace occ_1digit=3 if (b5_cod>=3000 & b5_cod<=3999) & work_situation==2
replace occ_1digit=4 if (b5_cod>=4000 & b5_cod<=4999) & work_situation==2
replace occ_1digit=5 if (b5_cod>=5000 & b5_cod<=5999) & work_situation==2
replace occ_1digit=6 if (b5_cod>=6000 & b5_cod<=6999) & work_situation==2
replace occ_1digit=7 if (b5_cod>=7000 & b5_cod<=7999) & work_situation==2
replace occ_1digit=8 if (b5_cod>=8000 & b5_cod<=8999) & work_situation==2
replace occ_1digit=9 if (b5_cod>=9000 & b5_cod<=9998) & work_situation==2

g permanent_job=1 if b6==1 & work_situation==2 // permanent 
replace permanent_job=2 if (b6==2 | b6==3 | b6==4 | b6==5) & work_situation==2  //not permanent

g act_econ_1digit=0 if b9d_cod==0 & work_situation==2
replace act_econ_1digit=1 if (b9d_cod>=1000 & b9d_cod<=1999) & work_situation==2
replace act_econ_1digit=2 if (b9d_cod>=2000 & b9d_cod<=2999) & work_situation==2
replace act_econ_1digit=3 if (b9d_cod>=3000 & b9d_cod<=3999) & work_situation==2
replace act_econ_1digit=4 if (b9d_cod>=4000 & b9d_cod<=4999) & work_situation==2
replace act_econ_1digit=5 if (b9d_cod>=5000 & b9d_cod<=5999) & work_situation==2
replace act_econ_1digit=6 if (b9d_cod>=6000 & b9d_cod<=6999) & work_situation==2
replace act_econ_1digit=7 if (b9d_cod>=7000 & b9d_cod<=7999) & work_situation==2
replace act_econ_1digit=8 if (b9d_cod>=8000 & b9d_cod<=8999) & work_situation==2
replace act_econ_1digit=9 if (b9d_cod>=9000 & b9d_cod<=9999) & work_situation==2

g categ_occ=1 if (b8==1 | b8==2) & work_situation==2 // self employed
replace categ_occ=2 if (b8==3 | b8==4 | b8==5 | b8==6) & work_situation==2 // employees

g job_contract=1 if b9a==1  & work_situation==2 //contract signed
replace job_contract=2 if (b9a==2 | b9a==3 | b9a==8 | b9a==9) & work_situation==2 //not contract signed

g hours_worked=b13 if work_situation==2
recode hours_worked (999=.)

g earnings_net=b12m if work_situation==2
replace earnings_net=. if earnings_net<0

g contributing=1 if (b18>=1 & b18<=6) & work_situation==2 // yes contributing
replace contributing=2 if (b18==7 | b18==8 | b18==9) & work_situation==2 // no contributing

g reason_endjob=b22
g reason_inactivity=b25

keep folio_n20 orden month_beginning_work year_beginning_work month_end_work year_end_work work_situation occ_1digit occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing reason_endjob reason_inactivity

g round_year=2012

tempfile temp_2012
save `temp_2012'

use "$data_raw\2012\entrevistado", replace 
merge m:1 folio_n20 using "$data_raw\Factores de Expansion EPS\factor_EPS2012"
*keep if ip2==1
ren factor_EPS2012 weight
keep folio_n20 a8 a9 a12n weight
merge 1:m folio_n20  using `temp_2012'

keep if _merge==3
drop _merge 

ren a8 sex 
ren a9 age 
ren a12n schooling_12
ren orden order_transition
sort folio_n order_transition 

save "$data_clean\transitions_file_2012", replace 

/************************************    Round     2015     *********************/

clear all 
use "$data_raw\2015\MODULOB_historia_laboral", replace 

*** Variables to use 
** b1im mes de inicio
** b1ia anio de inicio
** b1tm mes de finalizacion
** b1ta anio de finalizacion
** b2 en esa fecha en que situacion se encontraba (buscar trabajando==1)
** b5_cod - occupations 4 digitos 
** b6 Su trabajo principal es: permamnente, temporal, fijo, por tarea o servicio, otra especifique
** b9d_cod - actividad economica de la empresa - 4 digitos
** b8 - En su ocupación principal, usted trabaja (trabajaba) como
** b9a -firmo contrato de trabajo
** b13 - ¿Cuántas horas semanales trabaja (trabajaba) en su trabajo principal? 
** b12 - ingreso liquido mensual 
** b18 -¿Se encuentra (encontraba) cotizando en algún sistema previsional?
** b22 reason for end of job

*- 
*** Renaming variables 

g month_beginning_work=b1im 
g year_beginning_work=b1ia 
g month_end_work=b1tm  
g year_end_work=b1ta

recode year_beginning_work year_end_work (9999=.)
recode month_beginning_work month_end_work (99=.)

g work_situation=1 if b2==2 | b2==3 //unemployment 
replace work_situation=2 if b2==1 // active 
replace work_situation=3 if b2==4  // inactive 

tostring b5_cod, force replace
g occ_2digit = substr(b5_cod, 1, 2)

destring occ_2digit, force replace 
destring b5_cod, force replace 

g occ_1digit=0 if b5_cod==9999 & work_situation==2
replace occ_1digit=1 if (b5_cod>=1000 & b5_cod<=1999) & work_situation==2
replace occ_1digit=2 if (b5_cod>=2000 & b5_cod<=2999) & work_situation==2
replace occ_1digit=3 if (b5_cod>=3000 & b5_cod<=3999) & work_situation==2
replace occ_1digit=4 if (b5_cod>=4000 & b5_cod<=4999) & work_situation==2
replace occ_1digit=5 if (b5_cod>=5000 & b5_cod<=5999) & work_situation==2
replace occ_1digit=6 if (b5_cod>=6000 & b5_cod<=6999) & work_situation==2
replace occ_1digit=7 if (b5_cod>=7000 & b5_cod<=7999) & work_situation==2
replace occ_1digit=8 if (b5_cod>=8000 & b5_cod<=8999) & work_situation==2
replace occ_1digit=9 if (b5_cod>=9000 & b5_cod<=9998) & work_situation==2

g permanent_job=1 if b6==1 & work_situation==2 // permanent 
replace permanent_job=2 if (b6==2 | b6==3 | b6==4 | b6==5 | b6==8 | b6==9) & work_situation==2 //not permanent

g act_econ_1digit=0 if b9d_cod==0 & work_situation==2
replace act_econ_1digit=1 if (b9d_cod>=1000 & b9d_cod<=1999) & work_situation==2
replace act_econ_1digit=2 if (b9d_cod>=2000 & b9d_cod<=2999) & work_situation==2
replace act_econ_1digit=3 if (b9d_cod>=3000 & b9d_cod<=3999) & work_situation==2
replace act_econ_1digit=4 if (b9d_cod>=4000 & b9d_cod<=4999) & work_situation==2
replace act_econ_1digit=5 if (b9d_cod>=5000 & b9d_cod<=5999) & work_situation==2
replace act_econ_1digit=6 if (b9d_cod>=6000 & b9d_cod<=6999) & work_situation==2
replace act_econ_1digit=7 if (b9d_cod>=7000 & b9d_cod<=7999) & work_situation==2
replace act_econ_1digit=8 if (b9d_cod>=8000 & b9d_cod<=8999) & work_situation==2
replace act_econ_1digit=9 if (b9d_cod>=9000 & b9d_cod<=9999) & work_situation==2

g categ_occ=1 if (b8==1 | b8==2) & work_situation==2 // self employed
replace categ_occ=2 if (b8==3 | b8==4 | b8==5 | b8==6) & work_situation==2 // employees

g job_contract=1 if b9a==1  & work_situation==2 //contract signed
replace job_contract=2 if (b9a==2 | b9a==3 | b9a==8 | b9a==9) & work_situation==2 //not contract signed

g hours_worked=b13 if work_situation==2
recode hours_worked (888=.)
recode hours_worked (999=.)

g earnings_net=b12 if work_situation==2
replace earnings_net=. if earnings_net<0

g contributing=1 if (b18>=1 & b18<=6) & work_situation==2 // yes contributing
replace contributing=2 if (b18==7 | b18==8 | b18==9) & work_situation==2 // no contributing

g reason_endjob=b22

keep folio_n20 orden month_beginning_work year_beginning_work month_end_work year_end_work work_situation occ_1digit occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing reason_endjob 

g round_year=2015

tempfile temp_2015
save `temp_2015'

use "$data_raw\2015\MODULOA_entrevistado", replace 
merge m:1 folio_n20 using "$data_raw\Factores de Expansion EPS\factor_EPS2015"
*keep if ip2==1
ren factor_EPS2015 weight
keep folio_n20 a8 a9 a12n weight
merge 1:m folio_n20  using `temp_2015'

keep if _merge==3
drop _merge 

ren a8 sex 
ren a9 age 
ren a12n schooling_15
ren orden order_transition
sort folio_n order_transition 

save "$data_clean\transitions_file_2015", replace 

/*******************************************************************************
Second step: Appending all databases 

*******************************************************************************/

use "$data_clean\transitions_file_2002", replace
app using "$data_clean\transitions_file_2004"
app using "$data_clean\transitions_file_2006"
app using "$data_clean\transitions_file_2009"
*** Database 2012 has survey design problems, that is why we took the decision to exclude it from
*** our exercise 
*app using "$data_clean\transitions_file_2012"
app using "$data_clean\transitions_file_2015"

sort folio_n20 round_year

* To identify those observations with missing values in 2006 in isco 2 digits but not in isco 1 digit

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)
sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

g test_check =test_1

* 1-  In round_year==2004 and round_year==2009 I observe the same two digits and in round_year==2006 I observe the 1 digit that corresponds to the 2 digits. In this
* case we assume the same two digits observed for the previous and next round, in addition in 2006 I observe the same sector of economic activity as in 2004 and 2009

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

g occ_pivote_1=occ_2digit if round_year==2004 & round_year[_n+1]==2006 & test_1==1
egen occ_pivote_2=max(occ_pivote_1), by(folio_n20)
g occ_pivote_3=occ_2digit if round_year==2009 & round_year[_n-1]==2006 & test_1==1
egen occ_pivote_4=max(occ_pivote_3), by(folio_n20)

gen str_digit_1_2004 = string(occ_pivote_2, "%10.0g")  
gen digit_1_2004 = real(substr(str_digit_1_2004, 1, 1))  

gen str_digit_1_2009 = string(occ_pivote_4, "%10.0g")  
gen digit_1_2009 = real(substr(str_digit_1_2009, 1, 1))  

g sec_pivote_1=act_econ_1digit if round_year==2004 & round_year[_n+1]==2006 & test_1==1
egen sec_pivote_2=max(sec_pivote_1), by(folio_n20)
g sec_pivote_3=act_econ_1digit if round_year==2009 & round_year[_n-1]==2006 & test_1==1
egen sec_pivote_4=max(sec_pivote_3), by(folio_n20)

replace occ_2digit=occ_pivote_2 if (test_1==1 & round_year==2006) & occ_pivote_2==occ_pivote_4 & (occ_pivote_2!=. & occ_pivote_4!=.) & digit_1_2004==occ_1digit & digit_1_2009==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_2 & act_econ_1digit==sec_pivote_4

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

drop occ_pivote_1 occ_pivote_2 occ_pivote_3 occ_pivote_4 str_digit_1_2004 digit_1_2004 str_digit_1_2009 digit_1_2009 sec_pivote_1 sec_pivote_2 sec_pivote_3 sec_pivote_4 test test_1

* 2-  In round_year==2004 I observe missing and round_year==2009 I observe the two digits and in round_year==2006 I observe the 1 digit that corresponds to the 2 digits in 2009. In this
* case we assume the same two digits observed in 2009, in addition in 2006 I observe the same sector of economic activity as in 2009

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

g occ_pivote_1=occ_2digit if round_year==2004 & round_year[_n+1]==2006 & test_1==1
egen occ_pivote_2=max(occ_pivote_1), by(folio_n20)
g occ_pivote_3=occ_2digit if round_year==2009 & round_year[_n-1]==2006 & test_1==1
egen occ_pivote_4=max(occ_pivote_3), by(folio_n20)

gen str_digit_1_2004 = string(occ_pivote_2, "%10.0g")  
gen digit_1_2004 = real(substr(str_digit_1_2004, 1, 1))  

gen str_digit_1_2009 = string(occ_pivote_4, "%10.0g")  
gen digit_1_2009 = real(substr(str_digit_1_2009, 1, 1))  

g sec_pivote_1=act_econ_1digit if round_year==2004 & round_year[_n+1]==2006 & test_1==1
egen sec_pivote_2=max(sec_pivote_1), by(folio_n20)
g sec_pivote_3=act_econ_1digit if round_year==2009 & round_year[_n-1]==2006 & test_1==1
egen sec_pivote_4=max(sec_pivote_3), by(folio_n20)

replace occ_2digit=occ_pivote_4 if (test_1==1 & round_year==2006) & occ_pivote_2==. & occ_pivote_4!=. & digit_1_2009==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_4

* This codes includes those observations where I have values in 2004 and 2009, but it searches for values in 2009 that match values in 2006
replace occ_2digit=occ_pivote_4 if (occ_2digit==. & round_year==2006) & occ_pivote_4!=. & digit_1_2009==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_4

* This codes is less strict than the previous one, as it does not require that the person works in the same economic sector
replace occ_2digit=occ_pivote_4 if (occ_2digit==. & round_year==2006) & occ_pivote_4!=. & digit_1_2009==occ_1digit

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

drop occ_pivote_1 occ_pivote_2 occ_pivote_3 occ_pivote_4 str_digit_1_2004 digit_1_2004 str_digit_1_2009 digit_1_2009 sec_pivote_1 sec_pivote_2 sec_pivote_3 sec_pivote_4 test test_1

* 3-  In round_year==2009 I observe missing and round_year==2004 I observe the two digits and in round_year==2006 I observe the 1 digit that corresponds to the 2 digits in 2004. In this
* case we assume the same two digits observed in 2004, in addition in 2006 I observe the same sector of economic activity as in 2004

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

g occ_pivote_1=occ_2digit if round_year==2004 & round_year[_n+1]==2006 & test_1==1
egen occ_pivote_2=max(occ_pivote_1), by(folio_n20)
g occ_pivote_3=occ_2digit if round_year==2009 & round_year[_n-1]==2006 & test_1==1
egen occ_pivote_4=max(occ_pivote_3), by(folio_n20)

gen str_digit_1_2004 = string(occ_pivote_2, "%10.0g")  
gen digit_1_2004 = real(substr(str_digit_1_2004, 1, 1))  

gen str_digit_1_2009 = string(occ_pivote_4, "%10.0g")  
gen digit_1_2009 = real(substr(str_digit_1_2009, 1, 1))  

g sec_pivote_1=act_econ_1digit if round_year==2004 & round_year[_n+1]==2006 & test_1==1
egen sec_pivote_2=max(sec_pivote_1), by(folio_n20)
g sec_pivote_3=act_econ_1digit if round_year==2009 & round_year[_n-1]==2006 & test_1==1
egen sec_pivote_4=max(sec_pivote_3), by(folio_n20)

replace occ_2digit=occ_pivote_2 if (test_1==1 & round_year==2006) & occ_pivote_4==. & occ_pivote_2!=. & digit_1_2004==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_2

* This codes includes those observations where I have values in 2004 and 2009, but it searches for values in 2004 that match values in 2006
replace occ_2digit=occ_pivote_2 if (occ_2digit==. & round_year==2006) & occ_pivote_2!=. & digit_1_2004==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_2

* This codes is less strict than the previous one, as it does not require that the person works in the same economic sector
replace occ_2digit=occ_pivote_2 if (occ_2digit==. & round_year==2006) & occ_pivote_2!=. & digit_1_2004==occ_1digit 

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

drop occ_pivote_1 occ_pivote_2 occ_pivote_3 occ_pivote_4 str_digit_1_2004 digit_1_2004 str_digit_1_2009 digit_1_2009 sec_pivote_1 sec_pivote_2 sec_pivote_3 sec_pivote_4 test test_1

* 4-  The same as round 2, but searching for values +2 and -2 to assign the occupations

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

g occ_pivote_1=occ_2digit if round_year==2004 & round_year[_n+2]==2006 & test_1==1
egen occ_pivote_2=max(occ_pivote_1), by(folio_n20)
g occ_pivote_3=occ_2digit if round_year==2009 & round_year[_n-2]==2006 & test_1==1
egen occ_pivote_4=max(occ_pivote_3), by(folio_n20)

gen str_digit_1_2004 = string(occ_pivote_2, "%10.0g")  
gen digit_1_2004 = real(substr(str_digit_1_2004, 1, 1))  

gen str_digit_1_2009 = string(occ_pivote_4, "%10.0g")  
gen digit_1_2009 = real(substr(str_digit_1_2009, 1, 1))  

g sec_pivote_1=act_econ_1digit if round_year==2004 & round_year[_n+2]==2006 & test_1==1
egen sec_pivote_2=max(sec_pivote_1), by(folio_n20)
g sec_pivote_3=act_econ_1digit if round_year==2009 & round_year[_n-2]==2006 & test_1==1
egen sec_pivote_4=max(sec_pivote_3), by(folio_n20)

replace occ_2digit=occ_pivote_4 if (test_1==1 & round_year==2006) & occ_pivote_2==. & occ_pivote_4!=. & digit_1_2009==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_4

* This codes includes those observations where I have values in 2004 and 2009, but it searches for values in 2009 that match values in 2006
replace occ_2digit=occ_pivote_4 if (occ_2digit==. & round_year==2006) & occ_pivote_4!=. & digit_1_2009==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_4

* This codes is less strict than the previous one, as it does not require that the person works in the same economic sector
replace occ_2digit=occ_pivote_4 if (occ_2digit==. & round_year==2006) & occ_pivote_4!=. & digit_1_2009==occ_1digit

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

drop occ_pivote_1 occ_pivote_2 occ_pivote_3 occ_pivote_4 str_digit_1_2004 digit_1_2004 str_digit_1_2009 digit_1_2009 sec_pivote_1 sec_pivote_2 sec_pivote_3 sec_pivote_4 test test_1

* 5-  The same as round 3, but searching for values +2 and -2 to assign the occupations

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

g occ_pivote_1=occ_2digit if round_year==2004 & round_year[_n+2]==2006 & test_1==1
egen occ_pivote_2=max(occ_pivote_1), by(folio_n20)
g occ_pivote_3=occ_2digit if round_year==2009 & round_year[_n-2]==2006 & test_1==1
egen occ_pivote_4=max(occ_pivote_3), by(folio_n20)

gen str_digit_1_2004 = string(occ_pivote_2, "%10.0g")  
gen digit_1_2004 = real(substr(str_digit_1_2004, 1, 1))  

gen str_digit_1_2009 = string(occ_pivote_4, "%10.0g")  
gen digit_1_2009 = real(substr(str_digit_1_2009, 1, 1))  

g sec_pivote_1=act_econ_1digit if round_year==2004 & round_year[_n+2]==2006 & test_1==1
egen sec_pivote_2=max(sec_pivote_1), by(folio_n20)
g sec_pivote_3=act_econ_1digit if round_year==2009 & round_year[_n-2]==2006 & test_1==1
egen sec_pivote_4=max(sec_pivote_3), by(folio_n20)

replace occ_2digit=occ_pivote_2 if (test_1==1 & round_year==2006) & occ_pivote_4==. & occ_pivote_2!=. & digit_1_2004==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_2

* This codes includes those observations where I have values in 2004 and 2009, but it searches for values in 2004 that match values in 2006
replace occ_2digit=occ_pivote_2 if (occ_2digit==. & round_year==2006) & occ_pivote_2!=. & digit_1_2004==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_2

* This codes is less strict than the previous one, as it does not require that the person works in the same economic sector
replace occ_2digit=occ_pivote_2 if (occ_2digit==. & round_year==2006) & occ_pivote_2!=. & digit_1_2004==occ_1digit 

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

drop occ_pivote_1 occ_pivote_2 occ_pivote_3 occ_pivote_4 str_digit_1_2004 digit_1_2004 str_digit_1_2009 digit_1_2009 sec_pivote_1 sec_pivote_2 sec_pivote_3 sec_pivote_4 test test_1

* 6-  The same as round 2, but searching for values +3 and -3 to assign the occupations

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

g occ_pivote_1=occ_2digit if round_year==2004 & round_year[_n+3]==2006 & test_1==1
egen occ_pivote_2=max(occ_pivote_1), by(folio_n20)
g occ_pivote_3=occ_2digit if round_year==2009 & round_year[_n-3]==2006 & test_1==1
egen occ_pivote_4=max(occ_pivote_3), by(folio_n20)

gen str_digit_1_2004 = string(occ_pivote_2, "%10.0g")  
gen digit_1_2004 = real(substr(str_digit_1_2004, 1, 1))  

gen str_digit_1_2009 = string(occ_pivote_4, "%10.0g")  
gen digit_1_2009 = real(substr(str_digit_1_2009, 1, 1))  

g sec_pivote_1=act_econ_1digit if round_year==2004 & round_year[_n+3]==2006 & test_1==1
egen sec_pivote_2=max(sec_pivote_1), by(folio_n20)
g sec_pivote_3=act_econ_1digit if round_year==2009 & round_year[_n-3]==2006 & test_1==1
egen sec_pivote_4=max(sec_pivote_3), by(folio_n20)

replace occ_2digit=occ_pivote_4 if (test_1==1 & round_year==2006) & occ_pivote_2==. & occ_pivote_4!=. & digit_1_2009==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_4

* This codes includes those observations where I have values in 2004 and 2009, but it searches for values in 2009 that match values in 2006
replace occ_2digit=occ_pivote_4 if (occ_2digit==. & round_year==2006) & occ_pivote_4!=. & digit_1_2009==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_4

* This codes is less strict than the previous one, as it does not require that the person works in the same economic sector
replace occ_2digit=occ_pivote_4 if (occ_2digit==. & round_year==2006) & occ_pivote_4!=. & digit_1_2009==occ_1digit

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

drop occ_pivote_1 occ_pivote_2 occ_pivote_3 occ_pivote_4 str_digit_1_2004 digit_1_2004 str_digit_1_2009 digit_1_2009 sec_pivote_1 sec_pivote_2 sec_pivote_3 sec_pivote_4 test test_1

* 7-  The same as round 3, but searching for values +3 and -3 to assign the occupations

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

g occ_pivote_1=occ_2digit if round_year==2004 & round_year[_n+3]==2006 & test_1==1
egen occ_pivote_2=max(occ_pivote_1), by(folio_n20)
g occ_pivote_3=occ_2digit if round_year==2009 & round_year[_n-3]==2006 & test_1==1
egen occ_pivote_4=max(occ_pivote_3), by(folio_n20)

gen str_digit_1_2004 = string(occ_pivote_2, "%10.0g")  
gen digit_1_2004 = real(substr(str_digit_1_2004, 1, 1))  

gen str_digit_1_2009 = string(occ_pivote_4, "%10.0g")  
gen digit_1_2009 = real(substr(str_digit_1_2009, 1, 1))  

g sec_pivote_1=act_econ_1digit if round_year==2004 & round_year[_n+3]==2006 & test_1==1
egen sec_pivote_2=max(sec_pivote_1), by(folio_n20)
g sec_pivote_3=act_econ_1digit if round_year==2009 & round_year[_n-3]==2006 & test_1==1
egen sec_pivote_4=max(sec_pivote_3), by(folio_n20)

replace occ_2digit=occ_pivote_2 if (test_1==1 & round_year==2006) & occ_pivote_4==. & occ_pivote_2!=. & digit_1_2004==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_2

* This codes includes those observations where I have values in 2004 and 2009, but it searches for values in 2004 that match values in 2006
replace occ_2digit=occ_pivote_2 if (occ_2digit==. & round_year==2006) & occ_pivote_2!=. & digit_1_2004==occ_1digit /*
*/ & act_econ_1digit==sec_pivote_2

* This codes is less strict than the previous one, as it does not require that the person works in the same economic sector
replace occ_2digit=occ_pivote_2 if (occ_2digit==. & round_year==2006) & occ_pivote_2!=. & digit_1_2004==occ_1digit 

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

drop occ_pivote_1 occ_pivote_2 occ_pivote_3 occ_pivote_4 str_digit_1_2004 digit_1_2004 str_digit_1_2009 digit_1_2009 sec_pivote_1 sec_pivote_2 sec_pivote_3 sec_pivote_4 test test_1

* 8-  In this search we are assuming that we can use the occupation history to assign the 2 digits isco to the 2006. Basically, we search in the occupation history
* a 1 digit status in previous and next rounds to round 2006 that matches the 2006 1 digit. If we find, we assume that the corresponding two digits can be assigned to the 
* 2006 round. In a first search we also require that we observe the same sector of economic activity, later we relax this assumption

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

g occ_pivote_1=occ_1digit if test==1
egen occ_pivote_2=max(occ_pivote_1), by(folio_n20)

g occ_pivote_3=occ_2digit if occ_pivote_2==occ_1digit
egen occ_pivote_4=min(occ_pivote_3), by(folio_n20)

g sec_pivote_1=act_econ_1digit if test==1
egen sec_pivote_2=max(sec_pivote_1), by(folio_n20)

g sec_pivote_3=act_econ_1digit if sec_pivote_2==act_econ_1digit
egen sec_pivote_4=min(sec_pivote_3), by(folio_n20)

replace occ_2digit=occ_pivote_4 if occ_2digit==. & round_year==2006 & occ_1digit!=. & sec_pivote_4==act_econ_1digit

replace occ_2digit=occ_pivote_4 if occ_2digit==. & round_year==2006 & occ_1digit!=.

count if missing( occ_2digit ) &  occ_1digit!=. & round_year==2006

drop occ_pivote_1 occ_pivote_2 occ_pivote_3 occ_pivote_4 sec_pivote_1 sec_pivote_2 sec_pivote_3 sec_pivote_4 test test_1

* 9- Using random forest to assign the rest of observations not assigned. To do this, we are going to run a random forest model for each 1 digit classification 

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

tab occ_1digit if test==1

g schooling=.
replace schooling=schooling_02 if schooling==.
replace schooling=schooling_04 if schooling==.
replace schooling=schooling_06 if schooling==.
replace schooling=schooling_09 if schooling==.
replace schooling=schooling_15 if schooling==.

**** Implementing Random Forest 
*ssc install rforest, replace

** Model to distribute isco 1 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==1 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==1 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_1 if round_year==2006 & occ_1digit==1 & occ_2digit==.

replace occ_2digit=11 if prediction_1==1
replace occ_2digit=12 if prediction_1==2
replace occ_2digit=13 if prediction_1==3

drop random train rf_predicted prediction_1
label drop trainset

** Model to distribute isco 2 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==2 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==2 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_2 if round_year==2006 & occ_1digit==2 & occ_2digit==.

replace occ_2digit=21 if prediction_2==4
replace occ_2digit=22 if prediction_2==5
replace occ_2digit=23 if prediction_2==6
replace occ_2digit=24 if prediction_2==7

drop random train rf_predicted prediction_2
label drop trainset

** Model to distribute isco 3 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==3 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==3 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_3 if round_year==2006 & occ_1digit==3 & occ_2digit==.

replace occ_2digit=31 if prediction_3==8
replace occ_2digit=32 if prediction_3==9
replace occ_2digit=33 if prediction_3==10
replace occ_2digit=34 if prediction_3==11

drop random train rf_predicted prediction_3
label drop trainset

** Model to distribute isco 4 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==4 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==4 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_4 if round_year==2006 & occ_1digit==4 & occ_2digit==.

replace occ_2digit=41 if prediction_4==12
replace occ_2digit=42 if prediction_4==13

drop random train rf_predicted prediction_4
label drop trainset

** Model to distribute isco 5 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==5 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==5 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_5 if round_year==2006 & occ_1digit==5 & occ_2digit==.

replace occ_2digit=51 if prediction_5==15
replace occ_2digit=52 if prediction_5==16

drop random train rf_predicted prediction_5
label drop trainset

** Model to distribute isco 6 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==6 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==6 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_6 if round_year==2006 & occ_1digit==6 & occ_2digit==.

replace occ_2digit=61 if prediction_6==17
replace occ_2digit=62 if prediction_6==18

drop random train rf_predicted prediction_6
label drop trainset

** Model to distribute isco 7 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==7 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==7 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_7 if round_year==2006 & occ_1digit==7 & occ_2digit==.

replace occ_2digit=71 if prediction_7==20
replace occ_2digit=72 if prediction_7==21
replace occ_2digit=73 if prediction_7==22
replace occ_2digit=74 if prediction_7==23

drop random train rf_predicted prediction_7
label drop trainset

** Model to distribute isco 8 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==8 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==8 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_8 if round_year==2006 & occ_1digit==8 & occ_2digit==.

replace occ_2digit=81 if prediction_8==24
replace occ_2digit=82 if prediction_8==25
replace occ_2digit=83 if prediction_8==26

drop random train rf_predicted prediction_8
label drop trainset

** Model to distribute isco 9 into its two digit version 

set seed 50
gen random = runiform() if round_year==2009 & occ_1digit==9 & occ_2digit!=.
gen train = random < 0.8 if round_year==2009 & occ_1digit==9 & occ_2digit!=.
label define trainset 1 "Training" 0 "Testing"
label values train trainset

rforest occ_2digit permanent_job act_econ_1digit categ_occ job_contract hours_worked earnings_net contributing schooling if train==1, type(class) iter(100)  seed(50)
ereturn list
predict rf_predicted if train == 0
tabulate occ_2digit rf_predicted if train == 0

predict prediction_9 if round_year==2006 & occ_1digit==9 & occ_2digit==.

replace occ_2digit=91 if prediction_9==28
replace occ_2digit=92 if prediction_9==29
replace occ_2digit=93 if prediction_9==30

drop random train rf_predicted prediction_9 test test_1 test_check
label drop trainset 

* Checking if there are observations left 

g test=(occ_1digit!=. & occ_2digit==. & round_year==2006)
egen test_1=max(test), by(folio_n20)

sort folio_n20 round_year
br folio_n20 round_year occ_1digit occ_2digit if test_1==1

drop test test_1

** test

gen occ_1digit_0 = string(occ_2digit, "%10.0g")  
gen occ_1digit_1 = real(substr(occ_1digit_0, 1, 1))  

replace occ_2digit=. if occ_1digit_1!=occ_1digit

/*******************************************************************************
Third step: Searching for conflicting dates and cleaning the main database from inconsistencies 

*******************************************************************************/

*** The search for conflicting dates starts by looking if the date of beginning of the status is 
*** higher that the date of end of the status. In that case we make the two dates equal

gen mdate_beginning=ym(year_beginning_work, month_beginning_work)
format mdate_beginning %tm

gen mdate_end=ym(year_end_work, month_end_work)
format mdate_end %tm

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1
replace mdate_beginning=mdate_end if test_1==1
drop test_1

*** In a second step we identify the cases when the date of beginning of status t+1 is smaller
*** than the date of end of status t. In those cases we substitute the date of beginning of status
*** t+1 by the date of end of status t plus 1. Then, we repeat the search for dates of beginning
*** that are higher than dates of ending in the same observation. 

** Iteration 1

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]
replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 3

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 4

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 5

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 6

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 7

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 8

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 9

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 10

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

** Iteration 11

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

g test_2 =test_1[_n-1]

replace mdate_beginning=mdate_end[_n-1]+1 if test_2==1

drop test_1 test_2

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

*** Iteration 12

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

drop test_1

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning>mdate_end & (mdate_beginning!=. & mdate_end!=.) 
tab test_1

drop if test_1==1

drop test_1

*** Iteration 13

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_beginning[_n+1]<=mdate_end & (mdate_beginning[_n+1]!=. & mdate_end!=.)
tab test_1

drop if test_1==1

drop test_1

*** Eliminating further conflicts 

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_end[_n+1]<=mdate_end & (mdate_end[_n+1]!=. & mdate_end!=.)
tab test_1
drop if test_1==1
drop test_1

sort folio_n20 round_year mdate_beginning

bys folio_n20: g test_1=1 if mdate_end==. | mdate_beginning==.
tab test_1
drop if test_1==1
drop test_1

bys folio_n20: g test_1=1 if mdate_end[_n+1]<=mdate_end & (mdate_end[_n+1]!=. & mdate_end!=.)
tab test_1
drop if test_1==1
drop test_1

sort folio_n20 mdate_end

bys folio_n20: g test_1=1 if mdate_end==mdate_end[_n+1]
tab test_1
drop if test_1==1
drop test_1

*** Creating pivote databases 

ren mdate_beginning mdate
*ren mdate_end mdate

tempfile total_panel_data_CHL_pivote
save `total_panel_data_CHL_pivote'

keep folio_n20 mdate_end
ren mdate_end mdate

tempfile total_panel_data_CHL_pivote_1
save `total_panel_data_CHL_pivote_1'

/*******************************************************************************
Fourth step: Creating the database with the required format

*******************************************************************************/

*** To take just one observation per person 
bys folio_n20: gen prueba_0=_n
keep if prueba_0==1
keep folio_n20
expand 439
sort folio_n20
bys folio_n20: g test=_n
g year=1980 if test==1
g month=1 if test==1
gen mdate=ym(year, month)
format mdate %tm
replace mdate=mdate[_n-1]+1 if mdate==.
keep folio_n20 mdate

merge 1:m folio_n20 mdate using `total_panel_data_CHL_pivote'
drop mdate_end
g mdate_beginning=mdate if _merge==3
format mdate_beginning %tm

drop if _merge==2
drop _merge

*merge 1:m folio_n20 mdate using `total_panel_data_CHL_pivote_1'
merge m:1 folio_n20 mdate using `total_panel_data_CHL_pivote_1'

g mdate_end=mdate if _merge==3
format mdate_end %tm

drop if _merge==2
drop _merge

sort folio_n20 mdate

*bys folio_n20: replace age=age[_n-1] if age==.
bys folio_n20: replace weight=weight[_n-1] if weight ==.
bys folio_n20: replace sex=sex[_n-1] if sex==.
bys folio_n20: replace order_transition =order_transition[_n-1] if order_transition ==.
bys folio_n20: replace month_beginning_work =month_beginning_work[_n-1] if month_beginning_work ==.
bys folio_n20: replace year_beginning_work =year_beginning_work[_n-1] if year_beginning_work ==.
bys folio_n20: replace month_end_work =month_end_work[_n-1] if month_end_work ==.
bys folio_n20: replace year_end_work  =year_end_work[_n-1] if year_end_work ==.
bys folio_n20: replace work_situation =work_situation[_n-1] if work_situation  ==.
bys folio_n20: replace occ_2digit =occ_2digit[_n-1] if occ_2digit ==.
bys folio_n20: replace permanent_job =permanent_job[_n-1] if permanent_job ==.
bys folio_n20: replace categ_occ=categ_occ[_n-1] if categ_occ==.
bys folio_n20: replace job_contract=job_contract[_n-1] if job_contract==.
bys folio_n20: replace hours_worked=hours_worked[_n-1] if hours_worked==.
bys folio_n20: replace earnings_net=earnings_net[_n-1] if earnings_net==.
bys folio_n20: replace contributing=contributing[_n-1] if contributing==.
bys folio_n20: replace round_year=round_year[_n-1] if round_year==.
bys folio_n20: replace act_econ_1digit=act_econ_1digit[_n-1] if act_econ_1digit==.
 
sort folio_n20 mdate

egen mdate_pivote=max(mdate_end), by(folio_n20)
format mdate_pivote %tm

replace weight=. if mdate>mdate_pivote 
replace sex=. if mdate>mdate_pivote 
replace order_transition=. if mdate>mdate_pivote 
replace month_beginning_work =. if mdate>mdate_pivote 
replace year_beginning_work =. if mdate>mdate_pivote 
replace month_end_work =. if mdate>mdate_pivote 
replace year_end_work =. if mdate>mdate_pivote 
replace work_situation =. if mdate>mdate_pivote 
replace occ_2digit =. if mdate>mdate_pivote 
replace permanent_job =. if mdate>mdate_pivote 
replace categ_occ =. if mdate>mdate_pivote 
replace job_contract =. if mdate>mdate_pivote 
replace hours_worked =. if mdate>mdate_pivote 
replace earnings_net =. if mdate>mdate_pivote 
replace contributing =. if mdate>mdate_pivote 
replace round_year =. if mdate>mdate_pivote 
replace act_econ_1digit=. if mdate>mdate_pivote 

egen age_pivote=max(age), by(folio_n20)
replace age_pivote=. if mdate>mdate_pivote 

egen age_pivote_1=max(year_end_work), by(folio_n20)
replace age_pivote_1=. if mdate>mdate_pivote

g age_pivote_2=age_pivote_1-1980

g age_beginning=age_pivote-age_pivote_2

sort folio_n20 mdate
replace age_beginning=. if mdate!=240

replace age_beginning=age_beginning[_n-1] if age_beginning==. & (mdate>=240 & mdate<252)
replace age_beginning=age_beginning[_n-12]+1 if age_beginning==.
replace age_beginning=. if mdate>mdate_pivote
replace age_beginning=. if age_beginning<15
replace age_beginning=. if age_beginning>100
drop age /*mdate_pivote*/ age_pivote age_pivote_1 age_pivote_2

ren age_beginning age

sort folio_n20 mdate

drop order_transition month_beginning_work year_beginning_work month_end_work year_end_work 

label drop _all
label variable weight "Person weight in the round-sample"
label variable sex "Sex of the respondent"
label define sex 1 "Male" 2 "Female"
label value sex sex
label variable age "Age of the respondent"
label variable folio_n20 "ID of the respondent"
label variable work_situation "Situation of work"
label define work_situation 1 "Unemployment" 2 "Active" 3 "Inactive" 
label value work_situation work_situation
label variable categ_occ "Occupational category"
label define categ_occ 1 "self-employed" 2 "employees"
label value categ_occ categ_occ
label variable job_contract "Contract signed"
label define job_contract 1 "Yes contract" 2 "No contract"
label value job_contract job_contract
label variable contributing "Contributing to social security"
label define contributing 1 "Yes contributing" 2 "No contributing"
label value contributing contributing
label variable occ_2digit "ISCO_code 2 digit"
label variable act_econ_1digit "Economic activity"
label variable earnings_net "Earnings of persons engaged"
label variable hours_worked "Hours worked"
label variable mdate "Date year and month"
label variable mdate_beginning "Beginning of employment status"
label variable mdate_end "End of employment status"
label variable round_year "Sample/round year"
label variable permanent_job "Permanent job"
label define permanent_job 1 "Yes permanent" 2 "No permanent"
label value permanent_job permanent_job

sort folio_n20 mdate_beginning

bys folio_n20: g order_status=_n if mdate_beginning!=.

sort folio_n20 mdate

bys folio_n20: replace order_status=order_status[_n-1] if order_status==.
bys folio_n20: replace order_status=. if mdate>mdate_pivote

label variable order_status "Order of status"

bys folio_n20: replace work_situation=work_situation[_n-1] if work_situation ==.
bys folio_n20: replace work_situation=. if mdate>mdate_pivote

bys folio_n20: replace occ_2digit=occ_2digit[_n-1] if occ_2digit ==.
bys folio_n20: replace occ_2digit=. if mdate>mdate_pivote

bys folio_n20: replace permanent_job=permanent_job[_n-1] if permanent_job ==.
bys folio_n20: replace permanent_job=. if mdate>mdate_pivote

bys folio_n20: replace act_econ_1digit=act_econ_1digit[_n-1] if act_econ_1digit ==.
bys folio_n20: replace act_econ_1digit=. if mdate>mdate_pivote

bys folio_n20: replace categ_occ=categ_occ[_n-1] if categ_occ ==.
bys folio_n20: replace categ_occ=. if mdate>mdate_pivote

bys folio_n20: replace job_contract=job_contract[_n-1] if job_contract ==.
bys folio_n20: replace job_contract=. if mdate>mdate_pivote

bys folio_n20: replace hours_worked=hours_worked[_n-1] if hours_worked ==.
bys folio_n20: replace hours_worked=. if mdate>mdate_pivote

bys folio_n20: replace earnings_net=earnings_net[_n-1] if earnings_net==.
bys folio_n20: replace earnings_net=. if mdate>mdate_pivote

bys folio_n20: replace contributing=contributing[_n-1] if contributing==.
bys folio_n20: replace contributing=. if mdate>mdate_pivote

bys folio_n20: g test=occ_2digit[_n-1]
bys folio_n20: g test_1=1 if occ_2digit!=test & (occ_2digit!=. & test!=.)

sort folio_n20 test_1 mdate 

bys folio_n20: g test_2=_n if test_1!=.

sort folio_n20 mdate

ren test_2 occ_transition

bys folio_n20: replace occ_transition=occ_transition[_n-1] if occ_transition==.
bys folio_n20: replace occ_transition=. if mdate>mdate_pivote

label variable occ_transition "Transition in occupation"

bys folio_n20: replace reason_endjob=reason_endjob[_n-1] if reason_endjob==. & work_situation==2
bys folio_n20: replace reason_endjob=. if mdate>mdate_pivote

bys folio_n20: replace reason_inactivity=reason_inactivity[_n-1] if reason_inactivity==. & work_situation==3
bys folio_n20: replace reason_inactivity=. if mdate>mdate_pivote

drop test test_1 /*mdate_pivote*/

** Reasigning errors
replace occ_2digit=42 if occ_2digit==43
replace occ_2digit=62 if occ_2digit==63
replace occ_2digit=83 if occ_2digit==86

g occ_class=1 if occ_2digit==11 | occ_2digit==12 | occ_2digit==13 | occ_2digit==21 | occ_2digit==22 | occ_2digit==23 | occ_2digit==24 | occ_2digit==31 /*
*/ | occ_2digit==32 | occ_2digit==33 | occ_2digit==34
replace occ_class=2 if occ_2digit==41 | occ_2digit==42 | occ_2digit==52
replace occ_class=3 if occ_2digit==61 | occ_2digit==71 | occ_2digit==72 | occ_2digit==73 | occ_2digit==74 | occ_2digit==81 | occ_2digit==82 
replace occ_class=4 if occ_2digit==83 | occ_2digit==91 | occ_2digit==92 | occ_2digit==93 | occ_2digit==51 | occ_2digit==62

label variable occ_class "Occupational classification"
label define occ_class 1 "NRC" 2 "RC" 3 "RM" 4 "NRM"
label value occ_class occ_class

g self_nonprof=1 if categ_occ==1 & occ_class==4
g formal=1 if contributing==1 & job_contract==1 & permanent_job==1 & self_nonprof!=1
g informal=1 if contributing==2 | job_contract==2 | permanent_job==2 | self_nonprof==1

*replace work_situation=2 if categ_occ!=.
replace occ_2digit=. if work_situation==1 | work_situation==3
replace permanent_job=. if work_situation==1 | work_situation==3
replace act_econ_1digit=. if work_situation==1 | work_situation==3
replace categ_occ=. if work_situation==1 | work_situation==3
replace job_contract=. if work_situation==1 | work_situation==3
replace hours_worked=. if work_situation==1 | work_situation==3
replace earnings_net=. if work_situation==1 | work_situation==3
replace contributing=. if work_situation==1 | work_situation==3
replace occ_class=. if work_situation==1 | work_situation==3
replace self_nonprof=. if work_situation==1 | work_situation==3
replace formal=. if work_situation==1 | work_situation==3
replace informal=. if work_situation==1 | work_situation==3

g occ_class_paper=1 if occ_class==1 & formal==1 & work_situation==2
replace occ_class_paper=2 if occ_class==2 & formal==1 & work_situation==2
replace occ_class_paper=3 if occ_class==3 & formal==1 & work_situation==2
replace occ_class_paper=4 if occ_class==4 & formal==1 & work_situation==2
replace occ_class_paper=5 if work_situation==1 
replace occ_class_paper=6 if work_situation==3
replace occ_class_paper=7 if occ_class==1 & informal==1 & work_situation==2
replace occ_class_paper=8 if occ_class==2 & informal==1 & work_situation==2
replace occ_class_paper=9 if occ_class==3 & informal==1 & work_situation==2
replace occ_class_paper=10 if occ_class==4 & informal==1 & work_situation==2

label variable occ_class_paper "Occupational classification-paper"
label define occ_class_paper 1 "NRC formal" 2 "RC formal" 3 "RM formal" 4 "NRM formal" 5 "Unemployed" 6 "Inactive" 7 "NRC informal" /*
*/ 8 "RC informal" 9 "RM informal" 10 "NRM informal"
label value occ_class_paper occ_class_paper

replace formal=1 if contributing==1 & occ_class!=. & occ_class_paper==.
replace formal=1 if job_contract==1 & occ_class!=. & occ_class_paper==.
g occ_class_paper_1=1 if occ_class==1 & formal==1 & work_situation==2 & occ_class_paper==.
replace occ_class_paper_1=2 if occ_class==2 & formal==1 & work_situation==2 & occ_class_paper==.
replace occ_class_paper_1=3 if occ_class==3 & formal==1 & work_situation==2 & occ_class_paper==.
replace occ_class_paper_1=4 if occ_class==4 & formal==1 & work_situation==2 & occ_class_paper==.

replace occ_class_paper=occ_class_paper_1 if occ_class!=. & occ_class_paper==.

bys folio_n20: g test=occ_class_paper[_n-1]
bys folio_n20: g test_1=1 if occ_class_paper!=test & (occ_class_paper!=. & test!=.)

sort folio_n20 test_1 mdate 

bys folio_n20: g test_2=_n if test_1!=.

sort folio_n20 mdate

ren test_2 occ_transition_1

bys folio_n20: replace occ_transition_1=occ_transition_1[_n-1] if occ_transition_1==.
bys folio_n20: replace occ_transition_1=. if mdate>mdate_pivote

label variable occ_transition_1 "Transition in occupation"

drop mdate_pivote self_nonprof formal informal occ_class_paper_1 test test_1 occ_transition

ren occ_transition_1 occ_transition

sort folio_n20 mdate

** Additional changes
replace occ_transition=0 if occ_transition==. & occ_class_paper!=.

*** Error with sex
bys folio_n20: egen test=mean(sex)
tab test
br if test>1 & test<2
bys folio_n20: egen sex_1=mode(sex) if test>1 & test<2
replace sex=sex_1 if test>1 & test<2
drop test sex_1 

drop schooling

** Constructing schooling variable
bys folio_n20 round_year: egen schooling_02bis=max(schooling_02)
order schooling_02bis,after(schooling_02)
replace schooling_02 = schooling_02bis if round_year==2002
drop schooling_02bis
bys folio_n20 round_year: egen schooling_04bis=max(schooling_04)
order schooling_04bis,after(schooling_04)
replace schooling_04 = schooling_04bis if round_year==2004
drop schooling_04bis
bys folio_n20 round_year: egen schooling_06bis=max(schooling_06)
order schooling_06bis,after(schooling_06)
replace schooling_06 = schooling_06bis if round_year==2006
drop schooling_06bis
bys folio_n20 round_year: egen schooling_09bis=max(schooling_09)
order schooling_09bis,after(schooling_09)
replace schooling_09 = schooling_09bis if round_year==2009
drop schooling_09bis
bys folio_n20 round_year: egen schooling_15bis=max(schooling_15)
order schooling_15bis,after(schooling_15)
replace schooling_15 = schooling_15bis if round_year==2015
drop schooling_15bis

label define schooling_02 1 "Education preescolar" 2 "Preparatoria" 3 "Educacion basica" 4 "Educacion differencial" 5 "Humanidades" 6 "Educacion media cientifico" 7 "Tecnica, comercial, industrial" 8 "Educacion media tecnica profesional" 9 "Centro de formacion technica incompleta" 10 "Centro de formacion tecnica completa" 11 "Instituto profesional incompleta" 12 "Instituto profesional completa" 13 "Educacion universitaria incompleta" 14 "Education universitaria completa" 15 "Universitaria de postgrado" 16 "Ninguno"
label values schooling_02 schooling_02

recode schooling_04 -4=.
label define schooling_04 1 "Ninguna" 2 "Preescolar" 3 "Preparatoria" 4 "Basica" 5 "Diferencial" 6 "Humanidades" 7 "Media Centrifica-Humanista" 8 "Tecnica, comercial, normalista, industrial" 9 "Media Tecnica-Profesional" 10 "Superior en centro de formacion tecnica" 11 "Superior en instituto profesional" 12 "Superior en universidad" 13 "Magister o Postgrado"
label values schooling_04 schooling_04

recode schooling_06 99=.
label define schooling_06 1 "Ninguna" 2 "Preescolar" 3 "Preparatoria" 4 "Basica" 5 "Diferencial" 6 "Humanidades" 7 "Media Centrifica-Humanista" 8 "Tecnica, comercial, normalista, industrial" 9 "Media Tecnica-Profesional" 10 "Superior en centro de formacion tecnica" 11 "Superior en instituto profesional" 12 "Superior en universidad" 13 "Magister o Postgrado"
label values schooling_06 schooling_06

recode schooling_09 99=. 88=.
label define schooling_09 1 "Ninguna" 2 "Preescolar" 3 "Preparatoria" 4 "Basica" 5 "Diferencial" 6 "Humanidades" 7 "Media Centrifica-Humanista" 8 "Tecnica, comercial, normalista, industrial" 9 "Media Tecnica-Profesional" 10 "Superior en centro de formacion tecnica" 11 "Superior en instituto profesional" 12 "Superior en universidad" 13 "Magister o Postgrado"
label values schooling_09 schooling_09

recode schooling_15 99=. 88=.
label define schooling_15 1 "Educacion preescolar" 2 "Educacion basica" 3 "Educacion diferencial" 4 "Preparatoria" 5 "HUmanidades" 6 "Educacion media cientrifico-humanistica" 7 "Tecnica, comercial, industrial o normalista" 8 "Educacion media tecnica profesional" 9 "Centro de formacion tecnica" 10 "Instituto profesional" 11 "Universitaria" 12 "Universitaria de postgrado" 13 "Ninguno"
label values schooling_15 schooling_15


gen schooling = 1 if schooling_02 ==16 & round_year==2002
replace schooling = 1 if schooling_02 ==1 & round_year==2002
replace schooling = 1 if schooling_02 ==2 & round_year==2002
replace schooling = 1 if schooling_02 ==3 & round_year==2002
replace schooling = 2 if schooling_02 ==4 & round_year==2002
replace schooling = 2 if schooling_02 ==5 & round_year==2002
replace schooling = 2 if schooling_02 ==6 & round_year==2002
replace schooling = 2 if schooling_02 ==7 & round_year==2002
replace schooling = 2 if schooling_02 ==8 & round_year==2002
replace schooling = 2 if schooling_02 ==9 & round_year==2002
replace schooling = 2 if schooling_02 ==10 & round_year==2002
replace schooling = 2 if schooling_02 ==11 & round_year==2002
replace schooling = 2 if schooling_02 ==12 & round_year==2002
replace schooling = 3 if schooling_02 ==13 & round_year==2002
replace schooling = 3 if schooling_02 ==14 & round_year==2002
replace schooling = 3 if schooling_02 ==15 & round_year==2002
replace schooling = 1 if schooling_04 ==1 & round_year==2004
replace schooling = 1 if schooling_04 ==2 & round_year==2004
replace schooling = 1 if schooling_04 ==3 & round_year==2004
replace schooling = 1 if schooling_04 ==4 & round_year==2004
replace schooling = 2 if schooling_04 ==5 & round_year==2004
replace schooling = 2 if schooling_04 ==6 & round_year==2004
replace schooling = 2 if schooling_04 ==7 & round_year==2004
replace schooling = 2 if schooling_04 ==8 & round_year==2004
replace schooling = 2 if schooling_04 ==9 & round_year==2004
replace schooling = 2 if schooling_04 ==10 & round_year==2004
replace schooling = 2 if schooling_04 ==11 & round_year==2004
replace schooling = 3 if schooling_04 ==12 & round_year==2004
replace schooling = 3 if schooling_04 ==13 & round_year==2004
replace schooling = 1 if schooling_06 ==1 & round_year==2006
replace schooling = 1 if schooling_06 ==2 & round_year==2006
replace schooling = 1 if schooling_06 ==3 & round_year==2006
replace schooling = 1 if schooling_06 ==4 & round_year==2006
replace schooling = 2 if schooling_06 ==5 & round_year==2006
replace schooling = 2 if schooling_06 ==6 & round_year==2006
replace schooling = 2 if schooling_06 ==7 & round_year==2006
replace schooling = 2 if schooling_06 ==8 & round_year==2006
replace schooling = 2 if schooling_06 ==9 & round_year==2006
replace schooling = 2 if schooling_06 ==10 & round_year==2006
replace schooling = 2 if schooling_06 ==11 & round_year==2006
replace schooling = 3 if schooling_06 ==12 & round_year==2006
replace schooling = 3 if schooling_06 ==13 & round_year==2006
replace schooling = 1 if schooling_09 ==1 & round_year==2009
replace schooling = 1 if schooling_09 ==2 & round_year==2009
replace schooling = 1 if schooling_09 ==3 & round_year==2009
replace schooling = 1 if schooling_09 ==4 & round_year==2009
replace schooling = 2 if schooling_09 ==5 & round_year==2009
replace schooling = 2 if schooling_09 ==6 & round_year==2009
replace schooling = 2 if schooling_09 ==7 & round_year==2009
replace schooling = 2 if schooling_09 ==8 & round_year==2009
replace schooling = 2 if schooling_09 ==9 & round_year==2009
replace schooling = 2 if schooling_09 ==10 & round_year==2009
replace schooling = 2 if schooling_09 ==11 & round_year==2009
replace schooling = 3 if schooling_09 ==12 & round_year==2009
replace schooling = 3 if schooling_09 ==13 & round_year==2009
replace schooling = 1 if schooling_15 ==13 & round_year==2015
replace schooling = 1 if schooling_15 ==1 & round_year==2015
replace schooling = 1 if schooling_15 ==2 & round_year==2015
replace schooling = 2 if schooling_15 ==3 & round_year==2015
replace schooling = 2 if schooling_15 ==4 & round_year==2015
replace schooling = 2 if schooling_15 ==5 & round_year==2015
replace schooling = 2 if schooling_15 ==6 & round_year==2015
replace schooling = 2 if schooling_15 ==7 & round_year==2015
replace schooling = 2 if schooling_15 ==8 & round_year==2015
replace schooling = 2 if schooling_15 ==9 & round_year==2015
replace schooling = 2 if schooling_15 ==10 & round_year==2015
replace schooling = 3 if schooling_15 ==11 & round_year==2015
replace schooling = 3 if schooling_15 ==12 & round_year==2015

sort folio_n20 mdate

bys folio_n20:  replace schooling=schooling[_n-1] if schooling[_n-1]>schooling & schooling!=. & schooling[_n-1]!=.

drop schooling_02 schooling_04 schooling_06 schooling_09 schooling_15 
label define schooling 1 "Low" 2 "Middle" 3 "High"
label values schooling schooling
tab schooling,gen(schooling)

g test=1 if schooling==. & occ_class_paper!=.
egen test1=max(test), by(folio_n20)

bys folio_n20:  replace schooling=schooling[_n-1] if schooling==. & occ_class_paper!=.

drop test test1

g test=1 if schooling==. & occ_class_paper!=.
egen test1=max(test), by(folio_n20)

egen test2=mode(schooling) if test1==1, by(folio_n20)
replace schooling=test2 if test1==1 & schooling==. & occ_class_paper!=.

drop test test1 test2 schooling1 schooling2 schooling3

label variable schooling "Level of schooling"
label variable reason_endjob "Reason for ending job"
label variable reason_inactivity "Reason for inactivity"

**** This is the baseline database - This database is used for the Multilevel Multistate Event History Models

save "$data_clean\data_chile_paper_1980_2015_2_digits", replace 


/*******************************************************************************
Fourth step: Creating the database for the flow approach 

*******************************************************************************/

*use "$data_clean\data_chile_paper_1980_2015", replace 

* Database excel
keep mdate folio_n20 occ_class_paper age

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

drop age

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper, i(folio_n20)  j(mdate_text) string
order *, seq
label drop _all
recode occ* (.=1000)

save "$data_clean\transition_matrix_1980_2015_2_digits", replace 

**************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************
**************************************************************************************************************************************************************************

*** Here we are going to create the 12 groups we are going to use for our counterfactuals by demographic groups. These demographic groups are comprised by the 
*** following groups: men and women, 3 educational groups and two age groups 

*** Group 1: Hombre, Low, 15-29
*** Group 2: Hombre, Low, 30+
*** Group 3: Hombre , Medium, 15-29
*** Group 4: Hombre, Medium, 30+
*** Group 5: Hombre, High, 15-29
*** Group 6: Hombre, High, 30+
*** Group 7: Mujer, Low, 15-29
*** Group 8: Mujer, Low, 30+
*** Group 9: Mujer, Medium, 15-29
*** Group 10: Mujer, Medium, 30+
*** Group 11: Mujer, High, 15-29
*** Group 12: Mujer, High, 30+

*** Group 1: Hombre_Low_15_29***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==1 & schooling==1 & age_group==1

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 2: Hombre, Low, 30+***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==1 & schooling==1 & age_group==2

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 3: Hombre , Medium, 15-29***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==1 & schooling==2 & age_group==1

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 4: Hombre, Medium, 30+***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==1 & schooling==2 & age_group==2

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 5: Hombre, High, 15-29***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==1 & schooling==3 & age_group==1

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 6: Hombre, High, 30+***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==1 & schooling==3 & age_group==2

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 7: Mujer, Low, 15-29***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==2 & schooling==1 & age_group==1

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 8: Mujer, Low, 30+***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==2 & schooling==1 & age_group==2

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 9: Mujer, Medium, 15-29***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==2 & schooling==2 & age_group==1

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 10: Mujer, Medium, 30+***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==2 & schooling==2 & age_group==2

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 11: Mujer, High, 15-29***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==2 & schooling==3 & age_group==1

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

*** Group 12: Mujer, High, 30+***********************************************************************

use "$data_clean\data_chile_paper_1980_2015_2_digits", replace 

g age_group=.
replace age_group=1 if age>=15 & age<=29
replace age_group=2 if age>=30 & age!=.

label define age_group 1 "15-29" 2 "30+" 
label values age_group age_group

replace occ_class_paper=. if age<15
replace occ_class_paper=. if age>65

keep mdate folio_n20 occ_class_paper age_group sex schooling

sort folio_n20 mdate

generate mdate_text = string(mdate, "%tm")
drop mdate

g occ_class_paper_group_1=.
replace occ_class_paper_group_1=occ_class_paper if sex==2 & schooling==3 & age_group==2

drop age_group sex schooling occ_class_paper

duplicates drop folio_n20 mdate_text, force

reshape wide occ_class_paper_group_1, i(folio_n20)  j(mdate_text) string // If this gives error type reshape error and erase the conflicting observations
order *, seq
label drop _all
recode occ* (.=1000)

