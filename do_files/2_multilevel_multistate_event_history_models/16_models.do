* ---------------------------------------------------------------------------- *
* ANALYSIS: Running the models
* ---------------------------------------------------------------------------- *

* ---------------------------------------------------------------------------- *
* NRC formal: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_NRC_formal"

* risk of a employment transition (no controls)
streg ib5.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* risk of a employment transition (with controls)
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_NRC ib5.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_NRC 2=1 3=2 4=2
label define time_NRC 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_NRC ib1.sex#ib5.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
tab agegroup_dummy,m
streg ib1.sex ib1.education ib1.order ib1.time_since_NRC ib1.agegroup_dummy#ib5.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by level of education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_NRC ib1.education#ib5.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* RC formal: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_RC_formal"

* risk of a employment transition (no controls)
streg ib5.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_RC ib5.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_RC 2=1 3=2 4=2
label define time_RC 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_RC ib1.sex#ib5.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
tab agegroup_dummy,m
streg ib1.sex ib1.education ib1.order ib1.time_since_RC ib1.agegroup_dummy#ib5.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by level of education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_RC ib1.education#ib5.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* RM formal: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_RM_formal"

* risk of a employment transition (no controls)
streg ib5.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_RM ib5.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_RM 2=1 3=2 4=2
label define time_RM 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_RM ib1.sex#ib5.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
streg ib1.sex ib1.education ib1.order ib1.time_since_RM ib1.agegroup_dummy#ib5.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_RM ib1.education#ib5.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* NRM formal: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_NRM_formal"

* risk of a employment transition (no controls)
streg ib5.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* risk of a employment transition
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_NRM ib5.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_NRM 2=1 3=2 4=2
label define time_NRM 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_NRM ib1.sex#ib5.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
tab agegroup_dummy,m
streg ib1.sex ib1.education ib1.order ib1.time_since_NRM ib1.agegroup_dummy#ib5.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_NRM ib1.education#ib5.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* Out of emp: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_Outofemp"

* risk of a employment transition (no controls)
streg ib1.type#ib1.time_outofemp, dist(exponential) cluster(folio_n20)

**** Competing risk setting
* risk of a employment transition by fertility status and type of employment
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_outofemp ib1.type#ib1.time_outofemp, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_outofemp 2=1 3=2 4=2
label define time_outofemp 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_outofemp ib1.sex#ib1.type#ib1.time_outofemp, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
tab agegroup_dummy,m
streg ib1.sex ib1.education ib1.order ib1.time_since_outofemp ib1.agegroup_dummy#ib1.type#ib1.time_outofemp, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_outofemp ib1.education#ib1.type#ib1.time_outofemp, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* NRC informal: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_NRC_informal"

* risk of a employment transition (no controls)
streg ib6.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* risk of a employment transition (with controls)
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_NRC ib6.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_NRC 2=1 3=2 4=2
label define time_NRC 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_NRC ib1.sex#ib6.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
tab agegroup_dummy,m
streg ib1.sex ib1.education ib1.order ib1.time_since_NRC ib1.agegroup_dummy#ib6.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by level of education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_NRC ib1.education#ib6.type#ib1.time_NRC, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* RC informal: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_RC_informal"

* risk of a employment transition (no controls)
streg ib6.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_RC ib6.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_RC 2=1 3=2 4=2
label define time_RC 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_RC ib1.sex#ib6.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
tab agegroup_dummy,m
streg ib1.sex ib1.education ib1.order ib1.time_since_RC ib1.agegroup_dummy#ib6.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by level of education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_RC ib1.education#ib6.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* RM informal: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_RM_informal"

* risk of a employment transition (no controls)
streg ib6.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_RM ib6.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_RM 2=1 3=2 4=2
label define time_RM 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_RM ib1.sex#ib6.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
streg ib1.sex ib1.education ib1.order ib1.time_since_RM ib1.agegroup_dummy#ib6.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_RM ib1.education#ib6.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* NRM informal: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_NRM_informal"

* risk of a employment transition (no controls)
streg ib6.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

recode order 4=3
* risk of a employment transition
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_NRM ib6.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by gender
recode time_NRM 2=1 3=2 4=2
label define time_NRM 1 "1980-2000" 2 "2000-2020", modify
streg ib1.agegroup ib1.education ib1.order ib1.time_since_NRM ib1.sex#ib6.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by agegroup (15-29 and 30+)
g agegroup_dummy = 1 if agegroup==1
replace agegroup_dummy = 1 if agegroup==2
replace agegroup_dummy = 1 if agegroup==3
replace agegroup_dummy = 2 if agegroup>3
tab agegroup_dummy,m
streg ib1.sex ib1.education ib1.order ib1.time_since_NRM ib1.agegroup_dummy#ib6.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time by education
streg ib1.sex ib1.agegroup ib1.order ib1.time_since_NRM ib1.education#ib6.type#ib1.time_NRM, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* RM formal - Out of emp: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_RMFOutofemp"

g group =1 if previous_occ ==3
replace group=0 if previous_occ ==1
replace group=0 if previous_occ ==2
replace group=0 if previous_occ ==4

recode time_outofemp 2=1 3=2 4=2
label define time_outofemp 1 "1980-2000" 2 "2000-2020", modify

**** Competing risk setting
* risk of going back to employment by type of previous occ
stset duration, failure(event==1) id(folio_n20) exit(time 60)
sts graph, by(previous_occ) xscale(range(0 60)) failure

* ---------------------------------------------------------------------------- *
* RM informal - Out of emp: Analysis
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_RMIOutofemp"

g group =1 if previous_occ ==7
replace group=0 if previous_occ ==5
replace group=0 if previous_occ ==6
replace group=0 if previous_occ ==8

recode time_outofemp 2=1 3=2 4=2
label define time_outofemp 1 "1980-2000" 2 "2000-2020", modify

**** Competing risk setting
* risk of going back to employment by type of previous occ
stset duration, failure(event==1) id(folio_n20) exit(time 60)
sts graph, by(previous_occ) xscale(range(0 60)) failure

* ---------------------------------------------------------------------------- *
* RC formal unvoluntary: Robustness
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_RC_formal_robustness"

* risk of a employment transition (no controls)
streg ib5.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_RC ib5.type#ib1.time_RC, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* RM formal unvoluntary: Robustness
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load dataset
clear
use "$resultdir\outcomes_RM_formal_robustness"

* risk of a employment transition (no controls)
streg ib5.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* risk of a employment transition over time
streg ib1.sex ib1.agegroup ib1.education ib1.order ib1.time_since_RM ib5.type#ib1.time_RM, dist(exponential) cluster(folio_n20)

* ---------------------------------------------------------------------------- *
* End of the do-file
* ---------------------------------------------------------------------------- *