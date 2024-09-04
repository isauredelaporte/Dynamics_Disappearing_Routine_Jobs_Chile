* ---------------------------------------------------------------------------- *
* ANALYSIS OF RC INFORMAL OUTCOMES
* Evaluates outcomes for individuals in RC informal jobs
* ---------------------------------------------------------------------------- *

cap log close 
log using "$resultdir\9_outcomes_RC_informal.log", replace

* Clear current data, set directory and load the dataset for analysis
clear
use "$datadir\analysis_transitions_2_digits_isco88"

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 1: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *
* Count total individuals for initial overview
count

* Create risk set for individuals in the RC informal of order 1 category across multiple categories
gen indicator = .
forvalues i = 1/88 { 
    replace indicator = 1 if cat`i' == 8
}
drop if indicator==.
drop indicator

* Construct the 'beginning' variable
gen beginning = .

* Loop through each 'cat' variable
forvalues i = 1/88 {
    * Only update 'beginning' if it hasn't been set yet (still missing) and the current 'cat' is active
    replace beginning = cat`i'_start if missing(beginning) & cat`i' == 8
}

* Make sure that there are no missings
tab beginning,m

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'end' variable
* Initialize 'end' with 'cat1_end' value if 'cat2_end' is missing
gen end = cat1_end if missing(cat2_end)

* Re-order variables
order folio_n20 beginning end

* Loop through the 'cat_end' variables from 2 to the last one needed
forvalues i = 2/87 {
    * Update 'end' if this 'cat_end' is not missing and the next one is missing or if it's the last 'cat_end' in the sequence
    local next = `i' + 1  // Calculate the next index
    replace end = cat`i'_end if missing(cat`next'_end) & !missing(cat`i'_end)
}

* Check the 'end' variable tabulation, make sure there is no missings
tab end, m

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat1_start & cat2==1
order event,after(folio_n20)
replace event=2 if beginning==cat1_start & cat2==2
replace event=3 if beginning==cat1_start & cat2==3
replace event=4 if beginning==cat1_start & cat2==4
replace event=5 if beginning==cat1_start & cat2==5
replace event=6 if beginning==cat1_start & cat2==6
replace event=7 if beginning==cat1_start & cat2==7
replace event=8 if beginning==cat1_start & cat2==9
replace event=9 if beginning==cat1_start & cat2==10
replace event=0 if beginning==cat1_start & cat2==.
replace event=1 if beginning==cat2_start & cat3==1
replace event=2 if beginning==cat2_start & cat3==2
replace event=3 if beginning==cat2_start & cat3==3
replace event=4 if beginning==cat2_start & cat3==4
replace event=5 if beginning==cat2_start & cat3==5
replace event=6 if beginning==cat2_start & cat3==6
replace event=7 if beginning==cat2_start & cat3==7
replace event=8 if beginning==cat2_start & cat3==9
replace event=9 if beginning==cat2_start & cat3==10
replace event=0 if beginning==cat2_start & cat3==.
replace event=1 if beginning==cat3_start & cat4==1
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=2 if beginning==cat2_start & cat3==8 & cat4==2
replace event=0 if beginning==cat3_start & cat4==8 & cat5==.
replace event=0 if beginning==cat30_start & cat31==.
replace event=0 if beginning==cat26_start & cat27==.
replace event=0 if beginning==cat57_start & cat58==.
replace event=0 if beginning==cat53_start & cat54==.
replace event=0 if beginning==cat43_start & cat44==.
replace event=8 if beginning==cat33_start & cat34==9
replace event=8 if beginning==cat52_start & cat53==9
replace event=9 if beginning==cat35_start & cat36==10
replace event=6 if beginning==cat45_start & cat46==6
replace event=8 if beginning==cat26_start & cat27==9
replace event=4 if beginning==cat27_start & cat28==4
replace event=5 if beginning==cat49_start & cat50==5
replace event=8 if beginning==cat47_start & cat48==9
replace event=8 if beginning==cat38_start & cat39==9
replace event=0 if beginning==cat42_start & cat43==.
replace event=0 if beginning==cat1_start & cat2==8 & cat3==.
replace event=9 if beginning==cat27_start & cat28==10
replace event=9 if beginning==cat52_start & cat53==10
replace event=1 if beginning==cat28_start & cat29==1
replace event=0 if beginning==cat28_start & cat29==.
replace event=9 if beginning==cat26_start & cat27==10
replace event=9 if beginning==cat36_start & cat37==10
replace event=9 if beginning==cat51_start & cat52==10
replace event=9 if beginning==cat33_start & cat34==10

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat53_start - beginning if beginning==cat52_start & cat53!=8 & cat53!=.
replace duration = cat4_start - beginning if beginning==cat2_start & cat3==8 & cat4==2
replace duration = cat29_start - beginning if beginning==cat28_start & cat29==1
replace duration = cat37_start - beginning if beginning==cat36_start & cat37==10
replace duration = cat52_start - beginning if beginning==cat51_start & cat52==10

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC1_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =1

* Define the education variable
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling1 if beginning==cat1_start & education==.
replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling3 if beginning==cat3_start & education==.
replace education=schooling4 if beginning==cat4_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling10 if beginning==cat10_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling12 if beginning==cat12_start & education==.
replace education=schooling13 if beginning==cat13_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m
* 1 missing for education

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079) 
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC1_informal", replace

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 2: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load the dataset for analysis
clear
use "$resultdir\sample_RC1_informal"

drop event
replace beginning=beginning+duration
drop duration

* Create risk set: individuals that are in RC informal of order 2 across multiple categories
gen indicator = .  // Initialize the variable
replace indicator=1 if beginning==cat2_start & cat3==8 | beginning==cat2_start & cat4==8 | beginning==cat2_start & cat5==8 | beginning==cat2_start & cat6==8 | beginning==cat2_start & cat7==8 | beginning==cat2_start & cat8==8 | beginning==cat2_start & cat9==8 | beginning==cat2_start & cat10==8 | beginning==cat2_start & cat11==8 | beginning==cat2_start & cat12==8 | beginning==cat2_start & cat13==8 | beginning==cat2_start & cat14==8 | beginning==cat2_start & cat15==8 | beginning==cat2_start & cat16==8 | beginning==cat2_start & cat17==8 | beginning==cat2_start & cat18==8 | beginning==cat2_start & cat19==8 | beginning==cat2_start & cat20==8 | beginning==cat2_start & cat21==8 | beginning==cat2_start & cat22==8 | beginning==cat2_start & cat23==8 | beginning==cat2_start & cat24==8 | beginning==cat2_start & cat25==8 | beginning==cat2_start & cat26==8 | beginning==cat2_start & cat27==8 | beginning==cat2_start & cat28==8 | beginning==cat2_start & cat29==8 | beginning==cat2_start & cat30==8 | beginning==cat2_start & cat31==8 | beginning==cat2_start & cat32==8 | beginning==cat2_start & cat33==8 | beginning==cat2_start & cat34==8 | beginning==cat2_start & cat35==8 | beginning==cat2_start & cat36==8 | beginning==cat2_start & cat37==8 | beginning==cat2_start & cat38==8 | beginning==cat2_start & cat39==8 | beginning==cat2_start & cat40==8 | beginning==cat2_start & cat41==8 | beginning==cat2_start & cat42==8 | beginning==cat2_start & cat43==8 | beginning==cat2_start & cat44==8 | beginning==cat2_start & cat45==8 | beginning==cat2_start & cat46==8 | beginning==cat2_start & cat47==8 | beginning==cat2_start & cat48==8 | beginning==cat2_start & cat49==8 | beginning==cat2_start & cat50==8 | beginning==cat2_start & cat51==8 | beginning==cat2_start & cat52==8 | beginning==cat2_start & cat53==8 | beginning==cat2_start & cat54==8 | beginning==cat2_start & cat55==8 | beginning==cat2_start & cat56==8 | beginning==cat2_start & cat57==8 | beginning==cat2_start & cat58==8 | beginning==cat2_start & cat59==8 | beginning==cat2_start & cat60==8 | beginning==cat2_start & cat61==8 | beginning==cat2_start & cat62==8 | beginning==cat2_start & cat63==8 | beginning==cat2_start & cat64==8 | beginning==cat2_start & cat65==8 | beginning==cat2_start & cat66==8 | beginning==cat2_start & cat67==8 | beginning==cat2_start & cat68==8 | beginning==cat2_start & cat69==8 | beginning==cat2_start & cat70==8 | beginning==cat2_start & cat71==8 | beginning==cat2_start & cat72==8 | beginning==cat2_start & cat73==8 | beginning==cat2_start & cat74==8 | beginning==cat2_start & cat75==8 | beginning==cat2_start & cat76==8 | beginning==cat2_start & cat77==8 | beginning==cat2_start & cat78==8 | beginning==cat2_start & cat79==8 | beginning==cat2_start & cat80==8 | beginning==cat2_start & cat81==8 | beginning==cat2_start & cat82==8 | beginning==cat2_start & cat83==8 | beginning==cat2_start & cat84==8 | beginning==cat2_start & cat85==8 | beginning==cat2_start & cat86==8 | beginning==cat2_start & cat87==8 | beginning==cat2_start & cat88==8
replace indicator=0 if beginning==cat2_start & indicator==.
replace indicator=1 if beginning==cat3_start & cat4==8 | beginning==cat3_start & cat5==8 | beginning==cat3_start & cat6==8 | beginning==cat3_start & cat7==8 | beginning==cat3_start & cat8==8 | beginning==cat3_start & cat9==8 | beginning==cat3_start & cat10==8 | beginning==cat3_start & cat11==8 | beginning==cat3_start & cat12==8 | beginning==cat3_start & cat13==8 | beginning==cat3_start & cat14==8 | beginning==cat3_start & cat15==8 | beginning==cat3_start & cat16==8 | beginning==cat3_start & cat17==8 | beginning==cat3_start & cat18==8 | beginning==cat3_start & cat19==8 | beginning==cat3_start & cat20==8 | beginning==cat3_start & cat21==8 | beginning==cat3_start & cat22==8 | beginning==cat3_start & cat23==8 | beginning==cat3_start & cat24==8 | beginning==cat3_start & cat25==8 | beginning==cat3_start & cat26==8 | beginning==cat3_start & cat27==8 | beginning==cat3_start & cat28==8 | beginning==cat3_start & cat29==8 | beginning==cat3_start & cat30==8 | beginning==cat3_start & cat31==8 | beginning==cat3_start & cat32==8 | beginning==cat3_start & cat33==8 | beginning==cat3_start & cat34==8 | beginning==cat3_start & cat35==8 | beginning==cat3_start & cat36==8 | beginning==cat3_start & cat37==8 | beginning==cat3_start & cat38==8 | beginning==cat3_start & cat39==8 | beginning==cat3_start & cat40==8 | beginning==cat3_start & cat41==8 | beginning==cat3_start & cat42==8 | beginning==cat3_start & cat43==8 | beginning==cat3_start & cat44==8 | beginning==cat3_start & cat45==8 | beginning==cat3_start & cat46==8 | beginning==cat3_start & cat47==8 | beginning==cat3_start & cat48==8 | beginning==cat3_start & cat49==8 | beginning==cat3_start & cat50==8 | beginning==cat3_start & cat51==8 | beginning==cat3_start & cat52==8 | beginning==cat3_start & cat53==8 | beginning==cat3_start & cat54==8 | beginning==cat3_start & cat55==8 | beginning==cat3_start & cat56==8 | beginning==cat3_start & cat57==8 | beginning==cat3_start & cat58==8 | beginning==cat3_start & cat59==8 | beginning==cat3_start & cat60==8 | beginning==cat3_start & cat61==8 | beginning==cat3_start & cat62==8 | beginning==cat3_start & cat63==8 | beginning==cat3_start & cat64==8 | beginning==cat3_start & cat65==8 | beginning==cat3_start & cat66==8 | beginning==cat3_start & cat67==8 | beginning==cat3_start & cat68==8 | beginning==cat3_start & cat69==8 | beginning==cat3_start & cat70==8 | beginning==cat3_start & cat71==8 | beginning==cat3_start & cat72==8 | beginning==cat3_start & cat73==8 | beginning==cat3_start & cat74==8 | beginning==cat3_start & cat75==8 | beginning==cat3_start & cat76==8 | beginning==cat3_start & cat77==8 | beginning==cat3_start & cat78==8 | beginning==cat3_start & cat79==8 | beginning==cat3_start & cat80==8 | beginning==cat3_start & cat81==8 | beginning==cat3_start & cat82==8 | beginning==cat3_start & cat83==8 | beginning==cat3_start & cat84==8 | beginning==cat3_start & cat85==8 | beginning==cat3_start & cat86==8 | beginning==cat3_start & cat87==8 | beginning==cat3_start & cat88==8
replace indicator=0 if beginning==cat3_start & indicator==.
replace indicator=1 if beginning==cat4_start & cat5==8 | beginning==cat4_start & cat6==8 | beginning==cat4_start & cat7==8 | beginning==cat4_start & cat8==8 | beginning==cat4_start & cat9==8 | beginning==cat4_start & cat10==8 | beginning==cat4_start & cat11==8 | beginning==cat4_start & cat12==8 | beginning==cat4_start & cat13==8 | beginning==cat4_start & cat14==8 | beginning==cat4_start & cat15==8 | beginning==cat4_start & cat16==8 | beginning==cat4_start & cat17==8 | beginning==cat4_start & cat18==8 | beginning==cat4_start & cat19==8 | beginning==cat4_start & cat20==8 | beginning==cat4_start & cat21==8 | beginning==cat4_start & cat22==8 | beginning==cat4_start & cat23==8 | beginning==cat4_start & cat24==8 | beginning==cat4_start & cat25==8 | beginning==cat4_start & cat26==8 | beginning==cat4_start & cat27==8 | beginning==cat4_start & cat28==8 | beginning==cat4_start & cat29==8 | beginning==cat4_start & cat30==8 | beginning==cat4_start & cat31==8 | beginning==cat4_start & cat32==8 | beginning==cat4_start & cat33==8 | beginning==cat4_start & cat34==8 | beginning==cat4_start & cat35==8 | beginning==cat4_start & cat36==8 | beginning==cat4_start & cat37==8 | beginning==cat4_start & cat38==8 | beginning==cat4_start & cat39==8 | beginning==cat4_start & cat40==8 | beginning==cat4_start & cat41==8 | beginning==cat4_start & cat42==8 | beginning==cat4_start & cat43==8 | beginning==cat4_start & cat44==8 | beginning==cat4_start & cat45==8 | beginning==cat4_start & cat46==8 | beginning==cat4_start & cat47==8 | beginning==cat4_start & cat48==8 | beginning==cat4_start & cat49==8 | beginning==cat4_start & cat50==8 | beginning==cat4_start & cat51==8 | beginning==cat4_start & cat52==8 | beginning==cat4_start & cat53==8 | beginning==cat4_start & cat54==8 | beginning==cat4_start & cat55==8 | beginning==cat4_start & cat56==8 | beginning==cat4_start & cat57==8 | beginning==cat4_start & cat58==8 | beginning==cat4_start & cat59==8 | beginning==cat4_start & cat60==8 | beginning==cat4_start & cat61==8 | beginning==cat4_start & cat62==8 | beginning==cat4_start & cat63==8 | beginning==cat4_start & cat64==8 | beginning==cat4_start & cat65==8 | beginning==cat4_start & cat66==8 | beginning==cat4_start & cat67==8 | beginning==cat4_start & cat68==8 | beginning==cat4_start & cat69==8 | beginning==cat4_start & cat70==8 | beginning==cat4_start & cat71==8 | beginning==cat4_start & cat72==8 | beginning==cat4_start & cat73==8 | beginning==cat4_start & cat74==8 | beginning==cat4_start & cat75==8 | beginning==cat4_start & cat76==8 | beginning==cat4_start & cat77==8 | beginning==cat4_start & cat78==8 | beginning==cat4_start & cat79==8 | beginning==cat4_start & cat80==8 | beginning==cat4_start & cat81==8 | beginning==cat4_start & cat82==8 | beginning==cat4_start & cat83==8 | beginning==cat4_start & cat84==8 | beginning==cat4_start & cat85==8 | beginning==cat4_start & cat86==8 | beginning==cat4_start & cat87==8 | beginning==cat4_start & cat88==8
replace indicator=0 if beginning==cat4_start & indicator==.
replace indicator=1 if beginning==cat5_start & cat6==8 | beginning==cat5_start & cat7==8 | beginning==cat5_start & cat8==8 | beginning==cat5_start & cat9==8 | beginning==cat5_start & cat10==8 | beginning==cat5_start & cat11==8 | beginning==cat5_start & cat12==8 | beginning==cat5_start & cat13==8 | beginning==cat5_start & cat14==8 | beginning==cat5_start & cat15==8 | beginning==cat5_start & cat16==8 | beginning==cat5_start & cat17==8 | beginning==cat5_start & cat18==8 | beginning==cat5_start & cat19==8 | beginning==cat5_start & cat20==8 | beginning==cat5_start & cat21==8 | beginning==cat5_start & cat22==8 | beginning==cat5_start & cat23==8 | beginning==cat5_start & cat24==8 | beginning==cat5_start & cat25==8 | beginning==cat5_start & cat26==8 | beginning==cat5_start & cat27==8 | beginning==cat5_start & cat28==8 | beginning==cat5_start & cat29==8 | beginning==cat5_start & cat30==8 | beginning==cat5_start & cat31==8 | beginning==cat5_start & cat32==8 | beginning==cat5_start & cat33==8 | beginning==cat5_start & cat34==8 | beginning==cat5_start & cat35==8 | beginning==cat5_start & cat36==8 | beginning==cat5_start & cat37==8 | beginning==cat5_start & cat38==8 | beginning==cat5_start & cat39==8 | beginning==cat5_start & cat40==8 | beginning==cat5_start & cat41==8 | beginning==cat5_start & cat42==8 | beginning==cat5_start & cat43==8 | beginning==cat5_start & cat44==8 | beginning==cat5_start & cat45==8 | beginning==cat5_start & cat46==8 | beginning==cat5_start & cat47==8 | beginning==cat5_start & cat48==8 | beginning==cat5_start & cat49==8 | beginning==cat5_start & cat50==8 | beginning==cat5_start & cat51==8 | beginning==cat5_start & cat52==8 | beginning==cat5_start & cat53==8 | beginning==cat5_start & cat54==8 | beginning==cat5_start & cat55==8 | beginning==cat5_start & cat56==8 | beginning==cat5_start & cat57==8 | beginning==cat5_start & cat58==8 | beginning==cat5_start & cat59==8 | beginning==cat5_start & cat60==8 | beginning==cat5_start & cat61==8 | beginning==cat5_start & cat62==8 | beginning==cat5_start & cat63==8 | beginning==cat5_start & cat64==8 | beginning==cat5_start & cat65==8 | beginning==cat5_start & cat66==8 | beginning==cat5_start & cat67==8 | beginning==cat5_start & cat68==8 | beginning==cat5_start & cat69==8 | beginning==cat5_start & cat70==8 | beginning==cat5_start & cat71==8 | beginning==cat5_start & cat72==8 | beginning==cat5_start & cat73==8 | beginning==cat5_start & cat74==8 | beginning==cat5_start & cat75==8 | beginning==cat5_start & cat76==8 | beginning==cat5_start & cat77==8 | beginning==cat5_start & cat78==8 | beginning==cat5_start & cat79==8 | beginning==cat5_start & cat80==8 | beginning==cat5_start & cat81==8 | beginning==cat5_start & cat82==8 | beginning==cat5_start & cat83==8 | beginning==cat5_start & cat84==8 | beginning==cat5_start & cat85==8 | beginning==cat5_start & cat86==8 | beginning==cat5_start & cat87==8 | beginning==cat5_start & cat88==8
replace indicator=0 if beginning==cat5_start & indicator==.
replace indicator=1 if beginning==cat6_start & cat7==8 | beginning==cat6_start & cat8==8 | beginning==cat6_start & cat9==8 | beginning==cat6_start & cat10==8 | beginning==cat6_start & cat11==8 | beginning==cat6_start & cat12==8 | beginning==cat6_start & cat13==8 | beginning==cat6_start & cat14==8 | beginning==cat6_start & cat15==8 | beginning==cat6_start & cat16==8 | beginning==cat6_start & cat17==8 | beginning==cat6_start & cat18==8 | beginning==cat6_start & cat19==8 | beginning==cat6_start & cat20==8 | beginning==cat6_start & cat21==8 | beginning==cat6_start & cat22==8 | beginning==cat6_start & cat23==8 | beginning==cat6_start & cat24==8 | beginning==cat6_start & cat25==8 | beginning==cat6_start & cat26==8 | beginning==cat6_start & cat27==8 | beginning==cat6_start & cat28==8 | beginning==cat6_start & cat29==8 | beginning==cat6_start & cat30==8 | beginning==cat6_start & cat31==8 | beginning==cat6_start & cat32==8 | beginning==cat6_start & cat33==8 | beginning==cat6_start & cat34==8 | beginning==cat6_start & cat35==8 | beginning==cat6_start & cat36==8 | beginning==cat6_start & cat37==8 | beginning==cat6_start & cat38==8 | beginning==cat6_start & cat39==8 | beginning==cat6_start & cat40==8 | beginning==cat6_start & cat41==8 | beginning==cat6_start & cat42==8 | beginning==cat6_start & cat43==8 | beginning==cat6_start & cat44==8 | beginning==cat6_start & cat45==8 | beginning==cat6_start & cat46==8 | beginning==cat6_start & cat47==8 | beginning==cat6_start & cat48==8 | beginning==cat6_start & cat49==8 | beginning==cat6_start & cat50==8 | beginning==cat6_start & cat51==8 | beginning==cat6_start & cat52==8 | beginning==cat6_start & cat53==8 | beginning==cat6_start & cat54==8 | beginning==cat6_start & cat55==8 | beginning==cat6_start & cat56==8 | beginning==cat6_start & cat57==8 | beginning==cat6_start & cat58==8 | beginning==cat6_start & cat59==8 | beginning==cat6_start & cat60==8 | beginning==cat6_start & cat61==8 | beginning==cat6_start & cat62==8 | beginning==cat6_start & cat63==8 | beginning==cat6_start & cat64==8 | beginning==cat6_start & cat65==8 | beginning==cat6_start & cat66==8 | beginning==cat6_start & cat67==8 | beginning==cat6_start & cat68==8 | beginning==cat6_start & cat69==8 | beginning==cat6_start & cat70==8 | beginning==cat6_start & cat71==8 | beginning==cat6_start & cat72==8 | beginning==cat6_start & cat73==8 | beginning==cat6_start & cat74==8 | beginning==cat6_start & cat75==8 | beginning==cat6_start & cat76==8 | beginning==cat6_start & cat77==8 | beginning==cat6_start & cat78==8 | beginning==cat6_start & cat79==8 | beginning==cat6_start & cat80==8 | beginning==cat6_start & cat81==8 | beginning==cat6_start & cat82==8 | beginning==cat6_start & cat83==8 | beginning==cat6_start & cat84==8 | beginning==cat6_start & cat85==8 | beginning==cat6_start & cat86==8 | beginning==cat6_start & cat87==8 | beginning==cat6_start & cat88==8
replace indicator=0 if beginning==cat6_start & indicator==.
replace indicator=1 if beginning==cat7_start & cat8==8 | beginning==cat7_start & cat9==8 | beginning==cat7_start & cat10==8 | beginning==cat7_start & cat11==8 | beginning==cat7_start & cat12==8 | beginning==cat7_start & cat13==8 | beginning==cat7_start & cat14==8 | beginning==cat7_start & cat15==8 | beginning==cat7_start & cat16==8 | beginning==cat7_start & cat17==8 | beginning==cat7_start & cat18==8 | beginning==cat7_start & cat19==8 | beginning==cat7_start & cat20==8 | beginning==cat7_start & cat21==8 | beginning==cat7_start & cat22==8 | beginning==cat7_start & cat23==8 | beginning==cat7_start & cat24==8 | beginning==cat7_start & cat25==8 | beginning==cat7_start & cat26==8 | beginning==cat7_start & cat27==8 | beginning==cat7_start & cat28==8 | beginning==cat7_start & cat29==8 | beginning==cat7_start & cat30==8 | beginning==cat7_start & cat31==8 | beginning==cat7_start & cat32==8 | beginning==cat7_start & cat33==8 | beginning==cat7_start & cat34==8 | beginning==cat7_start & cat35==8 | beginning==cat7_start & cat36==8 | beginning==cat7_start & cat37==8 | beginning==cat7_start & cat38==8 | beginning==cat7_start & cat39==8 | beginning==cat7_start & cat40==8 | beginning==cat7_start & cat41==8 | beginning==cat7_start & cat42==8 | beginning==cat7_start & cat43==8 | beginning==cat7_start & cat44==8 | beginning==cat7_start & cat45==8 | beginning==cat7_start & cat46==8 | beginning==cat7_start & cat47==8 | beginning==cat7_start & cat48==8 | beginning==cat7_start & cat49==8 | beginning==cat7_start & cat50==8 | beginning==cat7_start & cat51==8 | beginning==cat7_start & cat52==8 | beginning==cat7_start & cat53==8 | beginning==cat7_start & cat54==8 | beginning==cat7_start & cat55==8 | beginning==cat7_start & cat56==8 | beginning==cat7_start & cat57==8 | beginning==cat7_start & cat58==8 | beginning==cat7_start & cat59==8 | beginning==cat7_start & cat60==8 | beginning==cat7_start & cat61==8 | beginning==cat7_start & cat62==8 | beginning==cat7_start & cat63==8 | beginning==cat7_start & cat64==8 | beginning==cat7_start & cat65==8 | beginning==cat7_start & cat66==8 | beginning==cat7_start & cat67==8 | beginning==cat7_start & cat68==8 | beginning==cat7_start & cat69==8 | beginning==cat7_start & cat70==8 | beginning==cat7_start & cat71==8 | beginning==cat7_start & cat72==8 | beginning==cat7_start & cat73==8 | beginning==cat7_start & cat74==8 | beginning==cat7_start & cat75==8 | beginning==cat7_start & cat76==8 | beginning==cat7_start & cat77==8 | beginning==cat7_start & cat78==8 | beginning==cat7_start & cat79==8 | beginning==cat7_start & cat80==8 | beginning==cat7_start & cat81==8 | beginning==cat7_start & cat82==8 | beginning==cat7_start & cat83==8 | beginning==cat7_start & cat84==8 | beginning==cat7_start & cat85==8 | beginning==cat7_start & cat86==8 | beginning==cat7_start & cat87==8 | beginning==cat7_start & cat88==8
replace indicator=0 if beginning==cat7_start & indicator==.
replace indicator=1 if beginning==cat8_start & cat9==8 | beginning==cat8_start & cat10==8 | beginning==cat8_start & cat11==8 | beginning==cat8_start & cat12==8 | beginning==cat8_start & cat13==8 | beginning==cat8_start & cat14==8 | beginning==cat8_start & cat15==8 | beginning==cat8_start & cat16==8 | beginning==cat8_start & cat17==8 | beginning==cat8_start & cat18==8 | beginning==cat8_start & cat19==8 | beginning==cat8_start & cat20==8 | beginning==cat8_start & cat21==8 | beginning==cat8_start & cat22==8 | beginning==cat8_start & cat23==8 | beginning==cat8_start & cat24==8 | beginning==cat8_start & cat25==8 | beginning==cat8_start & cat26==8 | beginning==cat8_start & cat27==8 | beginning==cat8_start & cat28==8 | beginning==cat8_start & cat29==8 | beginning==cat8_start & cat30==8 | beginning==cat8_start & cat31==8 | beginning==cat8_start & cat32==8 | beginning==cat8_start & cat33==8 | beginning==cat8_start & cat34==8 | beginning==cat8_start & cat35==8 | beginning==cat8_start & cat36==8 | beginning==cat8_start & cat37==8 | beginning==cat8_start & cat38==8 | beginning==cat8_start & cat39==8 | beginning==cat8_start & cat40==8 | beginning==cat8_start & cat41==8 | beginning==cat8_start & cat42==8 | beginning==cat8_start & cat43==8 | beginning==cat8_start & cat44==8 | beginning==cat8_start & cat45==8 | beginning==cat8_start & cat46==8 | beginning==cat8_start & cat47==8 | beginning==cat8_start & cat48==8 | beginning==cat8_start & cat49==8 | beginning==cat8_start & cat50==8 | beginning==cat8_start & cat51==8 | beginning==cat8_start & cat52==8 | beginning==cat8_start & cat53==8 | beginning==cat8_start & cat54==8 | beginning==cat8_start & cat55==8 | beginning==cat8_start & cat56==8 | beginning==cat8_start & cat57==8 | beginning==cat8_start & cat58==8 | beginning==cat8_start & cat59==8 | beginning==cat8_start & cat60==8 | beginning==cat8_start & cat61==8 | beginning==cat8_start & cat62==8 | beginning==cat8_start & cat63==8 | beginning==cat8_start & cat64==8 | beginning==cat8_start & cat65==8 | beginning==cat8_start & cat66==8 | beginning==cat8_start & cat67==8 | beginning==cat8_start & cat68==8 | beginning==cat8_start & cat69==8 | beginning==cat8_start & cat70==8 | beginning==cat8_start & cat71==8 | beginning==cat8_start & cat72==8 | beginning==cat8_start & cat73==8 | beginning==cat8_start & cat74==8 | beginning==cat8_start & cat75==8 | beginning==cat8_start & cat76==8 | beginning==cat8_start & cat77==8 | beginning==cat8_start & cat78==8 | beginning==cat8_start & cat79==8 | beginning==cat8_start & cat80==8 | beginning==cat8_start & cat81==8 | beginning==cat8_start & cat82==8 | beginning==cat8_start & cat83==8 | beginning==cat8_start & cat84==8 | beginning==cat8_start & cat85==8 | beginning==cat8_start & cat86==8 | beginning==cat8_start & cat87==8 | beginning==cat8_start & cat88==8
replace indicator=0 if beginning==cat8_start & indicator==.
replace indicator=0 if beginning==end
replace indicator=1 if beginning==cat9_start & cat10==8 | beginning==cat9_start & cat11==8 | beginning==cat9_start & cat12==8 | beginning==cat9_start & cat13==8 | beginning==cat9_start & cat14==8 | beginning==cat9_start & cat15==8 | beginning==cat9_start & cat16==8 | beginning==cat9_start & cat17==8 | beginning==cat9_start & cat18==8 | beginning==cat9_start & cat19==8 | beginning==cat9_start & cat20==8 | beginning==cat9_start & cat21==8 | beginning==cat9_start & cat22==8 | beginning==cat9_start & cat23==8 | beginning==cat9_start & cat24==8 | beginning==cat9_start & cat25==8 | beginning==cat9_start & cat26==8 | beginning==cat9_start & cat27==8 | beginning==cat9_start & cat28==8 | beginning==cat9_start & cat29==8 | beginning==cat9_start & cat30==8 | beginning==cat9_start & cat31==8 | beginning==cat9_start & cat32==8 | beginning==cat9_start & cat33==8 | beginning==cat9_start & cat34==8 | beginning==cat9_start & cat35==8 | beginning==cat9_start & cat36==8 | beginning==cat9_start & cat37==8 | beginning==cat9_start & cat38==8 | beginning==cat9_start & cat39==8 | beginning==cat9_start & cat40==8 | beginning==cat9_start & cat41==8 | beginning==cat9_start & cat42==8 | beginning==cat9_start & cat43==8 | beginning==cat9_start & cat44==8 | beginning==cat9_start & cat45==8 | beginning==cat9_start & cat46==8 | beginning==cat9_start & cat47==8 | beginning==cat9_start & cat48==8 | beginning==cat9_start & cat49==8 | beginning==cat9_start & cat50==8 | beginning==cat9_start & cat51==8 | beginning==cat9_start & cat52==8 | beginning==cat9_start & cat53==8 | beginning==cat9_start & cat54==8 | beginning==cat9_start & cat55==8 | beginning==cat9_start & cat56==8 | beginning==cat9_start & cat57==8 | beginning==cat9_start & cat58==8 | beginning==cat9_start & cat59==8 | beginning==cat9_start & cat60==8 | beginning==cat9_start & cat61==8 | beginning==cat9_start & cat62==8 | beginning==cat9_start & cat63==8 | beginning==cat9_start & cat64==8 | beginning==cat9_start & cat65==8 | beginning==cat9_start & cat66==8 | beginning==cat9_start & cat67==8 | beginning==cat9_start & cat68==8 | beginning==cat9_start & cat69==8 | beginning==cat9_start & cat70==8 | beginning==cat9_start & cat71==8 | beginning==cat9_start & cat72==8 | beginning==cat9_start & cat73==8 | beginning==cat9_start & cat74==8 | beginning==cat9_start & cat75==8 | beginning==cat9_start & cat76==8 | beginning==cat9_start & cat77==8 | beginning==cat9_start & cat78==8 | beginning==cat9_start & cat79==8 | beginning==cat9_start & cat80==8 | beginning==cat9_start & cat81==8 | beginning==cat9_start & cat82==8 | beginning==cat9_start & cat83==8 | beginning==cat9_start & cat84==8 | beginning==cat9_start & cat85==8 | beginning==cat9_start & cat86==8 | beginning==cat9_start & cat87==8 | beginning==cat9_start & cat88==8
replace indicator=0 if beginning==cat9_start & indicator==.
replace indicator=1 if beginning==cat10_start & cat11==8 | beginning==cat10_start & cat12==8 | beginning==cat10_start & cat13==8 | beginning==cat10_start & cat14==8 | beginning==cat10_start & cat15==8 | beginning==cat10_start & cat16==8 | beginning==cat10_start & cat17==8 | beginning==cat10_start & cat18==8 | beginning==cat10_start & cat19==8 | beginning==cat10_start & cat20==8 | beginning==cat10_start & cat21==8 | beginning==cat10_start & cat22==8 | beginning==cat10_start & cat23==8 | beginning==cat10_start & cat24==8 | beginning==cat10_start & cat25==8 | beginning==cat10_start & cat26==8 | beginning==cat10_start & cat27==8 | beginning==cat10_start & cat28==8 | beginning==cat10_start & cat29==8 | beginning==cat10_start & cat30==8 | beginning==cat10_start & cat31==8 | beginning==cat10_start & cat32==8 | beginning==cat10_start & cat33==8 | beginning==cat10_start & cat34==8 | beginning==cat10_start & cat35==8 | beginning==cat10_start & cat36==8 | beginning==cat10_start & cat37==8 | beginning==cat10_start & cat38==8 | beginning==cat10_start & cat39==8 | beginning==cat10_start & cat40==8 | beginning==cat10_start & cat41==8 | beginning==cat10_start & cat42==8 | beginning==cat10_start & cat43==8 | beginning==cat10_start & cat44==8 | beginning==cat10_start & cat45==8 | beginning==cat10_start & cat46==8 | beginning==cat10_start & cat47==8 | beginning==cat10_start & cat48==8 | beginning==cat10_start & cat49==8 | beginning==cat10_start & cat50==8 | beginning==cat10_start & cat51==8 | beginning==cat10_start & cat52==8 | beginning==cat10_start & cat53==8 | beginning==cat10_start & cat54==8 | beginning==cat10_start & cat55==8 | beginning==cat10_start & cat56==8 | beginning==cat10_start & cat57==8 | beginning==cat10_start & cat58==8 | beginning==cat10_start & cat59==8 | beginning==cat10_start & cat60==8 | beginning==cat10_start & cat61==8 | beginning==cat10_start & cat62==8 | beginning==cat10_start & cat63==8 | beginning==cat10_start & cat64==8 | beginning==cat10_start & cat65==8 | beginning==cat10_start & cat66==8 | beginning==cat10_start & cat67==8 | beginning==cat10_start & cat68==8 | beginning==cat10_start & cat69==8 | beginning==cat10_start & cat70==8 | beginning==cat10_start & cat71==8 | beginning==cat10_start & cat72==8 | beginning==cat10_start & cat73==8 | beginning==cat10_start & cat74==8 | beginning==cat10_start & cat75==8 | beginning==cat10_start & cat76==8 | beginning==cat10_start & cat77==8 | beginning==cat10_start & cat78==8 | beginning==cat10_start & cat79==8 | beginning==cat10_start & cat80==8 | beginning==cat10_start & cat81==8 | beginning==cat10_start & cat82==8 | beginning==cat10_start & cat83==8 | beginning==cat10_start & cat84==8 | beginning==cat10_start & cat85==8 | beginning==cat10_start & cat86==8 | beginning==cat10_start & cat87==8 | beginning==cat10_start & cat88==8
replace indicator=0 if beginning==cat10_start & indicator==.
replace indicator=1 if beginning==cat11_start & cat12==8 | beginning==cat11_start & cat13==8 | beginning==cat11_start & cat14==8 | beginning==cat11_start & cat15==8 | beginning==cat11_start & cat16==8 | beginning==cat11_start & cat17==8 | beginning==cat11_start & cat18==8 | beginning==cat11_start & cat19==8 | beginning==cat11_start & cat20==8 | beginning==cat11_start & cat21==8 | beginning==cat11_start & cat22==8 | beginning==cat11_start & cat23==8 | beginning==cat11_start & cat24==8 | beginning==cat11_start & cat25==8 | beginning==cat11_start & cat26==8 | beginning==cat11_start & cat27==8 | beginning==cat11_start & cat28==8 | beginning==cat11_start & cat29==8 | beginning==cat11_start & cat30==8 | beginning==cat11_start & cat31==8 | beginning==cat11_start & cat32==8 | beginning==cat11_start & cat33==8 | beginning==cat11_start & cat34==8 | beginning==cat11_start & cat35==8 | beginning==cat11_start & cat36==8 | beginning==cat11_start & cat37==8 | beginning==cat11_start & cat38==8 | beginning==cat11_start & cat39==8 | beginning==cat11_start & cat40==8 | beginning==cat11_start & cat41==8 | beginning==cat11_start & cat42==8 | beginning==cat11_start & cat43==8 | beginning==cat11_start & cat44==8 | beginning==cat11_start & cat45==8 | beginning==cat11_start & cat46==8 | beginning==cat11_start & cat47==8 | beginning==cat11_start & cat48==8 | beginning==cat11_start & cat49==8 | beginning==cat11_start & cat50==8 | beginning==cat11_start & cat51==8 | beginning==cat11_start & cat52==8 | beginning==cat11_start & cat53==8 | beginning==cat11_start & cat54==8 | beginning==cat11_start & cat55==8 | beginning==cat11_start & cat56==8 | beginning==cat11_start & cat57==8 | beginning==cat11_start & cat58==8 | beginning==cat11_start & cat59==8 | beginning==cat11_start & cat60==8 | beginning==cat11_start & cat61==8 | beginning==cat11_start & cat62==8 | beginning==cat11_start & cat63==8 | beginning==cat11_start & cat64==8 | beginning==cat11_start & cat65==8 | beginning==cat11_start & cat66==8 | beginning==cat11_start & cat67==8 | beginning==cat11_start & cat68==8 | beginning==cat11_start & cat69==8 | beginning==cat11_start & cat70==8 | beginning==cat11_start & cat71==8 | beginning==cat11_start & cat72==8 | beginning==cat11_start & cat73==8 | beginning==cat11_start & cat74==8 | beginning==cat11_start & cat75==8 | beginning==cat11_start & cat76==8 | beginning==cat11_start & cat77==8 | beginning==cat11_start & cat78==8 | beginning==cat11_start & cat79==8 | beginning==cat11_start & cat80==8 | beginning==cat11_start & cat81==8 | beginning==cat11_start & cat82==8 | beginning==cat11_start & cat83==8 | beginning==cat11_start & cat84==8 | beginning==cat11_start & cat85==8 | beginning==cat11_start & cat86==8 | beginning==cat11_start & cat87==8 | beginning==cat11_start & cat88==8
replace indicator=0 if beginning==cat11_start & indicator==.
replace indicator=1 if beginning==cat12_start & cat13==8 | beginning==cat12_start & cat14==8 | beginning==cat12_start & cat15==8 | beginning==cat12_start & cat16==8 | beginning==cat12_start & cat17==8 | beginning==cat12_start & cat18==8 | beginning==cat12_start & cat19==8 | beginning==cat12_start & cat20==8 | beginning==cat12_start & cat21==8 | beginning==cat12_start & cat22==8 | beginning==cat12_start & cat23==8 | beginning==cat12_start & cat24==8 | beginning==cat12_start & cat25==8 | beginning==cat12_start & cat26==8 | beginning==cat12_start & cat27==8 | beginning==cat12_start & cat28==8 | beginning==cat12_start & cat29==8 | beginning==cat12_start & cat30==8 | beginning==cat12_start & cat31==8 | beginning==cat12_start & cat32==8 | beginning==cat12_start & cat33==8 | beginning==cat12_start & cat34==8 | beginning==cat12_start & cat35==8 | beginning==cat12_start & cat36==8 | beginning==cat12_start & cat37==8 | beginning==cat12_start & cat38==8 | beginning==cat12_start & cat39==8 | beginning==cat12_start & cat40==8 | beginning==cat12_start & cat41==8 | beginning==cat12_start & cat42==8 | beginning==cat12_start & cat43==8 | beginning==cat12_start & cat44==8 | beginning==cat12_start & cat45==8 | beginning==cat12_start & cat46==8 | beginning==cat12_start & cat47==8 | beginning==cat12_start & cat48==8 | beginning==cat12_start & cat49==8 | beginning==cat12_start & cat50==8 | beginning==cat12_start & cat51==8 | beginning==cat12_start & cat52==8 | beginning==cat12_start & cat53==8 | beginning==cat12_start & cat54==8 | beginning==cat12_start & cat55==8 | beginning==cat12_start & cat56==8 | beginning==cat12_start & cat57==8 | beginning==cat12_start & cat58==8 | beginning==cat12_start & cat59==8 | beginning==cat12_start & cat60==8 | beginning==cat12_start & cat61==8 | beginning==cat12_start & cat62==8 | beginning==cat12_start & cat63==8 | beginning==cat12_start & cat64==8 | beginning==cat12_start & cat65==8 | beginning==cat12_start & cat66==8 | beginning==cat12_start & cat67==8 | beginning==cat12_start & cat68==8 | beginning==cat12_start & cat69==8 | beginning==cat12_start & cat70==8 | beginning==cat12_start & cat71==8 | beginning==cat12_start & cat72==8 | beginning==cat12_start & cat73==8 | beginning==cat12_start & cat74==8 | beginning==cat12_start & cat75==8 | beginning==cat12_start & cat76==8 | beginning==cat12_start & cat77==8 | beginning==cat12_start & cat78==8 | beginning==cat12_start & cat79==8 | beginning==cat12_start & cat80==8 | beginning==cat12_start & cat81==8 | beginning==cat12_start & cat82==8 | beginning==cat12_start & cat83==8 | beginning==cat12_start & cat84==8 | beginning==cat12_start & cat85==8 | beginning==cat12_start & cat86==8 | beginning==cat12_start & cat87==8 | beginning==cat12_start & cat88==8
replace indicator=0 if beginning==cat12_start & indicator==.
replace indicator=1 if beginning==cat13_start & cat14==8 | beginning==cat13_start & cat15==8 | beginning==cat13_start & cat16==8 | beginning==cat13_start & cat17==8 | beginning==cat13_start & cat18==8 | beginning==cat13_start & cat19==8 | beginning==cat13_start & cat20==8 | beginning==cat13_start & cat21==8 | beginning==cat13_start & cat22==8 | beginning==cat13_start & cat23==8 | beginning==cat13_start & cat24==8 | beginning==cat13_start & cat25==8 | beginning==cat13_start & cat26==8 | beginning==cat13_start & cat27==8 | beginning==cat13_start & cat28==8 | beginning==cat13_start & cat29==8 | beginning==cat13_start & cat30==8 | beginning==cat13_start & cat31==8 | beginning==cat13_start & cat32==8 | beginning==cat13_start & cat33==8 | beginning==cat13_start & cat34==8 | beginning==cat13_start & cat35==8 | beginning==cat13_start & cat36==8 | beginning==cat13_start & cat37==8 | beginning==cat13_start & cat38==8 | beginning==cat13_start & cat39==8 | beginning==cat13_start & cat40==8 | beginning==cat13_start & cat41==8 | beginning==cat13_start & cat42==8 | beginning==cat13_start & cat43==8 | beginning==cat13_start & cat44==8 | beginning==cat13_start & cat45==8 | beginning==cat13_start & cat46==8 | beginning==cat13_start & cat47==8 | beginning==cat13_start & cat48==8 | beginning==cat13_start & cat49==8 | beginning==cat13_start & cat50==8 | beginning==cat13_start & cat51==8 | beginning==cat13_start & cat52==8 | beginning==cat13_start & cat53==8 | beginning==cat13_start & cat54==8 | beginning==cat13_start & cat55==8 | beginning==cat13_start & cat56==8 | beginning==cat13_start & cat57==8 | beginning==cat13_start & cat58==8 | beginning==cat13_start & cat59==8 | beginning==cat13_start & cat60==8 | beginning==cat13_start & cat61==8 | beginning==cat13_start & cat62==8 | beginning==cat13_start & cat63==8 | beginning==cat13_start & cat64==8 | beginning==cat13_start & cat65==8 | beginning==cat13_start & cat66==8 | beginning==cat13_start & cat67==8 | beginning==cat13_start & cat68==8 | beginning==cat13_start & cat69==8 | beginning==cat13_start & cat70==8 | beginning==cat13_start & cat71==8 | beginning==cat13_start & cat72==8 | beginning==cat13_start & cat73==8 | beginning==cat13_start & cat74==8 | beginning==cat13_start & cat75==8 | beginning==cat13_start & cat76==8 | beginning==cat13_start & cat77==8 | beginning==cat13_start & cat78==8 | beginning==cat13_start & cat79==8 | beginning==cat13_start & cat80==8 | beginning==cat13_start & cat81==8 | beginning==cat13_start & cat82==8 | beginning==cat13_start & cat83==8 | beginning==cat13_start & cat84==8 | beginning==cat13_start & cat85==8 | beginning==cat13_start & cat86==8 | beginning==cat13_start & cat87==8 | beginning==cat13_start & cat88==8
replace indicator=0 if beginning==cat13_start & indicator==.
replace indicator=1 if beginning==cat14_start & cat15==8 | beginning==cat14_start & cat16==8 | beginning==cat14_start & cat17==8 | beginning==cat14_start & cat18==8 | beginning==cat14_start & cat19==8 | beginning==cat14_start & cat20==8 | beginning==cat14_start & cat21==8 | beginning==cat14_start & cat22==8 | beginning==cat14_start & cat23==8 | beginning==cat14_start & cat24==8 | beginning==cat14_start & cat25==8 | beginning==cat14_start & cat26==8 | beginning==cat14_start & cat27==8 | beginning==cat14_start & cat28==8 | beginning==cat14_start & cat29==8 | beginning==cat14_start & cat30==8 | beginning==cat14_start & cat31==8 | beginning==cat14_start & cat32==8 | beginning==cat14_start & cat33==8 | beginning==cat14_start & cat34==8 | beginning==cat14_start & cat35==8 | beginning==cat14_start & cat36==8 | beginning==cat14_start & cat37==8 | beginning==cat14_start & cat38==8 | beginning==cat14_start & cat39==8 | beginning==cat14_start & cat40==8 | beginning==cat14_start & cat41==8 | beginning==cat14_start & cat42==8 | beginning==cat14_start & cat43==8 | beginning==cat14_start & cat44==8 | beginning==cat14_start & cat45==8 | beginning==cat14_start & cat46==8 | beginning==cat14_start & cat47==8 | beginning==cat14_start & cat48==8 | beginning==cat14_start & cat49==8 | beginning==cat14_start & cat50==8 | beginning==cat14_start & cat51==8 | beginning==cat14_start & cat52==8 | beginning==cat14_start & cat53==8 | beginning==cat14_start & cat54==8 | beginning==cat14_start & cat55==8 | beginning==cat14_start & cat56==8 | beginning==cat14_start & cat57==8 | beginning==cat14_start & cat58==8 | beginning==cat14_start & cat59==8 | beginning==cat14_start & cat60==8 | beginning==cat14_start & cat61==8 | beginning==cat14_start & cat62==8 | beginning==cat14_start & cat63==8 | beginning==cat14_start & cat64==8 | beginning==cat14_start & cat65==8 | beginning==cat14_start & cat66==8 | beginning==cat14_start & cat67==8 | beginning==cat14_start & cat68==8 | beginning==cat14_start & cat69==8 | beginning==cat14_start & cat70==8 | beginning==cat14_start & cat71==8 | beginning==cat14_start & cat72==8 | beginning==cat14_start & cat73==8 | beginning==cat14_start & cat74==8 | beginning==cat14_start & cat75==8 | beginning==cat14_start & cat76==8 | beginning==cat14_start & cat77==8 | beginning==cat14_start & cat78==8 | beginning==cat14_start & cat79==8 | beginning==cat14_start & cat80==8 | beginning==cat14_start & cat81==8 | beginning==cat14_start & cat82==8 | beginning==cat14_start & cat83==8 | beginning==cat14_start & cat84==8 | beginning==cat14_start & cat85==8 | beginning==cat14_start & cat86==8 | beginning==cat14_start & cat87==8 | beginning==cat14_start & cat88==8
replace indicator=0 if beginning==cat14_start & indicator==.
replace indicator=0 if beginning==cat15_start & cat16==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==.
replace indicator=1 if beginning==cat15_start & cat16==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat16_start & cat17==.
replace indicator=1 if beginning==cat16_start & cat17==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18==.
replace indicator=1 if beginning==cat17_start & cat18==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==.
replace indicator=0 if beginning==cat18_start & cat19==.
replace indicator=1 if beginning==cat18_start & cat19==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21==.
replace indicator=1 if beginning==cat19_start & cat20==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat21_start & cat22==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31==.
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat24_start & cat25==.
replace indicator=0 if beginning==cat39_start & cat73!=8 & cat74==.
replace indicator=1 if beginning==cat48_start & cat49==8
replace indicator=1 if beginning==cat50_start & cat51==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==.
replace indicator=1 if beginning==cat25_start & cat26==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==.
replace indicator=0 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==.
replace indicator=1 if beginning==cat21_start & cat22==8
replace indicator=1 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat46_start & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52==.
replace indicator=0 if beginning==cat36_start & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49==.
replace indicator=0 if beginning==cat24_start & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat53_start & cat54==.
replace indicator=0 if beginning==cat34_start & cat35!=8 & cat36!=8 & cat37!=8 & cat38==.
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30!=8 & cat31!=8 & cat32==.
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat53_start & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58!=8 & cat59!=8 & cat60!=8 & cat61!=8 & cat62!=8 & cat63!=8 & cat64!=8 & cat65!=8 & cat66!=8 & cat67!=8 & cat68==.
replace indicator=1 if beginning==cat20_start & cat21==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45==.
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36==.
replace indicator=0 if beginning==cat29_start & cat30==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36==.
replace indicator=1 if beginning==cat17_start & cat18!=8 & cat19==8
replace indicator=1 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52!=8 & cat53!=8 & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58==.
replace indicator=0 if beginning==cat37_start & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48==.
replace indicator=0 if beginning==cat52_start & cat53==.
replace indicator=1 if beginning==cat20_start & cat21!=8 & cat22==8

tab indicator,m
* Drop individuals that are not in the risk set
drop if indicator==0
drop indicator

* Construct the 'beginning' variable
gen beginning2 = .
replace beginning2 = cat3_start if beginning==cat2_start & cat3==8
order folio_n20 beginning beginning2
replace beginning2 = cat4_start if beginning==cat2_start & cat3!=8 & cat4==8
replace beginning2 = cat5_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat19_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat4_start if beginning==cat3_start & cat4==8
replace beginning2 = cat5_start if beginning==cat3_start & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat22_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat26_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==8
replace beginning2 = cat5_start if beginning==cat4_start & cat5==8
replace beginning2 = cat6_start if beginning==cat4_start & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat16_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat6_start if beginning==cat5_start & cat6==8
replace beginning2 = cat7_start if beginning==cat5_start & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat22_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat7_start if beginning==cat6_start & cat7==8
replace beginning2 = cat8_start if beginning==cat6_start & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat23_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat24_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat8_start if beginning==cat7_start & cat8==8
replace beginning2 = cat9_start if beginning==cat7_start & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat20_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat21_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat9_start if beginning==cat8_start & cat9==8
replace beginning2 = cat10_start if beginning==cat8_start & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat10_start if beginning==cat9_start & cat10==8
replace beginning2 = cat11_start if beginning==cat9_start & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat11_start if beginning==cat10_start & cat11==8
replace beginning2 = cat12_start if beginning==cat10_start & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat12_start if beginning==cat11_start & cat12==8
replace beginning2 = cat13_start if beginning==cat11_start & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat13_start if beginning==cat12_start & cat13==8
replace beginning2 = cat14_start if beginning==cat12_start & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat21_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat14_start if beginning==cat13_start & cat14==8
replace beginning2 = cat15_start if beginning==cat13_start & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat15_start if beginning==cat14_start & cat15==8
replace beginning2 = cat16_start if beginning==cat14_start & cat15!=8 & cat16==8
replace beginning2 = cat16_start if beginning==cat15_start & cat16==8
replace beginning2 = cat17_start if beginning==cat15_start & cat16!=8 & cat17==8
replace beginning2 = cat17_start if beginning==cat16_start & cat17==8
replace beginning2 = cat18_start if beginning==cat17_start & cat18==8
replace beginning2 = cat19_start if beginning==cat18_start & cat19==8
replace beginning2 = cat20_start if beginning==cat19_start & cat20==8
replace beginning2 = cat25_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==8
replace beginning2 = cat35_start if beginning==cat32_start & cat33!=8 & cat34!=8 & cat35==8
replace beginning2 = cat18_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat17_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat20_start if beginning==cat18_start & cat19!=8 & cat20==8
replace beginning2 = cat26_start if beginning==cat25_start & cat26==8
replace beginning2 = cat49_start if beginning==cat48_start & cat49==8
replace beginning2 = cat51_start if beginning==cat50_start & cat51==8
replace beginning2 = cat22_start if beginning==cat21_start & cat22==8
replace beginning2 = cat30_start if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace beginning2 = cat18_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat16_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat16_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat20_start & cat21==8
replace beginning2 = cat19_start if beginning==cat17_start & cat18!=8 & cat19==8
replace beginning2 = cat23_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat22_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat17_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat20_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat22_start if beginning==cat20_start & cat21!=8 & cat22==8
replace beginning2 = cat23_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8

* Make sure that there are no missings
tab beginning2,m
drop beginning
rename beginning2 beginning

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat3_start & cat4==1
order event,after(folio_n20)
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=0 if beginning==cat29_start & cat30==.
replace event=3 if beginning==cat48_start & cat49==3
replace event=4 if beginning==cat26_start & cat27==4
replace event=6 if beginning==cat27_start & cat28==6
replace event=5 if beginning==cat35_start & cat36==5
replace event=0 if beginning==cat30_start & cat31==.
replace event=8 if beginning==cat49_start & cat50==9
replace event=6 if beginning==cat51_start & cat52==6
replace event=6 if beginning==cat26_start & cat27==6
replace event=9 if beginning==cat26_start & cat27==10

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat52_start - beginning if beginning==cat51_start & cat52!=8 & cat52!=.

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC2_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =2

* Define the education variable
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling4 if beginning==cat4_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling10 if beginning==cat10_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling12 if beginning==cat12_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079)
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC2_informal", replace

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 3: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load the dataset for analysis
clear
use "$resultdir\sample_RC2_informal"

drop event
replace beginning=beginning+duration
drop duration

* Create risk set: individuals that are in RC informal of order 3 across multiple categories
gen indicator = .  // Initialize the variable
replace indicator=1 if beginning==cat2_start & cat3==8 | beginning==cat2_start & cat4==8 | beginning==cat2_start & cat5==8 | beginning==cat2_start & cat6==8 | beginning==cat2_start & cat7==8 | beginning==cat2_start & cat8==8 | beginning==cat2_start & cat9==8 | beginning==cat2_start & cat10==8 | beginning==cat2_start & cat11==8 | beginning==cat2_start & cat12==8 | beginning==cat2_start & cat13==8 | beginning==cat2_start & cat14==8 | beginning==cat2_start & cat15==8 | beginning==cat2_start & cat16==8 | beginning==cat2_start & cat17==8 | beginning==cat2_start & cat18==8 | beginning==cat2_start & cat19==8 | beginning==cat2_start & cat20==8 | beginning==cat2_start & cat21==8 | beginning==cat2_start & cat22==8 | beginning==cat2_start & cat23==8 | beginning==cat2_start & cat24==8 | beginning==cat2_start & cat25==8 | beginning==cat2_start & cat26==8 | beginning==cat2_start & cat27==8 | beginning==cat2_start & cat28==8 | beginning==cat2_start & cat29==8 | beginning==cat2_start & cat30==8 | beginning==cat2_start & cat31==8 | beginning==cat2_start & cat32==8 | beginning==cat2_start & cat33==8 | beginning==cat2_start & cat34==8 | beginning==cat2_start & cat35==8 | beginning==cat2_start & cat36==8 | beginning==cat2_start & cat37==8 | beginning==cat2_start & cat38==8 | beginning==cat2_start & cat39==8 | beginning==cat2_start & cat40==8 | beginning==cat2_start & cat41==8 | beginning==cat2_start & cat42==8 | beginning==cat2_start & cat43==8 | beginning==cat2_start & cat44==8 | beginning==cat2_start & cat45==8 | beginning==cat2_start & cat46==8 | beginning==cat2_start & cat47==8 | beginning==cat2_start & cat48==8 | beginning==cat2_start & cat49==8 | beginning==cat2_start & cat50==8 | beginning==cat2_start & cat51==8 | beginning==cat2_start & cat52==8 | beginning==cat2_start & cat53==8 | beginning==cat2_start & cat54==8 | beginning==cat2_start & cat55==8 | beginning==cat2_start & cat56==8 | beginning==cat2_start & cat57==8 | beginning==cat2_start & cat58==8 | beginning==cat2_start & cat59==8 | beginning==cat2_start & cat60==8 | beginning==cat2_start & cat61==8 | beginning==cat2_start & cat62==8 | beginning==cat2_start & cat63==8 | beginning==cat2_start & cat64==8 | beginning==cat2_start & cat65==8 | beginning==cat2_start & cat66==8 | beginning==cat2_start & cat67==8 | beginning==cat2_start & cat68==8 | beginning==cat2_start & cat69==8 | beginning==cat2_start & cat70==8 | beginning==cat2_start & cat71==8 | beginning==cat2_start & cat72==8 | beginning==cat2_start & cat73==8 | beginning==cat2_start & cat74==8 | beginning==cat2_start & cat75==8 | beginning==cat2_start & cat76==8 | beginning==cat2_start & cat77==8 | beginning==cat2_start & cat78==8 | beginning==cat2_start & cat79==8 | beginning==cat2_start & cat80==8 | beginning==cat2_start & cat81==8 | beginning==cat2_start & cat82==8 | beginning==cat2_start & cat83==8 | beginning==cat2_start & cat84==8 | beginning==cat2_start & cat85==8 | beginning==cat2_start & cat86==8 | beginning==cat2_start & cat87==8 | beginning==cat2_start & cat88==8
replace indicator=0 if beginning==cat2_start & indicator==.
replace indicator=1 if beginning==cat3_start & cat4==8 | beginning==cat3_start & cat5==8 | beginning==cat3_start & cat6==8 | beginning==cat3_start & cat7==8 | beginning==cat3_start & cat8==8 | beginning==cat3_start & cat9==8 | beginning==cat3_start & cat10==8 | beginning==cat3_start & cat11==8 | beginning==cat3_start & cat12==8 | beginning==cat3_start & cat13==8 | beginning==cat3_start & cat14==8 | beginning==cat3_start & cat15==8 | beginning==cat3_start & cat16==8 | beginning==cat3_start & cat17==8 | beginning==cat3_start & cat18==8 | beginning==cat3_start & cat19==8 | beginning==cat3_start & cat20==8 | beginning==cat3_start & cat21==8 | beginning==cat3_start & cat22==8 | beginning==cat3_start & cat23==8 | beginning==cat3_start & cat24==8 | beginning==cat3_start & cat25==8 | beginning==cat3_start & cat26==8 | beginning==cat3_start & cat27==8 | beginning==cat3_start & cat28==8 | beginning==cat3_start & cat29==8 | beginning==cat3_start & cat30==8 | beginning==cat3_start & cat31==8 | beginning==cat3_start & cat32==8 | beginning==cat3_start & cat33==8 | beginning==cat3_start & cat34==8 | beginning==cat3_start & cat35==8 | beginning==cat3_start & cat36==8 | beginning==cat3_start & cat37==8 | beginning==cat3_start & cat38==8 | beginning==cat3_start & cat39==8 | beginning==cat3_start & cat40==8 | beginning==cat3_start & cat41==8 | beginning==cat3_start & cat42==8 | beginning==cat3_start & cat43==8 | beginning==cat3_start & cat44==8 | beginning==cat3_start & cat45==8 | beginning==cat3_start & cat46==8 | beginning==cat3_start & cat47==8 | beginning==cat3_start & cat48==8 | beginning==cat3_start & cat49==8 | beginning==cat3_start & cat50==8 | beginning==cat3_start & cat51==8 | beginning==cat3_start & cat52==8 | beginning==cat3_start & cat53==8 | beginning==cat3_start & cat54==8 | beginning==cat3_start & cat55==8 | beginning==cat3_start & cat56==8 | beginning==cat3_start & cat57==8 | beginning==cat3_start & cat58==8 | beginning==cat3_start & cat59==8 | beginning==cat3_start & cat60==8 | beginning==cat3_start & cat61==8 | beginning==cat3_start & cat62==8 | beginning==cat3_start & cat63==8 | beginning==cat3_start & cat64==8 | beginning==cat3_start & cat65==8 | beginning==cat3_start & cat66==8 | beginning==cat3_start & cat67==8 | beginning==cat3_start & cat68==8 | beginning==cat3_start & cat69==8 | beginning==cat3_start & cat70==8 | beginning==cat3_start & cat71==8 | beginning==cat3_start & cat72==8 | beginning==cat3_start & cat73==8 | beginning==cat3_start & cat74==8 | beginning==cat3_start & cat75==8 | beginning==cat3_start & cat76==8 | beginning==cat3_start & cat77==8 | beginning==cat3_start & cat78==8 | beginning==cat3_start & cat79==8 | beginning==cat3_start & cat80==8 | beginning==cat3_start & cat81==8 | beginning==cat3_start & cat82==8 | beginning==cat3_start & cat83==8 | beginning==cat3_start & cat84==8 | beginning==cat3_start & cat85==8 | beginning==cat3_start & cat86==8 | beginning==cat3_start & cat87==8 | beginning==cat3_start & cat88==8
replace indicator=0 if beginning==cat3_start & indicator==.
replace indicator=1 if beginning==cat4_start & cat5==8 | beginning==cat4_start & cat6==8 | beginning==cat4_start & cat7==8 | beginning==cat4_start & cat8==8 | beginning==cat4_start & cat9==8 | beginning==cat4_start & cat10==8 | beginning==cat4_start & cat11==8 | beginning==cat4_start & cat12==8 | beginning==cat4_start & cat13==8 | beginning==cat4_start & cat14==8 | beginning==cat4_start & cat15==8 | beginning==cat4_start & cat16==8 | beginning==cat4_start & cat17==8 | beginning==cat4_start & cat18==8 | beginning==cat4_start & cat19==8 | beginning==cat4_start & cat20==8 | beginning==cat4_start & cat21==8 | beginning==cat4_start & cat22==8 | beginning==cat4_start & cat23==8 | beginning==cat4_start & cat24==8 | beginning==cat4_start & cat25==8 | beginning==cat4_start & cat26==8 | beginning==cat4_start & cat27==8 | beginning==cat4_start & cat28==8 | beginning==cat4_start & cat29==8 | beginning==cat4_start & cat30==8 | beginning==cat4_start & cat31==8 | beginning==cat4_start & cat32==8 | beginning==cat4_start & cat33==8 | beginning==cat4_start & cat34==8 | beginning==cat4_start & cat35==8 | beginning==cat4_start & cat36==8 | beginning==cat4_start & cat37==8 | beginning==cat4_start & cat38==8 | beginning==cat4_start & cat39==8 | beginning==cat4_start & cat40==8 | beginning==cat4_start & cat41==8 | beginning==cat4_start & cat42==8 | beginning==cat4_start & cat43==8 | beginning==cat4_start & cat44==8 | beginning==cat4_start & cat45==8 | beginning==cat4_start & cat46==8 | beginning==cat4_start & cat47==8 | beginning==cat4_start & cat48==8 | beginning==cat4_start & cat49==8 | beginning==cat4_start & cat50==8 | beginning==cat4_start & cat51==8 | beginning==cat4_start & cat52==8 | beginning==cat4_start & cat53==8 | beginning==cat4_start & cat54==8 | beginning==cat4_start & cat55==8 | beginning==cat4_start & cat56==8 | beginning==cat4_start & cat57==8 | beginning==cat4_start & cat58==8 | beginning==cat4_start & cat59==8 | beginning==cat4_start & cat60==8 | beginning==cat4_start & cat61==8 | beginning==cat4_start & cat62==8 | beginning==cat4_start & cat63==8 | beginning==cat4_start & cat64==8 | beginning==cat4_start & cat65==8 | beginning==cat4_start & cat66==8 | beginning==cat4_start & cat67==8 | beginning==cat4_start & cat68==8 | beginning==cat4_start & cat69==8 | beginning==cat4_start & cat70==8 | beginning==cat4_start & cat71==8 | beginning==cat4_start & cat72==8 | beginning==cat4_start & cat73==8 | beginning==cat4_start & cat74==8 | beginning==cat4_start & cat75==8 | beginning==cat4_start & cat76==8 | beginning==cat4_start & cat77==8 | beginning==cat4_start & cat78==8 | beginning==cat4_start & cat79==8 | beginning==cat4_start & cat80==8 | beginning==cat4_start & cat81==8 | beginning==cat4_start & cat82==8 | beginning==cat4_start & cat83==8 | beginning==cat4_start & cat84==8 | beginning==cat4_start & cat85==8 | beginning==cat4_start & cat86==8 | beginning==cat4_start & cat87==8 | beginning==cat4_start & cat88==8
replace indicator=0 if beginning==cat4_start & indicator==.
replace indicator=1 if beginning==cat5_start & cat6==8 | beginning==cat5_start & cat7==8 | beginning==cat5_start & cat8==8 | beginning==cat5_start & cat9==8 | beginning==cat5_start & cat10==8 | beginning==cat5_start & cat11==8 | beginning==cat5_start & cat12==8 | beginning==cat5_start & cat13==8 | beginning==cat5_start & cat14==8 | beginning==cat5_start & cat15==8 | beginning==cat5_start & cat16==8 | beginning==cat5_start & cat17==8 | beginning==cat5_start & cat18==8 | beginning==cat5_start & cat19==8 | beginning==cat5_start & cat20==8 | beginning==cat5_start & cat21==8 | beginning==cat5_start & cat22==8 | beginning==cat5_start & cat23==8 | beginning==cat5_start & cat24==8 | beginning==cat5_start & cat25==8 | beginning==cat5_start & cat26==8 | beginning==cat5_start & cat27==8 | beginning==cat5_start & cat28==8 | beginning==cat5_start & cat29==8 | beginning==cat5_start & cat30==8 | beginning==cat5_start & cat31==8 | beginning==cat5_start & cat32==8 | beginning==cat5_start & cat33==8 | beginning==cat5_start & cat34==8 | beginning==cat5_start & cat35==8 | beginning==cat5_start & cat36==8 | beginning==cat5_start & cat37==8 | beginning==cat5_start & cat38==8 | beginning==cat5_start & cat39==8 | beginning==cat5_start & cat40==8 | beginning==cat5_start & cat41==8 | beginning==cat5_start & cat42==8 | beginning==cat5_start & cat43==8 | beginning==cat5_start & cat44==8 | beginning==cat5_start & cat45==8 | beginning==cat5_start & cat46==8 | beginning==cat5_start & cat47==8 | beginning==cat5_start & cat48==8 | beginning==cat5_start & cat49==8 | beginning==cat5_start & cat50==8 | beginning==cat5_start & cat51==8 | beginning==cat5_start & cat52==8 | beginning==cat5_start & cat53==8 | beginning==cat5_start & cat54==8 | beginning==cat5_start & cat55==8 | beginning==cat5_start & cat56==8 | beginning==cat5_start & cat57==8 | beginning==cat5_start & cat58==8 | beginning==cat5_start & cat59==8 | beginning==cat5_start & cat60==8 | beginning==cat5_start & cat61==8 | beginning==cat5_start & cat62==8 | beginning==cat5_start & cat63==8 | beginning==cat5_start & cat64==8 | beginning==cat5_start & cat65==8 | beginning==cat5_start & cat66==8 | beginning==cat5_start & cat67==8 | beginning==cat5_start & cat68==8 | beginning==cat5_start & cat69==8 | beginning==cat5_start & cat70==8 | beginning==cat5_start & cat71==8 | beginning==cat5_start & cat72==8 | beginning==cat5_start & cat73==8 | beginning==cat5_start & cat74==8 | beginning==cat5_start & cat75==8 | beginning==cat5_start & cat76==8 | beginning==cat5_start & cat77==8 | beginning==cat5_start & cat78==8 | beginning==cat5_start & cat79==8 | beginning==cat5_start & cat80==8 | beginning==cat5_start & cat81==8 | beginning==cat5_start & cat82==8 | beginning==cat5_start & cat83==8 | beginning==cat5_start & cat84==8 | beginning==cat5_start & cat85==8 | beginning==cat5_start & cat86==8 | beginning==cat5_start & cat87==8 | beginning==cat5_start & cat88==8
replace indicator=0 if beginning==cat5_start & indicator==.
replace indicator=1 if beginning==cat6_start & cat7==8 | beginning==cat6_start & cat8==8 | beginning==cat6_start & cat9==8 | beginning==cat6_start & cat10==8 | beginning==cat6_start & cat11==8 | beginning==cat6_start & cat12==8 | beginning==cat6_start & cat13==8 | beginning==cat6_start & cat14==8 | beginning==cat6_start & cat15==8 | beginning==cat6_start & cat16==8 | beginning==cat6_start & cat17==8 | beginning==cat6_start & cat18==8 | beginning==cat6_start & cat19==8 | beginning==cat6_start & cat20==8 | beginning==cat6_start & cat21==8 | beginning==cat6_start & cat22==8 | beginning==cat6_start & cat23==8 | beginning==cat6_start & cat24==8 | beginning==cat6_start & cat25==8 | beginning==cat6_start & cat26==8 | beginning==cat6_start & cat27==8 | beginning==cat6_start & cat28==8 | beginning==cat6_start & cat29==8 | beginning==cat6_start & cat30==8 | beginning==cat6_start & cat31==8 | beginning==cat6_start & cat32==8 | beginning==cat6_start & cat33==8 | beginning==cat6_start & cat34==8 | beginning==cat6_start & cat35==8 | beginning==cat6_start & cat36==8 | beginning==cat6_start & cat37==8 | beginning==cat6_start & cat38==8 | beginning==cat6_start & cat39==8 | beginning==cat6_start & cat40==8 | beginning==cat6_start & cat41==8 | beginning==cat6_start & cat42==8 | beginning==cat6_start & cat43==8 | beginning==cat6_start & cat44==8 | beginning==cat6_start & cat45==8 | beginning==cat6_start & cat46==8 | beginning==cat6_start & cat47==8 | beginning==cat6_start & cat48==8 | beginning==cat6_start & cat49==8 | beginning==cat6_start & cat50==8 | beginning==cat6_start & cat51==8 | beginning==cat6_start & cat52==8 | beginning==cat6_start & cat53==8 | beginning==cat6_start & cat54==8 | beginning==cat6_start & cat55==8 | beginning==cat6_start & cat56==8 | beginning==cat6_start & cat57==8 | beginning==cat6_start & cat58==8 | beginning==cat6_start & cat59==8 | beginning==cat6_start & cat60==8 | beginning==cat6_start & cat61==8 | beginning==cat6_start & cat62==8 | beginning==cat6_start & cat63==8 | beginning==cat6_start & cat64==8 | beginning==cat6_start & cat65==8 | beginning==cat6_start & cat66==8 | beginning==cat6_start & cat67==8 | beginning==cat6_start & cat68==8 | beginning==cat6_start & cat69==8 | beginning==cat6_start & cat70==8 | beginning==cat6_start & cat71==8 | beginning==cat6_start & cat72==8 | beginning==cat6_start & cat73==8 | beginning==cat6_start & cat74==8 | beginning==cat6_start & cat75==8 | beginning==cat6_start & cat76==8 | beginning==cat6_start & cat77==8 | beginning==cat6_start & cat78==8 | beginning==cat6_start & cat79==8 | beginning==cat6_start & cat80==8 | beginning==cat6_start & cat81==8 | beginning==cat6_start & cat82==8 | beginning==cat6_start & cat83==8 | beginning==cat6_start & cat84==8 | beginning==cat6_start & cat85==8 | beginning==cat6_start & cat86==8 | beginning==cat6_start & cat87==8 | beginning==cat6_start & cat88==8
replace indicator=0 if beginning==cat6_start & indicator==.
replace indicator=1 if beginning==cat7_start & cat8==8 | beginning==cat7_start & cat9==8 | beginning==cat7_start & cat10==8 | beginning==cat7_start & cat11==8 | beginning==cat7_start & cat12==8 | beginning==cat7_start & cat13==8 | beginning==cat7_start & cat14==8 | beginning==cat7_start & cat15==8 | beginning==cat7_start & cat16==8 | beginning==cat7_start & cat17==8 | beginning==cat7_start & cat18==8 | beginning==cat7_start & cat19==8 | beginning==cat7_start & cat20==8 | beginning==cat7_start & cat21==8 | beginning==cat7_start & cat22==8 | beginning==cat7_start & cat23==8 | beginning==cat7_start & cat24==8 | beginning==cat7_start & cat25==8 | beginning==cat7_start & cat26==8 | beginning==cat7_start & cat27==8 | beginning==cat7_start & cat28==8 | beginning==cat7_start & cat29==8 | beginning==cat7_start & cat30==8 | beginning==cat7_start & cat31==8 | beginning==cat7_start & cat32==8 | beginning==cat7_start & cat33==8 | beginning==cat7_start & cat34==8 | beginning==cat7_start & cat35==8 | beginning==cat7_start & cat36==8 | beginning==cat7_start & cat37==8 | beginning==cat7_start & cat38==8 | beginning==cat7_start & cat39==8 | beginning==cat7_start & cat40==8 | beginning==cat7_start & cat41==8 | beginning==cat7_start & cat42==8 | beginning==cat7_start & cat43==8 | beginning==cat7_start & cat44==8 | beginning==cat7_start & cat45==8 | beginning==cat7_start & cat46==8 | beginning==cat7_start & cat47==8 | beginning==cat7_start & cat48==8 | beginning==cat7_start & cat49==8 | beginning==cat7_start & cat50==8 | beginning==cat7_start & cat51==8 | beginning==cat7_start & cat52==8 | beginning==cat7_start & cat53==8 | beginning==cat7_start & cat54==8 | beginning==cat7_start & cat55==8 | beginning==cat7_start & cat56==8 | beginning==cat7_start & cat57==8 | beginning==cat7_start & cat58==8 | beginning==cat7_start & cat59==8 | beginning==cat7_start & cat60==8 | beginning==cat7_start & cat61==8 | beginning==cat7_start & cat62==8 | beginning==cat7_start & cat63==8 | beginning==cat7_start & cat64==8 | beginning==cat7_start & cat65==8 | beginning==cat7_start & cat66==8 | beginning==cat7_start & cat67==8 | beginning==cat7_start & cat68==8 | beginning==cat7_start & cat69==8 | beginning==cat7_start & cat70==8 | beginning==cat7_start & cat71==8 | beginning==cat7_start & cat72==8 | beginning==cat7_start & cat73==8 | beginning==cat7_start & cat74==8 | beginning==cat7_start & cat75==8 | beginning==cat7_start & cat76==8 | beginning==cat7_start & cat77==8 | beginning==cat7_start & cat78==8 | beginning==cat7_start & cat79==8 | beginning==cat7_start & cat80==8 | beginning==cat7_start & cat81==8 | beginning==cat7_start & cat82==8 | beginning==cat7_start & cat83==8 | beginning==cat7_start & cat84==8 | beginning==cat7_start & cat85==8 | beginning==cat7_start & cat86==8 | beginning==cat7_start & cat87==8 | beginning==cat7_start & cat88==8
replace indicator=0 if beginning==cat7_start & indicator==.
replace indicator=1 if beginning==cat8_start & cat9==8 | beginning==cat8_start & cat10==8 | beginning==cat8_start & cat11==8 | beginning==cat8_start & cat12==8 | beginning==cat8_start & cat13==8 | beginning==cat8_start & cat14==8 | beginning==cat8_start & cat15==8 | beginning==cat8_start & cat16==8 | beginning==cat8_start & cat17==8 | beginning==cat8_start & cat18==8 | beginning==cat8_start & cat19==8 | beginning==cat8_start & cat20==8 | beginning==cat8_start & cat21==8 | beginning==cat8_start & cat22==8 | beginning==cat8_start & cat23==8 | beginning==cat8_start & cat24==8 | beginning==cat8_start & cat25==8 | beginning==cat8_start & cat26==8 | beginning==cat8_start & cat27==8 | beginning==cat8_start & cat28==8 | beginning==cat8_start & cat29==8 | beginning==cat8_start & cat30==8 | beginning==cat8_start & cat31==8 | beginning==cat8_start & cat32==8 | beginning==cat8_start & cat33==8 | beginning==cat8_start & cat34==8 | beginning==cat8_start & cat35==8 | beginning==cat8_start & cat36==8 | beginning==cat8_start & cat37==8 | beginning==cat8_start & cat38==8 | beginning==cat8_start & cat39==8 | beginning==cat8_start & cat40==8 | beginning==cat8_start & cat41==8 | beginning==cat8_start & cat42==8 | beginning==cat8_start & cat43==8 | beginning==cat8_start & cat44==8 | beginning==cat8_start & cat45==8 | beginning==cat8_start & cat46==8 | beginning==cat8_start & cat47==8 | beginning==cat8_start & cat48==8 | beginning==cat8_start & cat49==8 | beginning==cat8_start & cat50==8 | beginning==cat8_start & cat51==8 | beginning==cat8_start & cat52==8 | beginning==cat8_start & cat53==8 | beginning==cat8_start & cat54==8 | beginning==cat8_start & cat55==8 | beginning==cat8_start & cat56==8 | beginning==cat8_start & cat57==8 | beginning==cat8_start & cat58==8 | beginning==cat8_start & cat59==8 | beginning==cat8_start & cat60==8 | beginning==cat8_start & cat61==8 | beginning==cat8_start & cat62==8 | beginning==cat8_start & cat63==8 | beginning==cat8_start & cat64==8 | beginning==cat8_start & cat65==8 | beginning==cat8_start & cat66==8 | beginning==cat8_start & cat67==8 | beginning==cat8_start & cat68==8 | beginning==cat8_start & cat69==8 | beginning==cat8_start & cat70==8 | beginning==cat8_start & cat71==8 | beginning==cat8_start & cat72==8 | beginning==cat8_start & cat73==8 | beginning==cat8_start & cat74==8 | beginning==cat8_start & cat75==8 | beginning==cat8_start & cat76==8 | beginning==cat8_start & cat77==8 | beginning==cat8_start & cat78==8 | beginning==cat8_start & cat79==8 | beginning==cat8_start & cat80==8 | beginning==cat8_start & cat81==8 | beginning==cat8_start & cat82==8 | beginning==cat8_start & cat83==8 | beginning==cat8_start & cat84==8 | beginning==cat8_start & cat85==8 | beginning==cat8_start & cat86==8 | beginning==cat8_start & cat87==8 | beginning==cat8_start & cat88==8
replace indicator=0 if beginning==cat8_start & indicator==.
replace indicator=0 if beginning==end
replace indicator=1 if beginning==cat9_start & cat10==8 | beginning==cat9_start & cat11==8 | beginning==cat9_start & cat12==8 | beginning==cat9_start & cat13==8 | beginning==cat9_start & cat14==8 | beginning==cat9_start & cat15==8 | beginning==cat9_start & cat16==8 | beginning==cat9_start & cat17==8 | beginning==cat9_start & cat18==8 | beginning==cat9_start & cat19==8 | beginning==cat9_start & cat20==8 | beginning==cat9_start & cat21==8 | beginning==cat9_start & cat22==8 | beginning==cat9_start & cat23==8 | beginning==cat9_start & cat24==8 | beginning==cat9_start & cat25==8 | beginning==cat9_start & cat26==8 | beginning==cat9_start & cat27==8 | beginning==cat9_start & cat28==8 | beginning==cat9_start & cat29==8 | beginning==cat9_start & cat30==8 | beginning==cat9_start & cat31==8 | beginning==cat9_start & cat32==8 | beginning==cat9_start & cat33==8 | beginning==cat9_start & cat34==8 | beginning==cat9_start & cat35==8 | beginning==cat9_start & cat36==8 | beginning==cat9_start & cat37==8 | beginning==cat9_start & cat38==8 | beginning==cat9_start & cat39==8 | beginning==cat9_start & cat40==8 | beginning==cat9_start & cat41==8 | beginning==cat9_start & cat42==8 | beginning==cat9_start & cat43==8 | beginning==cat9_start & cat44==8 | beginning==cat9_start & cat45==8 | beginning==cat9_start & cat46==8 | beginning==cat9_start & cat47==8 | beginning==cat9_start & cat48==8 | beginning==cat9_start & cat49==8 | beginning==cat9_start & cat50==8 | beginning==cat9_start & cat51==8 | beginning==cat9_start & cat52==8 | beginning==cat9_start & cat53==8 | beginning==cat9_start & cat54==8 | beginning==cat9_start & cat55==8 | beginning==cat9_start & cat56==8 | beginning==cat9_start & cat57==8 | beginning==cat9_start & cat58==8 | beginning==cat9_start & cat59==8 | beginning==cat9_start & cat60==8 | beginning==cat9_start & cat61==8 | beginning==cat9_start & cat62==8 | beginning==cat9_start & cat63==8 | beginning==cat9_start & cat64==8 | beginning==cat9_start & cat65==8 | beginning==cat9_start & cat66==8 | beginning==cat9_start & cat67==8 | beginning==cat9_start & cat68==8 | beginning==cat9_start & cat69==8 | beginning==cat9_start & cat70==8 | beginning==cat9_start & cat71==8 | beginning==cat9_start & cat72==8 | beginning==cat9_start & cat73==8 | beginning==cat9_start & cat74==8 | beginning==cat9_start & cat75==8 | beginning==cat9_start & cat76==8 | beginning==cat9_start & cat77==8 | beginning==cat9_start & cat78==8 | beginning==cat9_start & cat79==8 | beginning==cat9_start & cat80==8 | beginning==cat9_start & cat81==8 | beginning==cat9_start & cat82==8 | beginning==cat9_start & cat83==8 | beginning==cat9_start & cat84==8 | beginning==cat9_start & cat85==8 | beginning==cat9_start & cat86==8 | beginning==cat9_start & cat87==8 | beginning==cat9_start & cat88==8
replace indicator=0 if beginning==cat9_start & indicator==.
replace indicator=1 if beginning==cat10_start & cat11==8 | beginning==cat10_start & cat12==8 | beginning==cat10_start & cat13==8 | beginning==cat10_start & cat14==8 | beginning==cat10_start & cat15==8 | beginning==cat10_start & cat16==8 | beginning==cat10_start & cat17==8 | beginning==cat10_start & cat18==8 | beginning==cat10_start & cat19==8 | beginning==cat10_start & cat20==8 | beginning==cat10_start & cat21==8 | beginning==cat10_start & cat22==8 | beginning==cat10_start & cat23==8 | beginning==cat10_start & cat24==8 | beginning==cat10_start & cat25==8 | beginning==cat10_start & cat26==8 | beginning==cat10_start & cat27==8 | beginning==cat10_start & cat28==8 | beginning==cat10_start & cat29==8 | beginning==cat10_start & cat30==8 | beginning==cat10_start & cat31==8 | beginning==cat10_start & cat32==8 | beginning==cat10_start & cat33==8 | beginning==cat10_start & cat34==8 | beginning==cat10_start & cat35==8 | beginning==cat10_start & cat36==8 | beginning==cat10_start & cat37==8 | beginning==cat10_start & cat38==8 | beginning==cat10_start & cat39==8 | beginning==cat10_start & cat40==8 | beginning==cat10_start & cat41==8 | beginning==cat10_start & cat42==8 | beginning==cat10_start & cat43==8 | beginning==cat10_start & cat44==8 | beginning==cat10_start & cat45==8 | beginning==cat10_start & cat46==8 | beginning==cat10_start & cat47==8 | beginning==cat10_start & cat48==8 | beginning==cat10_start & cat49==8 | beginning==cat10_start & cat50==8 | beginning==cat10_start & cat51==8 | beginning==cat10_start & cat52==8 | beginning==cat10_start & cat53==8 | beginning==cat10_start & cat54==8 | beginning==cat10_start & cat55==8 | beginning==cat10_start & cat56==8 | beginning==cat10_start & cat57==8 | beginning==cat10_start & cat58==8 | beginning==cat10_start & cat59==8 | beginning==cat10_start & cat60==8 | beginning==cat10_start & cat61==8 | beginning==cat10_start & cat62==8 | beginning==cat10_start & cat63==8 | beginning==cat10_start & cat64==8 | beginning==cat10_start & cat65==8 | beginning==cat10_start & cat66==8 | beginning==cat10_start & cat67==8 | beginning==cat10_start & cat68==8 | beginning==cat10_start & cat69==8 | beginning==cat10_start & cat70==8 | beginning==cat10_start & cat71==8 | beginning==cat10_start & cat72==8 | beginning==cat10_start & cat73==8 | beginning==cat10_start & cat74==8 | beginning==cat10_start & cat75==8 | beginning==cat10_start & cat76==8 | beginning==cat10_start & cat77==8 | beginning==cat10_start & cat78==8 | beginning==cat10_start & cat79==8 | beginning==cat10_start & cat80==8 | beginning==cat10_start & cat81==8 | beginning==cat10_start & cat82==8 | beginning==cat10_start & cat83==8 | beginning==cat10_start & cat84==8 | beginning==cat10_start & cat85==8 | beginning==cat10_start & cat86==8 | beginning==cat10_start & cat87==8 | beginning==cat10_start & cat88==8
replace indicator=0 if beginning==cat10_start & indicator==.
replace indicator=1 if beginning==cat11_start & cat12==8 | beginning==cat11_start & cat13==8 | beginning==cat11_start & cat14==8 | beginning==cat11_start & cat15==8 | beginning==cat11_start & cat16==8 | beginning==cat11_start & cat17==8 | beginning==cat11_start & cat18==8 | beginning==cat11_start & cat19==8 | beginning==cat11_start & cat20==8 | beginning==cat11_start & cat21==8 | beginning==cat11_start & cat22==8 | beginning==cat11_start & cat23==8 | beginning==cat11_start & cat24==8 | beginning==cat11_start & cat25==8 | beginning==cat11_start & cat26==8 | beginning==cat11_start & cat27==8 | beginning==cat11_start & cat28==8 | beginning==cat11_start & cat29==8 | beginning==cat11_start & cat30==8 | beginning==cat11_start & cat31==8 | beginning==cat11_start & cat32==8 | beginning==cat11_start & cat33==8 | beginning==cat11_start & cat34==8 | beginning==cat11_start & cat35==8 | beginning==cat11_start & cat36==8 | beginning==cat11_start & cat37==8 | beginning==cat11_start & cat38==8 | beginning==cat11_start & cat39==8 | beginning==cat11_start & cat40==8 | beginning==cat11_start & cat41==8 | beginning==cat11_start & cat42==8 | beginning==cat11_start & cat43==8 | beginning==cat11_start & cat44==8 | beginning==cat11_start & cat45==8 | beginning==cat11_start & cat46==8 | beginning==cat11_start & cat47==8 | beginning==cat11_start & cat48==8 | beginning==cat11_start & cat49==8 | beginning==cat11_start & cat50==8 | beginning==cat11_start & cat51==8 | beginning==cat11_start & cat52==8 | beginning==cat11_start & cat53==8 | beginning==cat11_start & cat54==8 | beginning==cat11_start & cat55==8 | beginning==cat11_start & cat56==8 | beginning==cat11_start & cat57==8 | beginning==cat11_start & cat58==8 | beginning==cat11_start & cat59==8 | beginning==cat11_start & cat60==8 | beginning==cat11_start & cat61==8 | beginning==cat11_start & cat62==8 | beginning==cat11_start & cat63==8 | beginning==cat11_start & cat64==8 | beginning==cat11_start & cat65==8 | beginning==cat11_start & cat66==8 | beginning==cat11_start & cat67==8 | beginning==cat11_start & cat68==8 | beginning==cat11_start & cat69==8 | beginning==cat11_start & cat70==8 | beginning==cat11_start & cat71==8 | beginning==cat11_start & cat72==8 | beginning==cat11_start & cat73==8 | beginning==cat11_start & cat74==8 | beginning==cat11_start & cat75==8 | beginning==cat11_start & cat76==8 | beginning==cat11_start & cat77==8 | beginning==cat11_start & cat78==8 | beginning==cat11_start & cat79==8 | beginning==cat11_start & cat80==8 | beginning==cat11_start & cat81==8 | beginning==cat11_start & cat82==8 | beginning==cat11_start & cat83==8 | beginning==cat11_start & cat84==8 | beginning==cat11_start & cat85==8 | beginning==cat11_start & cat86==8 | beginning==cat11_start & cat87==8 | beginning==cat11_start & cat88==8
replace indicator=0 if beginning==cat11_start & indicator==.
replace indicator=1 if beginning==cat12_start & cat13==8 | beginning==cat12_start & cat14==8 | beginning==cat12_start & cat15==8 | beginning==cat12_start & cat16==8 | beginning==cat12_start & cat17==8 | beginning==cat12_start & cat18==8 | beginning==cat12_start & cat19==8 | beginning==cat12_start & cat20==8 | beginning==cat12_start & cat21==8 | beginning==cat12_start & cat22==8 | beginning==cat12_start & cat23==8 | beginning==cat12_start & cat24==8 | beginning==cat12_start & cat25==8 | beginning==cat12_start & cat26==8 | beginning==cat12_start & cat27==8 | beginning==cat12_start & cat28==8 | beginning==cat12_start & cat29==8 | beginning==cat12_start & cat30==8 | beginning==cat12_start & cat31==8 | beginning==cat12_start & cat32==8 | beginning==cat12_start & cat33==8 | beginning==cat12_start & cat34==8 | beginning==cat12_start & cat35==8 | beginning==cat12_start & cat36==8 | beginning==cat12_start & cat37==8 | beginning==cat12_start & cat38==8 | beginning==cat12_start & cat39==8 | beginning==cat12_start & cat40==8 | beginning==cat12_start & cat41==8 | beginning==cat12_start & cat42==8 | beginning==cat12_start & cat43==8 | beginning==cat12_start & cat44==8 | beginning==cat12_start & cat45==8 | beginning==cat12_start & cat46==8 | beginning==cat12_start & cat47==8 | beginning==cat12_start & cat48==8 | beginning==cat12_start & cat49==8 | beginning==cat12_start & cat50==8 | beginning==cat12_start & cat51==8 | beginning==cat12_start & cat52==8 | beginning==cat12_start & cat53==8 | beginning==cat12_start & cat54==8 | beginning==cat12_start & cat55==8 | beginning==cat12_start & cat56==8 | beginning==cat12_start & cat57==8 | beginning==cat12_start & cat58==8 | beginning==cat12_start & cat59==8 | beginning==cat12_start & cat60==8 | beginning==cat12_start & cat61==8 | beginning==cat12_start & cat62==8 | beginning==cat12_start & cat63==8 | beginning==cat12_start & cat64==8 | beginning==cat12_start & cat65==8 | beginning==cat12_start & cat66==8 | beginning==cat12_start & cat67==8 | beginning==cat12_start & cat68==8 | beginning==cat12_start & cat69==8 | beginning==cat12_start & cat70==8 | beginning==cat12_start & cat71==8 | beginning==cat12_start & cat72==8 | beginning==cat12_start & cat73==8 | beginning==cat12_start & cat74==8 | beginning==cat12_start & cat75==8 | beginning==cat12_start & cat76==8 | beginning==cat12_start & cat77==8 | beginning==cat12_start & cat78==8 | beginning==cat12_start & cat79==8 | beginning==cat12_start & cat80==8 | beginning==cat12_start & cat81==8 | beginning==cat12_start & cat82==8 | beginning==cat12_start & cat83==8 | beginning==cat12_start & cat84==8 | beginning==cat12_start & cat85==8 | beginning==cat12_start & cat86==8 | beginning==cat12_start & cat87==8 | beginning==cat12_start & cat88==8
replace indicator=0 if beginning==cat12_start & indicator==.
replace indicator=1 if beginning==cat13_start & cat14==8 | beginning==cat13_start & cat15==8 | beginning==cat13_start & cat16==8 | beginning==cat13_start & cat17==8 | beginning==cat13_start & cat18==8 | beginning==cat13_start & cat19==8 | beginning==cat13_start & cat20==8 | beginning==cat13_start & cat21==8 | beginning==cat13_start & cat22==8 | beginning==cat13_start & cat23==8 | beginning==cat13_start & cat24==8 | beginning==cat13_start & cat25==8 | beginning==cat13_start & cat26==8 | beginning==cat13_start & cat27==8 | beginning==cat13_start & cat28==8 | beginning==cat13_start & cat29==8 | beginning==cat13_start & cat30==8 | beginning==cat13_start & cat31==8 | beginning==cat13_start & cat32==8 | beginning==cat13_start & cat33==8 | beginning==cat13_start & cat34==8 | beginning==cat13_start & cat35==8 | beginning==cat13_start & cat36==8 | beginning==cat13_start & cat37==8 | beginning==cat13_start & cat38==8 | beginning==cat13_start & cat39==8 | beginning==cat13_start & cat40==8 | beginning==cat13_start & cat41==8 | beginning==cat13_start & cat42==8 | beginning==cat13_start & cat43==8 | beginning==cat13_start & cat44==8 | beginning==cat13_start & cat45==8 | beginning==cat13_start & cat46==8 | beginning==cat13_start & cat47==8 | beginning==cat13_start & cat48==8 | beginning==cat13_start & cat49==8 | beginning==cat13_start & cat50==8 | beginning==cat13_start & cat51==8 | beginning==cat13_start & cat52==8 | beginning==cat13_start & cat53==8 | beginning==cat13_start & cat54==8 | beginning==cat13_start & cat55==8 | beginning==cat13_start & cat56==8 | beginning==cat13_start & cat57==8 | beginning==cat13_start & cat58==8 | beginning==cat13_start & cat59==8 | beginning==cat13_start & cat60==8 | beginning==cat13_start & cat61==8 | beginning==cat13_start & cat62==8 | beginning==cat13_start & cat63==8 | beginning==cat13_start & cat64==8 | beginning==cat13_start & cat65==8 | beginning==cat13_start & cat66==8 | beginning==cat13_start & cat67==8 | beginning==cat13_start & cat68==8 | beginning==cat13_start & cat69==8 | beginning==cat13_start & cat70==8 | beginning==cat13_start & cat71==8 | beginning==cat13_start & cat72==8 | beginning==cat13_start & cat73==8 | beginning==cat13_start & cat74==8 | beginning==cat13_start & cat75==8 | beginning==cat13_start & cat76==8 | beginning==cat13_start & cat77==8 | beginning==cat13_start & cat78==8 | beginning==cat13_start & cat79==8 | beginning==cat13_start & cat80==8 | beginning==cat13_start & cat81==8 | beginning==cat13_start & cat82==8 | beginning==cat13_start & cat83==8 | beginning==cat13_start & cat84==8 | beginning==cat13_start & cat85==8 | beginning==cat13_start & cat86==8 | beginning==cat13_start & cat87==8 | beginning==cat13_start & cat88==8
replace indicator=0 if beginning==cat13_start & indicator==.
replace indicator=1 if beginning==cat14_start & cat15==8 | beginning==cat14_start & cat16==8 | beginning==cat14_start & cat17==8 | beginning==cat14_start & cat18==8 | beginning==cat14_start & cat19==8 | beginning==cat14_start & cat20==8 | beginning==cat14_start & cat21==8 | beginning==cat14_start & cat22==8 | beginning==cat14_start & cat23==8 | beginning==cat14_start & cat24==8 | beginning==cat14_start & cat25==8 | beginning==cat14_start & cat26==8 | beginning==cat14_start & cat27==8 | beginning==cat14_start & cat28==8 | beginning==cat14_start & cat29==8 | beginning==cat14_start & cat30==8 | beginning==cat14_start & cat31==8 | beginning==cat14_start & cat32==8 | beginning==cat14_start & cat33==8 | beginning==cat14_start & cat34==8 | beginning==cat14_start & cat35==8 | beginning==cat14_start & cat36==8 | beginning==cat14_start & cat37==8 | beginning==cat14_start & cat38==8 | beginning==cat14_start & cat39==8 | beginning==cat14_start & cat40==8 | beginning==cat14_start & cat41==8 | beginning==cat14_start & cat42==8 | beginning==cat14_start & cat43==8 | beginning==cat14_start & cat44==8 | beginning==cat14_start & cat45==8 | beginning==cat14_start & cat46==8 | beginning==cat14_start & cat47==8 | beginning==cat14_start & cat48==8 | beginning==cat14_start & cat49==8 | beginning==cat14_start & cat50==8 | beginning==cat14_start & cat51==8 | beginning==cat14_start & cat52==8 | beginning==cat14_start & cat53==8 | beginning==cat14_start & cat54==8 | beginning==cat14_start & cat55==8 | beginning==cat14_start & cat56==8 | beginning==cat14_start & cat57==8 | beginning==cat14_start & cat58==8 | beginning==cat14_start & cat59==8 | beginning==cat14_start & cat60==8 | beginning==cat14_start & cat61==8 | beginning==cat14_start & cat62==8 | beginning==cat14_start & cat63==8 | beginning==cat14_start & cat64==8 | beginning==cat14_start & cat65==8 | beginning==cat14_start & cat66==8 | beginning==cat14_start & cat67==8 | beginning==cat14_start & cat68==8 | beginning==cat14_start & cat69==8 | beginning==cat14_start & cat70==8 | beginning==cat14_start & cat71==8 | beginning==cat14_start & cat72==8 | beginning==cat14_start & cat73==8 | beginning==cat14_start & cat74==8 | beginning==cat14_start & cat75==8 | beginning==cat14_start & cat76==8 | beginning==cat14_start & cat77==8 | beginning==cat14_start & cat78==8 | beginning==cat14_start & cat79==8 | beginning==cat14_start & cat80==8 | beginning==cat14_start & cat81==8 | beginning==cat14_start & cat82==8 | beginning==cat14_start & cat83==8 | beginning==cat14_start & cat84==8 | beginning==cat14_start & cat85==8 | beginning==cat14_start & cat86==8 | beginning==cat14_start & cat87==8 | beginning==cat14_start & cat88==8
replace indicator=0 if beginning==cat14_start & indicator==.
replace indicator=0 if beginning==cat15_start & cat16==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==.
replace indicator=1 if beginning==cat15_start & cat16==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat16_start & cat17==.
replace indicator=1 if beginning==cat16_start & cat17==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18==.
replace indicator=1 if beginning==cat17_start & cat18==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==.
replace indicator=0 if beginning==cat18_start & cat19==.
replace indicator=1 if beginning==cat18_start & cat19==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21==.
replace indicator=1 if beginning==cat19_start & cat20==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat21_start & cat22==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31==.
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat24_start & cat25==.
replace indicator=0 if beginning==cat39_start & cat73!=8 & cat74==.
replace indicator=1 if beginning==cat48_start & cat49==8
replace indicator=1 if beginning==cat50_start & cat51==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==.
replace indicator=1 if beginning==cat25_start & cat26==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==.
replace indicator=0 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==.
replace indicator=1 if beginning==cat21_start & cat22==8
replace indicator=1 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat46_start & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52==.
replace indicator=0 if beginning==cat36_start & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49==.
replace indicator=0 if beginning==cat24_start & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat53_start & cat54==.
replace indicator=0 if beginning==cat34_start & cat35!=8 & cat36!=8 & cat37!=8 & cat38==.
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace indicator=0 if beginning==cat52_start & cat53!=8 & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58==.
replace indicator=1 if beginning==cat27_start & cat28==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=1 if beginning==cat20_start & cat21==8
replace indicator=1 if beginning==cat23_start & cat24==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace indicator=1 if beginning==cat22_start & cat23==8
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
tab indicator,m
* Drop individuals that are not in the risk set
drop if indicator==0
drop indicator

* Construct the 'beginning' variable
gen beginning2 = .
replace beginning2 = cat3_start if beginning==cat2_start & cat3==8
order folio_n20 beginning beginning2
replace beginning2 = cat4_start if beginning==cat2_start & cat3!=8 & cat4==8
replace beginning2 = cat5_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat4_start if beginning==cat3_start & cat4==8
replace beginning2 = cat5_start if beginning==cat3_start & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat5_start if beginning==cat4_start & cat5==8
replace beginning2 = cat6_start if beginning==cat4_start & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat6_start if beginning==cat5_start & cat6==8
replace beginning2 = cat7_start if beginning==cat5_start & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat7_start if beginning==cat6_start & cat7==8
replace beginning2 = cat8_start if beginning==cat6_start & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat23_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat24_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat8_start if beginning==cat7_start & cat8==8
replace beginning2 = cat9_start if beginning==cat7_start & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat9_start if beginning==cat8_start & cat9==8
replace beginning2 = cat10_start if beginning==cat8_start & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat22_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat22_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat10_start if beginning==cat9_start & cat10==8
replace beginning2 = cat11_start if beginning==cat9_start & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat16_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat11_start if beginning==cat10_start & cat11==8
replace beginning2 = cat12_start if beginning==cat10_start & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat17_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat12_start if beginning==cat11_start & cat12==8
replace beginning2 = cat13_start if beginning==cat11_start & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat13_start if beginning==cat12_start & cat13==8
replace beginning2 = cat14_start if beginning==cat12_start & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat14_start if beginning==cat13_start & cat14==8
replace beginning2 = cat15_start if beginning==cat13_start & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat13_start & cat14!=2 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat20_start if beginning==cat13_start & cat14!=2 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat22_start if beginning==cat13_start & cat14!=2 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat15_start if beginning==cat14_start & cat15==8
replace beginning2 = cat16_start if beginning==cat14_start & cat15!=8 & cat16==8
replace beginning2 = cat16_start if beginning==cat15_start & cat16==8
replace beginning2 = cat17_start if beginning==cat15_start & cat16!=8 & cat17==8
replace beginning2 = cat17_start if beginning==cat16_start & cat17==8
replace beginning2 = cat18_start if beginning==cat17_start & cat18==8
replace beginning2 = cat19_start if beginning==cat18_start & cat19==8
replace beginning2 = cat20_start if beginning==cat19_start & cat20==8
replace beginning2 = cat25_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==8
replace beginning2 = cat35_start if beginning==cat32_start & cat33!=8 & cat34!=8 & cat35==8
replace beginning2 = cat17_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat16_start & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat24_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat19_start if beginning==cat17_start & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat18_start & cat19!=8 & cat20==8
replace beginning2 = cat21_start if beginning==cat19_start & cat20!=8 & cat21==8
replace beginning2 = cat22_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat22_start if beginning==cat21_start & cat22==8
replace beginning2 = cat18_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat14_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat15_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat14_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat25_start if beginning==cat24_start & cat25==8
replace beginning2 = cat23_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat17_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat51_start if beginning==cat50_start & cat51==8
replace beginning2 = cat28_start if beginning==cat27_start & cat28==8
replace beginning2 = cat17_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat21_start if beginning==cat20_start & cat21==8
replace beginning2 = cat24_start if beginning==cat23_start & cat24==8
replace beginning2 = cat21_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat20_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat23_start if beginning==cat22_start & cat23==8
replace beginning2 = cat22_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat19_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat19_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8

* Make sure that there are no missings
tab beginning2,m
drop beginning
rename beginning2 beginning

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat3_start & cat4==1
order event,after(folio_n20)
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=0 if beginning==cat29_start & cat30==.
replace event=3 if beginning==cat48_start & cat49==3
replace event=4 if beginning==cat26_start & cat27==4
replace event=6 if beginning==cat27_start & cat28==6
replace event=5 if beginning==cat35_start & cat36==5
replace event=0 if beginning==cat7_start & cat8==8 & cat9==.
replace event=9 if beginning==cat51_start & cat52==10
replace event=9 if beginning==cat28_start & cat29==10

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat29_start - beginning if beginning==cat28_start & cat29!=8 & cat29!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat52_start - beginning if beginning==cat51_start & cat52!=8 & cat52!=.

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC3_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =3

* Define the education variable
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling10 if beginning==cat10_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079)
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC3_informal", replace

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 4: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load the dataset for analysis
clear
use "$resultdir\sample_RC3_informal"

drop event
replace beginning=beginning+duration
drop duration

* Create risk set: individuals that are in RC informal of order 4 across multiple categories
gen indicator = .  // Initialize the variable
replace indicator=1 if beginning==cat2_start & cat3==8 | beginning==cat2_start & cat4==8 | beginning==cat2_start & cat5==8 | beginning==cat2_start & cat6==8 | beginning==cat2_start & cat7==8 | beginning==cat2_start & cat8==8 | beginning==cat2_start & cat9==8 | beginning==cat2_start & cat10==8 | beginning==cat2_start & cat11==8 | beginning==cat2_start & cat12==8 | beginning==cat2_start & cat13==8 | beginning==cat2_start & cat14==8 | beginning==cat2_start & cat15==8 | beginning==cat2_start & cat16==8 | beginning==cat2_start & cat17==8 | beginning==cat2_start & cat18==8 | beginning==cat2_start & cat19==8 | beginning==cat2_start & cat20==8 | beginning==cat2_start & cat21==8 | beginning==cat2_start & cat22==8 | beginning==cat2_start & cat23==8 | beginning==cat2_start & cat24==8 | beginning==cat2_start & cat25==8 | beginning==cat2_start & cat26==8 | beginning==cat2_start & cat27==8 | beginning==cat2_start & cat28==8 | beginning==cat2_start & cat29==8 | beginning==cat2_start & cat30==8 | beginning==cat2_start & cat31==8 | beginning==cat2_start & cat32==8 | beginning==cat2_start & cat33==8 | beginning==cat2_start & cat34==8 | beginning==cat2_start & cat35==8 | beginning==cat2_start & cat36==8 | beginning==cat2_start & cat37==8 | beginning==cat2_start & cat38==8 | beginning==cat2_start & cat39==8 | beginning==cat2_start & cat40==8 | beginning==cat2_start & cat41==8 | beginning==cat2_start & cat42==8 | beginning==cat2_start & cat43==8 | beginning==cat2_start & cat44==8 | beginning==cat2_start & cat45==8 | beginning==cat2_start & cat46==8 | beginning==cat2_start & cat47==8 | beginning==cat2_start & cat48==8 | beginning==cat2_start & cat49==8 | beginning==cat2_start & cat50==8 | beginning==cat2_start & cat51==8 | beginning==cat2_start & cat52==8 | beginning==cat2_start & cat53==8 | beginning==cat2_start & cat54==8 | beginning==cat2_start & cat55==8 | beginning==cat2_start & cat56==8 | beginning==cat2_start & cat57==8 | beginning==cat2_start & cat58==8 | beginning==cat2_start & cat59==8 | beginning==cat2_start & cat60==8 | beginning==cat2_start & cat61==8 | beginning==cat2_start & cat62==8 | beginning==cat2_start & cat63==8 | beginning==cat2_start & cat64==8 | beginning==cat2_start & cat65==8 | beginning==cat2_start & cat66==8 | beginning==cat2_start & cat67==8 | beginning==cat2_start & cat68==8 | beginning==cat2_start & cat69==8 | beginning==cat2_start & cat70==8 | beginning==cat2_start & cat71==8 | beginning==cat2_start & cat72==8 | beginning==cat2_start & cat73==8 | beginning==cat2_start & cat74==8 | beginning==cat2_start & cat75==8 | beginning==cat2_start & cat76==8 | beginning==cat2_start & cat77==8 | beginning==cat2_start & cat78==8 | beginning==cat2_start & cat79==8 | beginning==cat2_start & cat80==8 | beginning==cat2_start & cat81==8 | beginning==cat2_start & cat82==8 | beginning==cat2_start & cat83==8 | beginning==cat2_start & cat84==8 | beginning==cat2_start & cat85==8 | beginning==cat2_start & cat86==8 | beginning==cat2_start & cat87==8 | beginning==cat2_start & cat88==8
replace indicator=0 if beginning==cat2_start & indicator==.
replace indicator=1 if beginning==cat3_start & cat4==8 | beginning==cat3_start & cat5==8 | beginning==cat3_start & cat6==8 | beginning==cat3_start & cat7==8 | beginning==cat3_start & cat8==8 | beginning==cat3_start & cat9==8 | beginning==cat3_start & cat10==8 | beginning==cat3_start & cat11==8 | beginning==cat3_start & cat12==8 | beginning==cat3_start & cat13==8 | beginning==cat3_start & cat14==8 | beginning==cat3_start & cat15==8 | beginning==cat3_start & cat16==8 | beginning==cat3_start & cat17==8 | beginning==cat3_start & cat18==8 | beginning==cat3_start & cat19==8 | beginning==cat3_start & cat20==8 | beginning==cat3_start & cat21==8 | beginning==cat3_start & cat22==8 | beginning==cat3_start & cat23==8 | beginning==cat3_start & cat24==8 | beginning==cat3_start & cat25==8 | beginning==cat3_start & cat26==8 | beginning==cat3_start & cat27==8 | beginning==cat3_start & cat28==8 | beginning==cat3_start & cat29==8 | beginning==cat3_start & cat30==8 | beginning==cat3_start & cat31==8 | beginning==cat3_start & cat32==8 | beginning==cat3_start & cat33==8 | beginning==cat3_start & cat34==8 | beginning==cat3_start & cat35==8 | beginning==cat3_start & cat36==8 | beginning==cat3_start & cat37==8 | beginning==cat3_start & cat38==8 | beginning==cat3_start & cat39==8 | beginning==cat3_start & cat40==8 | beginning==cat3_start & cat41==8 | beginning==cat3_start & cat42==8 | beginning==cat3_start & cat43==8 | beginning==cat3_start & cat44==8 | beginning==cat3_start & cat45==8 | beginning==cat3_start & cat46==8 | beginning==cat3_start & cat47==8 | beginning==cat3_start & cat48==8 | beginning==cat3_start & cat49==8 | beginning==cat3_start & cat50==8 | beginning==cat3_start & cat51==8 | beginning==cat3_start & cat52==8 | beginning==cat3_start & cat53==8 | beginning==cat3_start & cat54==8 | beginning==cat3_start & cat55==8 | beginning==cat3_start & cat56==8 | beginning==cat3_start & cat57==8 | beginning==cat3_start & cat58==8 | beginning==cat3_start & cat59==8 | beginning==cat3_start & cat60==8 | beginning==cat3_start & cat61==8 | beginning==cat3_start & cat62==8 | beginning==cat3_start & cat63==8 | beginning==cat3_start & cat64==8 | beginning==cat3_start & cat65==8 | beginning==cat3_start & cat66==8 | beginning==cat3_start & cat67==8 | beginning==cat3_start & cat68==8 | beginning==cat3_start & cat69==8 | beginning==cat3_start & cat70==8 | beginning==cat3_start & cat71==8 | beginning==cat3_start & cat72==8 | beginning==cat3_start & cat73==8 | beginning==cat3_start & cat74==8 | beginning==cat3_start & cat75==8 | beginning==cat3_start & cat76==8 | beginning==cat3_start & cat77==8 | beginning==cat3_start & cat78==8 | beginning==cat3_start & cat79==8 | beginning==cat3_start & cat80==8 | beginning==cat3_start & cat81==8 | beginning==cat3_start & cat82==8 | beginning==cat3_start & cat83==8 | beginning==cat3_start & cat84==8 | beginning==cat3_start & cat85==8 | beginning==cat3_start & cat86==8 | beginning==cat3_start & cat87==8 | beginning==cat3_start & cat88==8
replace indicator=0 if beginning==cat3_start & indicator==.
replace indicator=1 if beginning==cat4_start & cat5==8 | beginning==cat4_start & cat6==8 | beginning==cat4_start & cat7==8 | beginning==cat4_start & cat8==8 | beginning==cat4_start & cat9==8 | beginning==cat4_start & cat10==8 | beginning==cat4_start & cat11==8 | beginning==cat4_start & cat12==8 | beginning==cat4_start & cat13==8 | beginning==cat4_start & cat14==8 | beginning==cat4_start & cat15==8 | beginning==cat4_start & cat16==8 | beginning==cat4_start & cat17==8 | beginning==cat4_start & cat18==8 | beginning==cat4_start & cat19==8 | beginning==cat4_start & cat20==8 | beginning==cat4_start & cat21==8 | beginning==cat4_start & cat22==8 | beginning==cat4_start & cat23==8 | beginning==cat4_start & cat24==8 | beginning==cat4_start & cat25==8 | beginning==cat4_start & cat26==8 | beginning==cat4_start & cat27==8 | beginning==cat4_start & cat28==8 | beginning==cat4_start & cat29==8 | beginning==cat4_start & cat30==8 | beginning==cat4_start & cat31==8 | beginning==cat4_start & cat32==8 | beginning==cat4_start & cat33==8 | beginning==cat4_start & cat34==8 | beginning==cat4_start & cat35==8 | beginning==cat4_start & cat36==8 | beginning==cat4_start & cat37==8 | beginning==cat4_start & cat38==8 | beginning==cat4_start & cat39==8 | beginning==cat4_start & cat40==8 | beginning==cat4_start & cat41==8 | beginning==cat4_start & cat42==8 | beginning==cat4_start & cat43==8 | beginning==cat4_start & cat44==8 | beginning==cat4_start & cat45==8 | beginning==cat4_start & cat46==8 | beginning==cat4_start & cat47==8 | beginning==cat4_start & cat48==8 | beginning==cat4_start & cat49==8 | beginning==cat4_start & cat50==8 | beginning==cat4_start & cat51==8 | beginning==cat4_start & cat52==8 | beginning==cat4_start & cat53==8 | beginning==cat4_start & cat54==8 | beginning==cat4_start & cat55==8 | beginning==cat4_start & cat56==8 | beginning==cat4_start & cat57==8 | beginning==cat4_start & cat58==8 | beginning==cat4_start & cat59==8 | beginning==cat4_start & cat60==8 | beginning==cat4_start & cat61==8 | beginning==cat4_start & cat62==8 | beginning==cat4_start & cat63==8 | beginning==cat4_start & cat64==8 | beginning==cat4_start & cat65==8 | beginning==cat4_start & cat66==8 | beginning==cat4_start & cat67==8 | beginning==cat4_start & cat68==8 | beginning==cat4_start & cat69==8 | beginning==cat4_start & cat70==8 | beginning==cat4_start & cat71==8 | beginning==cat4_start & cat72==8 | beginning==cat4_start & cat73==8 | beginning==cat4_start & cat74==8 | beginning==cat4_start & cat75==8 | beginning==cat4_start & cat76==8 | beginning==cat4_start & cat77==8 | beginning==cat4_start & cat78==8 | beginning==cat4_start & cat79==8 | beginning==cat4_start & cat80==8 | beginning==cat4_start & cat81==8 | beginning==cat4_start & cat82==8 | beginning==cat4_start & cat83==8 | beginning==cat4_start & cat84==8 | beginning==cat4_start & cat85==8 | beginning==cat4_start & cat86==8 | beginning==cat4_start & cat87==8 | beginning==cat4_start & cat88==8
replace indicator=0 if beginning==cat4_start & indicator==.
replace indicator=1 if beginning==cat5_start & cat6==8 | beginning==cat5_start & cat7==8 | beginning==cat5_start & cat8==8 | beginning==cat5_start & cat9==8 | beginning==cat5_start & cat10==8 | beginning==cat5_start & cat11==8 | beginning==cat5_start & cat12==8 | beginning==cat5_start & cat13==8 | beginning==cat5_start & cat14==8 | beginning==cat5_start & cat15==8 | beginning==cat5_start & cat16==8 | beginning==cat5_start & cat17==8 | beginning==cat5_start & cat18==8 | beginning==cat5_start & cat19==8 | beginning==cat5_start & cat20==8 | beginning==cat5_start & cat21==8 | beginning==cat5_start & cat22==8 | beginning==cat5_start & cat23==8 | beginning==cat5_start & cat24==8 | beginning==cat5_start & cat25==8 | beginning==cat5_start & cat26==8 | beginning==cat5_start & cat27==8 | beginning==cat5_start & cat28==8 | beginning==cat5_start & cat29==8 | beginning==cat5_start & cat30==8 | beginning==cat5_start & cat31==8 | beginning==cat5_start & cat32==8 | beginning==cat5_start & cat33==8 | beginning==cat5_start & cat34==8 | beginning==cat5_start & cat35==8 | beginning==cat5_start & cat36==8 | beginning==cat5_start & cat37==8 | beginning==cat5_start & cat38==8 | beginning==cat5_start & cat39==8 | beginning==cat5_start & cat40==8 | beginning==cat5_start & cat41==8 | beginning==cat5_start & cat42==8 | beginning==cat5_start & cat43==8 | beginning==cat5_start & cat44==8 | beginning==cat5_start & cat45==8 | beginning==cat5_start & cat46==8 | beginning==cat5_start & cat47==8 | beginning==cat5_start & cat48==8 | beginning==cat5_start & cat49==8 | beginning==cat5_start & cat50==8 | beginning==cat5_start & cat51==8 | beginning==cat5_start & cat52==8 | beginning==cat5_start & cat53==8 | beginning==cat5_start & cat54==8 | beginning==cat5_start & cat55==8 | beginning==cat5_start & cat56==8 | beginning==cat5_start & cat57==8 | beginning==cat5_start & cat58==8 | beginning==cat5_start & cat59==8 | beginning==cat5_start & cat60==8 | beginning==cat5_start & cat61==8 | beginning==cat5_start & cat62==8 | beginning==cat5_start & cat63==8 | beginning==cat5_start & cat64==8 | beginning==cat5_start & cat65==8 | beginning==cat5_start & cat66==8 | beginning==cat5_start & cat67==8 | beginning==cat5_start & cat68==8 | beginning==cat5_start & cat69==8 | beginning==cat5_start & cat70==8 | beginning==cat5_start & cat71==8 | beginning==cat5_start & cat72==8 | beginning==cat5_start & cat73==8 | beginning==cat5_start & cat74==8 | beginning==cat5_start & cat75==8 | beginning==cat5_start & cat76==8 | beginning==cat5_start & cat77==8 | beginning==cat5_start & cat78==8 | beginning==cat5_start & cat79==8 | beginning==cat5_start & cat80==8 | beginning==cat5_start & cat81==8 | beginning==cat5_start & cat82==8 | beginning==cat5_start & cat83==8 | beginning==cat5_start & cat84==8 | beginning==cat5_start & cat85==8 | beginning==cat5_start & cat86==8 | beginning==cat5_start & cat87==8 | beginning==cat5_start & cat88==8
replace indicator=0 if beginning==cat5_start & indicator==.
replace indicator=1 if beginning==cat6_start & cat7==8 | beginning==cat6_start & cat8==8 | beginning==cat6_start & cat9==8 | beginning==cat6_start & cat10==8 | beginning==cat6_start & cat11==8 | beginning==cat6_start & cat12==8 | beginning==cat6_start & cat13==8 | beginning==cat6_start & cat14==8 | beginning==cat6_start & cat15==8 | beginning==cat6_start & cat16==8 | beginning==cat6_start & cat17==8 | beginning==cat6_start & cat18==8 | beginning==cat6_start & cat19==8 | beginning==cat6_start & cat20==8 | beginning==cat6_start & cat21==8 | beginning==cat6_start & cat22==8 | beginning==cat6_start & cat23==8 | beginning==cat6_start & cat24==8 | beginning==cat6_start & cat25==8 | beginning==cat6_start & cat26==8 | beginning==cat6_start & cat27==8 | beginning==cat6_start & cat28==8 | beginning==cat6_start & cat29==8 | beginning==cat6_start & cat30==8 | beginning==cat6_start & cat31==8 | beginning==cat6_start & cat32==8 | beginning==cat6_start & cat33==8 | beginning==cat6_start & cat34==8 | beginning==cat6_start & cat35==8 | beginning==cat6_start & cat36==8 | beginning==cat6_start & cat37==8 | beginning==cat6_start & cat38==8 | beginning==cat6_start & cat39==8 | beginning==cat6_start & cat40==8 | beginning==cat6_start & cat41==8 | beginning==cat6_start & cat42==8 | beginning==cat6_start & cat43==8 | beginning==cat6_start & cat44==8 | beginning==cat6_start & cat45==8 | beginning==cat6_start & cat46==8 | beginning==cat6_start & cat47==8 | beginning==cat6_start & cat48==8 | beginning==cat6_start & cat49==8 | beginning==cat6_start & cat50==8 | beginning==cat6_start & cat51==8 | beginning==cat6_start & cat52==8 | beginning==cat6_start & cat53==8 | beginning==cat6_start & cat54==8 | beginning==cat6_start & cat55==8 | beginning==cat6_start & cat56==8 | beginning==cat6_start & cat57==8 | beginning==cat6_start & cat58==8 | beginning==cat6_start & cat59==8 | beginning==cat6_start & cat60==8 | beginning==cat6_start & cat61==8 | beginning==cat6_start & cat62==8 | beginning==cat6_start & cat63==8 | beginning==cat6_start & cat64==8 | beginning==cat6_start & cat65==8 | beginning==cat6_start & cat66==8 | beginning==cat6_start & cat67==8 | beginning==cat6_start & cat68==8 | beginning==cat6_start & cat69==8 | beginning==cat6_start & cat70==8 | beginning==cat6_start & cat71==8 | beginning==cat6_start & cat72==8 | beginning==cat6_start & cat73==8 | beginning==cat6_start & cat74==8 | beginning==cat6_start & cat75==8 | beginning==cat6_start & cat76==8 | beginning==cat6_start & cat77==8 | beginning==cat6_start & cat78==8 | beginning==cat6_start & cat79==8 | beginning==cat6_start & cat80==8 | beginning==cat6_start & cat81==8 | beginning==cat6_start & cat82==8 | beginning==cat6_start & cat83==8 | beginning==cat6_start & cat84==8 | beginning==cat6_start & cat85==8 | beginning==cat6_start & cat86==8 | beginning==cat6_start & cat87==8 | beginning==cat6_start & cat88==8
replace indicator=0 if beginning==cat6_start & indicator==.
replace indicator=1 if beginning==cat7_start & cat8==8 | beginning==cat7_start & cat9==8 | beginning==cat7_start & cat10==8 | beginning==cat7_start & cat11==8 | beginning==cat7_start & cat12==8 | beginning==cat7_start & cat13==8 | beginning==cat7_start & cat14==8 | beginning==cat7_start & cat15==8 | beginning==cat7_start & cat16==8 | beginning==cat7_start & cat17==8 | beginning==cat7_start & cat18==8 | beginning==cat7_start & cat19==8 | beginning==cat7_start & cat20==8 | beginning==cat7_start & cat21==8 | beginning==cat7_start & cat22==8 | beginning==cat7_start & cat23==8 | beginning==cat7_start & cat24==8 | beginning==cat7_start & cat25==8 | beginning==cat7_start & cat26==8 | beginning==cat7_start & cat27==8 | beginning==cat7_start & cat28==8 | beginning==cat7_start & cat29==8 | beginning==cat7_start & cat30==8 | beginning==cat7_start & cat31==8 | beginning==cat7_start & cat32==8 | beginning==cat7_start & cat33==8 | beginning==cat7_start & cat34==8 | beginning==cat7_start & cat35==8 | beginning==cat7_start & cat36==8 | beginning==cat7_start & cat37==8 | beginning==cat7_start & cat38==8 | beginning==cat7_start & cat39==8 | beginning==cat7_start & cat40==8 | beginning==cat7_start & cat41==8 | beginning==cat7_start & cat42==8 | beginning==cat7_start & cat43==8 | beginning==cat7_start & cat44==8 | beginning==cat7_start & cat45==8 | beginning==cat7_start & cat46==8 | beginning==cat7_start & cat47==8 | beginning==cat7_start & cat48==8 | beginning==cat7_start & cat49==8 | beginning==cat7_start & cat50==8 | beginning==cat7_start & cat51==8 | beginning==cat7_start & cat52==8 | beginning==cat7_start & cat53==8 | beginning==cat7_start & cat54==8 | beginning==cat7_start & cat55==8 | beginning==cat7_start & cat56==8 | beginning==cat7_start & cat57==8 | beginning==cat7_start & cat58==8 | beginning==cat7_start & cat59==8 | beginning==cat7_start & cat60==8 | beginning==cat7_start & cat61==8 | beginning==cat7_start & cat62==8 | beginning==cat7_start & cat63==8 | beginning==cat7_start & cat64==8 | beginning==cat7_start & cat65==8 | beginning==cat7_start & cat66==8 | beginning==cat7_start & cat67==8 | beginning==cat7_start & cat68==8 | beginning==cat7_start & cat69==8 | beginning==cat7_start & cat70==8 | beginning==cat7_start & cat71==8 | beginning==cat7_start & cat72==8 | beginning==cat7_start & cat73==8 | beginning==cat7_start & cat74==8 | beginning==cat7_start & cat75==8 | beginning==cat7_start & cat76==8 | beginning==cat7_start & cat77==8 | beginning==cat7_start & cat78==8 | beginning==cat7_start & cat79==8 | beginning==cat7_start & cat80==8 | beginning==cat7_start & cat81==8 | beginning==cat7_start & cat82==8 | beginning==cat7_start & cat83==8 | beginning==cat7_start & cat84==8 | beginning==cat7_start & cat85==8 | beginning==cat7_start & cat86==8 | beginning==cat7_start & cat87==8 | beginning==cat7_start & cat88==8
replace indicator=0 if beginning==cat7_start & indicator==.
replace indicator=1 if beginning==cat8_start & cat9==8 | beginning==cat8_start & cat10==8 | beginning==cat8_start & cat11==8 | beginning==cat8_start & cat12==8 | beginning==cat8_start & cat13==8 | beginning==cat8_start & cat14==8 | beginning==cat8_start & cat15==8 | beginning==cat8_start & cat16==8 | beginning==cat8_start & cat17==8 | beginning==cat8_start & cat18==8 | beginning==cat8_start & cat19==8 | beginning==cat8_start & cat20==8 | beginning==cat8_start & cat21==8 | beginning==cat8_start & cat22==8 | beginning==cat8_start & cat23==8 | beginning==cat8_start & cat24==8 | beginning==cat8_start & cat25==8 | beginning==cat8_start & cat26==8 | beginning==cat8_start & cat27==8 | beginning==cat8_start & cat28==8 | beginning==cat8_start & cat29==8 | beginning==cat8_start & cat30==8 | beginning==cat8_start & cat31==8 | beginning==cat8_start & cat32==8 | beginning==cat8_start & cat33==8 | beginning==cat8_start & cat34==8 | beginning==cat8_start & cat35==8 | beginning==cat8_start & cat36==8 | beginning==cat8_start & cat37==8 | beginning==cat8_start & cat38==8 | beginning==cat8_start & cat39==8 | beginning==cat8_start & cat40==8 | beginning==cat8_start & cat41==8 | beginning==cat8_start & cat42==8 | beginning==cat8_start & cat43==8 | beginning==cat8_start & cat44==8 | beginning==cat8_start & cat45==8 | beginning==cat8_start & cat46==8 | beginning==cat8_start & cat47==8 | beginning==cat8_start & cat48==8 | beginning==cat8_start & cat49==8 | beginning==cat8_start & cat50==8 | beginning==cat8_start & cat51==8 | beginning==cat8_start & cat52==8 | beginning==cat8_start & cat53==8 | beginning==cat8_start & cat54==8 | beginning==cat8_start & cat55==8 | beginning==cat8_start & cat56==8 | beginning==cat8_start & cat57==8 | beginning==cat8_start & cat58==8 | beginning==cat8_start & cat59==8 | beginning==cat8_start & cat60==8 | beginning==cat8_start & cat61==8 | beginning==cat8_start & cat62==8 | beginning==cat8_start & cat63==8 | beginning==cat8_start & cat64==8 | beginning==cat8_start & cat65==8 | beginning==cat8_start & cat66==8 | beginning==cat8_start & cat67==8 | beginning==cat8_start & cat68==8 | beginning==cat8_start & cat69==8 | beginning==cat8_start & cat70==8 | beginning==cat8_start & cat71==8 | beginning==cat8_start & cat72==8 | beginning==cat8_start & cat73==8 | beginning==cat8_start & cat74==8 | beginning==cat8_start & cat75==8 | beginning==cat8_start & cat76==8 | beginning==cat8_start & cat77==8 | beginning==cat8_start & cat78==8 | beginning==cat8_start & cat79==8 | beginning==cat8_start & cat80==8 | beginning==cat8_start & cat81==8 | beginning==cat8_start & cat82==8 | beginning==cat8_start & cat83==8 | beginning==cat8_start & cat84==8 | beginning==cat8_start & cat85==8 | beginning==cat8_start & cat86==8 | beginning==cat8_start & cat87==8 | beginning==cat8_start & cat88==8
replace indicator=0 if beginning==cat8_start & indicator==.
replace indicator=0 if beginning==end
replace indicator=1 if beginning==cat9_start & cat10==8 | beginning==cat9_start & cat11==8 | beginning==cat9_start & cat12==8 | beginning==cat9_start & cat13==8 | beginning==cat9_start & cat14==8 | beginning==cat9_start & cat15==8 | beginning==cat9_start & cat16==8 | beginning==cat9_start & cat17==8 | beginning==cat9_start & cat18==8 | beginning==cat9_start & cat19==8 | beginning==cat9_start & cat20==8 | beginning==cat9_start & cat21==8 | beginning==cat9_start & cat22==8 | beginning==cat9_start & cat23==8 | beginning==cat9_start & cat24==8 | beginning==cat9_start & cat25==8 | beginning==cat9_start & cat26==8 | beginning==cat9_start & cat27==8 | beginning==cat9_start & cat28==8 | beginning==cat9_start & cat29==8 | beginning==cat9_start & cat30==8 | beginning==cat9_start & cat31==8 | beginning==cat9_start & cat32==8 | beginning==cat9_start & cat33==8 | beginning==cat9_start & cat34==8 | beginning==cat9_start & cat35==8 | beginning==cat9_start & cat36==8 | beginning==cat9_start & cat37==8 | beginning==cat9_start & cat38==8 | beginning==cat9_start & cat39==8 | beginning==cat9_start & cat40==8 | beginning==cat9_start & cat41==8 | beginning==cat9_start & cat42==8 | beginning==cat9_start & cat43==8 | beginning==cat9_start & cat44==8 | beginning==cat9_start & cat45==8 | beginning==cat9_start & cat46==8 | beginning==cat9_start & cat47==8 | beginning==cat9_start & cat48==8 | beginning==cat9_start & cat49==8 | beginning==cat9_start & cat50==8 | beginning==cat9_start & cat51==8 | beginning==cat9_start & cat52==8 | beginning==cat9_start & cat53==8 | beginning==cat9_start & cat54==8 | beginning==cat9_start & cat55==8 | beginning==cat9_start & cat56==8 | beginning==cat9_start & cat57==8 | beginning==cat9_start & cat58==8 | beginning==cat9_start & cat59==8 | beginning==cat9_start & cat60==8 | beginning==cat9_start & cat61==8 | beginning==cat9_start & cat62==8 | beginning==cat9_start & cat63==8 | beginning==cat9_start & cat64==8 | beginning==cat9_start & cat65==8 | beginning==cat9_start & cat66==8 | beginning==cat9_start & cat67==8 | beginning==cat9_start & cat68==8 | beginning==cat9_start & cat69==8 | beginning==cat9_start & cat70==8 | beginning==cat9_start & cat71==8 | beginning==cat9_start & cat72==8 | beginning==cat9_start & cat73==8 | beginning==cat9_start & cat74==8 | beginning==cat9_start & cat75==8 | beginning==cat9_start & cat76==8 | beginning==cat9_start & cat77==8 | beginning==cat9_start & cat78==8 | beginning==cat9_start & cat79==8 | beginning==cat9_start & cat80==8 | beginning==cat9_start & cat81==8 | beginning==cat9_start & cat82==8 | beginning==cat9_start & cat83==8 | beginning==cat9_start & cat84==8 | beginning==cat9_start & cat85==8 | beginning==cat9_start & cat86==8 | beginning==cat9_start & cat87==8 | beginning==cat9_start & cat88==8
replace indicator=0 if beginning==cat9_start & indicator==.
replace indicator=1 if beginning==cat10_start & cat11==8 | beginning==cat10_start & cat12==8 | beginning==cat10_start & cat13==8 | beginning==cat10_start & cat14==8 | beginning==cat10_start & cat15==8 | beginning==cat10_start & cat16==8 | beginning==cat10_start & cat17==8 | beginning==cat10_start & cat18==8 | beginning==cat10_start & cat19==8 | beginning==cat10_start & cat20==8 | beginning==cat10_start & cat21==8 | beginning==cat10_start & cat22==8 | beginning==cat10_start & cat23==8 | beginning==cat10_start & cat24==8 | beginning==cat10_start & cat25==8 | beginning==cat10_start & cat26==8 | beginning==cat10_start & cat27==8 | beginning==cat10_start & cat28==8 | beginning==cat10_start & cat29==8 | beginning==cat10_start & cat30==8 | beginning==cat10_start & cat31==8 | beginning==cat10_start & cat32==8 | beginning==cat10_start & cat33==8 | beginning==cat10_start & cat34==8 | beginning==cat10_start & cat35==8 | beginning==cat10_start & cat36==8 | beginning==cat10_start & cat37==8 | beginning==cat10_start & cat38==8 | beginning==cat10_start & cat39==8 | beginning==cat10_start & cat40==8 | beginning==cat10_start & cat41==8 | beginning==cat10_start & cat42==8 | beginning==cat10_start & cat43==8 | beginning==cat10_start & cat44==8 | beginning==cat10_start & cat45==8 | beginning==cat10_start & cat46==8 | beginning==cat10_start & cat47==8 | beginning==cat10_start & cat48==8 | beginning==cat10_start & cat49==8 | beginning==cat10_start & cat50==8 | beginning==cat10_start & cat51==8 | beginning==cat10_start & cat52==8 | beginning==cat10_start & cat53==8 | beginning==cat10_start & cat54==8 | beginning==cat10_start & cat55==8 | beginning==cat10_start & cat56==8 | beginning==cat10_start & cat57==8 | beginning==cat10_start & cat58==8 | beginning==cat10_start & cat59==8 | beginning==cat10_start & cat60==8 | beginning==cat10_start & cat61==8 | beginning==cat10_start & cat62==8 | beginning==cat10_start & cat63==8 | beginning==cat10_start & cat64==8 | beginning==cat10_start & cat65==8 | beginning==cat10_start & cat66==8 | beginning==cat10_start & cat67==8 | beginning==cat10_start & cat68==8 | beginning==cat10_start & cat69==8 | beginning==cat10_start & cat70==8 | beginning==cat10_start & cat71==8 | beginning==cat10_start & cat72==8 | beginning==cat10_start & cat73==8 | beginning==cat10_start & cat74==8 | beginning==cat10_start & cat75==8 | beginning==cat10_start & cat76==8 | beginning==cat10_start & cat77==8 | beginning==cat10_start & cat78==8 | beginning==cat10_start & cat79==8 | beginning==cat10_start & cat80==8 | beginning==cat10_start & cat81==8 | beginning==cat10_start & cat82==8 | beginning==cat10_start & cat83==8 | beginning==cat10_start & cat84==8 | beginning==cat10_start & cat85==8 | beginning==cat10_start & cat86==8 | beginning==cat10_start & cat87==8 | beginning==cat10_start & cat88==8
replace indicator=0 if beginning==cat10_start & indicator==.
replace indicator=1 if beginning==cat11_start & cat12==8 | beginning==cat11_start & cat13==8 | beginning==cat11_start & cat14==8 | beginning==cat11_start & cat15==8 | beginning==cat11_start & cat16==8 | beginning==cat11_start & cat17==8 | beginning==cat11_start & cat18==8 | beginning==cat11_start & cat19==8 | beginning==cat11_start & cat20==8 | beginning==cat11_start & cat21==8 | beginning==cat11_start & cat22==8 | beginning==cat11_start & cat23==8 | beginning==cat11_start & cat24==8 | beginning==cat11_start & cat25==8 | beginning==cat11_start & cat26==8 | beginning==cat11_start & cat27==8 | beginning==cat11_start & cat28==8 | beginning==cat11_start & cat29==8 | beginning==cat11_start & cat30==8 | beginning==cat11_start & cat31==8 | beginning==cat11_start & cat32==8 | beginning==cat11_start & cat33==8 | beginning==cat11_start & cat34==8 | beginning==cat11_start & cat35==8 | beginning==cat11_start & cat36==8 | beginning==cat11_start & cat37==8 | beginning==cat11_start & cat38==8 | beginning==cat11_start & cat39==8 | beginning==cat11_start & cat40==8 | beginning==cat11_start & cat41==8 | beginning==cat11_start & cat42==8 | beginning==cat11_start & cat43==8 | beginning==cat11_start & cat44==8 | beginning==cat11_start & cat45==8 | beginning==cat11_start & cat46==8 | beginning==cat11_start & cat47==8 | beginning==cat11_start & cat48==8 | beginning==cat11_start & cat49==8 | beginning==cat11_start & cat50==8 | beginning==cat11_start & cat51==8 | beginning==cat11_start & cat52==8 | beginning==cat11_start & cat53==8 | beginning==cat11_start & cat54==8 | beginning==cat11_start & cat55==8 | beginning==cat11_start & cat56==8 | beginning==cat11_start & cat57==8 | beginning==cat11_start & cat58==8 | beginning==cat11_start & cat59==8 | beginning==cat11_start & cat60==8 | beginning==cat11_start & cat61==8 | beginning==cat11_start & cat62==8 | beginning==cat11_start & cat63==8 | beginning==cat11_start & cat64==8 | beginning==cat11_start & cat65==8 | beginning==cat11_start & cat66==8 | beginning==cat11_start & cat67==8 | beginning==cat11_start & cat68==8 | beginning==cat11_start & cat69==8 | beginning==cat11_start & cat70==8 | beginning==cat11_start & cat71==8 | beginning==cat11_start & cat72==8 | beginning==cat11_start & cat73==8 | beginning==cat11_start & cat74==8 | beginning==cat11_start & cat75==8 | beginning==cat11_start & cat76==8 | beginning==cat11_start & cat77==8 | beginning==cat11_start & cat78==8 | beginning==cat11_start & cat79==8 | beginning==cat11_start & cat80==8 | beginning==cat11_start & cat81==8 | beginning==cat11_start & cat82==8 | beginning==cat11_start & cat83==8 | beginning==cat11_start & cat84==8 | beginning==cat11_start & cat85==8 | beginning==cat11_start & cat86==8 | beginning==cat11_start & cat87==8 | beginning==cat11_start & cat88==8
replace indicator=0 if beginning==cat11_start & indicator==.
replace indicator=1 if beginning==cat12_start & cat13==8 | beginning==cat12_start & cat14==8 | beginning==cat12_start & cat15==8 | beginning==cat12_start & cat16==8 | beginning==cat12_start & cat17==8 | beginning==cat12_start & cat18==8 | beginning==cat12_start & cat19==8 | beginning==cat12_start & cat20==8 | beginning==cat12_start & cat21==8 | beginning==cat12_start & cat22==8 | beginning==cat12_start & cat23==8 | beginning==cat12_start & cat24==8 | beginning==cat12_start & cat25==8 | beginning==cat12_start & cat26==8 | beginning==cat12_start & cat27==8 | beginning==cat12_start & cat28==8 | beginning==cat12_start & cat29==8 | beginning==cat12_start & cat30==8 | beginning==cat12_start & cat31==8 | beginning==cat12_start & cat32==8 | beginning==cat12_start & cat33==8 | beginning==cat12_start & cat34==8 | beginning==cat12_start & cat35==8 | beginning==cat12_start & cat36==8 | beginning==cat12_start & cat37==8 | beginning==cat12_start & cat38==8 | beginning==cat12_start & cat39==8 | beginning==cat12_start & cat40==8 | beginning==cat12_start & cat41==8 | beginning==cat12_start & cat42==8 | beginning==cat12_start & cat43==8 | beginning==cat12_start & cat44==8 | beginning==cat12_start & cat45==8 | beginning==cat12_start & cat46==8 | beginning==cat12_start & cat47==8 | beginning==cat12_start & cat48==8 | beginning==cat12_start & cat49==8 | beginning==cat12_start & cat50==8 | beginning==cat12_start & cat51==8 | beginning==cat12_start & cat52==8 | beginning==cat12_start & cat53==8 | beginning==cat12_start & cat54==8 | beginning==cat12_start & cat55==8 | beginning==cat12_start & cat56==8 | beginning==cat12_start & cat57==8 | beginning==cat12_start & cat58==8 | beginning==cat12_start & cat59==8 | beginning==cat12_start & cat60==8 | beginning==cat12_start & cat61==8 | beginning==cat12_start & cat62==8 | beginning==cat12_start & cat63==8 | beginning==cat12_start & cat64==8 | beginning==cat12_start & cat65==8 | beginning==cat12_start & cat66==8 | beginning==cat12_start & cat67==8 | beginning==cat12_start & cat68==8 | beginning==cat12_start & cat69==8 | beginning==cat12_start & cat70==8 | beginning==cat12_start & cat71==8 | beginning==cat12_start & cat72==8 | beginning==cat12_start & cat73==8 | beginning==cat12_start & cat74==8 | beginning==cat12_start & cat75==8 | beginning==cat12_start & cat76==8 | beginning==cat12_start & cat77==8 | beginning==cat12_start & cat78==8 | beginning==cat12_start & cat79==8 | beginning==cat12_start & cat80==8 | beginning==cat12_start & cat81==8 | beginning==cat12_start & cat82==8 | beginning==cat12_start & cat83==8 | beginning==cat12_start & cat84==8 | beginning==cat12_start & cat85==8 | beginning==cat12_start & cat86==8 | beginning==cat12_start & cat87==8 | beginning==cat12_start & cat88==8
replace indicator=0 if beginning==cat12_start & indicator==.
replace indicator=1 if beginning==cat13_start & cat14==8 | beginning==cat13_start & cat15==8 | beginning==cat13_start & cat16==8 | beginning==cat13_start & cat17==8 | beginning==cat13_start & cat18==8 | beginning==cat13_start & cat19==8 | beginning==cat13_start & cat20==8 | beginning==cat13_start & cat21==8 | beginning==cat13_start & cat22==8 | beginning==cat13_start & cat23==8 | beginning==cat13_start & cat24==8 | beginning==cat13_start & cat25==8 | beginning==cat13_start & cat26==8 | beginning==cat13_start & cat27==8 | beginning==cat13_start & cat28==8 | beginning==cat13_start & cat29==8 | beginning==cat13_start & cat30==8 | beginning==cat13_start & cat31==8 | beginning==cat13_start & cat32==8 | beginning==cat13_start & cat33==8 | beginning==cat13_start & cat34==8 | beginning==cat13_start & cat35==8 | beginning==cat13_start & cat36==8 | beginning==cat13_start & cat37==8 | beginning==cat13_start & cat38==8 | beginning==cat13_start & cat39==8 | beginning==cat13_start & cat40==8 | beginning==cat13_start & cat41==8 | beginning==cat13_start & cat42==8 | beginning==cat13_start & cat43==8 | beginning==cat13_start & cat44==8 | beginning==cat13_start & cat45==8 | beginning==cat13_start & cat46==8 | beginning==cat13_start & cat47==8 | beginning==cat13_start & cat48==8 | beginning==cat13_start & cat49==8 | beginning==cat13_start & cat50==8 | beginning==cat13_start & cat51==8 | beginning==cat13_start & cat52==8 | beginning==cat13_start & cat53==8 | beginning==cat13_start & cat54==8 | beginning==cat13_start & cat55==8 | beginning==cat13_start & cat56==8 | beginning==cat13_start & cat57==8 | beginning==cat13_start & cat58==8 | beginning==cat13_start & cat59==8 | beginning==cat13_start & cat60==8 | beginning==cat13_start & cat61==8 | beginning==cat13_start & cat62==8 | beginning==cat13_start & cat63==8 | beginning==cat13_start & cat64==8 | beginning==cat13_start & cat65==8 | beginning==cat13_start & cat66==8 | beginning==cat13_start & cat67==8 | beginning==cat13_start & cat68==8 | beginning==cat13_start & cat69==8 | beginning==cat13_start & cat70==8 | beginning==cat13_start & cat71==8 | beginning==cat13_start & cat72==8 | beginning==cat13_start & cat73==8 | beginning==cat13_start & cat74==8 | beginning==cat13_start & cat75==8 | beginning==cat13_start & cat76==8 | beginning==cat13_start & cat77==8 | beginning==cat13_start & cat78==8 | beginning==cat13_start & cat79==8 | beginning==cat13_start & cat80==8 | beginning==cat13_start & cat81==8 | beginning==cat13_start & cat82==8 | beginning==cat13_start & cat83==8 | beginning==cat13_start & cat84==8 | beginning==cat13_start & cat85==8 | beginning==cat13_start & cat86==8 | beginning==cat13_start & cat87==8 | beginning==cat13_start & cat88==8
replace indicator=0 if beginning==cat13_start & indicator==.
replace indicator=1 if beginning==cat14_start & cat15==8 | beginning==cat14_start & cat16==8 | beginning==cat14_start & cat17==8 | beginning==cat14_start & cat18==8 | beginning==cat14_start & cat19==8 | beginning==cat14_start & cat20==8 | beginning==cat14_start & cat21==8 | beginning==cat14_start & cat22==8 | beginning==cat14_start & cat23==8 | beginning==cat14_start & cat24==8 | beginning==cat14_start & cat25==8 | beginning==cat14_start & cat26==8 | beginning==cat14_start & cat27==8 | beginning==cat14_start & cat28==8 | beginning==cat14_start & cat29==8 | beginning==cat14_start & cat30==8 | beginning==cat14_start & cat31==8 | beginning==cat14_start & cat32==8 | beginning==cat14_start & cat33==8 | beginning==cat14_start & cat34==8 | beginning==cat14_start & cat35==8 | beginning==cat14_start & cat36==8 | beginning==cat14_start & cat37==8 | beginning==cat14_start & cat38==8 | beginning==cat14_start & cat39==8 | beginning==cat14_start & cat40==8 | beginning==cat14_start & cat41==8 | beginning==cat14_start & cat42==8 | beginning==cat14_start & cat43==8 | beginning==cat14_start & cat44==8 | beginning==cat14_start & cat45==8 | beginning==cat14_start & cat46==8 | beginning==cat14_start & cat47==8 | beginning==cat14_start & cat48==8 | beginning==cat14_start & cat49==8 | beginning==cat14_start & cat50==8 | beginning==cat14_start & cat51==8 | beginning==cat14_start & cat52==8 | beginning==cat14_start & cat53==8 | beginning==cat14_start & cat54==8 | beginning==cat14_start & cat55==8 | beginning==cat14_start & cat56==8 | beginning==cat14_start & cat57==8 | beginning==cat14_start & cat58==8 | beginning==cat14_start & cat59==8 | beginning==cat14_start & cat60==8 | beginning==cat14_start & cat61==8 | beginning==cat14_start & cat62==8 | beginning==cat14_start & cat63==8 | beginning==cat14_start & cat64==8 | beginning==cat14_start & cat65==8 | beginning==cat14_start & cat66==8 | beginning==cat14_start & cat67==8 | beginning==cat14_start & cat68==8 | beginning==cat14_start & cat69==8 | beginning==cat14_start & cat70==8 | beginning==cat14_start & cat71==8 | beginning==cat14_start & cat72==8 | beginning==cat14_start & cat73==8 | beginning==cat14_start & cat74==8 | beginning==cat14_start & cat75==8 | beginning==cat14_start & cat76==8 | beginning==cat14_start & cat77==8 | beginning==cat14_start & cat78==8 | beginning==cat14_start & cat79==8 | beginning==cat14_start & cat80==8 | beginning==cat14_start & cat81==8 | beginning==cat14_start & cat82==8 | beginning==cat14_start & cat83==8 | beginning==cat14_start & cat84==8 | beginning==cat14_start & cat85==8 | beginning==cat14_start & cat86==8 | beginning==cat14_start & cat87==8 | beginning==cat14_start & cat88==8
replace indicator=0 if beginning==cat14_start & indicator==.
replace indicator=0 if beginning==cat15_start & cat16==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==.
replace indicator=1 if beginning==cat15_start & cat16==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat16_start & cat17==.
replace indicator=1 if beginning==cat16_start & cat17==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18==.
replace indicator=1 if beginning==cat17_start & cat18==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==.
replace indicator=0 if beginning==cat18_start & cat19==.
replace indicator=1 if beginning==cat18_start & cat19==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21==.
replace indicator=1 if beginning==cat19_start & cat20==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat21_start & cat22==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31==.
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat24_start & cat25==.
replace indicator=0 if beginning==cat39_start & cat73!=8 & cat74==.
replace indicator=1 if beginning==cat48_start & cat49==8
replace indicator=1 if beginning==cat50_start & cat51==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==.
replace indicator=1 if beginning==cat25_start & cat26==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==.
replace indicator=0 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==.
replace indicator=1 if beginning==cat21_start & cat22==8
replace indicator=1 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat46_start & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52==.
replace indicator=0 if beginning==cat36_start & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49==.
replace indicator=0 if beginning==cat24_start & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat53_start & cat54==.
replace indicator=0 if beginning==cat34_start & cat35!=8 & cat36!=8 & cat37!=8 & cat38==.
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace indicator=0 if beginning==cat52_start & cat53!=8 & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58==.
replace indicator=1 if beginning==cat27_start & cat28==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=1 if beginning==cat20_start & cat21==8
replace indicator=1 if beginning==cat23_start & cat24==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29==.
replace indicator=1 if beginning==cat29_start & cat30==8
replace indicator=1 if beginning==cat22_start & cat23==8
replace indicator=1 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18==8
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
tab indicator,m
* Drop individuals that are not in the risk set
drop if indicator==0
drop indicator

* Construct the 'beginning' variable
gen beginning2 = .
replace beginning2 = cat3_start if beginning==cat2_start & cat3==8
order folio_n20 beginning beginning2
replace beginning2 = cat4_start if beginning==cat2_start & cat3!=8 & cat4==8
replace beginning2 = cat5_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat4_start if beginning==cat3_start & cat4==8
replace beginning2 = cat5_start if beginning==cat3_start & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat5_start if beginning==cat4_start & cat5==8
replace beginning2 = cat6_start if beginning==cat4_start & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat6_start if beginning==cat5_start & cat6==8
replace beginning2 = cat7_start if beginning==cat5_start & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat7_start if beginning==cat6_start & cat7==8
replace beginning2 = cat8_start if beginning==cat6_start & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat23_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat24_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat8_start if beginning==cat7_start & cat8==8
replace beginning2 = cat9_start if beginning==cat7_start & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat9_start if beginning==cat8_start & cat9==8
replace beginning2 = cat10_start if beginning==cat8_start & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat10_start if beginning==cat9_start & cat10==8
replace beginning2 = cat11_start if beginning==cat9_start & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat16_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat11_start if beginning==cat10_start & cat11==8
replace beginning2 = cat12_start if beginning==cat10_start & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat17_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat12_start if beginning==cat11_start & cat12==8
replace beginning2 = cat13_start if beginning==cat11_start & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat13_start if beginning==cat12_start & cat13==8
replace beginning2 = cat14_start if beginning==cat12_start & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat14_start if beginning==cat13_start & cat14==8
replace beginning2 = cat15_start if beginning==cat13_start & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat15_start if beginning==cat14_start & cat15==8
replace beginning2 = cat16_start if beginning==cat14_start & cat15!=8 & cat16==8
replace beginning2 = cat16_start if beginning==cat15_start & cat16==8
replace beginning2 = cat17_start if beginning==cat15_start & cat16!=8 & cat17==8
replace beginning2 = cat17_start if beginning==cat16_start & cat17==8
replace beginning2 = cat18_start if beginning==cat17_start & cat18==8
replace beginning2 = cat19_start if beginning==cat18_start & cat19==8
replace beginning2 = cat20_start if beginning==cat19_start & cat20==8
replace beginning2 = cat25_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23!=2 & cat24!=2 & cat25==2
replace beginning2 = cat35_start if beginning==cat32_start & cat33!=8 & cat34!=8 & cat35==8
replace beginning2 = cat17_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat16_start & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat24_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat19_start if beginning==cat17_start & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat18_start & cat19!=8 & cat20==8
replace beginning2 = cat21_start if beginning==cat19_start & cat20!=8 & cat21==8
replace beginning2 = cat22_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat22_start if beginning==cat21_start & cat22==8
replace beginning2 = cat18_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat14_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat15_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat14_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat25_start if beginning==cat24_start & cat25==8
replace beginning2 = cat16_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat24_start if beginning==cat23_start & cat24==8
replace beginning2 = cat20_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat23_start if beginning==cat21_start & cat22!=8 & cat23==8
replace beginning2 = cat19_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat17_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat21_start if beginning==cat20_start & cat21==8
replace beginning2 = cat30_start if beginning==cat29_start & cat30==8
replace beginning2 = cat23_start if beginning==cat22_start & cat23==8
replace beginning2 = cat17_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat24_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat26_start if beginning==cat25_start & cat26==8
replace beginning2 = cat20_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat20_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat23_start if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8

* Make sure that there are no missings
tab beginning2,m
drop beginning
rename beginning2 beginning

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat3_start & cat4==1
order event,after(folio_n20)
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=0 if beginning==cat29_start & cat30==.
replace event=3 if beginning==cat48_start & cat49==3
replace event=4 if beginning==cat26_start & cat27==4
replace event=6 if beginning==cat27_start & cat28==6
replace event=5 if beginning==cat35_start & cat36==5
replace event=9 if beginning==cat30_start & cat31==10
replace event=6 if beginning==cat26_start & cat27==6

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat29_start - beginning if beginning==cat28_start & cat29!=8 & cat29!=.
replace duration = cat31_start - beginning if beginning==cat30_start & cat31!=8 & cat31!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat52_start - beginning if beginning==cat51_start & cat52!=8 & cat52!=.

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC4_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =4

* Define the education variables
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling10 if beginning==cat10_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079) 
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC4_informal", replace

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 5: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load the dataset for analysis
clear
use "$resultdir\sample_RC4_informal"

drop event
replace beginning=beginning+duration
drop duration

* Create risk set: individuals that are in RC informal of order 5 across multiple categories
gen indicator = .  // Initialize the variable
replace indicator=1 if beginning==cat2_start & cat3==8 | beginning==cat2_start & cat4==8 | beginning==cat2_start & cat5==8 | beginning==cat2_start & cat6==8 | beginning==cat2_start & cat7==8 | beginning==cat2_start & cat8==8 | beginning==cat2_start & cat9==8 | beginning==cat2_start & cat10==8 | beginning==cat2_start & cat11==8 | beginning==cat2_start & cat12==8 | beginning==cat2_start & cat13==8 | beginning==cat2_start & cat14==8 | beginning==cat2_start & cat15==8 | beginning==cat2_start & cat16==8 | beginning==cat2_start & cat17==8 | beginning==cat2_start & cat18==8 | beginning==cat2_start & cat19==8 | beginning==cat2_start & cat20==8 | beginning==cat2_start & cat21==8 | beginning==cat2_start & cat22==8 | beginning==cat2_start & cat23==8 | beginning==cat2_start & cat24==8 | beginning==cat2_start & cat25==8 | beginning==cat2_start & cat26==8 | beginning==cat2_start & cat27==8 | beginning==cat2_start & cat28==8 | beginning==cat2_start & cat29==8 | beginning==cat2_start & cat30==8 | beginning==cat2_start & cat31==8 | beginning==cat2_start & cat32==8 | beginning==cat2_start & cat33==8 | beginning==cat2_start & cat34==8 | beginning==cat2_start & cat35==8 | beginning==cat2_start & cat36==8 | beginning==cat2_start & cat37==8 | beginning==cat2_start & cat38==8 | beginning==cat2_start & cat39==8 | beginning==cat2_start & cat40==8 | beginning==cat2_start & cat41==8 | beginning==cat2_start & cat42==8 | beginning==cat2_start & cat43==8 | beginning==cat2_start & cat44==8 | beginning==cat2_start & cat45==8 | beginning==cat2_start & cat46==8 | beginning==cat2_start & cat47==8 | beginning==cat2_start & cat48==8 | beginning==cat2_start & cat49==8 | beginning==cat2_start & cat50==8 | beginning==cat2_start & cat51==8 | beginning==cat2_start & cat52==8 | beginning==cat2_start & cat53==8 | beginning==cat2_start & cat54==8 | beginning==cat2_start & cat55==8 | beginning==cat2_start & cat56==8 | beginning==cat2_start & cat57==8 | beginning==cat2_start & cat58==8 | beginning==cat2_start & cat59==8 | beginning==cat2_start & cat60==8 | beginning==cat2_start & cat61==8 | beginning==cat2_start & cat62==8 | beginning==cat2_start & cat63==8 | beginning==cat2_start & cat64==8 | beginning==cat2_start & cat65==8 | beginning==cat2_start & cat66==8 | beginning==cat2_start & cat67==8 | beginning==cat2_start & cat68==8 | beginning==cat2_start & cat69==8 | beginning==cat2_start & cat70==8 | beginning==cat2_start & cat71==8 | beginning==cat2_start & cat72==8 | beginning==cat2_start & cat73==8 | beginning==cat2_start & cat74==8 | beginning==cat2_start & cat75==8 | beginning==cat2_start & cat76==8 | beginning==cat2_start & cat77==8 | beginning==cat2_start & cat78==8 | beginning==cat2_start & cat79==8 | beginning==cat2_start & cat80==8 | beginning==cat2_start & cat81==8 | beginning==cat2_start & cat82==8 | beginning==cat2_start & cat83==8 | beginning==cat2_start & cat84==8 | beginning==cat2_start & cat85==8 | beginning==cat2_start & cat86==8 | beginning==cat2_start & cat87==8 | beginning==cat2_start & cat88==8
replace indicator=0 if beginning==cat2_start & indicator==.
replace indicator=1 if beginning==cat3_start & cat4==8 | beginning==cat3_start & cat5==8 | beginning==cat3_start & cat6==8 | beginning==cat3_start & cat7==8 | beginning==cat3_start & cat8==8 | beginning==cat3_start & cat9==8 | beginning==cat3_start & cat10==8 | beginning==cat3_start & cat11==8 | beginning==cat3_start & cat12==8 | beginning==cat3_start & cat13==8 | beginning==cat3_start & cat14==8 | beginning==cat3_start & cat15==8 | beginning==cat3_start & cat16==8 | beginning==cat3_start & cat17==8 | beginning==cat3_start & cat18==8 | beginning==cat3_start & cat19==8 | beginning==cat3_start & cat20==8 | beginning==cat3_start & cat21==8 | beginning==cat3_start & cat22==8 | beginning==cat3_start & cat23==8 | beginning==cat3_start & cat24==8 | beginning==cat3_start & cat25==8 | beginning==cat3_start & cat26==8 | beginning==cat3_start & cat27==8 | beginning==cat3_start & cat28==8 | beginning==cat3_start & cat29==8 | beginning==cat3_start & cat30==8 | beginning==cat3_start & cat31==8 | beginning==cat3_start & cat32==8 | beginning==cat3_start & cat33==8 | beginning==cat3_start & cat34==8 | beginning==cat3_start & cat35==8 | beginning==cat3_start & cat36==8 | beginning==cat3_start & cat37==8 | beginning==cat3_start & cat38==8 | beginning==cat3_start & cat39==8 | beginning==cat3_start & cat40==8 | beginning==cat3_start & cat41==8 | beginning==cat3_start & cat42==8 | beginning==cat3_start & cat43==8 | beginning==cat3_start & cat44==8 | beginning==cat3_start & cat45==8 | beginning==cat3_start & cat46==8 | beginning==cat3_start & cat47==8 | beginning==cat3_start & cat48==8 | beginning==cat3_start & cat49==8 | beginning==cat3_start & cat50==8 | beginning==cat3_start & cat51==8 | beginning==cat3_start & cat52==8 | beginning==cat3_start & cat53==8 | beginning==cat3_start & cat54==8 | beginning==cat3_start & cat55==8 | beginning==cat3_start & cat56==8 | beginning==cat3_start & cat57==8 | beginning==cat3_start & cat58==8 | beginning==cat3_start & cat59==8 | beginning==cat3_start & cat60==8 | beginning==cat3_start & cat61==8 | beginning==cat3_start & cat62==8 | beginning==cat3_start & cat63==8 | beginning==cat3_start & cat64==8 | beginning==cat3_start & cat65==8 | beginning==cat3_start & cat66==8 | beginning==cat3_start & cat67==8 | beginning==cat3_start & cat68==8 | beginning==cat3_start & cat69==8 | beginning==cat3_start & cat70==8 | beginning==cat3_start & cat71==8 | beginning==cat3_start & cat72==8 | beginning==cat3_start & cat73==8 | beginning==cat3_start & cat74==8 | beginning==cat3_start & cat75==8 | beginning==cat3_start & cat76==8 | beginning==cat3_start & cat77==8 | beginning==cat3_start & cat78==8 | beginning==cat3_start & cat79==8 | beginning==cat3_start & cat80==8 | beginning==cat3_start & cat81==8 | beginning==cat3_start & cat82==8 | beginning==cat3_start & cat83==8 | beginning==cat3_start & cat84==8 | beginning==cat3_start & cat85==8 | beginning==cat3_start & cat86==8 | beginning==cat3_start & cat87==8 | beginning==cat3_start & cat88==8
replace indicator=0 if beginning==cat3_start & indicator==.
replace indicator=1 if beginning==cat4_start & cat5==8 | beginning==cat4_start & cat6==8 | beginning==cat4_start & cat7==8 | beginning==cat4_start & cat8==8 | beginning==cat4_start & cat9==8 | beginning==cat4_start & cat10==8 | beginning==cat4_start & cat11==8 | beginning==cat4_start & cat12==8 | beginning==cat4_start & cat13==8 | beginning==cat4_start & cat14==8 | beginning==cat4_start & cat15==8 | beginning==cat4_start & cat16==8 | beginning==cat4_start & cat17==8 | beginning==cat4_start & cat18==8 | beginning==cat4_start & cat19==8 | beginning==cat4_start & cat20==8 | beginning==cat4_start & cat21==8 | beginning==cat4_start & cat22==8 | beginning==cat4_start & cat23==8 | beginning==cat4_start & cat24==8 | beginning==cat4_start & cat25==8 | beginning==cat4_start & cat26==8 | beginning==cat4_start & cat27==8 | beginning==cat4_start & cat28==8 | beginning==cat4_start & cat29==8 | beginning==cat4_start & cat30==8 | beginning==cat4_start & cat31==8 | beginning==cat4_start & cat32==8 | beginning==cat4_start & cat33==8 | beginning==cat4_start & cat34==8 | beginning==cat4_start & cat35==8 | beginning==cat4_start & cat36==8 | beginning==cat4_start & cat37==8 | beginning==cat4_start & cat38==8 | beginning==cat4_start & cat39==8 | beginning==cat4_start & cat40==8 | beginning==cat4_start & cat41==8 | beginning==cat4_start & cat42==8 | beginning==cat4_start & cat43==8 | beginning==cat4_start & cat44==8 | beginning==cat4_start & cat45==8 | beginning==cat4_start & cat46==8 | beginning==cat4_start & cat47==8 | beginning==cat4_start & cat48==8 | beginning==cat4_start & cat49==8 | beginning==cat4_start & cat50==8 | beginning==cat4_start & cat51==8 | beginning==cat4_start & cat52==8 | beginning==cat4_start & cat53==8 | beginning==cat4_start & cat54==8 | beginning==cat4_start & cat55==8 | beginning==cat4_start & cat56==8 | beginning==cat4_start & cat57==8 | beginning==cat4_start & cat58==8 | beginning==cat4_start & cat59==8 | beginning==cat4_start & cat60==8 | beginning==cat4_start & cat61==8 | beginning==cat4_start & cat62==8 | beginning==cat4_start & cat63==8 | beginning==cat4_start & cat64==8 | beginning==cat4_start & cat65==8 | beginning==cat4_start & cat66==8 | beginning==cat4_start & cat67==8 | beginning==cat4_start & cat68==8 | beginning==cat4_start & cat69==8 | beginning==cat4_start & cat70==8 | beginning==cat4_start & cat71==8 | beginning==cat4_start & cat72==8 | beginning==cat4_start & cat73==8 | beginning==cat4_start & cat74==8 | beginning==cat4_start & cat75==8 | beginning==cat4_start & cat76==8 | beginning==cat4_start & cat77==8 | beginning==cat4_start & cat78==8 | beginning==cat4_start & cat79==8 | beginning==cat4_start & cat80==8 | beginning==cat4_start & cat81==8 | beginning==cat4_start & cat82==8 | beginning==cat4_start & cat83==8 | beginning==cat4_start & cat84==8 | beginning==cat4_start & cat85==8 | beginning==cat4_start & cat86==8 | beginning==cat4_start & cat87==8 | beginning==cat4_start & cat88==8
replace indicator=0 if beginning==cat4_start & indicator==.
replace indicator=1 if beginning==cat5_start & cat6==8 | beginning==cat5_start & cat7==8 | beginning==cat5_start & cat8==8 | beginning==cat5_start & cat9==8 | beginning==cat5_start & cat10==8 | beginning==cat5_start & cat11==8 | beginning==cat5_start & cat12==8 | beginning==cat5_start & cat13==8 | beginning==cat5_start & cat14==8 | beginning==cat5_start & cat15==8 | beginning==cat5_start & cat16==8 | beginning==cat5_start & cat17==8 | beginning==cat5_start & cat18==8 | beginning==cat5_start & cat19==8 | beginning==cat5_start & cat20==8 | beginning==cat5_start & cat21==8 | beginning==cat5_start & cat22==8 | beginning==cat5_start & cat23==8 | beginning==cat5_start & cat24==8 | beginning==cat5_start & cat25==8 | beginning==cat5_start & cat26==8 | beginning==cat5_start & cat27==8 | beginning==cat5_start & cat28==8 | beginning==cat5_start & cat29==8 | beginning==cat5_start & cat30==8 | beginning==cat5_start & cat31==8 | beginning==cat5_start & cat32==8 | beginning==cat5_start & cat33==8 | beginning==cat5_start & cat34==8 | beginning==cat5_start & cat35==8 | beginning==cat5_start & cat36==8 | beginning==cat5_start & cat37==8 | beginning==cat5_start & cat38==8 | beginning==cat5_start & cat39==8 | beginning==cat5_start & cat40==8 | beginning==cat5_start & cat41==8 | beginning==cat5_start & cat42==8 | beginning==cat5_start & cat43==8 | beginning==cat5_start & cat44==8 | beginning==cat5_start & cat45==8 | beginning==cat5_start & cat46==8 | beginning==cat5_start & cat47==8 | beginning==cat5_start & cat48==8 | beginning==cat5_start & cat49==8 | beginning==cat5_start & cat50==8 | beginning==cat5_start & cat51==8 | beginning==cat5_start & cat52==8 | beginning==cat5_start & cat53==8 | beginning==cat5_start & cat54==8 | beginning==cat5_start & cat55==8 | beginning==cat5_start & cat56==8 | beginning==cat5_start & cat57==8 | beginning==cat5_start & cat58==8 | beginning==cat5_start & cat59==8 | beginning==cat5_start & cat60==8 | beginning==cat5_start & cat61==8 | beginning==cat5_start & cat62==8 | beginning==cat5_start & cat63==8 | beginning==cat5_start & cat64==8 | beginning==cat5_start & cat65==8 | beginning==cat5_start & cat66==8 | beginning==cat5_start & cat67==8 | beginning==cat5_start & cat68==8 | beginning==cat5_start & cat69==8 | beginning==cat5_start & cat70==8 | beginning==cat5_start & cat71==8 | beginning==cat5_start & cat72==8 | beginning==cat5_start & cat73==8 | beginning==cat5_start & cat74==8 | beginning==cat5_start & cat75==8 | beginning==cat5_start & cat76==8 | beginning==cat5_start & cat77==8 | beginning==cat5_start & cat78==8 | beginning==cat5_start & cat79==8 | beginning==cat5_start & cat80==8 | beginning==cat5_start & cat81==8 | beginning==cat5_start & cat82==8 | beginning==cat5_start & cat83==8 | beginning==cat5_start & cat84==8 | beginning==cat5_start & cat85==8 | beginning==cat5_start & cat86==8 | beginning==cat5_start & cat87==8 | beginning==cat5_start & cat88==8
replace indicator=0 if beginning==cat5_start & indicator==.
replace indicator=1 if beginning==cat6_start & cat7==8 | beginning==cat6_start & cat8==8 | beginning==cat6_start & cat9==8 | beginning==cat6_start & cat10==8 | beginning==cat6_start & cat11==8 | beginning==cat6_start & cat12==8 | beginning==cat6_start & cat13==8 | beginning==cat6_start & cat14==8 | beginning==cat6_start & cat15==8 | beginning==cat6_start & cat16==8 | beginning==cat6_start & cat17==8 | beginning==cat6_start & cat18==8 | beginning==cat6_start & cat19==8 | beginning==cat6_start & cat20==8 | beginning==cat6_start & cat21==8 | beginning==cat6_start & cat22==8 | beginning==cat6_start & cat23==8 | beginning==cat6_start & cat24==8 | beginning==cat6_start & cat25==8 | beginning==cat6_start & cat26==8 | beginning==cat6_start & cat27==8 | beginning==cat6_start & cat28==8 | beginning==cat6_start & cat29==8 | beginning==cat6_start & cat30==8 | beginning==cat6_start & cat31==8 | beginning==cat6_start & cat32==8 | beginning==cat6_start & cat33==8 | beginning==cat6_start & cat34==8 | beginning==cat6_start & cat35==8 | beginning==cat6_start & cat36==8 | beginning==cat6_start & cat37==8 | beginning==cat6_start & cat38==8 | beginning==cat6_start & cat39==8 | beginning==cat6_start & cat40==8 | beginning==cat6_start & cat41==8 | beginning==cat6_start & cat42==8 | beginning==cat6_start & cat43==8 | beginning==cat6_start & cat44==8 | beginning==cat6_start & cat45==8 | beginning==cat6_start & cat46==8 | beginning==cat6_start & cat47==8 | beginning==cat6_start & cat48==8 | beginning==cat6_start & cat49==8 | beginning==cat6_start & cat50==8 | beginning==cat6_start & cat51==8 | beginning==cat6_start & cat52==8 | beginning==cat6_start & cat53==8 | beginning==cat6_start & cat54==8 | beginning==cat6_start & cat55==8 | beginning==cat6_start & cat56==8 | beginning==cat6_start & cat57==8 | beginning==cat6_start & cat58==8 | beginning==cat6_start & cat59==8 | beginning==cat6_start & cat60==8 | beginning==cat6_start & cat61==8 | beginning==cat6_start & cat62==8 | beginning==cat6_start & cat63==8 | beginning==cat6_start & cat64==8 | beginning==cat6_start & cat65==8 | beginning==cat6_start & cat66==8 | beginning==cat6_start & cat67==8 | beginning==cat6_start & cat68==8 | beginning==cat6_start & cat69==8 | beginning==cat6_start & cat70==8 | beginning==cat6_start & cat71==8 | beginning==cat6_start & cat72==8 | beginning==cat6_start & cat73==8 | beginning==cat6_start & cat74==8 | beginning==cat6_start & cat75==8 | beginning==cat6_start & cat76==8 | beginning==cat6_start & cat77==8 | beginning==cat6_start & cat78==8 | beginning==cat6_start & cat79==8 | beginning==cat6_start & cat80==8 | beginning==cat6_start & cat81==8 | beginning==cat6_start & cat82==8 | beginning==cat6_start & cat83==8 | beginning==cat6_start & cat84==8 | beginning==cat6_start & cat85==8 | beginning==cat6_start & cat86==8 | beginning==cat6_start & cat87==8 | beginning==cat6_start & cat88==8
replace indicator=0 if beginning==cat6_start & indicator==.
replace indicator=1 if beginning==cat7_start & cat8==8 | beginning==cat7_start & cat9==8 | beginning==cat7_start & cat10==8 | beginning==cat7_start & cat11==8 | beginning==cat7_start & cat12==8 | beginning==cat7_start & cat13==8 | beginning==cat7_start & cat14==8 | beginning==cat7_start & cat15==8 | beginning==cat7_start & cat16==8 | beginning==cat7_start & cat17==8 | beginning==cat7_start & cat18==8 | beginning==cat7_start & cat19==8 | beginning==cat7_start & cat20==8 | beginning==cat7_start & cat21==8 | beginning==cat7_start & cat22==8 | beginning==cat7_start & cat23==8 | beginning==cat7_start & cat24==8 | beginning==cat7_start & cat25==8 | beginning==cat7_start & cat26==8 | beginning==cat7_start & cat27==8 | beginning==cat7_start & cat28==8 | beginning==cat7_start & cat29==8 | beginning==cat7_start & cat30==8 | beginning==cat7_start & cat31==8 | beginning==cat7_start & cat32==8 | beginning==cat7_start & cat33==8 | beginning==cat7_start & cat34==8 | beginning==cat7_start & cat35==8 | beginning==cat7_start & cat36==8 | beginning==cat7_start & cat37==8 | beginning==cat7_start & cat38==8 | beginning==cat7_start & cat39==8 | beginning==cat7_start & cat40==8 | beginning==cat7_start & cat41==8 | beginning==cat7_start & cat42==8 | beginning==cat7_start & cat43==8 | beginning==cat7_start & cat44==8 | beginning==cat7_start & cat45==8 | beginning==cat7_start & cat46==8 | beginning==cat7_start & cat47==8 | beginning==cat7_start & cat48==8 | beginning==cat7_start & cat49==8 | beginning==cat7_start & cat50==8 | beginning==cat7_start & cat51==8 | beginning==cat7_start & cat52==8 | beginning==cat7_start & cat53==8 | beginning==cat7_start & cat54==8 | beginning==cat7_start & cat55==8 | beginning==cat7_start & cat56==8 | beginning==cat7_start & cat57==8 | beginning==cat7_start & cat58==8 | beginning==cat7_start & cat59==8 | beginning==cat7_start & cat60==8 | beginning==cat7_start & cat61==8 | beginning==cat7_start & cat62==8 | beginning==cat7_start & cat63==8 | beginning==cat7_start & cat64==8 | beginning==cat7_start & cat65==8 | beginning==cat7_start & cat66==8 | beginning==cat7_start & cat67==8 | beginning==cat7_start & cat68==8 | beginning==cat7_start & cat69==8 | beginning==cat7_start & cat70==8 | beginning==cat7_start & cat71==8 | beginning==cat7_start & cat72==8 | beginning==cat7_start & cat73==8 | beginning==cat7_start & cat74==8 | beginning==cat7_start & cat75==8 | beginning==cat7_start & cat76==8 | beginning==cat7_start & cat77==8 | beginning==cat7_start & cat78==8 | beginning==cat7_start & cat79==8 | beginning==cat7_start & cat80==8 | beginning==cat7_start & cat81==8 | beginning==cat7_start & cat82==8 | beginning==cat7_start & cat83==8 | beginning==cat7_start & cat84==8 | beginning==cat7_start & cat85==8 | beginning==cat7_start & cat86==8 | beginning==cat7_start & cat87==8 | beginning==cat7_start & cat88==8
replace indicator=0 if beginning==cat7_start & indicator==.
replace indicator=1 if beginning==cat8_start & cat9==8 | beginning==cat8_start & cat10==8 | beginning==cat8_start & cat11==8 | beginning==cat8_start & cat12==8 | beginning==cat8_start & cat13==8 | beginning==cat8_start & cat14==8 | beginning==cat8_start & cat15==8 | beginning==cat8_start & cat16==8 | beginning==cat8_start & cat17==8 | beginning==cat8_start & cat18==8 | beginning==cat8_start & cat19==8 | beginning==cat8_start & cat20==8 | beginning==cat8_start & cat21==8 | beginning==cat8_start & cat22==8 | beginning==cat8_start & cat23==8 | beginning==cat8_start & cat24==8 | beginning==cat8_start & cat25==8 | beginning==cat8_start & cat26==8 | beginning==cat8_start & cat27==8 | beginning==cat8_start & cat28==8 | beginning==cat8_start & cat29==8 | beginning==cat8_start & cat30==8 | beginning==cat8_start & cat31==8 | beginning==cat8_start & cat32==8 | beginning==cat8_start & cat33==8 | beginning==cat8_start & cat34==8 | beginning==cat8_start & cat35==8 | beginning==cat8_start & cat36==8 | beginning==cat8_start & cat37==8 | beginning==cat8_start & cat38==8 | beginning==cat8_start & cat39==8 | beginning==cat8_start & cat40==8 | beginning==cat8_start & cat41==8 | beginning==cat8_start & cat42==8 | beginning==cat8_start & cat43==8 | beginning==cat8_start & cat44==8 | beginning==cat8_start & cat45==8 | beginning==cat8_start & cat46==8 | beginning==cat8_start & cat47==8 | beginning==cat8_start & cat48==8 | beginning==cat8_start & cat49==8 | beginning==cat8_start & cat50==8 | beginning==cat8_start & cat51==8 | beginning==cat8_start & cat52==8 | beginning==cat8_start & cat53==8 | beginning==cat8_start & cat54==8 | beginning==cat8_start & cat55==8 | beginning==cat8_start & cat56==8 | beginning==cat8_start & cat57==8 | beginning==cat8_start & cat58==8 | beginning==cat8_start & cat59==8 | beginning==cat8_start & cat60==8 | beginning==cat8_start & cat61==8 | beginning==cat8_start & cat62==8 | beginning==cat8_start & cat63==8 | beginning==cat8_start & cat64==8 | beginning==cat8_start & cat65==8 | beginning==cat8_start & cat66==8 | beginning==cat8_start & cat67==8 | beginning==cat8_start & cat68==8 | beginning==cat8_start & cat69==8 | beginning==cat8_start & cat70==8 | beginning==cat8_start & cat71==8 | beginning==cat8_start & cat72==8 | beginning==cat8_start & cat73==8 | beginning==cat8_start & cat74==8 | beginning==cat8_start & cat75==8 | beginning==cat8_start & cat76==8 | beginning==cat8_start & cat77==8 | beginning==cat8_start & cat78==8 | beginning==cat8_start & cat79==8 | beginning==cat8_start & cat80==8 | beginning==cat8_start & cat81==8 | beginning==cat8_start & cat82==8 | beginning==cat8_start & cat83==8 | beginning==cat8_start & cat84==8 | beginning==cat8_start & cat85==8 | beginning==cat8_start & cat86==8 | beginning==cat8_start & cat87==8 | beginning==cat8_start & cat88==8
replace indicator=0 if beginning==cat8_start & indicator==.
replace indicator=0 if beginning==end
replace indicator=1 if beginning==cat9_start & cat10==8 | beginning==cat9_start & cat11==8 | beginning==cat9_start & cat12==8 | beginning==cat9_start & cat13==8 | beginning==cat9_start & cat14==8 | beginning==cat9_start & cat15==8 | beginning==cat9_start & cat16==8 | beginning==cat9_start & cat17==8 | beginning==cat9_start & cat18==8 | beginning==cat9_start & cat19==8 | beginning==cat9_start & cat20==8 | beginning==cat9_start & cat21==8 | beginning==cat9_start & cat22==8 | beginning==cat9_start & cat23==8 | beginning==cat9_start & cat24==8 | beginning==cat9_start & cat25==8 | beginning==cat9_start & cat26==8 | beginning==cat9_start & cat27==8 | beginning==cat9_start & cat28==8 | beginning==cat9_start & cat29==8 | beginning==cat9_start & cat30==8 | beginning==cat9_start & cat31==8 | beginning==cat9_start & cat32==8 | beginning==cat9_start & cat33==8 | beginning==cat9_start & cat34==8 | beginning==cat9_start & cat35==8 | beginning==cat9_start & cat36==8 | beginning==cat9_start & cat37==8 | beginning==cat9_start & cat38==8 | beginning==cat9_start & cat39==8 | beginning==cat9_start & cat40==8 | beginning==cat9_start & cat41==8 | beginning==cat9_start & cat42==8 | beginning==cat9_start & cat43==8 | beginning==cat9_start & cat44==8 | beginning==cat9_start & cat45==8 | beginning==cat9_start & cat46==8 | beginning==cat9_start & cat47==8 | beginning==cat9_start & cat48==8 | beginning==cat9_start & cat49==8 | beginning==cat9_start & cat50==8 | beginning==cat9_start & cat51==8 | beginning==cat9_start & cat52==8 | beginning==cat9_start & cat53==8 | beginning==cat9_start & cat54==8 | beginning==cat9_start & cat55==8 | beginning==cat9_start & cat56==8 | beginning==cat9_start & cat57==8 | beginning==cat9_start & cat58==8 | beginning==cat9_start & cat59==8 | beginning==cat9_start & cat60==8 | beginning==cat9_start & cat61==8 | beginning==cat9_start & cat62==8 | beginning==cat9_start & cat63==8 | beginning==cat9_start & cat64==8 | beginning==cat9_start & cat65==8 | beginning==cat9_start & cat66==8 | beginning==cat9_start & cat67==8 | beginning==cat9_start & cat68==8 | beginning==cat9_start & cat69==8 | beginning==cat9_start & cat70==8 | beginning==cat9_start & cat71==8 | beginning==cat9_start & cat72==8 | beginning==cat9_start & cat73==8 | beginning==cat9_start & cat74==8 | beginning==cat9_start & cat75==8 | beginning==cat9_start & cat76==8 | beginning==cat9_start & cat77==8 | beginning==cat9_start & cat78==8 | beginning==cat9_start & cat79==8 | beginning==cat9_start & cat80==8 | beginning==cat9_start & cat81==8 | beginning==cat9_start & cat82==8 | beginning==cat9_start & cat83==8 | beginning==cat9_start & cat84==8 | beginning==cat9_start & cat85==8 | beginning==cat9_start & cat86==8 | beginning==cat9_start & cat87==8 | beginning==cat9_start & cat88==8
replace indicator=0 if beginning==cat9_start & indicator==.
replace indicator=1 if beginning==cat10_start & cat11==8 | beginning==cat10_start & cat12==8 | beginning==cat10_start & cat13==8 | beginning==cat10_start & cat14==8 | beginning==cat10_start & cat15==8 | beginning==cat10_start & cat16==8 | beginning==cat10_start & cat17==8 | beginning==cat10_start & cat18==8 | beginning==cat10_start & cat19==8 | beginning==cat10_start & cat20==8 | beginning==cat10_start & cat21==8 | beginning==cat10_start & cat22==8 | beginning==cat10_start & cat23==8 | beginning==cat10_start & cat24==8 | beginning==cat10_start & cat25==8 | beginning==cat10_start & cat26==8 | beginning==cat10_start & cat27==8 | beginning==cat10_start & cat28==8 | beginning==cat10_start & cat29==8 | beginning==cat10_start & cat30==8 | beginning==cat10_start & cat31==8 | beginning==cat10_start & cat32==8 | beginning==cat10_start & cat33==8 | beginning==cat10_start & cat34==8 | beginning==cat10_start & cat35==8 | beginning==cat10_start & cat36==8 | beginning==cat10_start & cat37==8 | beginning==cat10_start & cat38==8 | beginning==cat10_start & cat39==8 | beginning==cat10_start & cat40==8 | beginning==cat10_start & cat41==8 | beginning==cat10_start & cat42==8 | beginning==cat10_start & cat43==8 | beginning==cat10_start & cat44==8 | beginning==cat10_start & cat45==8 | beginning==cat10_start & cat46==8 | beginning==cat10_start & cat47==8 | beginning==cat10_start & cat48==8 | beginning==cat10_start & cat49==8 | beginning==cat10_start & cat50==8 | beginning==cat10_start & cat51==8 | beginning==cat10_start & cat52==8 | beginning==cat10_start & cat53==8 | beginning==cat10_start & cat54==8 | beginning==cat10_start & cat55==8 | beginning==cat10_start & cat56==8 | beginning==cat10_start & cat57==8 | beginning==cat10_start & cat58==8 | beginning==cat10_start & cat59==8 | beginning==cat10_start & cat60==8 | beginning==cat10_start & cat61==8 | beginning==cat10_start & cat62==8 | beginning==cat10_start & cat63==8 | beginning==cat10_start & cat64==8 | beginning==cat10_start & cat65==8 | beginning==cat10_start & cat66==8 | beginning==cat10_start & cat67==8 | beginning==cat10_start & cat68==8 | beginning==cat10_start & cat69==8 | beginning==cat10_start & cat70==8 | beginning==cat10_start & cat71==8 | beginning==cat10_start & cat72==8 | beginning==cat10_start & cat73==8 | beginning==cat10_start & cat74==8 | beginning==cat10_start & cat75==8 | beginning==cat10_start & cat76==8 | beginning==cat10_start & cat77==8 | beginning==cat10_start & cat78==8 | beginning==cat10_start & cat79==8 | beginning==cat10_start & cat80==8 | beginning==cat10_start & cat81==8 | beginning==cat10_start & cat82==8 | beginning==cat10_start & cat83==8 | beginning==cat10_start & cat84==8 | beginning==cat10_start & cat85==8 | beginning==cat10_start & cat86==8 | beginning==cat10_start & cat87==8 | beginning==cat10_start & cat88==8
replace indicator=0 if beginning==cat10_start & indicator==.
replace indicator=1 if beginning==cat11_start & cat12==8 | beginning==cat11_start & cat13==8 | beginning==cat11_start & cat14==8 | beginning==cat11_start & cat15==8 | beginning==cat11_start & cat16==8 | beginning==cat11_start & cat17==8 | beginning==cat11_start & cat18==8 | beginning==cat11_start & cat19==8 | beginning==cat11_start & cat20==8 | beginning==cat11_start & cat21==8 | beginning==cat11_start & cat22==8 | beginning==cat11_start & cat23==8 | beginning==cat11_start & cat24==8 | beginning==cat11_start & cat25==8 | beginning==cat11_start & cat26==8 | beginning==cat11_start & cat27==8 | beginning==cat11_start & cat28==8 | beginning==cat11_start & cat29==8 | beginning==cat11_start & cat30==8 | beginning==cat11_start & cat31==8 | beginning==cat11_start & cat32==8 | beginning==cat11_start & cat33==8 | beginning==cat11_start & cat34==8 | beginning==cat11_start & cat35==8 | beginning==cat11_start & cat36==8 | beginning==cat11_start & cat37==8 | beginning==cat11_start & cat38==8 | beginning==cat11_start & cat39==8 | beginning==cat11_start & cat40==8 | beginning==cat11_start & cat41==8 | beginning==cat11_start & cat42==8 | beginning==cat11_start & cat43==8 | beginning==cat11_start & cat44==8 | beginning==cat11_start & cat45==8 | beginning==cat11_start & cat46==8 | beginning==cat11_start & cat47==8 | beginning==cat11_start & cat48==8 | beginning==cat11_start & cat49==8 | beginning==cat11_start & cat50==8 | beginning==cat11_start & cat51==8 | beginning==cat11_start & cat52==8 | beginning==cat11_start & cat53==8 | beginning==cat11_start & cat54==8 | beginning==cat11_start & cat55==8 | beginning==cat11_start & cat56==8 | beginning==cat11_start & cat57==8 | beginning==cat11_start & cat58==8 | beginning==cat11_start & cat59==8 | beginning==cat11_start & cat60==8 | beginning==cat11_start & cat61==8 | beginning==cat11_start & cat62==8 | beginning==cat11_start & cat63==8 | beginning==cat11_start & cat64==8 | beginning==cat11_start & cat65==8 | beginning==cat11_start & cat66==8 | beginning==cat11_start & cat67==8 | beginning==cat11_start & cat68==8 | beginning==cat11_start & cat69==8 | beginning==cat11_start & cat70==8 | beginning==cat11_start & cat71==8 | beginning==cat11_start & cat72==8 | beginning==cat11_start & cat73==8 | beginning==cat11_start & cat74==8 | beginning==cat11_start & cat75==8 | beginning==cat11_start & cat76==8 | beginning==cat11_start & cat77==8 | beginning==cat11_start & cat78==8 | beginning==cat11_start & cat79==8 | beginning==cat11_start & cat80==8 | beginning==cat11_start & cat81==8 | beginning==cat11_start & cat82==8 | beginning==cat11_start & cat83==8 | beginning==cat11_start & cat84==8 | beginning==cat11_start & cat85==8 | beginning==cat11_start & cat86==8 | beginning==cat11_start & cat87==8 | beginning==cat11_start & cat88==8
replace indicator=0 if beginning==cat11_start & indicator==.
replace indicator=1 if beginning==cat12_start & cat13==8 | beginning==cat12_start & cat14==8 | beginning==cat12_start & cat15==8 | beginning==cat12_start & cat16==8 | beginning==cat12_start & cat17==8 | beginning==cat12_start & cat18==8 | beginning==cat12_start & cat19==8 | beginning==cat12_start & cat20==8 | beginning==cat12_start & cat21==8 | beginning==cat12_start & cat22==8 | beginning==cat12_start & cat23==8 | beginning==cat12_start & cat24==8 | beginning==cat12_start & cat25==8 | beginning==cat12_start & cat26==8 | beginning==cat12_start & cat27==8 | beginning==cat12_start & cat28==8 | beginning==cat12_start & cat29==8 | beginning==cat12_start & cat30==8 | beginning==cat12_start & cat31==8 | beginning==cat12_start & cat32==8 | beginning==cat12_start & cat33==8 | beginning==cat12_start & cat34==8 | beginning==cat12_start & cat35==8 | beginning==cat12_start & cat36==8 | beginning==cat12_start & cat37==8 | beginning==cat12_start & cat38==8 | beginning==cat12_start & cat39==8 | beginning==cat12_start & cat40==8 | beginning==cat12_start & cat41==8 | beginning==cat12_start & cat42==8 | beginning==cat12_start & cat43==8 | beginning==cat12_start & cat44==8 | beginning==cat12_start & cat45==8 | beginning==cat12_start & cat46==8 | beginning==cat12_start & cat47==8 | beginning==cat12_start & cat48==8 | beginning==cat12_start & cat49==8 | beginning==cat12_start & cat50==8 | beginning==cat12_start & cat51==8 | beginning==cat12_start & cat52==8 | beginning==cat12_start & cat53==8 | beginning==cat12_start & cat54==8 | beginning==cat12_start & cat55==8 | beginning==cat12_start & cat56==8 | beginning==cat12_start & cat57==8 | beginning==cat12_start & cat58==8 | beginning==cat12_start & cat59==8 | beginning==cat12_start & cat60==8 | beginning==cat12_start & cat61==8 | beginning==cat12_start & cat62==8 | beginning==cat12_start & cat63==8 | beginning==cat12_start & cat64==8 | beginning==cat12_start & cat65==8 | beginning==cat12_start & cat66==8 | beginning==cat12_start & cat67==8 | beginning==cat12_start & cat68==8 | beginning==cat12_start & cat69==8 | beginning==cat12_start & cat70==8 | beginning==cat12_start & cat71==8 | beginning==cat12_start & cat72==8 | beginning==cat12_start & cat73==8 | beginning==cat12_start & cat74==8 | beginning==cat12_start & cat75==8 | beginning==cat12_start & cat76==8 | beginning==cat12_start & cat77==8 | beginning==cat12_start & cat78==8 | beginning==cat12_start & cat79==8 | beginning==cat12_start & cat80==8 | beginning==cat12_start & cat81==8 | beginning==cat12_start & cat82==8 | beginning==cat12_start & cat83==8 | beginning==cat12_start & cat84==8 | beginning==cat12_start & cat85==8 | beginning==cat12_start & cat86==8 | beginning==cat12_start & cat87==8 | beginning==cat12_start & cat88==8
replace indicator=0 if beginning==cat12_start & indicator==.
replace indicator=1 if beginning==cat13_start & cat14==8 | beginning==cat13_start & cat15==8 | beginning==cat13_start & cat16==8 | beginning==cat13_start & cat17==8 | beginning==cat13_start & cat18==8 | beginning==cat13_start & cat19==8 | beginning==cat13_start & cat20==8 | beginning==cat13_start & cat21==8 | beginning==cat13_start & cat22==8 | beginning==cat13_start & cat23==8 | beginning==cat13_start & cat24==8 | beginning==cat13_start & cat25==8 | beginning==cat13_start & cat26==8 | beginning==cat13_start & cat27==8 | beginning==cat13_start & cat28==8 | beginning==cat13_start & cat29==8 | beginning==cat13_start & cat30==8 | beginning==cat13_start & cat31==8 | beginning==cat13_start & cat32==8 | beginning==cat13_start & cat33==8 | beginning==cat13_start & cat34==8 | beginning==cat13_start & cat35==8 | beginning==cat13_start & cat36==8 | beginning==cat13_start & cat37==8 | beginning==cat13_start & cat38==8 | beginning==cat13_start & cat39==8 | beginning==cat13_start & cat40==8 | beginning==cat13_start & cat41==8 | beginning==cat13_start & cat42==8 | beginning==cat13_start & cat43==8 | beginning==cat13_start & cat44==8 | beginning==cat13_start & cat45==8 | beginning==cat13_start & cat46==8 | beginning==cat13_start & cat47==8 | beginning==cat13_start & cat48==8 | beginning==cat13_start & cat49==8 | beginning==cat13_start & cat50==8 | beginning==cat13_start & cat51==8 | beginning==cat13_start & cat52==8 | beginning==cat13_start & cat53==8 | beginning==cat13_start & cat54==8 | beginning==cat13_start & cat55==8 | beginning==cat13_start & cat56==8 | beginning==cat13_start & cat57==8 | beginning==cat13_start & cat58==8 | beginning==cat13_start & cat59==8 | beginning==cat13_start & cat60==8 | beginning==cat13_start & cat61==8 | beginning==cat13_start & cat62==8 | beginning==cat13_start & cat63==8 | beginning==cat13_start & cat64==8 | beginning==cat13_start & cat65==8 | beginning==cat13_start & cat66==8 | beginning==cat13_start & cat67==8 | beginning==cat13_start & cat68==8 | beginning==cat13_start & cat69==8 | beginning==cat13_start & cat70==8 | beginning==cat13_start & cat71==8 | beginning==cat13_start & cat72==8 | beginning==cat13_start & cat73==8 | beginning==cat13_start & cat74==8 | beginning==cat13_start & cat75==8 | beginning==cat13_start & cat76==8 | beginning==cat13_start & cat77==8 | beginning==cat13_start & cat78==8 | beginning==cat13_start & cat79==8 | beginning==cat13_start & cat80==8 | beginning==cat13_start & cat81==8 | beginning==cat13_start & cat82==8 | beginning==cat13_start & cat83==8 | beginning==cat13_start & cat84==8 | beginning==cat13_start & cat85==8 | beginning==cat13_start & cat86==8 | beginning==cat13_start & cat87==8 | beginning==cat13_start & cat88==8
replace indicator=0 if beginning==cat13_start & indicator==.
replace indicator=1 if beginning==cat14_start & cat15==8 | beginning==cat14_start & cat16==8 | beginning==cat14_start & cat17==8 | beginning==cat14_start & cat18==8 | beginning==cat14_start & cat19==8 | beginning==cat14_start & cat20==8 | beginning==cat14_start & cat21==8 | beginning==cat14_start & cat22==8 | beginning==cat14_start & cat23==8 | beginning==cat14_start & cat24==8 | beginning==cat14_start & cat25==8 | beginning==cat14_start & cat26==8 | beginning==cat14_start & cat27==8 | beginning==cat14_start & cat28==8 | beginning==cat14_start & cat29==8 | beginning==cat14_start & cat30==8 | beginning==cat14_start & cat31==8 | beginning==cat14_start & cat32==8 | beginning==cat14_start & cat33==8 | beginning==cat14_start & cat34==8 | beginning==cat14_start & cat35==8 | beginning==cat14_start & cat36==8 | beginning==cat14_start & cat37==8 | beginning==cat14_start & cat38==8 | beginning==cat14_start & cat39==8 | beginning==cat14_start & cat40==8 | beginning==cat14_start & cat41==8 | beginning==cat14_start & cat42==8 | beginning==cat14_start & cat43==8 | beginning==cat14_start & cat44==8 | beginning==cat14_start & cat45==8 | beginning==cat14_start & cat46==8 | beginning==cat14_start & cat47==8 | beginning==cat14_start & cat48==8 | beginning==cat14_start & cat49==8 | beginning==cat14_start & cat50==8 | beginning==cat14_start & cat51==8 | beginning==cat14_start & cat52==8 | beginning==cat14_start & cat53==8 | beginning==cat14_start & cat54==8 | beginning==cat14_start & cat55==8 | beginning==cat14_start & cat56==8 | beginning==cat14_start & cat57==8 | beginning==cat14_start & cat58==8 | beginning==cat14_start & cat59==8 | beginning==cat14_start & cat60==8 | beginning==cat14_start & cat61==8 | beginning==cat14_start & cat62==8 | beginning==cat14_start & cat63==8 | beginning==cat14_start & cat64==8 | beginning==cat14_start & cat65==8 | beginning==cat14_start & cat66==8 | beginning==cat14_start & cat67==8 | beginning==cat14_start & cat68==8 | beginning==cat14_start & cat69==8 | beginning==cat14_start & cat70==8 | beginning==cat14_start & cat71==8 | beginning==cat14_start & cat72==8 | beginning==cat14_start & cat73==8 | beginning==cat14_start & cat74==8 | beginning==cat14_start & cat75==8 | beginning==cat14_start & cat76==8 | beginning==cat14_start & cat77==8 | beginning==cat14_start & cat78==8 | beginning==cat14_start & cat79==8 | beginning==cat14_start & cat80==8 | beginning==cat14_start & cat81==8 | beginning==cat14_start & cat82==8 | beginning==cat14_start & cat83==8 | beginning==cat14_start & cat84==8 | beginning==cat14_start & cat85==8 | beginning==cat14_start & cat86==8 | beginning==cat14_start & cat87==8 | beginning==cat14_start & cat88==8
replace indicator=0 if beginning==cat14_start & indicator==.
replace indicator=0 if beginning==cat15_start & cat16==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==.
replace indicator=1 if beginning==cat15_start & cat16==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat16_start & cat17==.
replace indicator=1 if beginning==cat16_start & cat17==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18==.
replace indicator=1 if beginning==cat17_start & cat18==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==.
replace indicator=0 if beginning==cat18_start & cat19==.
replace indicator=1 if beginning==cat18_start & cat19==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21==.
replace indicator=1 if beginning==cat19_start & cat20==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat21_start & cat22==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31==.
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat24_start & cat25==.
replace indicator=0 if beginning==cat39_start & cat73!=8 & cat74==.
replace indicator=1 if beginning==cat48_start & cat49==8
replace indicator=1 if beginning==cat50_start & cat51==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==.
replace indicator=1 if beginning==cat25_start & cat26==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==.
replace indicator=0 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==.
replace indicator=1 if beginning==cat21_start & cat22==8
replace indicator=1 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat46_start & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52==.
replace indicator=0 if beginning==cat36_start & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49==.
replace indicator=0 if beginning==cat24_start & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat53_start & cat54==.
replace indicator=0 if beginning==cat34_start & cat35!=8 & cat36!=8 & cat37!=8 & cat38==.
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace indicator=0 if beginning==cat52_start & cat53!=8 & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58==.
replace indicator=1 if beginning==cat27_start & cat28==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=1 if beginning==cat20_start & cat21==8
replace indicator=1 if beginning==cat23_start & cat24==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29==.
replace indicator=1 if beginning==cat29_start & cat30==8
replace indicator=1 if beginning==cat22_start & cat23==8
replace indicator=1 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace indicator=1 if beginning==cat31_start & cat32==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==8
tab indicator,m
* Drop individuals that are not in the risk set
drop if indicator==0
drop indicator

* Construct the 'beginning' variable
gen beginning2 = .
replace beginning2 = cat3_start if beginning==cat2_start & cat3==8
order folio_n20 beginning beginning2
replace beginning2 = cat4_start if beginning==cat2_start & cat3!=8 & cat4==8
replace beginning2 = cat5_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat4_start if beginning==cat3_start & cat4==8
replace beginning2 = cat5_start if beginning==cat3_start & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat5_start if beginning==cat4_start & cat5==8
replace beginning2 = cat6_start if beginning==cat4_start & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat6_start if beginning==cat5_start & cat6==8
replace beginning2 = cat7_start if beginning==cat5_start & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat7_start if beginning==cat6_start & cat7==8
replace beginning2 = cat8_start if beginning==cat6_start & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat23_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat24_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat8_start if beginning==cat7_start & cat8==8
replace beginning2 = cat9_start if beginning==cat7_start & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat9_start if beginning==cat8_start & cat9==8
replace beginning2 = cat10_start if beginning==cat8_start & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat10_start if beginning==cat9_start & cat10==8
replace beginning2 = cat11_start if beginning==cat9_start & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat16_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat11_start if beginning==cat10_start & cat11==8
replace beginning2 = cat12_start if beginning==cat10_start & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat17_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat12_start if beginning==cat11_start & cat12==8
replace beginning2 = cat13_start if beginning==cat11_start & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat13_start if beginning==cat12_start & cat13==8
replace beginning2 = cat14_start if beginning==cat12_start & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat14_start if beginning==cat13_start & cat14==8
replace beginning2 = cat15_start if beginning==cat13_start & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat15_start if beginning==cat14_start & cat15==8
replace beginning2 = cat16_start if beginning==cat14_start & cat15!=8 & cat16==8
replace beginning2 = cat16_start if beginning==cat15_start & cat16==8
replace beginning2 = cat17_start if beginning==cat15_start & cat16!=8 & cat17==8
replace beginning2 = cat17_start if beginning==cat16_start & cat17==8
replace beginning2 = cat18_start if beginning==cat17_start & cat18==8
replace beginning2 = cat19_start if beginning==cat18_start & cat19==8
replace beginning2 = cat20_start if beginning==cat19_start & cat20==8
replace beginning2 = cat25_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23!=2 & cat24!=2 & cat25==2
replace beginning2 = cat35_start if beginning==cat32_start & cat33!=8 & cat34!=8 & cat35==8
replace beginning2 = cat17_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat16_start & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat24_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat19_start if beginning==cat17_start & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat18_start & cat19!=8 & cat20==8
replace beginning2 = cat21_start if beginning==cat19_start & cat20!=8 & cat21==8
replace beginning2 = cat22_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat22_start if beginning==cat21_start & cat22==8
replace beginning2 = cat18_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat14_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat15_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat14_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat25_start if beginning==cat24_start & cat25==8
replace beginning2 = cat16_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat24_start if beginning==cat23_start & cat24==8
replace beginning2 = cat20_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat23_start if beginning==cat21_start & cat22!=8 & cat23==8
replace beginning2 = cat19_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat17_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat21_start if beginning==cat20_start & cat21==8
replace beginning2 = cat30_start if beginning==cat29_start & cat30==8
replace beginning2 = cat23_start if beginning==cat22_start & cat23==8
replace beginning2 = cat17_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat24_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat26_start if beginning==cat25_start & cat26==8
replace beginning2 = cat20_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat32_start if beginning==cat31_start & cat32==8
replace beginning2 = cat20_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat18_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat20_start if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==8

* Make sure that there are no missings
tab beginning2,m
drop beginning
rename beginning2 beginning

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat3_start & cat4==1
order event,after(folio_n20)
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=0 if beginning==cat29_start & cat30==.
replace event=3 if beginning==cat48_start & cat49==3
replace event=4 if beginning==cat26_start & cat27==4
replace event=6 if beginning==cat27_start & cat28==6
replace event=5 if beginning==cat35_start & cat36==5
replace event=9 if beginning==cat30_start & cat31==10
replace event=6 if beginning==cat26_start & cat27==6
replace event=2 if beginning==cat32_start & cat33==2

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat29_start - beginning if beginning==cat28_start & cat29!=8 & cat29!=.
replace duration = cat31_start - beginning if beginning==cat30_start & cat31!=8 & cat31!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat33_start - beginning if beginning==cat32_start & cat33!=8 & cat33!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat52_start - beginning if beginning==cat51_start & cat52!=8 & cat52!=.

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC5_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =5

* Define the education variable
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling12 if beginning==cat12_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079)
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC5_informal", replace

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 6: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load the dataset for analysis
clear
use "$resultdir\sample_RC5_informal"

drop event
replace beginning=beginning+duration
drop duration

* Create risk set: individuals that are in RC informal of order 6 across multiple categories
gen indicator = .  // Initialize the variable
replace indicator=1 if beginning==cat2_start & cat3==8 | beginning==cat2_start & cat4==8 | beginning==cat2_start & cat5==8 | beginning==cat2_start & cat6==8 | beginning==cat2_start & cat7==8 | beginning==cat2_start & cat8==8 | beginning==cat2_start & cat9==8 | beginning==cat2_start & cat10==8 | beginning==cat2_start & cat11==8 | beginning==cat2_start & cat12==8 | beginning==cat2_start & cat13==8 | beginning==cat2_start & cat14==8 | beginning==cat2_start & cat15==8 | beginning==cat2_start & cat16==8 | beginning==cat2_start & cat17==8 | beginning==cat2_start & cat18==8 | beginning==cat2_start & cat19==8 | beginning==cat2_start & cat20==8 | beginning==cat2_start & cat21==8 | beginning==cat2_start & cat22==8 | beginning==cat2_start & cat23==8 | beginning==cat2_start & cat24==8 | beginning==cat2_start & cat25==8 | beginning==cat2_start & cat26==8 | beginning==cat2_start & cat27==8 | beginning==cat2_start & cat28==8 | beginning==cat2_start & cat29==8 | beginning==cat2_start & cat30==8 | beginning==cat2_start & cat31==8 | beginning==cat2_start & cat32==8 | beginning==cat2_start & cat33==8 | beginning==cat2_start & cat34==8 | beginning==cat2_start & cat35==8 | beginning==cat2_start & cat36==8 | beginning==cat2_start & cat37==8 | beginning==cat2_start & cat38==8 | beginning==cat2_start & cat39==8 | beginning==cat2_start & cat40==8 | beginning==cat2_start & cat41==8 | beginning==cat2_start & cat42==8 | beginning==cat2_start & cat43==8 | beginning==cat2_start & cat44==8 | beginning==cat2_start & cat45==8 | beginning==cat2_start & cat46==8 | beginning==cat2_start & cat47==8 | beginning==cat2_start & cat48==8 | beginning==cat2_start & cat49==8 | beginning==cat2_start & cat50==8 | beginning==cat2_start & cat51==8 | beginning==cat2_start & cat52==8 | beginning==cat2_start & cat53==8 | beginning==cat2_start & cat54==8 | beginning==cat2_start & cat55==8 | beginning==cat2_start & cat56==8 | beginning==cat2_start & cat57==8 | beginning==cat2_start & cat58==8 | beginning==cat2_start & cat59==8 | beginning==cat2_start & cat60==8 | beginning==cat2_start & cat61==8 | beginning==cat2_start & cat62==8 | beginning==cat2_start & cat63==8 | beginning==cat2_start & cat64==8 | beginning==cat2_start & cat65==8 | beginning==cat2_start & cat66==8 | beginning==cat2_start & cat67==8 | beginning==cat2_start & cat68==8 | beginning==cat2_start & cat69==8 | beginning==cat2_start & cat70==8 | beginning==cat2_start & cat71==8 | beginning==cat2_start & cat72==8 | beginning==cat2_start & cat73==8 | beginning==cat2_start & cat74==8 | beginning==cat2_start & cat75==8 | beginning==cat2_start & cat76==8 | beginning==cat2_start & cat77==8 | beginning==cat2_start & cat78==8 | beginning==cat2_start & cat79==8 | beginning==cat2_start & cat80==8 | beginning==cat2_start & cat81==8 | beginning==cat2_start & cat82==8 | beginning==cat2_start & cat83==8 | beginning==cat2_start & cat84==8 | beginning==cat2_start & cat85==8 | beginning==cat2_start & cat86==8 | beginning==cat2_start & cat87==8 | beginning==cat2_start & cat88==8 
replace indicator=0 if beginning==cat2_start & indicator==.
replace indicator=1 if beginning==cat3_start & cat4==8 | beginning==cat3_start & cat5==8 | beginning==cat3_start & cat6==8 | beginning==cat3_start & cat7==8 | beginning==cat3_start & cat8==8 | beginning==cat3_start & cat9==8 | beginning==cat3_start & cat10==8 | beginning==cat3_start & cat11==8 | beginning==cat3_start & cat12==8 | beginning==cat3_start & cat13==8 | beginning==cat3_start & cat14==8 | beginning==cat3_start & cat15==8 | beginning==cat3_start & cat16==8 | beginning==cat3_start & cat17==8 | beginning==cat3_start & cat18==8 | beginning==cat3_start & cat19==8 | beginning==cat3_start & cat20==8 | beginning==cat3_start & cat21==8 | beginning==cat3_start & cat22==8 | beginning==cat3_start & cat23==8 | beginning==cat3_start & cat24==8 | beginning==cat3_start & cat25==8 | beginning==cat3_start & cat26==8 | beginning==cat3_start & cat27==8 | beginning==cat3_start & cat28==8 | beginning==cat3_start & cat29==8 | beginning==cat3_start & cat30==8 | beginning==cat3_start & cat31==8 | beginning==cat3_start & cat32==8 | beginning==cat3_start & cat33==8 | beginning==cat3_start & cat34==8 | beginning==cat3_start & cat35==8 | beginning==cat3_start & cat36==8 | beginning==cat3_start & cat37==8 | beginning==cat3_start & cat38==8 | beginning==cat3_start & cat39==8 | beginning==cat3_start & cat40==8 | beginning==cat3_start & cat41==8 | beginning==cat3_start & cat42==8 | beginning==cat3_start & cat43==8 | beginning==cat3_start & cat44==8 | beginning==cat3_start & cat45==8 | beginning==cat3_start & cat46==8 | beginning==cat3_start & cat47==8 | beginning==cat3_start & cat48==8 | beginning==cat3_start & cat49==8 | beginning==cat3_start & cat50==8 | beginning==cat3_start & cat51==8 | beginning==cat3_start & cat52==8 | beginning==cat3_start & cat53==8 | beginning==cat3_start & cat54==8 | beginning==cat3_start & cat55==8 | beginning==cat3_start & cat56==8 | beginning==cat3_start & cat57==8 | beginning==cat3_start & cat58==8 | beginning==cat3_start & cat59==8 | beginning==cat3_start & cat60==8 | beginning==cat3_start & cat61==8 | beginning==cat3_start & cat62==8 | beginning==cat3_start & cat63==8 | beginning==cat3_start & cat64==8 | beginning==cat3_start & cat65==8 | beginning==cat3_start & cat66==8 | beginning==cat3_start & cat67==8 | beginning==cat3_start & cat68==8 | beginning==cat3_start & cat69==8 | beginning==cat3_start & cat70==8 | beginning==cat3_start & cat71==8 | beginning==cat3_start & cat72==8 | beginning==cat3_start & cat73==8 | beginning==cat3_start & cat74==8 | beginning==cat3_start & cat75==8 | beginning==cat3_start & cat76==8 | beginning==cat3_start & cat77==8 | beginning==cat3_start & cat78==8 | beginning==cat3_start & cat79==8 | beginning==cat3_start & cat80==8 | beginning==cat3_start & cat81==8 | beginning==cat3_start & cat82==8 | beginning==cat3_start & cat83==8 | beginning==cat3_start & cat84==8 | beginning==cat3_start & cat85==8 | beginning==cat3_start & cat86==8 | beginning==cat3_start & cat87==8 | beginning==cat3_start & cat88==8
replace indicator=0 if beginning==cat3_start & indicator==.
replace indicator=1 if beginning==cat4_start & cat5==8 | beginning==cat4_start & cat6==8 | beginning==cat4_start & cat7==8 | beginning==cat4_start & cat8==8 | beginning==cat4_start & cat9==8 | beginning==cat4_start & cat10==8 | beginning==cat4_start & cat11==8 | beginning==cat4_start & cat12==8 | beginning==cat4_start & cat13==8 | beginning==cat4_start & cat14==8 | beginning==cat4_start & cat15==8 | beginning==cat4_start & cat16==8 | beginning==cat4_start & cat17==8 | beginning==cat4_start & cat18==8 | beginning==cat4_start & cat19==8 | beginning==cat4_start & cat20==8 | beginning==cat4_start & cat21==8 | beginning==cat4_start & cat22==8 | beginning==cat4_start & cat23==8 | beginning==cat4_start & cat24==8 | beginning==cat4_start & cat25==8 | beginning==cat4_start & cat26==8 | beginning==cat4_start & cat27==8 | beginning==cat4_start & cat28==8 | beginning==cat4_start & cat29==8 | beginning==cat4_start & cat30==8 | beginning==cat4_start & cat31==8 | beginning==cat4_start & cat32==8 | beginning==cat4_start & cat33==8 | beginning==cat4_start & cat34==8 | beginning==cat4_start & cat35==8 | beginning==cat4_start & cat36==8 | beginning==cat4_start & cat37==8 | beginning==cat4_start & cat38==8 | beginning==cat4_start & cat39==8 | beginning==cat4_start & cat40==8 | beginning==cat4_start & cat41==8 | beginning==cat4_start & cat42==8 | beginning==cat4_start & cat43==8 | beginning==cat4_start & cat44==8 | beginning==cat4_start & cat45==8 | beginning==cat4_start & cat46==8 | beginning==cat4_start & cat47==8 | beginning==cat4_start & cat48==8 | beginning==cat4_start & cat49==8 | beginning==cat4_start & cat50==8 | beginning==cat4_start & cat51==8 | beginning==cat4_start & cat52==8 | beginning==cat4_start & cat53==8 | beginning==cat4_start & cat54==8 | beginning==cat4_start & cat55==8 | beginning==cat4_start & cat56==8 | beginning==cat4_start & cat57==8 | beginning==cat4_start & cat58==8 | beginning==cat4_start & cat59==8 | beginning==cat4_start & cat60==8 | beginning==cat4_start & cat61==8 | beginning==cat4_start & cat62==8 | beginning==cat4_start & cat63==8 | beginning==cat4_start & cat64==8 | beginning==cat4_start & cat65==8 | beginning==cat4_start & cat66==8 | beginning==cat4_start & cat67==8 | beginning==cat4_start & cat68==8 | beginning==cat4_start & cat69==8 | beginning==cat4_start & cat70==8 | beginning==cat4_start & cat71==8 | beginning==cat4_start & cat72==8 | beginning==cat4_start & cat73==8 | beginning==cat4_start & cat74==8 | beginning==cat4_start & cat75==8 | beginning==cat4_start & cat76==8 | beginning==cat4_start & cat77==8 | beginning==cat4_start & cat78==8 | beginning==cat4_start & cat79==8 | beginning==cat4_start & cat80==8 | beginning==cat4_start & cat81==8 | beginning==cat4_start & cat82==8 | beginning==cat4_start & cat83==8 | beginning==cat4_start & cat84==8 | beginning==cat4_start & cat85==8 | beginning==cat4_start & cat86==8 | beginning==cat4_start & cat87==8 | beginning==cat4_start & cat88==8
replace indicator=0 if beginning==cat4_start & indicator==.
replace indicator=1 if beginning==cat5_start & cat6==8 | beginning==cat5_start & cat7==8 | beginning==cat5_start & cat8==8 | beginning==cat5_start & cat9==8 | beginning==cat5_start & cat10==8 | beginning==cat5_start & cat11==8 | beginning==cat5_start & cat12==8 | beginning==cat5_start & cat13==8 | beginning==cat5_start & cat14==8 | beginning==cat5_start & cat15==8 | beginning==cat5_start & cat16==8 | beginning==cat5_start & cat17==8 | beginning==cat5_start & cat18==8 | beginning==cat5_start & cat19==8 | beginning==cat5_start & cat20==8 | beginning==cat5_start & cat21==8 | beginning==cat5_start & cat22==8 | beginning==cat5_start & cat23==8 | beginning==cat5_start & cat24==8 | beginning==cat5_start & cat25==8 | beginning==cat5_start & cat26==8 | beginning==cat5_start & cat27==8 | beginning==cat5_start & cat28==8 | beginning==cat5_start & cat29==8 | beginning==cat5_start & cat30==8 | beginning==cat5_start & cat31==8 | beginning==cat5_start & cat32==8 | beginning==cat5_start & cat33==8 | beginning==cat5_start & cat34==8 | beginning==cat5_start & cat35==8 | beginning==cat5_start & cat36==8 | beginning==cat5_start & cat37==8 | beginning==cat5_start & cat38==8 | beginning==cat5_start & cat39==8 | beginning==cat5_start & cat40==8 | beginning==cat5_start & cat41==8 | beginning==cat5_start & cat42==8 | beginning==cat5_start & cat43==8 | beginning==cat5_start & cat44==8 | beginning==cat5_start & cat45==8 | beginning==cat5_start & cat46==8 | beginning==cat5_start & cat47==8 | beginning==cat5_start & cat48==8 | beginning==cat5_start & cat49==8 | beginning==cat5_start & cat50==8 | beginning==cat5_start & cat51==8 | beginning==cat5_start & cat52==8 | beginning==cat5_start & cat53==8 | beginning==cat5_start & cat54==8 | beginning==cat5_start & cat55==8 | beginning==cat5_start & cat56==8 | beginning==cat5_start & cat57==8 | beginning==cat5_start & cat58==8 | beginning==cat5_start & cat59==8 | beginning==cat5_start & cat60==8 | beginning==cat5_start & cat61==8 | beginning==cat5_start & cat62==8 | beginning==cat5_start & cat63==8 | beginning==cat5_start & cat64==8 | beginning==cat5_start & cat65==8 | beginning==cat5_start & cat66==8 | beginning==cat5_start & cat67==8 | beginning==cat5_start & cat68==8 | beginning==cat5_start & cat69==8 | beginning==cat5_start & cat70==8 | beginning==cat5_start & cat71==8 | beginning==cat5_start & cat72==8 | beginning==cat5_start & cat73==8 | beginning==cat5_start & cat74==8 | beginning==cat5_start & cat75==8 | beginning==cat5_start & cat76==8 | beginning==cat5_start & cat77==8 | beginning==cat5_start & cat78==8 | beginning==cat5_start & cat79==8 | beginning==cat5_start & cat80==8 | beginning==cat5_start & cat81==8 | beginning==cat5_start & cat82==8 | beginning==cat5_start & cat83==8 | beginning==cat5_start & cat84==8 | beginning==cat5_start & cat85==8 | beginning==cat5_start & cat86==8 | beginning==cat5_start & cat87==8 | beginning==cat5_start & cat88==8
replace indicator=0 if beginning==cat5_start & indicator==.
replace indicator=1 if beginning==cat6_start & cat7==8 | beginning==cat6_start & cat8==8 | beginning==cat6_start & cat9==8 | beginning==cat6_start & cat10==8 | beginning==cat6_start & cat11==8 | beginning==cat6_start & cat12==8 | beginning==cat6_start & cat13==8 | beginning==cat6_start & cat14==8 | beginning==cat6_start & cat15==8 | beginning==cat6_start & cat16==8 | beginning==cat6_start & cat17==8 | beginning==cat6_start & cat18==8 | beginning==cat6_start & cat19==8 | beginning==cat6_start & cat20==8 | beginning==cat6_start & cat21==8 | beginning==cat6_start & cat22==8 | beginning==cat6_start & cat23==8 | beginning==cat6_start & cat24==8 | beginning==cat6_start & cat25==8 | beginning==cat6_start & cat26==8 | beginning==cat6_start & cat27==8 | beginning==cat6_start & cat28==8 | beginning==cat6_start & cat29==8 | beginning==cat6_start & cat30==8 | beginning==cat6_start & cat31==8 | beginning==cat6_start & cat32==8 | beginning==cat6_start & cat33==8 | beginning==cat6_start & cat34==8 | beginning==cat6_start & cat35==8 | beginning==cat6_start & cat36==8 | beginning==cat6_start & cat37==8 | beginning==cat6_start & cat38==8 | beginning==cat6_start & cat39==8 | beginning==cat6_start & cat40==8 | beginning==cat6_start & cat41==8 | beginning==cat6_start & cat42==8 | beginning==cat6_start & cat43==8 | beginning==cat6_start & cat44==8 | beginning==cat6_start & cat45==8 | beginning==cat6_start & cat46==8 | beginning==cat6_start & cat47==8 | beginning==cat6_start & cat48==8 | beginning==cat6_start & cat49==8 | beginning==cat6_start & cat50==8 | beginning==cat6_start & cat51==8 | beginning==cat6_start & cat52==8 | beginning==cat6_start & cat53==8 | beginning==cat6_start & cat54==8 | beginning==cat6_start & cat55==8 | beginning==cat6_start & cat56==8 | beginning==cat6_start & cat57==8 | beginning==cat6_start & cat58==8 | beginning==cat6_start & cat59==8 | beginning==cat6_start & cat60==8 | beginning==cat6_start & cat61==8 | beginning==cat6_start & cat62==8 | beginning==cat6_start & cat63==8 | beginning==cat6_start & cat64==8 | beginning==cat6_start & cat65==8 | beginning==cat6_start & cat66==8 | beginning==cat6_start & cat67==8 | beginning==cat6_start & cat68==8 | beginning==cat6_start & cat69==8 | beginning==cat6_start & cat70==8 | beginning==cat6_start & cat71==8 | beginning==cat6_start & cat72==8 | beginning==cat6_start & cat73==8 | beginning==cat6_start & cat74==8 | beginning==cat6_start & cat75==8 | beginning==cat6_start & cat76==8 | beginning==cat6_start & cat77==8 | beginning==cat6_start & cat78==8 | beginning==cat6_start & cat79==8 | beginning==cat6_start & cat80==8 | beginning==cat6_start & cat81==8 | beginning==cat6_start & cat82==8 | beginning==cat6_start & cat83==8 | beginning==cat6_start & cat84==8 | beginning==cat6_start & cat85==8 | beginning==cat6_start & cat86==8 | beginning==cat6_start & cat87==8 | beginning==cat6_start & cat88==8
replace indicator=0 if beginning==cat6_start & indicator==.
replace indicator=1 if beginning==cat7_start & cat8==8 | beginning==cat7_start & cat9==8 | beginning==cat7_start & cat10==8 | beginning==cat7_start & cat11==8 | beginning==cat7_start & cat12==8 | beginning==cat7_start & cat13==8 | beginning==cat7_start & cat14==8 | beginning==cat7_start & cat15==8 | beginning==cat7_start & cat16==8 | beginning==cat7_start & cat17==8 | beginning==cat7_start & cat18==8 | beginning==cat7_start & cat19==8 | beginning==cat7_start & cat20==8 | beginning==cat7_start & cat21==8 | beginning==cat7_start & cat22==8 | beginning==cat7_start & cat23==8 | beginning==cat7_start & cat24==8 | beginning==cat7_start & cat25==8 | beginning==cat7_start & cat26==8 | beginning==cat7_start & cat27==8 | beginning==cat7_start & cat28==8 | beginning==cat7_start & cat29==8 | beginning==cat7_start & cat30==8 | beginning==cat7_start & cat31==8 | beginning==cat7_start & cat32==8 | beginning==cat7_start & cat33==8 | beginning==cat7_start & cat34==8 | beginning==cat7_start & cat35==8 | beginning==cat7_start & cat36==8 | beginning==cat7_start & cat37==8 | beginning==cat7_start & cat38==8 | beginning==cat7_start & cat39==8 | beginning==cat7_start & cat40==8 | beginning==cat7_start & cat41==8 | beginning==cat7_start & cat42==8 | beginning==cat7_start & cat43==8 | beginning==cat7_start & cat44==8 | beginning==cat7_start & cat45==8 | beginning==cat7_start & cat46==8 | beginning==cat7_start & cat47==8 | beginning==cat7_start & cat48==8 | beginning==cat7_start & cat49==8 | beginning==cat7_start & cat50==8 | beginning==cat7_start & cat51==8 | beginning==cat7_start & cat52==8 | beginning==cat7_start & cat53==8 | beginning==cat7_start & cat54==8 | beginning==cat7_start & cat55==8 | beginning==cat7_start & cat56==8 | beginning==cat7_start & cat57==8 | beginning==cat7_start & cat58==8 | beginning==cat7_start & cat59==8 | beginning==cat7_start & cat60==8 | beginning==cat7_start & cat61==8 | beginning==cat7_start & cat62==8 | beginning==cat7_start & cat63==8 | beginning==cat7_start & cat64==8 | beginning==cat7_start & cat65==8 | beginning==cat7_start & cat66==8 | beginning==cat7_start & cat67==8 | beginning==cat7_start & cat68==8 | beginning==cat7_start & cat69==8 | beginning==cat7_start & cat70==8 | beginning==cat7_start & cat71==8 | beginning==cat7_start & cat72==8 | beginning==cat7_start & cat73==8 | beginning==cat7_start & cat74==8 | beginning==cat7_start & cat75==8 | beginning==cat7_start & cat76==8 | beginning==cat7_start & cat77==8 | beginning==cat7_start & cat78==8 | beginning==cat7_start & cat79==8 | beginning==cat7_start & cat80==8 | beginning==cat7_start & cat81==8 | beginning==cat7_start & cat82==8 | beginning==cat7_start & cat83==8 | beginning==cat7_start & cat84==8 | beginning==cat7_start & cat85==8 | beginning==cat7_start & cat86==8 | beginning==cat7_start & cat87==8 | beginning==cat7_start & cat88==8
replace indicator=0 if beginning==cat7_start & indicator==.
replace indicator=1 if beginning==cat8_start & cat9==8 | beginning==cat8_start & cat10==8 | beginning==cat8_start & cat11==8 | beginning==cat8_start & cat12==8 | beginning==cat8_start & cat13==8 | beginning==cat8_start & cat14==8 | beginning==cat8_start & cat15==8 | beginning==cat8_start & cat16==8 | beginning==cat8_start & cat17==8 | beginning==cat8_start & cat18==8 | beginning==cat8_start & cat19==8 | beginning==cat8_start & cat20==8 | beginning==cat8_start & cat21==8 | beginning==cat8_start & cat22==8 | beginning==cat8_start & cat23==8 | beginning==cat8_start & cat24==8 | beginning==cat8_start & cat25==8 | beginning==cat8_start & cat26==8 | beginning==cat8_start & cat27==8 | beginning==cat8_start & cat28==8 | beginning==cat8_start & cat29==8 | beginning==cat8_start & cat30==8 | beginning==cat8_start & cat31==8 | beginning==cat8_start & cat32==8 | beginning==cat8_start & cat33==8 | beginning==cat8_start & cat34==8 | beginning==cat8_start & cat35==8 | beginning==cat8_start & cat36==8 | beginning==cat8_start & cat37==8 | beginning==cat8_start & cat38==8 | beginning==cat8_start & cat39==8 | beginning==cat8_start & cat40==8 | beginning==cat8_start & cat41==8 | beginning==cat8_start & cat42==8 | beginning==cat8_start & cat43==8 | beginning==cat8_start & cat44==8 | beginning==cat8_start & cat45==8 | beginning==cat8_start & cat46==8 | beginning==cat8_start & cat47==8 | beginning==cat8_start & cat48==8 | beginning==cat8_start & cat49==8 | beginning==cat8_start & cat50==8 | beginning==cat8_start & cat51==8 | beginning==cat8_start & cat52==8 | beginning==cat8_start & cat53==8 | beginning==cat8_start & cat54==8 | beginning==cat8_start & cat55==8 | beginning==cat8_start & cat56==8 | beginning==cat8_start & cat57==8 | beginning==cat8_start & cat58==8 | beginning==cat8_start & cat59==8 | beginning==cat8_start & cat60==8 | beginning==cat8_start & cat61==8 | beginning==cat8_start & cat62==8 | beginning==cat8_start & cat63==8 | beginning==cat8_start & cat64==8 | beginning==cat8_start & cat65==8 | beginning==cat8_start & cat66==8 | beginning==cat8_start & cat67==8 | beginning==cat8_start & cat68==8 | beginning==cat8_start & cat69==8 | beginning==cat8_start & cat70==8 | beginning==cat8_start & cat71==8 | beginning==cat8_start & cat72==8 | beginning==cat8_start & cat73==8 | beginning==cat8_start & cat74==8 | beginning==cat8_start & cat75==8 | beginning==cat8_start & cat76==8 | beginning==cat8_start & cat77==8 | beginning==cat8_start & cat78==8 | beginning==cat8_start & cat79==8 | beginning==cat8_start & cat80==8 | beginning==cat8_start & cat81==8 | beginning==cat8_start & cat82==8 | beginning==cat8_start & cat83==8 | beginning==cat8_start & cat84==8 | beginning==cat8_start & cat85==8 | beginning==cat8_start & cat86==8 | beginning==cat8_start & cat87==8 | beginning==cat8_start & cat88==8
replace indicator=0 if beginning==cat8_start & indicator==.
replace indicator=0 if beginning==end
replace indicator=1 if beginning==cat9_start & cat10==8 | beginning==cat9_start & cat11==8 | beginning==cat9_start & cat12==8 | beginning==cat9_start & cat13==8 | beginning==cat9_start & cat14==8 | beginning==cat9_start & cat15==8 | beginning==cat9_start & cat16==8 | beginning==cat9_start & cat17==8 | beginning==cat9_start & cat18==8 | beginning==cat9_start & cat19==8 | beginning==cat9_start & cat20==8 | beginning==cat9_start & cat21==8 | beginning==cat9_start & cat22==8 | beginning==cat9_start & cat23==8 | beginning==cat9_start & cat24==8 | beginning==cat9_start & cat25==8 | beginning==cat9_start & cat26==8 | beginning==cat9_start & cat27==8 | beginning==cat9_start & cat28==8 | beginning==cat9_start & cat29==8 | beginning==cat9_start & cat30==8 | beginning==cat9_start & cat31==8 | beginning==cat9_start & cat32==8 | beginning==cat9_start & cat33==8 | beginning==cat9_start & cat34==8 | beginning==cat9_start & cat35==8 | beginning==cat9_start & cat36==8 | beginning==cat9_start & cat37==8 | beginning==cat9_start & cat38==8 | beginning==cat9_start & cat39==8 | beginning==cat9_start & cat40==8 | beginning==cat9_start & cat41==8 | beginning==cat9_start & cat42==8 | beginning==cat9_start & cat43==8 | beginning==cat9_start & cat44==8 | beginning==cat9_start & cat45==8 | beginning==cat9_start & cat46==8 | beginning==cat9_start & cat47==8 | beginning==cat9_start & cat48==8 | beginning==cat9_start & cat49==8 | beginning==cat9_start & cat50==8 | beginning==cat9_start & cat51==8 | beginning==cat9_start & cat52==8 | beginning==cat9_start & cat53==8 | beginning==cat9_start & cat54==8 | beginning==cat9_start & cat55==8 | beginning==cat9_start & cat56==8 | beginning==cat9_start & cat57==8 | beginning==cat9_start & cat58==8 | beginning==cat9_start & cat59==8 | beginning==cat9_start & cat60==8 | beginning==cat9_start & cat61==8 | beginning==cat9_start & cat62==8 | beginning==cat9_start & cat63==8 | beginning==cat9_start & cat64==8 | beginning==cat9_start & cat65==8 | beginning==cat9_start & cat66==8 | beginning==cat9_start & cat67==8 | beginning==cat9_start & cat68==8 | beginning==cat9_start & cat69==8 | beginning==cat9_start & cat70==8 | beginning==cat9_start & cat71==8 | beginning==cat9_start & cat72==8 | beginning==cat9_start & cat73==8 | beginning==cat9_start & cat74==8 | beginning==cat9_start & cat75==8 | beginning==cat9_start & cat76==8 | beginning==cat9_start & cat77==8 | beginning==cat9_start & cat78==8 | beginning==cat9_start & cat79==8 | beginning==cat9_start & cat80==8 | beginning==cat9_start & cat81==8 | beginning==cat9_start & cat82==8 | beginning==cat9_start & cat83==8 | beginning==cat9_start & cat84==8 | beginning==cat9_start & cat85==8 | beginning==cat9_start & cat86==8 | beginning==cat9_start & cat87==8 | beginning==cat9_start & cat88==8
replace indicator=0 if beginning==cat9_start & indicator==.
replace indicator=1 if beginning==cat10_start & cat11==8 | beginning==cat10_start & cat12==8 | beginning==cat10_start & cat13==8 | beginning==cat10_start & cat14==8 | beginning==cat10_start & cat15==8 | beginning==cat10_start & cat16==8 | beginning==cat10_start & cat17==8 | beginning==cat10_start & cat18==8 | beginning==cat10_start & cat19==8 | beginning==cat10_start & cat20==8 | beginning==cat10_start & cat21==8 | beginning==cat10_start & cat22==8 | beginning==cat10_start & cat23==8 | beginning==cat10_start & cat24==8 | beginning==cat10_start & cat25==8 | beginning==cat10_start & cat26==8 | beginning==cat10_start & cat27==8 | beginning==cat10_start & cat28==8 | beginning==cat10_start & cat29==8 | beginning==cat10_start & cat30==8 | beginning==cat10_start & cat31==8 | beginning==cat10_start & cat32==8 | beginning==cat10_start & cat33==8 | beginning==cat10_start & cat34==8 | beginning==cat10_start & cat35==8 | beginning==cat10_start & cat36==8 | beginning==cat10_start & cat37==8 | beginning==cat10_start & cat38==8 | beginning==cat10_start & cat39==8 | beginning==cat10_start & cat40==8 | beginning==cat10_start & cat41==8 | beginning==cat10_start & cat42==8 | beginning==cat10_start & cat43==8 | beginning==cat10_start & cat44==8 | beginning==cat10_start & cat45==8 | beginning==cat10_start & cat46==8 | beginning==cat10_start & cat47==8 | beginning==cat10_start & cat48==8 | beginning==cat10_start & cat49==8 | beginning==cat10_start & cat50==8 | beginning==cat10_start & cat51==8 | beginning==cat10_start & cat52==8 | beginning==cat10_start & cat53==8 | beginning==cat10_start & cat54==8 | beginning==cat10_start & cat55==8 | beginning==cat10_start & cat56==8 | beginning==cat10_start & cat57==8 | beginning==cat10_start & cat58==8 | beginning==cat10_start & cat59==8 | beginning==cat10_start & cat60==8 | beginning==cat10_start & cat61==8 | beginning==cat10_start & cat62==8 | beginning==cat10_start & cat63==8 | beginning==cat10_start & cat64==8 | beginning==cat10_start & cat65==8 | beginning==cat10_start & cat66==8 | beginning==cat10_start & cat67==8 | beginning==cat10_start & cat68==8 | beginning==cat10_start & cat69==8 | beginning==cat10_start & cat70==8 | beginning==cat10_start & cat71==8 | beginning==cat10_start & cat72==8 | beginning==cat10_start & cat73==8 | beginning==cat10_start & cat74==8 | beginning==cat10_start & cat75==8 | beginning==cat10_start & cat76==8 | beginning==cat10_start & cat77==8 | beginning==cat10_start & cat78==8 | beginning==cat10_start & cat79==8 | beginning==cat10_start & cat80==8 | beginning==cat10_start & cat81==8 | beginning==cat10_start & cat82==8 | beginning==cat10_start & cat83==8 | beginning==cat10_start & cat84==8 | beginning==cat10_start & cat85==8 | beginning==cat10_start & cat86==8 | beginning==cat10_start & cat87==8 | beginning==cat10_start & cat88==8
replace indicator=0 if beginning==cat10_start & indicator==.
replace indicator=1 if beginning==cat11_start & cat12==8 | beginning==cat11_start & cat13==8 | beginning==cat11_start & cat14==8 | beginning==cat11_start & cat15==8 | beginning==cat11_start & cat16==8 | beginning==cat11_start & cat17==8 | beginning==cat11_start & cat18==8 | beginning==cat11_start & cat19==8 | beginning==cat11_start & cat20==8 | beginning==cat11_start & cat21==8 | beginning==cat11_start & cat22==8 | beginning==cat11_start & cat23==8 | beginning==cat11_start & cat24==8 | beginning==cat11_start & cat25==8 | beginning==cat11_start & cat26==8 | beginning==cat11_start & cat27==8 | beginning==cat11_start & cat28==8 | beginning==cat11_start & cat29==8 | beginning==cat11_start & cat30==8 | beginning==cat11_start & cat31==8 | beginning==cat11_start & cat32==8 | beginning==cat11_start & cat33==8 | beginning==cat11_start & cat34==8 | beginning==cat11_start & cat35==8 | beginning==cat11_start & cat36==8 | beginning==cat11_start & cat37==8 | beginning==cat11_start & cat38==8 | beginning==cat11_start & cat39==8 | beginning==cat11_start & cat40==8 | beginning==cat11_start & cat41==8 | beginning==cat11_start & cat42==8 | beginning==cat11_start & cat43==8 | beginning==cat11_start & cat44==8 | beginning==cat11_start & cat45==8 | beginning==cat11_start & cat46==8 | beginning==cat11_start & cat47==8 | beginning==cat11_start & cat48==8 | beginning==cat11_start & cat49==8 | beginning==cat11_start & cat50==8 | beginning==cat11_start & cat51==8 | beginning==cat11_start & cat52==8 | beginning==cat11_start & cat53==8 | beginning==cat11_start & cat54==8 | beginning==cat11_start & cat55==8 | beginning==cat11_start & cat56==8 | beginning==cat11_start & cat57==8 | beginning==cat11_start & cat58==8 | beginning==cat11_start & cat59==8 | beginning==cat11_start & cat60==8 | beginning==cat11_start & cat61==8 | beginning==cat11_start & cat62==8 | beginning==cat11_start & cat63==8 | beginning==cat11_start & cat64==8 | beginning==cat11_start & cat65==8 | beginning==cat11_start & cat66==8 | beginning==cat11_start & cat67==8 | beginning==cat11_start & cat68==8 | beginning==cat11_start & cat69==8 | beginning==cat11_start & cat70==8 | beginning==cat11_start & cat71==8 | beginning==cat11_start & cat72==8 | beginning==cat11_start & cat73==8 | beginning==cat11_start & cat74==8 | beginning==cat11_start & cat75==8 | beginning==cat11_start & cat76==8 | beginning==cat11_start & cat77==8 | beginning==cat11_start & cat78==8 | beginning==cat11_start & cat79==8 | beginning==cat11_start & cat80==8 | beginning==cat11_start & cat81==8 | beginning==cat11_start & cat82==8 | beginning==cat11_start & cat83==8 | beginning==cat11_start & cat84==8 | beginning==cat11_start & cat85==8 | beginning==cat11_start & cat86==8 | beginning==cat11_start & cat87==8 | beginning==cat11_start & cat88==8
replace indicator=0 if beginning==cat11_start & indicator==.
replace indicator=1 if beginning==cat12_start & cat13==8 | beginning==cat12_start & cat14==8 | beginning==cat12_start & cat15==8 | beginning==cat12_start & cat16==8 | beginning==cat12_start & cat17==8 | beginning==cat12_start & cat18==8 | beginning==cat12_start & cat19==8 | beginning==cat12_start & cat20==8 | beginning==cat12_start & cat21==8 | beginning==cat12_start & cat22==8 | beginning==cat12_start & cat23==8 | beginning==cat12_start & cat24==8 | beginning==cat12_start & cat25==8 | beginning==cat12_start & cat26==8 | beginning==cat12_start & cat27==8 | beginning==cat12_start & cat28==8 | beginning==cat12_start & cat29==8 | beginning==cat12_start & cat30==8 | beginning==cat12_start & cat31==8 | beginning==cat12_start & cat32==8 | beginning==cat12_start & cat33==8 | beginning==cat12_start & cat34==8 | beginning==cat12_start & cat35==8 | beginning==cat12_start & cat36==8 | beginning==cat12_start & cat37==8 | beginning==cat12_start & cat38==8 | beginning==cat12_start & cat39==8 | beginning==cat12_start & cat40==8 | beginning==cat12_start & cat41==8 | beginning==cat12_start & cat42==8 | beginning==cat12_start & cat43==8 | beginning==cat12_start & cat44==8 | beginning==cat12_start & cat45==8 | beginning==cat12_start & cat46==8 | beginning==cat12_start & cat47==8 | beginning==cat12_start & cat48==8 | beginning==cat12_start & cat49==8 | beginning==cat12_start & cat50==8 | beginning==cat12_start & cat51==8 | beginning==cat12_start & cat52==8 | beginning==cat12_start & cat53==8 | beginning==cat12_start & cat54==8 | beginning==cat12_start & cat55==8 | beginning==cat12_start & cat56==8 | beginning==cat12_start & cat57==8 | beginning==cat12_start & cat58==8 | beginning==cat12_start & cat59==8 | beginning==cat12_start & cat60==8 | beginning==cat12_start & cat61==8 | beginning==cat12_start & cat62==8 | beginning==cat12_start & cat63==8 | beginning==cat12_start & cat64==8 | beginning==cat12_start & cat65==8 | beginning==cat12_start & cat66==8 | beginning==cat12_start & cat67==8 | beginning==cat12_start & cat68==8 | beginning==cat12_start & cat69==8 | beginning==cat12_start & cat70==8 | beginning==cat12_start & cat71==8 | beginning==cat12_start & cat72==8 | beginning==cat12_start & cat73==8 | beginning==cat12_start & cat74==8 | beginning==cat12_start & cat75==8 | beginning==cat12_start & cat76==8 | beginning==cat12_start & cat77==8 | beginning==cat12_start & cat78==8 | beginning==cat12_start & cat79==8 | beginning==cat12_start & cat80==8 | beginning==cat12_start & cat81==8 | beginning==cat12_start & cat82==8 | beginning==cat12_start & cat83==8 | beginning==cat12_start & cat84==8 | beginning==cat12_start & cat85==8 | beginning==cat12_start & cat86==8 | beginning==cat12_start & cat87==8 | beginning==cat12_start & cat88==8
replace indicator=0 if beginning==cat12_start & indicator==.
replace indicator=1 if beginning==cat13_start & cat14==8 | beginning==cat13_start & cat15==8 | beginning==cat13_start & cat16==8 | beginning==cat13_start & cat17==8 | beginning==cat13_start & cat18==8 | beginning==cat13_start & cat19==8 | beginning==cat13_start & cat20==8 | beginning==cat13_start & cat21==8 | beginning==cat13_start & cat22==8 | beginning==cat13_start & cat23==8 | beginning==cat13_start & cat24==8 | beginning==cat13_start & cat25==8 | beginning==cat13_start & cat26==8 | beginning==cat13_start & cat27==8 | beginning==cat13_start & cat28==8 | beginning==cat13_start & cat29==8 | beginning==cat13_start & cat30==8 | beginning==cat13_start & cat31==8 | beginning==cat13_start & cat32==8 | beginning==cat13_start & cat33==8 | beginning==cat13_start & cat34==8 | beginning==cat13_start & cat35==8 | beginning==cat13_start & cat36==8 | beginning==cat13_start & cat37==8 | beginning==cat13_start & cat38==8 | beginning==cat13_start & cat39==8 | beginning==cat13_start & cat40==8 | beginning==cat13_start & cat41==8 | beginning==cat13_start & cat42==8 | beginning==cat13_start & cat43==8 | beginning==cat13_start & cat44==8 | beginning==cat13_start & cat45==8 | beginning==cat13_start & cat46==8 | beginning==cat13_start & cat47==8 | beginning==cat13_start & cat48==8 | beginning==cat13_start & cat49==8 | beginning==cat13_start & cat50==8 | beginning==cat13_start & cat51==8 | beginning==cat13_start & cat52==8 | beginning==cat13_start & cat53==8 | beginning==cat13_start & cat54==8 | beginning==cat13_start & cat55==8 | beginning==cat13_start & cat56==8 | beginning==cat13_start & cat57==8 | beginning==cat13_start & cat58==8 | beginning==cat13_start & cat59==8 | beginning==cat13_start & cat60==8 | beginning==cat13_start & cat61==8 | beginning==cat13_start & cat62==8 | beginning==cat13_start & cat63==8 | beginning==cat13_start & cat64==8 | beginning==cat13_start & cat65==8 | beginning==cat13_start & cat66==8 | beginning==cat13_start & cat67==8 | beginning==cat13_start & cat68==8 | beginning==cat13_start & cat69==8 | beginning==cat13_start & cat70==8 | beginning==cat13_start & cat71==8 | beginning==cat13_start & cat72==8 | beginning==cat13_start & cat73==8 | beginning==cat13_start & cat74==8 | beginning==cat13_start & cat75==8 | beginning==cat13_start & cat76==8 | beginning==cat13_start & cat77==8 | beginning==cat13_start & cat78==8 | beginning==cat13_start & cat79==8 | beginning==cat13_start & cat80==8 | beginning==cat13_start & cat81==8 | beginning==cat13_start & cat82==8 | beginning==cat13_start & cat83==8 | beginning==cat13_start & cat84==8 | beginning==cat13_start & cat85==8 | beginning==cat13_start & cat86==8 | beginning==cat13_start & cat87==8 | beginning==cat13_start & cat88==8
replace indicator=0 if beginning==cat13_start & indicator==.
replace indicator=1 if beginning==cat14_start & cat15==8 | beginning==cat14_start & cat16==8 | beginning==cat14_start & cat17==8 | beginning==cat14_start & cat18==8 | beginning==cat14_start & cat19==8 | beginning==cat14_start & cat20==8 | beginning==cat14_start & cat21==8 | beginning==cat14_start & cat22==8 | beginning==cat14_start & cat23==8 | beginning==cat14_start & cat24==8 | beginning==cat14_start & cat25==8 | beginning==cat14_start & cat26==8 | beginning==cat14_start & cat27==8 | beginning==cat14_start & cat28==8 | beginning==cat14_start & cat29==8 | beginning==cat14_start & cat30==8 | beginning==cat14_start & cat31==8 | beginning==cat14_start & cat32==8 | beginning==cat14_start & cat33==8 | beginning==cat14_start & cat34==8 | beginning==cat14_start & cat35==8 | beginning==cat14_start & cat36==8 | beginning==cat14_start & cat37==8 | beginning==cat14_start & cat38==8 | beginning==cat14_start & cat39==8 | beginning==cat14_start & cat40==8 | beginning==cat14_start & cat41==8 | beginning==cat14_start & cat42==8 | beginning==cat14_start & cat43==8 | beginning==cat14_start & cat44==8 | beginning==cat14_start & cat45==8 | beginning==cat14_start & cat46==8 | beginning==cat14_start & cat47==8 | beginning==cat14_start & cat48==8 | beginning==cat14_start & cat49==8 | beginning==cat14_start & cat50==8 | beginning==cat14_start & cat51==8 | beginning==cat14_start & cat52==8 | beginning==cat14_start & cat53==8 | beginning==cat14_start & cat54==8 | beginning==cat14_start & cat55==8 | beginning==cat14_start & cat56==8 | beginning==cat14_start & cat57==8 | beginning==cat14_start & cat58==8 | beginning==cat14_start & cat59==8 | beginning==cat14_start & cat60==8 | beginning==cat14_start & cat61==8 | beginning==cat14_start & cat62==8 | beginning==cat14_start & cat63==8 | beginning==cat14_start & cat64==8 | beginning==cat14_start & cat65==8 | beginning==cat14_start & cat66==8 | beginning==cat14_start & cat67==8 | beginning==cat14_start & cat68==8 | beginning==cat14_start & cat69==8 | beginning==cat14_start & cat70==8 | beginning==cat14_start & cat71==8 | beginning==cat14_start & cat72==8 | beginning==cat14_start & cat73==8 | beginning==cat14_start & cat74==8 | beginning==cat14_start & cat75==8 | beginning==cat14_start & cat76==8 | beginning==cat14_start & cat77==8 | beginning==cat14_start & cat78==8 | beginning==cat14_start & cat79==8 | beginning==cat14_start & cat80==8 | beginning==cat14_start & cat81==8 | beginning==cat14_start & cat82==8 | beginning==cat14_start & cat83==8 | beginning==cat14_start & cat84==8 | beginning==cat14_start & cat85==8 | beginning==cat14_start & cat86==8 | beginning==cat14_start & cat87==8 | beginning==cat14_start & cat88==8
replace indicator=0 if beginning==cat14_start & indicator==.
replace indicator=0 if beginning==cat15_start & cat16==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==.
replace indicator=1 if beginning==cat15_start & cat16==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat16_start & cat17==.
replace indicator=1 if beginning==cat16_start & cat17==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18==.
replace indicator=1 if beginning==cat17_start & cat18==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==.
replace indicator=0 if beginning==cat18_start & cat19==.
replace indicator=1 if beginning==cat18_start & cat19==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21==.
replace indicator=1 if beginning==cat19_start & cat20==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat21_start & cat22==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31==.
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat24_start & cat25==.
replace indicator=0 if beginning==cat39_start & cat73!=8 & cat74==.
replace indicator=1 if beginning==cat48_start & cat49==8
replace indicator=1 if beginning==cat50_start & cat51==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==.
replace indicator=1 if beginning==cat25_start & cat26==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==.
replace indicator=0 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==.
replace indicator=1 if beginning==cat21_start & cat22==8
replace indicator=1 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat46_start & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52==.
replace indicator=0 if beginning==cat36_start & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49==.
replace indicator=0 if beginning==cat24_start & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat53_start & cat54==.
replace indicator=0 if beginning==cat34_start & cat35!=8 & cat36!=8 & cat37!=8 & cat38==.
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace indicator=0 if beginning==cat52_start & cat53!=8 & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58==.
replace indicator=1 if beginning==cat27_start & cat28==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=1 if beginning==cat20_start & cat21==8
replace indicator=1 if beginning==cat23_start & cat24==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29==.
replace indicator=1 if beginning==cat29_start & cat30==8
replace indicator=1 if beginning==cat22_start & cat23==8
replace indicator=1 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace indicator=1 if beginning==cat31_start & cat32==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat33_start & cat34==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8

tab indicator,m
* Drop individuals that are not in the risk set
drop if indicator==0
drop indicator

* Construct the 'beginning' variable
gen beginning2 = .
replace beginning2 = cat3_start if beginning==cat2_start & cat3==8
order folio_n20 beginning beginning2
replace beginning2 = cat4_start if beginning==cat2_start & cat3!=8 & cat4==8
replace beginning2 = cat5_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat4_start if beginning==cat3_start & cat4==8
replace beginning2 = cat5_start if beginning==cat3_start & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat5_start if beginning==cat4_start & cat5==8
replace beginning2 = cat6_start if beginning==cat4_start & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat6_start if beginning==cat5_start & cat6==8
replace beginning2 = cat7_start if beginning==cat5_start & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat7_start if beginning==cat6_start & cat7==8
replace beginning2 = cat8_start if beginning==cat6_start & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat23_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat24_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat8_start if beginning==cat7_start & cat8==8
replace beginning2 = cat9_start if beginning==cat7_start & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat9_start if beginning==cat8_start & cat9==8
replace beginning2 = cat10_start if beginning==cat8_start & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat10_start if beginning==cat9_start & cat10==8
replace beginning2 = cat11_start if beginning==cat9_start & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat16_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat11_start if beginning==cat10_start & cat11==8
replace beginning2 = cat12_start if beginning==cat10_start & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat17_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat12_start if beginning==cat11_start & cat12==8
replace beginning2 = cat13_start if beginning==cat11_start & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat13_start if beginning==cat12_start & cat13==8
replace beginning2 = cat14_start if beginning==cat12_start & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat14_start if beginning==cat13_start & cat14==8
replace beginning2 = cat15_start if beginning==cat13_start & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat15_start if beginning==cat14_start & cat15==8
replace beginning2 = cat16_start if beginning==cat14_start & cat15!=8 & cat16==8
replace beginning2 = cat16_start if beginning==cat15_start & cat16==8
replace beginning2 = cat17_start if beginning==cat15_start & cat16!=8 & cat17==8
replace beginning2 = cat17_start if beginning==cat16_start & cat17==8
replace beginning2 = cat18_start if beginning==cat17_start & cat18==8
replace beginning2 = cat19_start if beginning==cat18_start & cat19==8
replace beginning2 = cat20_start if beginning==cat19_start & cat20==8
replace beginning2 = cat25_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23!=2 & cat24!=2 & cat25==2
replace beginning2 = cat35_start if beginning==cat32_start & cat33!=8 & cat34!=8 & cat35==8
replace beginning2 = cat17_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat16_start & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat24_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat19_start if beginning==cat17_start & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat18_start & cat19!=8 & cat20==8
replace beginning2 = cat21_start if beginning==cat19_start & cat20!=8 & cat21==8
replace beginning2 = cat22_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat22_start if beginning==cat21_start & cat22==8
replace beginning2 = cat18_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat14_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat15_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat14_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat25_start if beginning==cat24_start & cat25==8
replace beginning2 = cat16_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat24_start if beginning==cat23_start & cat24==8
replace beginning2 = cat20_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat23_start if beginning==cat21_start & cat22!=8 & cat23==8
replace beginning2 = cat19_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat17_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat21_start if beginning==cat20_start & cat21==8
replace beginning2 = cat30_start if beginning==cat29_start & cat30==8
replace beginning2 = cat23_start if beginning==cat22_start & cat23==8
replace beginning2 = cat17_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat24_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat26_start if beginning==cat25_start & cat26==8
replace beginning2 = cat20_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat32_start if beginning==cat31_start & cat32==8
replace beginning2 = cat20_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat18_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8

* Make sure that there are no missings
tab beginning2,m
drop beginning
rename beginning2 beginning

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat3_start & cat4==1
order event,after(folio_n20)
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=0 if beginning==cat29_start & cat30==.
replace event=3 if beginning==cat48_start & cat49==3
replace event=4 if beginning==cat26_start & cat27==4
replace event=6 if beginning==cat27_start & cat28==6
replace event=5 if beginning==cat35_start & cat36==5
replace event=9 if beginning==cat30_start & cat31==10
replace event=6 if beginning==cat26_start & cat27==6
replace event=2 if beginning==cat32_start & cat33==2

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat29_start - beginning if beginning==cat28_start & cat29!=8 & cat29!=.
replace duration = cat31_start - beginning if beginning==cat30_start & cat31!=8 & cat31!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat33_start - beginning if beginning==cat32_start & cat33!=8 & cat33!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat52_start - beginning if beginning==cat51_start & cat52!=8 & cat52!=.

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC6_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =6

* Define the education variable
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling12 if beginning==cat12_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079)
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC6_informal", replace

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 7: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load the dataset for analysis
clear
use "$resultdir\sample_RC6_informal"

drop event
replace beginning=beginning+duration
drop duration

* Create risk set: individuals that are in RC informal of order 7 across multiple categories
gen indicator = .  // Initialize the variable
replace indicator=1 if beginning==cat2_start & cat3==8 | beginning==cat2_start & cat4==8 | beginning==cat2_start & cat5==8 | beginning==cat2_start & cat6==8 | beginning==cat2_start & cat7==8 | beginning==cat2_start & cat8==8 | beginning==cat2_start & cat9==8 | beginning==cat2_start & cat10==8 | beginning==cat2_start & cat11==8 | beginning==cat2_start & cat12==8 | beginning==cat2_start & cat13==8 | beginning==cat2_start & cat14==8 | beginning==cat2_start & cat15==8 | beginning==cat2_start & cat16==8 | beginning==cat2_start & cat17==8 | beginning==cat2_start & cat18==8 | beginning==cat2_start & cat19==8 | beginning==cat2_start & cat20==8 | beginning==cat2_start & cat21==8 | beginning==cat2_start & cat22==8 | beginning==cat2_start & cat23==8 | beginning==cat2_start & cat24==8 | beginning==cat2_start & cat25==8 | beginning==cat2_start & cat26==8 | beginning==cat2_start & cat27==8 | beginning==cat2_start & cat28==8 | beginning==cat2_start & cat29==8 | beginning==cat2_start & cat30==8 | beginning==cat2_start & cat31==8 | beginning==cat2_start & cat32==8 | beginning==cat2_start & cat33==8 | beginning==cat2_start & cat34==8 | beginning==cat2_start & cat35==8 | beginning==cat2_start & cat36==8 | beginning==cat2_start & cat37==8 | beginning==cat2_start & cat38==8 | beginning==cat2_start & cat39==8 | beginning==cat2_start & cat40==8 | beginning==cat2_start & cat41==8 | beginning==cat2_start & cat42==8 | beginning==cat2_start & cat43==8 | beginning==cat2_start & cat44==8 | beginning==cat2_start & cat45==8 | beginning==cat2_start & cat46==8 | beginning==cat2_start & cat47==8 | beginning==cat2_start & cat48==8 | beginning==cat2_start & cat49==8 | beginning==cat2_start & cat50==8 | beginning==cat2_start & cat51==8 | beginning==cat2_start & cat52==8 | beginning==cat2_start & cat53==8 | beginning==cat2_start & cat54==8 | beginning==cat2_start & cat55==8 | beginning==cat2_start & cat56==8 | beginning==cat2_start & cat57==8 | beginning==cat2_start & cat58==8 | beginning==cat2_start & cat59==8 | beginning==cat2_start & cat60==8 | beginning==cat2_start & cat61==8 | beginning==cat2_start & cat62==8 | beginning==cat2_start & cat63==8 | beginning==cat2_start & cat64==8 | beginning==cat2_start & cat65==8 | beginning==cat2_start & cat66==8 | beginning==cat2_start & cat67==8 | beginning==cat2_start & cat68==8 | beginning==cat2_start & cat69==8 | beginning==cat2_start & cat70==8 | beginning==cat2_start & cat71==8 | beginning==cat2_start & cat72==8 | beginning==cat2_start & cat73==8 | beginning==cat2_start & cat74==8 | beginning==cat2_start & cat75==8 | beginning==cat2_start & cat76==8 | beginning==cat2_start & cat77==8 | beginning==cat2_start & cat78==8 | beginning==cat2_start & cat79==8 | beginning==cat2_start & cat80==8 | beginning==cat2_start & cat81==8 | beginning==cat2_start & cat82==8 | beginning==cat2_start & cat83==8 | beginning==cat2_start & cat84==8 | beginning==cat2_start & cat85==8 | beginning==cat2_start & cat86==8 | beginning==cat2_start & cat87==8 | beginning==cat2_start & cat88==8
replace indicator=0 if beginning==cat2_start & indicator==.
replace indicator=1 if beginning==cat3_start & cat4==8 | beginning==cat3_start & cat5==8 | beginning==cat3_start & cat6==8 | beginning==cat3_start & cat7==8 | beginning==cat3_start & cat8==8 | beginning==cat3_start & cat9==8 | beginning==cat3_start & cat10==8 | beginning==cat3_start & cat11==8 | beginning==cat3_start & cat12==8 | beginning==cat3_start & cat13==8 | beginning==cat3_start & cat14==8 | beginning==cat3_start & cat15==8 | beginning==cat3_start & cat16==8 | beginning==cat3_start & cat17==8 | beginning==cat3_start & cat18==8 | beginning==cat3_start & cat19==8 | beginning==cat3_start & cat20==8 | beginning==cat3_start & cat21==8 | beginning==cat3_start & cat22==8 | beginning==cat3_start & cat23==8 | beginning==cat3_start & cat24==8 | beginning==cat3_start & cat25==8 | beginning==cat3_start & cat26==8 | beginning==cat3_start & cat27==8 | beginning==cat3_start & cat28==8 | beginning==cat3_start & cat29==8 | beginning==cat3_start & cat30==8 | beginning==cat3_start & cat31==8 | beginning==cat3_start & cat32==8 | beginning==cat3_start & cat33==8 | beginning==cat3_start & cat34==8 | beginning==cat3_start & cat35==8 | beginning==cat3_start & cat36==8 | beginning==cat3_start & cat37==8 | beginning==cat3_start & cat38==8 | beginning==cat3_start & cat39==8 | beginning==cat3_start & cat40==8 | beginning==cat3_start & cat41==8 | beginning==cat3_start & cat42==8 | beginning==cat3_start & cat43==8 | beginning==cat3_start & cat44==8 | beginning==cat3_start & cat45==8 | beginning==cat3_start & cat46==8 | beginning==cat3_start & cat47==8 | beginning==cat3_start & cat48==8 | beginning==cat3_start & cat49==8 | beginning==cat3_start & cat50==8 | beginning==cat3_start & cat51==8 | beginning==cat3_start & cat52==8 | beginning==cat3_start & cat53==8 | beginning==cat3_start & cat54==8 | beginning==cat3_start & cat55==8 | beginning==cat3_start & cat56==8 | beginning==cat3_start & cat57==8 | beginning==cat3_start & cat58==8 | beginning==cat3_start & cat59==8 | beginning==cat3_start & cat60==8 | beginning==cat3_start & cat61==8 | beginning==cat3_start & cat62==8 | beginning==cat3_start & cat63==8 | beginning==cat3_start & cat64==8 | beginning==cat3_start & cat65==8 | beginning==cat3_start & cat66==8 | beginning==cat3_start & cat67==8 | beginning==cat3_start & cat68==8 | beginning==cat3_start & cat69==8 | beginning==cat3_start & cat70==8 | beginning==cat3_start & cat71==8 | beginning==cat3_start & cat72==8 | beginning==cat3_start & cat73==8 | beginning==cat3_start & cat74==8 | beginning==cat3_start & cat75==8 | beginning==cat3_start & cat76==8 | beginning==cat3_start & cat77==8 | beginning==cat3_start & cat78==8 | beginning==cat3_start & cat79==8 | beginning==cat3_start & cat80==8 | beginning==cat3_start & cat81==8 | beginning==cat3_start & cat82==8 | beginning==cat3_start & cat83==8 | beginning==cat3_start & cat84==8 | beginning==cat3_start & cat85==8 | beginning==cat3_start & cat86==8 | beginning==cat3_start & cat87==8 | beginning==cat3_start & cat88==8
replace indicator=0 if beginning==cat3_start & indicator==.
replace indicator=1 if beginning==cat4_start & cat5==8 | beginning==cat4_start & cat6==8 | beginning==cat4_start & cat7==8 | beginning==cat4_start & cat8==8 | beginning==cat4_start & cat9==8 | beginning==cat4_start & cat10==8 | beginning==cat4_start & cat11==8 | beginning==cat4_start & cat12==8 | beginning==cat4_start & cat13==8 | beginning==cat4_start & cat14==8 | beginning==cat4_start & cat15==8 | beginning==cat4_start & cat16==8 | beginning==cat4_start & cat17==8 | beginning==cat4_start & cat18==8 | beginning==cat4_start & cat19==8 | beginning==cat4_start & cat20==8 | beginning==cat4_start & cat21==8 | beginning==cat4_start & cat22==8 | beginning==cat4_start & cat23==8 | beginning==cat4_start & cat24==8 | beginning==cat4_start & cat25==8 | beginning==cat4_start & cat26==8 | beginning==cat4_start & cat27==8 | beginning==cat4_start & cat28==8 | beginning==cat4_start & cat29==8 | beginning==cat4_start & cat30==8 | beginning==cat4_start & cat31==8 | beginning==cat4_start & cat32==8 | beginning==cat4_start & cat33==8 | beginning==cat4_start & cat34==8 | beginning==cat4_start & cat35==8 | beginning==cat4_start & cat36==8 | beginning==cat4_start & cat37==8 | beginning==cat4_start & cat38==8 | beginning==cat4_start & cat39==8 | beginning==cat4_start & cat40==8 | beginning==cat4_start & cat41==8 | beginning==cat4_start & cat42==8 | beginning==cat4_start & cat43==8 | beginning==cat4_start & cat44==8 | beginning==cat4_start & cat45==8 | beginning==cat4_start & cat46==8 | beginning==cat4_start & cat47==8 | beginning==cat4_start & cat48==8 | beginning==cat4_start & cat49==8 | beginning==cat4_start & cat50==8 | beginning==cat4_start & cat51==8 | beginning==cat4_start & cat52==8 | beginning==cat4_start & cat53==8 | beginning==cat4_start & cat54==8 | beginning==cat4_start & cat55==8 | beginning==cat4_start & cat56==8 | beginning==cat4_start & cat57==8 | beginning==cat4_start & cat58==8 | beginning==cat4_start & cat59==8 | beginning==cat4_start & cat60==8 | beginning==cat4_start & cat61==8 | beginning==cat4_start & cat62==8 | beginning==cat4_start & cat63==8 | beginning==cat4_start & cat64==8 | beginning==cat4_start & cat65==8 | beginning==cat4_start & cat66==8 | beginning==cat4_start & cat67==8 | beginning==cat4_start & cat68==8 | beginning==cat4_start & cat69==8 | beginning==cat4_start & cat70==8 | beginning==cat4_start & cat71==8 | beginning==cat4_start & cat72==8 | beginning==cat4_start & cat73==8 | beginning==cat4_start & cat74==8 | beginning==cat4_start & cat75==8 | beginning==cat4_start & cat76==8 | beginning==cat4_start & cat77==8 | beginning==cat4_start & cat78==8 | beginning==cat4_start & cat79==8 | beginning==cat4_start & cat80==8 | beginning==cat4_start & cat81==8 | beginning==cat4_start & cat82==8 | beginning==cat4_start & cat83==8 | beginning==cat4_start & cat84==8 | beginning==cat4_start & cat85==8 | beginning==cat4_start & cat86==8 | beginning==cat4_start & cat87==8 | beginning==cat4_start & cat88==8
replace indicator=0 if beginning==cat4_start & indicator==.
replace indicator=1 if beginning==cat5_start & cat6==8 | beginning==cat5_start & cat7==8 | beginning==cat5_start & cat8==8 | beginning==cat5_start & cat9==8 | beginning==cat5_start & cat10==8 | beginning==cat5_start & cat11==8 | beginning==cat5_start & cat12==8 | beginning==cat5_start & cat13==8 | beginning==cat5_start & cat14==8 | beginning==cat5_start & cat15==8 | beginning==cat5_start & cat16==8 | beginning==cat5_start & cat17==8 | beginning==cat5_start & cat18==8 | beginning==cat5_start & cat19==8 | beginning==cat5_start & cat20==8 | beginning==cat5_start & cat21==8 | beginning==cat5_start & cat22==8 | beginning==cat5_start & cat23==8 | beginning==cat5_start & cat24==8 | beginning==cat5_start & cat25==8 | beginning==cat5_start & cat26==8 | beginning==cat5_start & cat27==8 | beginning==cat5_start & cat28==8 | beginning==cat5_start & cat29==8 | beginning==cat5_start & cat30==8 | beginning==cat5_start & cat31==8 | beginning==cat5_start & cat32==8 | beginning==cat5_start & cat33==8 | beginning==cat5_start & cat34==8 | beginning==cat5_start & cat35==8 | beginning==cat5_start & cat36==8 | beginning==cat5_start & cat37==8 | beginning==cat5_start & cat38==8 | beginning==cat5_start & cat39==8 | beginning==cat5_start & cat40==8 | beginning==cat5_start & cat41==8 | beginning==cat5_start & cat42==8 | beginning==cat5_start & cat43==8 | beginning==cat5_start & cat44==8 | beginning==cat5_start & cat45==8 | beginning==cat5_start & cat46==8 | beginning==cat5_start & cat47==8 | beginning==cat5_start & cat48==8 | beginning==cat5_start & cat49==8 | beginning==cat5_start & cat50==8 | beginning==cat5_start & cat51==8 | beginning==cat5_start & cat52==8 | beginning==cat5_start & cat53==8 | beginning==cat5_start & cat54==8 | beginning==cat5_start & cat55==8 | beginning==cat5_start & cat56==8 | beginning==cat5_start & cat57==8 | beginning==cat5_start & cat58==8 | beginning==cat5_start & cat59==8 | beginning==cat5_start & cat60==8 | beginning==cat5_start & cat61==8 | beginning==cat5_start & cat62==8 | beginning==cat5_start & cat63==8 | beginning==cat5_start & cat64==8 | beginning==cat5_start & cat65==8 | beginning==cat5_start & cat66==8 | beginning==cat5_start & cat67==8 | beginning==cat5_start & cat68==8 | beginning==cat5_start & cat69==8 | beginning==cat5_start & cat70==8 | beginning==cat5_start & cat71==8 | beginning==cat5_start & cat72==8 | beginning==cat5_start & cat73==8 | beginning==cat5_start & cat74==8 | beginning==cat5_start & cat75==8 | beginning==cat5_start & cat76==8 | beginning==cat5_start & cat77==8 | beginning==cat5_start & cat78==8 | beginning==cat5_start & cat79==8 | beginning==cat5_start & cat80==8 | beginning==cat5_start & cat81==8 | beginning==cat5_start & cat82==8 | beginning==cat5_start & cat83==8 | beginning==cat5_start & cat84==8 | beginning==cat5_start & cat85==8 | beginning==cat5_start & cat86==8 | beginning==cat5_start & cat87==8 | beginning==cat5_start & cat88==8
replace indicator=0 if beginning==cat5_start & indicator==.
replace indicator=1 if beginning==cat6_start & cat7==8 | beginning==cat6_start & cat8==8 | beginning==cat6_start & cat9==8 | beginning==cat6_start & cat10==8 | beginning==cat6_start & cat11==8 | beginning==cat6_start & cat12==8 | beginning==cat6_start & cat13==8 | beginning==cat6_start & cat14==8 | beginning==cat6_start & cat15==8 | beginning==cat6_start & cat16==8 | beginning==cat6_start & cat17==8 | beginning==cat6_start & cat18==8 | beginning==cat6_start & cat19==8 | beginning==cat6_start & cat20==8 | beginning==cat6_start & cat21==8 | beginning==cat6_start & cat22==8 | beginning==cat6_start & cat23==8 | beginning==cat6_start & cat24==8 | beginning==cat6_start & cat25==8 | beginning==cat6_start & cat26==8 | beginning==cat6_start & cat27==8 | beginning==cat6_start & cat28==8 | beginning==cat6_start & cat29==8 | beginning==cat6_start & cat30==8 | beginning==cat6_start & cat31==8 | beginning==cat6_start & cat32==8 | beginning==cat6_start & cat33==8 | beginning==cat6_start & cat34==8 | beginning==cat6_start & cat35==8 | beginning==cat6_start & cat36==8 | beginning==cat6_start & cat37==8 | beginning==cat6_start & cat38==8 | beginning==cat6_start & cat39==8 | beginning==cat6_start & cat40==8 | beginning==cat6_start & cat41==8 | beginning==cat6_start & cat42==8 | beginning==cat6_start & cat43==8 | beginning==cat6_start & cat44==8 | beginning==cat6_start & cat45==8 | beginning==cat6_start & cat46==8 | beginning==cat6_start & cat47==8 | beginning==cat6_start & cat48==8 | beginning==cat6_start & cat49==8 | beginning==cat6_start & cat50==8 | beginning==cat6_start & cat51==8 | beginning==cat6_start & cat52==8 | beginning==cat6_start & cat53==8 | beginning==cat6_start & cat54==8 | beginning==cat6_start & cat55==8 | beginning==cat6_start & cat56==8 | beginning==cat6_start & cat57==8 | beginning==cat6_start & cat58==8 | beginning==cat6_start & cat59==8 | beginning==cat6_start & cat60==8 | beginning==cat6_start & cat61==8 | beginning==cat6_start & cat62==8 | beginning==cat6_start & cat63==8 | beginning==cat6_start & cat64==8 | beginning==cat6_start & cat65==8 | beginning==cat6_start & cat66==8 | beginning==cat6_start & cat67==8 | beginning==cat6_start & cat68==8 | beginning==cat6_start & cat69==8 | beginning==cat6_start & cat70==8 | beginning==cat6_start & cat71==8 | beginning==cat6_start & cat72==8 | beginning==cat6_start & cat73==8 | beginning==cat6_start & cat74==8 | beginning==cat6_start & cat75==8 | beginning==cat6_start & cat76==8 | beginning==cat6_start & cat77==8 | beginning==cat6_start & cat78==8 | beginning==cat6_start & cat79==8 | beginning==cat6_start & cat80==8 | beginning==cat6_start & cat81==8 | beginning==cat6_start & cat82==8 | beginning==cat6_start & cat83==8 | beginning==cat6_start & cat84==8 | beginning==cat6_start & cat85==8 | beginning==cat6_start & cat86==8 | beginning==cat6_start & cat87==8 | beginning==cat6_start & cat88==8
replace indicator=0 if beginning==cat6_start & indicator==.
replace indicator=1 if beginning==cat7_start & cat8==8 | beginning==cat7_start & cat9==8 | beginning==cat7_start & cat10==8 | beginning==cat7_start & cat11==8 | beginning==cat7_start & cat12==8 | beginning==cat7_start & cat13==8 | beginning==cat7_start & cat14==8 | beginning==cat7_start & cat15==8 | beginning==cat7_start & cat16==8 | beginning==cat7_start & cat17==8 | beginning==cat7_start & cat18==8 | beginning==cat7_start & cat19==8 | beginning==cat7_start & cat20==8 | beginning==cat7_start & cat21==8 | beginning==cat7_start & cat22==8 | beginning==cat7_start & cat23==8 | beginning==cat7_start & cat24==8 | beginning==cat7_start & cat25==8 | beginning==cat7_start & cat26==8 | beginning==cat7_start & cat27==8 | beginning==cat7_start & cat28==8 | beginning==cat7_start & cat29==8 | beginning==cat7_start & cat30==8 | beginning==cat7_start & cat31==8 | beginning==cat7_start & cat32==8 | beginning==cat7_start & cat33==8 | beginning==cat7_start & cat34==8 | beginning==cat7_start & cat35==8 | beginning==cat7_start & cat36==8 | beginning==cat7_start & cat37==8 | beginning==cat7_start & cat38==8 | beginning==cat7_start & cat39==8 | beginning==cat7_start & cat40==8 | beginning==cat7_start & cat41==8 | beginning==cat7_start & cat42==8 | beginning==cat7_start & cat43==8 | beginning==cat7_start & cat44==8 | beginning==cat7_start & cat45==8 | beginning==cat7_start & cat46==8 | beginning==cat7_start & cat47==8 | beginning==cat7_start & cat48==8 | beginning==cat7_start & cat49==8 | beginning==cat7_start & cat50==8 | beginning==cat7_start & cat51==8 | beginning==cat7_start & cat52==8 | beginning==cat7_start & cat53==8 | beginning==cat7_start & cat54==8 | beginning==cat7_start & cat55==8 | beginning==cat7_start & cat56==8 | beginning==cat7_start & cat57==8 | beginning==cat7_start & cat58==8 | beginning==cat7_start & cat59==8 | beginning==cat7_start & cat60==8 | beginning==cat7_start & cat61==8 | beginning==cat7_start & cat62==8 | beginning==cat7_start & cat63==8 | beginning==cat7_start & cat64==8 | beginning==cat7_start & cat65==8 | beginning==cat7_start & cat66==8 | beginning==cat7_start & cat67==8 | beginning==cat7_start & cat68==8 | beginning==cat7_start & cat69==8 | beginning==cat7_start & cat70==8 | beginning==cat7_start & cat71==8 | beginning==cat7_start & cat72==8 | beginning==cat7_start & cat73==8 | beginning==cat7_start & cat74==8 | beginning==cat7_start & cat75==8 | beginning==cat7_start & cat76==8 | beginning==cat7_start & cat77==8 | beginning==cat7_start & cat78==8 | beginning==cat7_start & cat79==8 | beginning==cat7_start & cat80==8 | beginning==cat7_start & cat81==8 | beginning==cat7_start & cat82==8 | beginning==cat7_start & cat83==8 | beginning==cat7_start & cat84==8 | beginning==cat7_start & cat85==8 | beginning==cat7_start & cat86==8 | beginning==cat7_start & cat87==8 | beginning==cat7_start & cat88==8
replace indicator=0 if beginning==cat7_start & indicator==.
replace indicator=1 if beginning==cat8_start & cat9==8 | beginning==cat8_start & cat10==8 | beginning==cat8_start & cat11==8 | beginning==cat8_start & cat12==8 | beginning==cat8_start & cat13==8 | beginning==cat8_start & cat14==8 | beginning==cat8_start & cat15==8 | beginning==cat8_start & cat16==8 | beginning==cat8_start & cat17==8 | beginning==cat8_start & cat18==8 | beginning==cat8_start & cat19==8 | beginning==cat8_start & cat20==8 | beginning==cat8_start & cat21==8 | beginning==cat8_start & cat22==8 | beginning==cat8_start & cat23==8 | beginning==cat8_start & cat24==8 | beginning==cat8_start & cat25==8 | beginning==cat8_start & cat26==8 | beginning==cat8_start & cat27==8 | beginning==cat8_start & cat28==8 | beginning==cat8_start & cat29==8 | beginning==cat8_start & cat30==8 | beginning==cat8_start & cat31==8 | beginning==cat8_start & cat32==8 | beginning==cat8_start & cat33==8 | beginning==cat8_start & cat34==8 | beginning==cat8_start & cat35==8 | beginning==cat8_start & cat36==8 | beginning==cat8_start & cat37==8 | beginning==cat8_start & cat38==8 | beginning==cat8_start & cat39==8 | beginning==cat8_start & cat40==8 | beginning==cat8_start & cat41==8 | beginning==cat8_start & cat42==8 | beginning==cat8_start & cat43==8 | beginning==cat8_start & cat44==8 | beginning==cat8_start & cat45==8 | beginning==cat8_start & cat46==8 | beginning==cat8_start & cat47==8 | beginning==cat8_start & cat48==8 | beginning==cat8_start & cat49==8 | beginning==cat8_start & cat50==8 | beginning==cat8_start & cat51==8 | beginning==cat8_start & cat52==8 | beginning==cat8_start & cat53==8 | beginning==cat8_start & cat54==8 | beginning==cat8_start & cat55==8 | beginning==cat8_start & cat56==8 | beginning==cat8_start & cat57==8 | beginning==cat8_start & cat58==8 | beginning==cat8_start & cat59==8 | beginning==cat8_start & cat60==8 | beginning==cat8_start & cat61==8 | beginning==cat8_start & cat62==8 | beginning==cat8_start & cat63==8 | beginning==cat8_start & cat64==8 | beginning==cat8_start & cat65==8 | beginning==cat8_start & cat66==8 | beginning==cat8_start & cat67==8 | beginning==cat8_start & cat68==8 | beginning==cat8_start & cat69==8 | beginning==cat8_start & cat70==8 | beginning==cat8_start & cat71==8 | beginning==cat8_start & cat72==8 | beginning==cat8_start & cat73==8 | beginning==cat8_start & cat74==8 | beginning==cat8_start & cat75==8 | beginning==cat8_start & cat76==8 | beginning==cat8_start & cat77==8 | beginning==cat8_start & cat78==8 | beginning==cat8_start & cat79==8 | beginning==cat8_start & cat80==8 | beginning==cat8_start & cat81==8 | beginning==cat8_start & cat82==8 | beginning==cat8_start & cat83==8 | beginning==cat8_start & cat84==8 | beginning==cat8_start & cat85==8 | beginning==cat8_start & cat86==8 | beginning==cat8_start & cat87==8 | beginning==cat8_start & cat88==8
replace indicator=0 if beginning==cat8_start & indicator==.
replace indicator=0 if beginning==end
replace indicator=1 if beginning==cat9_start & cat10==8 | beginning==cat9_start & cat11==8 | beginning==cat9_start & cat12==8 | beginning==cat9_start & cat13==8 | beginning==cat9_start & cat14==8 | beginning==cat9_start & cat15==8 | beginning==cat9_start & cat16==8 | beginning==cat9_start & cat17==8 | beginning==cat9_start & cat18==8 | beginning==cat9_start & cat19==8 | beginning==cat9_start & cat20==8 | beginning==cat9_start & cat21==8 | beginning==cat9_start & cat22==8 | beginning==cat9_start & cat23==8 | beginning==cat9_start & cat24==8 | beginning==cat9_start & cat25==8 | beginning==cat9_start & cat26==8 | beginning==cat9_start & cat27==8 | beginning==cat9_start & cat28==8 | beginning==cat9_start & cat29==8 | beginning==cat9_start & cat30==8 | beginning==cat9_start & cat31==8 | beginning==cat9_start & cat32==8 | beginning==cat9_start & cat33==8 | beginning==cat9_start & cat34==8 | beginning==cat9_start & cat35==8 | beginning==cat9_start & cat36==8 | beginning==cat9_start & cat37==8 | beginning==cat9_start & cat38==8 | beginning==cat9_start & cat39==8 | beginning==cat9_start & cat40==8 | beginning==cat9_start & cat41==8 | beginning==cat9_start & cat42==8 | beginning==cat9_start & cat43==8 | beginning==cat9_start & cat44==8 | beginning==cat9_start & cat45==8 | beginning==cat9_start & cat46==8 | beginning==cat9_start & cat47==8 | beginning==cat9_start & cat48==8 | beginning==cat9_start & cat49==8 | beginning==cat9_start & cat50==8 | beginning==cat9_start & cat51==8 | beginning==cat9_start & cat52==8 | beginning==cat9_start & cat53==8 | beginning==cat9_start & cat54==8 | beginning==cat9_start & cat55==8 | beginning==cat9_start & cat56==8 | beginning==cat9_start & cat57==8 | beginning==cat9_start & cat58==8 | beginning==cat9_start & cat59==8 | beginning==cat9_start & cat60==8 | beginning==cat9_start & cat61==8 | beginning==cat9_start & cat62==8 | beginning==cat9_start & cat63==8 | beginning==cat9_start & cat64==8 | beginning==cat9_start & cat65==8 | beginning==cat9_start & cat66==8 | beginning==cat9_start & cat67==8 | beginning==cat9_start & cat68==8 | beginning==cat9_start & cat69==8 | beginning==cat9_start & cat70==8 | beginning==cat9_start & cat71==8 | beginning==cat9_start & cat72==8 | beginning==cat9_start & cat73==8 | beginning==cat9_start & cat74==8 | beginning==cat9_start & cat75==8 | beginning==cat9_start & cat76==8 | beginning==cat9_start & cat77==8 | beginning==cat9_start & cat78==8 | beginning==cat9_start & cat79==8 | beginning==cat9_start & cat80==8 | beginning==cat9_start & cat81==8 | beginning==cat9_start & cat82==8 | beginning==cat9_start & cat83==8 | beginning==cat9_start & cat84==8 | beginning==cat9_start & cat85==8 | beginning==cat9_start & cat86==8 | beginning==cat9_start & cat87==8 | beginning==cat9_start & cat88==8
replace indicator=0 if beginning==cat9_start & indicator==.
replace indicator=1 if beginning==cat10_start & cat11==8 | beginning==cat10_start & cat12==8 | beginning==cat10_start & cat13==8 | beginning==cat10_start & cat14==8 | beginning==cat10_start & cat15==8 | beginning==cat10_start & cat16==8 | beginning==cat10_start & cat17==8 | beginning==cat10_start & cat18==8 | beginning==cat10_start & cat19==8 | beginning==cat10_start & cat20==8 | beginning==cat10_start & cat21==8 | beginning==cat10_start & cat22==8 | beginning==cat10_start & cat23==8 | beginning==cat10_start & cat24==8 | beginning==cat10_start & cat25==8 | beginning==cat10_start & cat26==8 | beginning==cat10_start & cat27==8 | beginning==cat10_start & cat28==8 | beginning==cat10_start & cat29==8 | beginning==cat10_start & cat30==8 | beginning==cat10_start & cat31==8 | beginning==cat10_start & cat32==8 | beginning==cat10_start & cat33==8 | beginning==cat10_start & cat34==8 | beginning==cat10_start & cat35==8 | beginning==cat10_start & cat36==8 | beginning==cat10_start & cat37==8 | beginning==cat10_start & cat38==8 | beginning==cat10_start & cat39==8 | beginning==cat10_start & cat40==8 | beginning==cat10_start & cat41==8 | beginning==cat10_start & cat42==8 | beginning==cat10_start & cat43==8 | beginning==cat10_start & cat44==8 | beginning==cat10_start & cat45==8 | beginning==cat10_start & cat46==8 | beginning==cat10_start & cat47==8 | beginning==cat10_start & cat48==8 | beginning==cat10_start & cat49==8 | beginning==cat10_start & cat50==8 | beginning==cat10_start & cat51==8 | beginning==cat10_start & cat52==8 | beginning==cat10_start & cat53==8 | beginning==cat10_start & cat54==8 | beginning==cat10_start & cat55==8 | beginning==cat10_start & cat56==8 | beginning==cat10_start & cat57==8 | beginning==cat10_start & cat58==8 | beginning==cat10_start & cat59==8 | beginning==cat10_start & cat60==8 | beginning==cat10_start & cat61==8 | beginning==cat10_start & cat62==8 | beginning==cat10_start & cat63==8 | beginning==cat10_start & cat64==8 | beginning==cat10_start & cat65==8 | beginning==cat10_start & cat66==8 | beginning==cat10_start & cat67==8 | beginning==cat10_start & cat68==8 | beginning==cat10_start & cat69==8 | beginning==cat10_start & cat70==8 | beginning==cat10_start & cat71==8 | beginning==cat10_start & cat72==8 | beginning==cat10_start & cat73==8 | beginning==cat10_start & cat74==8 | beginning==cat10_start & cat75==8 | beginning==cat10_start & cat76==8 | beginning==cat10_start & cat77==8 | beginning==cat10_start & cat78==8 | beginning==cat10_start & cat79==8 | beginning==cat10_start & cat80==8 | beginning==cat10_start & cat81==8 | beginning==cat10_start & cat82==8 | beginning==cat10_start & cat83==8 | beginning==cat10_start & cat84==8 | beginning==cat10_start & cat85==8 | beginning==cat10_start & cat86==8 | beginning==cat10_start & cat87==8 | beginning==cat10_start & cat88==8
replace indicator=0 if beginning==cat10_start & indicator==.
replace indicator=1 if beginning==cat11_start & cat12==8 | beginning==cat11_start & cat13==8 | beginning==cat11_start & cat14==8 | beginning==cat11_start & cat15==8 | beginning==cat11_start & cat16==8 | beginning==cat11_start & cat17==8 | beginning==cat11_start & cat18==8 | beginning==cat11_start & cat19==8 | beginning==cat11_start & cat20==8 | beginning==cat11_start & cat21==8 | beginning==cat11_start & cat22==8 | beginning==cat11_start & cat23==8 | beginning==cat11_start & cat24==8 | beginning==cat11_start & cat25==8 | beginning==cat11_start & cat26==8 | beginning==cat11_start & cat27==8 | beginning==cat11_start & cat28==8 | beginning==cat11_start & cat29==8 | beginning==cat11_start & cat30==8 | beginning==cat11_start & cat31==8 | beginning==cat11_start & cat32==8 | beginning==cat11_start & cat33==8 | beginning==cat11_start & cat34==8 | beginning==cat11_start & cat35==8 | beginning==cat11_start & cat36==8 | beginning==cat11_start & cat37==8 | beginning==cat11_start & cat38==8 | beginning==cat11_start & cat39==8 | beginning==cat11_start & cat40==8 | beginning==cat11_start & cat41==8 | beginning==cat11_start & cat42==8 | beginning==cat11_start & cat43==8 | beginning==cat11_start & cat44==8 | beginning==cat11_start & cat45==8 | beginning==cat11_start & cat46==8 | beginning==cat11_start & cat47==8 | beginning==cat11_start & cat48==8 | beginning==cat11_start & cat49==8 | beginning==cat11_start & cat50==8 | beginning==cat11_start & cat51==8 | beginning==cat11_start & cat52==8 | beginning==cat11_start & cat53==8 | beginning==cat11_start & cat54==8 | beginning==cat11_start & cat55==8 | beginning==cat11_start & cat56==8 | beginning==cat11_start & cat57==8 | beginning==cat11_start & cat58==8 | beginning==cat11_start & cat59==8 | beginning==cat11_start & cat60==8 | beginning==cat11_start & cat61==8 | beginning==cat11_start & cat62==8 | beginning==cat11_start & cat63==8 | beginning==cat11_start & cat64==8 | beginning==cat11_start & cat65==8 | beginning==cat11_start & cat66==8 | beginning==cat11_start & cat67==8 | beginning==cat11_start & cat68==8 | beginning==cat11_start & cat69==8 | beginning==cat11_start & cat70==8 | beginning==cat11_start & cat71==8 | beginning==cat11_start & cat72==8 | beginning==cat11_start & cat73==8 | beginning==cat11_start & cat74==8 | beginning==cat11_start & cat75==8 | beginning==cat11_start & cat76==8 | beginning==cat11_start & cat77==8 | beginning==cat11_start & cat78==8 | beginning==cat11_start & cat79==8 | beginning==cat11_start & cat80==8 | beginning==cat11_start & cat81==8 | beginning==cat11_start & cat82==8 | beginning==cat11_start & cat83==8 | beginning==cat11_start & cat84==8 | beginning==cat11_start & cat85==8 | beginning==cat11_start & cat86==8 | beginning==cat11_start & cat87==8 | beginning==cat11_start & cat88==8
replace indicator=0 if beginning==cat11_start & indicator==.
replace indicator=1 if beginning==cat12_start & cat13==8 | beginning==cat12_start & cat14==8 | beginning==cat12_start & cat15==8 | beginning==cat12_start & cat16==8 | beginning==cat12_start & cat17==8 | beginning==cat12_start & cat18==8 | beginning==cat12_start & cat19==8 | beginning==cat12_start & cat20==8 | beginning==cat12_start & cat21==8 | beginning==cat12_start & cat22==8 | beginning==cat12_start & cat23==8 | beginning==cat12_start & cat24==8 | beginning==cat12_start & cat25==8 | beginning==cat12_start & cat26==8 | beginning==cat12_start & cat27==8 | beginning==cat12_start & cat28==8 | beginning==cat12_start & cat29==8 | beginning==cat12_start & cat30==8 | beginning==cat12_start & cat31==8 | beginning==cat12_start & cat32==8 | beginning==cat12_start & cat33==8 | beginning==cat12_start & cat34==8 | beginning==cat12_start & cat35==8 | beginning==cat12_start & cat36==8 | beginning==cat12_start & cat37==8 | beginning==cat12_start & cat38==8 | beginning==cat12_start & cat39==8 | beginning==cat12_start & cat40==8 | beginning==cat12_start & cat41==8 | beginning==cat12_start & cat42==8 | beginning==cat12_start & cat43==8 | beginning==cat12_start & cat44==8 | beginning==cat12_start & cat45==8 | beginning==cat12_start & cat46==8 | beginning==cat12_start & cat47==8 | beginning==cat12_start & cat48==8 | beginning==cat12_start & cat49==8 | beginning==cat12_start & cat50==8 | beginning==cat12_start & cat51==8 | beginning==cat12_start & cat52==8 | beginning==cat12_start & cat53==8 | beginning==cat12_start & cat54==8 | beginning==cat12_start & cat55==8 | beginning==cat12_start & cat56==8 | beginning==cat12_start & cat57==8 | beginning==cat12_start & cat58==8 | beginning==cat12_start & cat59==8 | beginning==cat12_start & cat60==8 | beginning==cat12_start & cat61==8 | beginning==cat12_start & cat62==8 | beginning==cat12_start & cat63==8 | beginning==cat12_start & cat64==8 | beginning==cat12_start & cat65==8 | beginning==cat12_start & cat66==8 | beginning==cat12_start & cat67==8 | beginning==cat12_start & cat68==8 | beginning==cat12_start & cat69==8 | beginning==cat12_start & cat70==8 | beginning==cat12_start & cat71==8 | beginning==cat12_start & cat72==8 | beginning==cat12_start & cat73==8 | beginning==cat12_start & cat74==8 | beginning==cat12_start & cat75==8 | beginning==cat12_start & cat76==8 | beginning==cat12_start & cat77==8 | beginning==cat12_start & cat78==8 | beginning==cat12_start & cat79==8 | beginning==cat12_start & cat80==8 | beginning==cat12_start & cat81==8 | beginning==cat12_start & cat82==8 | beginning==cat12_start & cat83==8 | beginning==cat12_start & cat84==8 | beginning==cat12_start & cat85==8 | beginning==cat12_start & cat86==8 | beginning==cat12_start & cat87==8 | beginning==cat12_start & cat88==8
replace indicator=0 if beginning==cat12_start & indicator==.
replace indicator=1 if beginning==cat13_start & cat14==8 | beginning==cat13_start & cat15==8 | beginning==cat13_start & cat16==8 | beginning==cat13_start & cat17==8 | beginning==cat13_start & cat18==8 | beginning==cat13_start & cat19==8 | beginning==cat13_start & cat20==8 | beginning==cat13_start & cat21==8 | beginning==cat13_start & cat22==8 | beginning==cat13_start & cat23==8 | beginning==cat13_start & cat24==8 | beginning==cat13_start & cat25==8 | beginning==cat13_start & cat26==8 | beginning==cat13_start & cat27==8 | beginning==cat13_start & cat28==8 | beginning==cat13_start & cat29==8 | beginning==cat13_start & cat30==8 | beginning==cat13_start & cat31==8 | beginning==cat13_start & cat32==8 | beginning==cat13_start & cat33==8 | beginning==cat13_start & cat34==8 | beginning==cat13_start & cat35==8 | beginning==cat13_start & cat36==8 | beginning==cat13_start & cat37==8 | beginning==cat13_start & cat38==8 | beginning==cat13_start & cat39==8 | beginning==cat13_start & cat40==8 | beginning==cat13_start & cat41==8 | beginning==cat13_start & cat42==8 | beginning==cat13_start & cat43==8 | beginning==cat13_start & cat44==8 | beginning==cat13_start & cat45==8 | beginning==cat13_start & cat46==8 | beginning==cat13_start & cat47==8 | beginning==cat13_start & cat48==8 | beginning==cat13_start & cat49==8 | beginning==cat13_start & cat50==8 | beginning==cat13_start & cat51==8 | beginning==cat13_start & cat52==8 | beginning==cat13_start & cat53==8 | beginning==cat13_start & cat54==8 | beginning==cat13_start & cat55==8 | beginning==cat13_start & cat56==8 | beginning==cat13_start & cat57==8 | beginning==cat13_start & cat58==8 | beginning==cat13_start & cat59==8 | beginning==cat13_start & cat60==8 | beginning==cat13_start & cat61==8 | beginning==cat13_start & cat62==8 | beginning==cat13_start & cat63==8 | beginning==cat13_start & cat64==8 | beginning==cat13_start & cat65==8 | beginning==cat13_start & cat66==8 | beginning==cat13_start & cat67==8 | beginning==cat13_start & cat68==8 | beginning==cat13_start & cat69==8 | beginning==cat13_start & cat70==8 | beginning==cat13_start & cat71==8 | beginning==cat13_start & cat72==8 | beginning==cat13_start & cat73==8 | beginning==cat13_start & cat74==8 | beginning==cat13_start & cat75==8 | beginning==cat13_start & cat76==8 | beginning==cat13_start & cat77==8 | beginning==cat13_start & cat78==8 | beginning==cat13_start & cat79==8 | beginning==cat13_start & cat80==8 | beginning==cat13_start & cat81==8 | beginning==cat13_start & cat82==8 | beginning==cat13_start & cat83==8 | beginning==cat13_start & cat84==8 | beginning==cat13_start & cat85==8 | beginning==cat13_start & cat86==8 | beginning==cat13_start & cat87==8 | beginning==cat13_start & cat88==8
replace indicator=0 if beginning==cat13_start & indicator==.
replace indicator=1 if beginning==cat14_start & cat15==8 | beginning==cat14_start & cat16==8 | beginning==cat14_start & cat17==8 | beginning==cat14_start & cat18==8 | beginning==cat14_start & cat19==8 | beginning==cat14_start & cat20==8 | beginning==cat14_start & cat21==8 | beginning==cat14_start & cat22==8 | beginning==cat14_start & cat23==8 | beginning==cat14_start & cat24==8 | beginning==cat14_start & cat25==8 | beginning==cat14_start & cat26==8 | beginning==cat14_start & cat27==8 | beginning==cat14_start & cat28==8 | beginning==cat14_start & cat29==8 | beginning==cat14_start & cat30==8 | beginning==cat14_start & cat31==8 | beginning==cat14_start & cat32==8 | beginning==cat14_start & cat33==8 | beginning==cat14_start & cat34==8 | beginning==cat14_start & cat35==8 | beginning==cat14_start & cat36==8 | beginning==cat14_start & cat37==8 | beginning==cat14_start & cat38==8 | beginning==cat14_start & cat39==8 | beginning==cat14_start & cat40==8 | beginning==cat14_start & cat41==8 | beginning==cat14_start & cat42==8 | beginning==cat14_start & cat43==8 | beginning==cat14_start & cat44==8 | beginning==cat14_start & cat45==8 | beginning==cat14_start & cat46==8 | beginning==cat14_start & cat47==8 | beginning==cat14_start & cat48==8 | beginning==cat14_start & cat49==8 | beginning==cat14_start & cat50==8 | beginning==cat14_start & cat51==8 | beginning==cat14_start & cat52==8 | beginning==cat14_start & cat53==8 | beginning==cat14_start & cat54==8 | beginning==cat14_start & cat55==8 | beginning==cat14_start & cat56==8 | beginning==cat14_start & cat57==8 | beginning==cat14_start & cat58==8 | beginning==cat14_start & cat59==8 | beginning==cat14_start & cat60==8 | beginning==cat14_start & cat61==8 | beginning==cat14_start & cat62==8 | beginning==cat14_start & cat63==8 | beginning==cat14_start & cat64==8 | beginning==cat14_start & cat65==8 | beginning==cat14_start & cat66==8 | beginning==cat14_start & cat67==8 | beginning==cat14_start & cat68==8 | beginning==cat14_start & cat69==8 | beginning==cat14_start & cat70==8 | beginning==cat14_start & cat71==8 | beginning==cat14_start & cat72==8 | beginning==cat14_start & cat73==8 | beginning==cat14_start & cat74==8 | beginning==cat14_start & cat75==8 | beginning==cat14_start & cat76==8 | beginning==cat14_start & cat77==8 | beginning==cat14_start & cat78==8 | beginning==cat14_start & cat79==8 | beginning==cat14_start & cat80==8 | beginning==cat14_start & cat81==8 | beginning==cat14_start & cat82==8 | beginning==cat14_start & cat83==8 | beginning==cat14_start & cat84==8 | beginning==cat14_start & cat85==8 | beginning==cat14_start & cat86==8 | beginning==cat14_start & cat87==8 | beginning==cat14_start & cat88==8
replace indicator=0 if beginning==cat14_start & indicator==.
replace indicator=0 if beginning==cat15_start & cat16==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==.
replace indicator=1 if beginning==cat15_start & cat16==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat16_start & cat17==.
replace indicator=1 if beginning==cat16_start & cat17==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18==.
replace indicator=1 if beginning==cat17_start & cat18==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==.
replace indicator=0 if beginning==cat18_start & cat19==.
replace indicator=1 if beginning==cat18_start & cat19==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21==.
replace indicator=1 if beginning==cat19_start & cat20==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat21_start & cat22==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31==.
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat24_start & cat25==.
replace indicator=0 if beginning==cat39_start & cat73!=8 & cat74==.
replace indicator=1 if beginning==cat48_start & cat49==8
replace indicator=1 if beginning==cat50_start & cat51==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==.
replace indicator=1 if beginning==cat25_start & cat26==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==.
replace indicator=0 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==.
replace indicator=1 if beginning==cat21_start & cat22==8
replace indicator=1 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat46_start & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52==.
replace indicator=0 if beginning==cat36_start & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49==.
replace indicator=0 if beginning==cat24_start & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat53_start & cat54==.
replace indicator=0 if beginning==cat34_start & cat35!=8 & cat36!=8 & cat37!=8 & cat38==.
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace indicator=0 if beginning==cat52_start & cat53!=8 & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58==.
replace indicator=1 if beginning==cat27_start & cat28==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=1 if beginning==cat20_start & cat21==8
replace indicator=1 if beginning==cat23_start & cat24==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29==.
replace indicator=1 if beginning==cat29_start & cat30==8
replace indicator=1 if beginning==cat22_start & cat23==8
replace indicator=1 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace indicator=1 if beginning==cat31_start & cat32==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat33_start & cat34==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
tab indicator,m
* Drop individuals that are not in the risk set
drop if indicator==0
drop indicator

* Construct the 'beginning' variable
gen beginning2 = .
replace beginning2 = cat3_start if beginning==cat2_start & cat3==8
order folio_n20 beginning beginning2
replace beginning2 = cat4_start if beginning==cat2_start & cat3!=8 & cat4==8
replace beginning2 = cat5_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat4_start if beginning==cat3_start & cat4==8
replace beginning2 = cat5_start if beginning==cat3_start & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat5_start if beginning==cat4_start & cat5==8
replace beginning2 = cat6_start if beginning==cat4_start & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat6_start if beginning==cat5_start & cat6==8
replace beginning2 = cat7_start if beginning==cat5_start & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat7_start if beginning==cat6_start & cat7==8
replace beginning2 = cat8_start if beginning==cat6_start & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat23_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat24_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat8_start if beginning==cat7_start & cat8==8
replace beginning2 = cat9_start if beginning==cat7_start & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat9_start if beginning==cat8_start & cat9==8
replace beginning2 = cat10_start if beginning==cat8_start & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat10_start if beginning==cat9_start & cat10==8
replace beginning2 = cat11_start if beginning==cat9_start & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat16_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat11_start if beginning==cat10_start & cat11==8
replace beginning2 = cat12_start if beginning==cat10_start & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat17_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat12_start if beginning==cat11_start & cat12==8
replace beginning2 = cat13_start if beginning==cat11_start & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat13_start if beginning==cat12_start & cat13==8
replace beginning2 = cat14_start if beginning==cat12_start & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat14_start if beginning==cat13_start & cat14==8
replace beginning2 = cat15_start if beginning==cat13_start & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat15_start if beginning==cat14_start & cat15==8
replace beginning2 = cat16_start if beginning==cat14_start & cat15!=8 & cat16==8
replace beginning2 = cat16_start if beginning==cat15_start & cat16==8
replace beginning2 = cat17_start if beginning==cat15_start & cat16!=8 & cat17==8
replace beginning2 = cat17_start if beginning==cat16_start & cat17==8
replace beginning2 = cat18_start if beginning==cat17_start & cat18==8
replace beginning2 = cat19_start if beginning==cat18_start & cat19==8
replace beginning2 = cat20_start if beginning==cat19_start & cat20==8
replace beginning2 = cat25_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23!=2 & cat24!=2 & cat25==2
replace beginning2 = cat35_start if beginning==cat32_start & cat33!=8 & cat34!=8 & cat35==8
replace beginning2 = cat17_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat16_start & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat24_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat19_start if beginning==cat17_start & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat18_start & cat19!=8 & cat20==8
replace beginning2 = cat21_start if beginning==cat19_start & cat20!=8 & cat21==8
replace beginning2 = cat22_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat22_start if beginning==cat21_start & cat22==8
replace beginning2 = cat18_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat14_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat15_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat14_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat25_start if beginning==cat24_start & cat25==8
replace beginning2 = cat16_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat24_start if beginning==cat23_start & cat24==8
replace beginning2 = cat20_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat23_start if beginning==cat21_start & cat22!=8 & cat23==8
replace beginning2 = cat19_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat17_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat21_start if beginning==cat20_start & cat21==8
replace beginning2 = cat30_start if beginning==cat29_start & cat30==8
replace beginning2 = cat23_start if beginning==cat22_start & cat23==8
replace beginning2 = cat17_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat24_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat26_start if beginning==cat25_start & cat26==8
replace beginning2 = cat20_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat32_start if beginning==cat31_start & cat32==8
replace beginning2 = cat20_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat18_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8

* Make sure that there are no missings
tab beginning2,m
drop beginning
rename beginning2 beginning

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat3_start & cat4==1
order event,after(folio_n20)
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=0 if beginning==cat29_start & cat30==.
replace event=3 if beginning==cat48_start & cat49==3
replace event=4 if beginning==cat26_start & cat27==4
replace event=6 if beginning==cat27_start & cat28==6
replace event=5 if beginning==cat35_start & cat36==5
replace event=9 if beginning==cat30_start & cat31==10
replace event=6 if beginning==cat26_start & cat27==6
replace event=2 if beginning==cat32_start & cat33==2

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat29_start - beginning if beginning==cat28_start & cat29!=8 & cat29!=.
replace duration = cat31_start - beginning if beginning==cat30_start & cat31!=8 & cat31!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat33_start - beginning if beginning==cat32_start & cat33!=8 & cat33!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat52_start - beginning if beginning==cat51_start & cat52!=8 & cat52!=.

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC7_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =7

* Define the education variable
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079)
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC7_informal", replace

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 8: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load the dataset for analysis
clear
use "$resultdir\sample_RC7_informal"

drop event
replace beginning=beginning+duration
drop duration

* Create risk set: individuals that are in RC informal of order 8 across multiple categories
gen indicator = .  // Initialize the variable
replace indicator=1 if beginning==cat2_start & cat3==8 | beginning==cat2_start & cat4==8 | beginning==cat2_start & cat5==8 | beginning==cat2_start & cat6==8 | beginning==cat2_start & cat7==8 | beginning==cat2_start & cat8==8 | beginning==cat2_start & cat9==8 | beginning==cat2_start & cat10==8 | beginning==cat2_start & cat11==8 | beginning==cat2_start & cat12==8 | beginning==cat2_start & cat13==8 | beginning==cat2_start & cat14==8 | beginning==cat2_start & cat15==8 | beginning==cat2_start & cat16==8 | beginning==cat2_start & cat17==8 | beginning==cat2_start & cat18==8 | beginning==cat2_start & cat19==8 | beginning==cat2_start & cat20==8 | beginning==cat2_start & cat21==8 | beginning==cat2_start & cat22==8 | beginning==cat2_start & cat23==8 | beginning==cat2_start & cat24==8 | beginning==cat2_start & cat25==8 | beginning==cat2_start & cat26==8 | beginning==cat2_start & cat27==8 | beginning==cat2_start & cat28==8 | beginning==cat2_start & cat29==8 | beginning==cat2_start & cat30==8 | beginning==cat2_start & cat31==8 | beginning==cat2_start & cat32==8 | beginning==cat2_start & cat33==8 | beginning==cat2_start & cat34==8 | beginning==cat2_start & cat35==8 | beginning==cat2_start & cat36==8 | beginning==cat2_start & cat37==8 | beginning==cat2_start & cat38==8 | beginning==cat2_start & cat39==8 | beginning==cat2_start & cat40==8 | beginning==cat2_start & cat41==8 | beginning==cat2_start & cat42==8 | beginning==cat2_start & cat43==8 | beginning==cat2_start & cat44==8 | beginning==cat2_start & cat45==8 | beginning==cat2_start & cat46==8 | beginning==cat2_start & cat47==8 | beginning==cat2_start & cat48==8 | beginning==cat2_start & cat49==8 | beginning==cat2_start & cat50==8 | beginning==cat2_start & cat51==8 | beginning==cat2_start & cat52==8 | beginning==cat2_start & cat53==8 | beginning==cat2_start & cat54==8 | beginning==cat2_start & cat55==8 | beginning==cat2_start & cat56==8 | beginning==cat2_start & cat57==8 | beginning==cat2_start & cat58==8 | beginning==cat2_start & cat59==8 | beginning==cat2_start & cat60==8 | beginning==cat2_start & cat61==8 | beginning==cat2_start & cat62==8 | beginning==cat2_start & cat63==8 | beginning==cat2_start & cat64==8 | beginning==cat2_start & cat65==8 | beginning==cat2_start & cat66==8 | beginning==cat2_start & cat67==8 | beginning==cat2_start & cat68==8 | beginning==cat2_start & cat69==8 | beginning==cat2_start & cat70==8 | beginning==cat2_start & cat71==8 | beginning==cat2_start & cat72==8 | beginning==cat2_start & cat73==8 | beginning==cat2_start & cat74==8 | beginning==cat2_start & cat75==8 | beginning==cat2_start & cat76==8 | beginning==cat2_start & cat77==8 | beginning==cat2_start & cat78==8 | beginning==cat2_start & cat79==8 | beginning==cat2_start & cat80==8 | beginning==cat2_start & cat81==8 | beginning==cat2_start & cat82==8 | beginning==cat2_start & cat83==8 | beginning==cat2_start & cat84==8 | beginning==cat2_start & cat85==8 | beginning==cat2_start & cat86==8 | beginning==cat2_start & cat87==8 | beginning==cat2_start & cat88==8
replace indicator=0 if beginning==cat2_start & indicator==.
replace indicator=1 if beginning==cat3_start & cat4==8 | beginning==cat3_start & cat5==8 | beginning==cat3_start & cat6==8 | beginning==cat3_start & cat7==8 | beginning==cat3_start & cat8==8 | beginning==cat3_start & cat9==8 | beginning==cat3_start & cat10==8 | beginning==cat3_start & cat11==8 | beginning==cat3_start & cat12==8 | beginning==cat3_start & cat13==8 | beginning==cat3_start & cat14==8 | beginning==cat3_start & cat15==8 | beginning==cat3_start & cat16==8 | beginning==cat3_start & cat17==8 | beginning==cat3_start & cat18==8 | beginning==cat3_start & cat19==8 | beginning==cat3_start & cat20==8 | beginning==cat3_start & cat21==8 | beginning==cat3_start & cat22==8 | beginning==cat3_start & cat23==8 | beginning==cat3_start & cat24==8 | beginning==cat3_start & cat25==8 | beginning==cat3_start & cat26==8 | beginning==cat3_start & cat27==8 | beginning==cat3_start & cat28==8 | beginning==cat3_start & cat29==8 | beginning==cat3_start & cat30==8 | beginning==cat3_start & cat31==8 | beginning==cat3_start & cat32==8 | beginning==cat3_start & cat33==8 | beginning==cat3_start & cat34==8 | beginning==cat3_start & cat35==8 | beginning==cat3_start & cat36==8 | beginning==cat3_start & cat37==8 | beginning==cat3_start & cat38==8 | beginning==cat3_start & cat39==8 | beginning==cat3_start & cat40==8 | beginning==cat3_start & cat41==8 | beginning==cat3_start & cat42==8 | beginning==cat3_start & cat43==8 | beginning==cat3_start & cat44==8 | beginning==cat3_start & cat45==8 | beginning==cat3_start & cat46==8 | beginning==cat3_start & cat47==8 | beginning==cat3_start & cat48==8 | beginning==cat3_start & cat49==8 | beginning==cat3_start & cat50==8 | beginning==cat3_start & cat51==8 | beginning==cat3_start & cat52==8 | beginning==cat3_start & cat53==8 | beginning==cat3_start & cat54==8 | beginning==cat3_start & cat55==8 | beginning==cat3_start & cat56==8 | beginning==cat3_start & cat57==8 | beginning==cat3_start & cat58==8 | beginning==cat3_start & cat59==8 | beginning==cat3_start & cat60==8 | beginning==cat3_start & cat61==8 | beginning==cat3_start & cat62==8 | beginning==cat3_start & cat63==8 | beginning==cat3_start & cat64==8 | beginning==cat3_start & cat65==8 | beginning==cat3_start & cat66==8 | beginning==cat3_start & cat67==8 | beginning==cat3_start & cat68==8 | beginning==cat3_start & cat69==8 | beginning==cat3_start & cat70==8 | beginning==cat3_start & cat71==8 | beginning==cat3_start & cat72==8 | beginning==cat3_start & cat73==8 | beginning==cat3_start & cat74==8 | beginning==cat3_start & cat75==8 | beginning==cat3_start & cat76==8 | beginning==cat3_start & cat77==8 | beginning==cat3_start & cat78==8 | beginning==cat3_start & cat79==8 | beginning==cat3_start & cat80==8 | beginning==cat3_start & cat81==8 | beginning==cat3_start & cat82==8 | beginning==cat3_start & cat83==8 | beginning==cat3_start & cat84==8 | beginning==cat3_start & cat85==8 | beginning==cat3_start & cat86==8 | beginning==cat3_start & cat87==8 | beginning==cat3_start & cat88==8
replace indicator=0 if beginning==cat3_start & indicator==.
replace indicator=1 if beginning==cat4_start & cat5==8 | beginning==cat4_start & cat6==8 | beginning==cat4_start & cat7==8 | beginning==cat4_start & cat8==8 | beginning==cat4_start & cat9==8 | beginning==cat4_start & cat10==8 | beginning==cat4_start & cat11==8 | beginning==cat4_start & cat12==8 | beginning==cat4_start & cat13==8 | beginning==cat4_start & cat14==8 | beginning==cat4_start & cat15==8 | beginning==cat4_start & cat16==8 | beginning==cat4_start & cat17==8 | beginning==cat4_start & cat18==8 | beginning==cat4_start & cat19==8 | beginning==cat4_start & cat20==8 | beginning==cat4_start & cat21==8 | beginning==cat4_start & cat22==8 | beginning==cat4_start & cat23==8 | beginning==cat4_start & cat24==8 | beginning==cat4_start & cat25==8 | beginning==cat4_start & cat26==8 | beginning==cat4_start & cat27==8 | beginning==cat4_start & cat28==8 | beginning==cat4_start & cat29==8 | beginning==cat4_start & cat30==8 | beginning==cat4_start & cat31==8 | beginning==cat4_start & cat32==8 | beginning==cat4_start & cat33==8 | beginning==cat4_start & cat34==8 | beginning==cat4_start & cat35==8 | beginning==cat4_start & cat36==8 | beginning==cat4_start & cat37==8 | beginning==cat4_start & cat38==8 | beginning==cat4_start & cat39==8 | beginning==cat4_start & cat40==8 | beginning==cat4_start & cat41==8 | beginning==cat4_start & cat42==8 | beginning==cat4_start & cat43==8 | beginning==cat4_start & cat44==8 | beginning==cat4_start & cat45==8 | beginning==cat4_start & cat46==8 | beginning==cat4_start & cat47==8 | beginning==cat4_start & cat48==8 | beginning==cat4_start & cat49==8 | beginning==cat4_start & cat50==8 | beginning==cat4_start & cat51==8 | beginning==cat4_start & cat52==8 | beginning==cat4_start & cat53==8 | beginning==cat4_start & cat54==8 | beginning==cat4_start & cat55==8 | beginning==cat4_start & cat56==8 | beginning==cat4_start & cat57==8 | beginning==cat4_start & cat58==8 | beginning==cat4_start & cat59==8 | beginning==cat4_start & cat60==8 | beginning==cat4_start & cat61==8 | beginning==cat4_start & cat62==8 | beginning==cat4_start & cat63==8 | beginning==cat4_start & cat64==8 | beginning==cat4_start & cat65==8 | beginning==cat4_start & cat66==8 | beginning==cat4_start & cat67==8 | beginning==cat4_start & cat68==8 | beginning==cat4_start & cat69==8 | beginning==cat4_start & cat70==8 | beginning==cat4_start & cat71==8 | beginning==cat4_start & cat72==8 | beginning==cat4_start & cat73==8 | beginning==cat4_start & cat74==8 | beginning==cat4_start & cat75==8 | beginning==cat4_start & cat76==8 | beginning==cat4_start & cat77==8 | beginning==cat4_start & cat78==8 | beginning==cat4_start & cat79==8 | beginning==cat4_start & cat80==8 | beginning==cat4_start & cat81==8 | beginning==cat4_start & cat82==8 | beginning==cat4_start & cat83==8 | beginning==cat4_start & cat84==8 | beginning==cat4_start & cat85==8 | beginning==cat4_start & cat86==8 | beginning==cat4_start & cat87==8 | beginning==cat4_start & cat88==8
replace indicator=0 if beginning==cat4_start & indicator==.
replace indicator=1 if beginning==cat5_start & cat6==8 | beginning==cat5_start & cat7==8 | beginning==cat5_start & cat8==8 | beginning==cat5_start & cat9==8 | beginning==cat5_start & cat10==8 | beginning==cat5_start & cat11==8 | beginning==cat5_start & cat12==8 | beginning==cat5_start & cat13==8 | beginning==cat5_start & cat14==8 | beginning==cat5_start & cat15==8 | beginning==cat5_start & cat16==8 | beginning==cat5_start & cat17==8 | beginning==cat5_start & cat18==8 | beginning==cat5_start & cat19==8 | beginning==cat5_start & cat20==8 | beginning==cat5_start & cat21==8 | beginning==cat5_start & cat22==8 | beginning==cat5_start & cat23==8 | beginning==cat5_start & cat24==8 | beginning==cat5_start & cat25==8 | beginning==cat5_start & cat26==8 | beginning==cat5_start & cat27==8 | beginning==cat5_start & cat28==8 | beginning==cat5_start & cat29==8 | beginning==cat5_start & cat30==8 | beginning==cat5_start & cat31==8 | beginning==cat5_start & cat32==8 | beginning==cat5_start & cat33==8 | beginning==cat5_start & cat34==8 | beginning==cat5_start & cat35==8 | beginning==cat5_start & cat36==8 | beginning==cat5_start & cat37==8 | beginning==cat5_start & cat38==8 | beginning==cat5_start & cat39==8 | beginning==cat5_start & cat40==8 | beginning==cat5_start & cat41==8 | beginning==cat5_start & cat42==8 | beginning==cat5_start & cat43==8 | beginning==cat5_start & cat44==8 | beginning==cat5_start & cat45==8 | beginning==cat5_start & cat46==8 | beginning==cat5_start & cat47==8 | beginning==cat5_start & cat48==8 | beginning==cat5_start & cat49==8 | beginning==cat5_start & cat50==8 | beginning==cat5_start & cat51==8 | beginning==cat5_start & cat52==8 | beginning==cat5_start & cat53==8 | beginning==cat5_start & cat54==8 | beginning==cat5_start & cat55==8 | beginning==cat5_start & cat56==8 | beginning==cat5_start & cat57==8 | beginning==cat5_start & cat58==8 | beginning==cat5_start & cat59==8 | beginning==cat5_start & cat60==8 | beginning==cat5_start & cat61==8 | beginning==cat5_start & cat62==8 | beginning==cat5_start & cat63==8 | beginning==cat5_start & cat64==8 | beginning==cat5_start & cat65==8 | beginning==cat5_start & cat66==8 | beginning==cat5_start & cat67==8 | beginning==cat5_start & cat68==8 | beginning==cat5_start & cat69==8 | beginning==cat5_start & cat70==8 | beginning==cat5_start & cat71==8 | beginning==cat5_start & cat72==8 | beginning==cat5_start & cat73==8 | beginning==cat5_start & cat74==8 | beginning==cat5_start & cat75==8 | beginning==cat5_start & cat76==8 | beginning==cat5_start & cat77==8 | beginning==cat5_start & cat78==8 | beginning==cat5_start & cat79==8 | beginning==cat5_start & cat80==8 | beginning==cat5_start & cat81==8 | beginning==cat5_start & cat82==8 | beginning==cat5_start & cat83==8 | beginning==cat5_start & cat84==8 | beginning==cat5_start & cat85==8 | beginning==cat5_start & cat86==8 | beginning==cat5_start & cat87==8 | beginning==cat5_start & cat88==8
replace indicator=0 if beginning==cat5_start & indicator==.
replace indicator=1 if beginning==cat6_start & cat7==8 | beginning==cat6_start & cat8==8 | beginning==cat6_start & cat9==8 | beginning==cat6_start & cat10==8 | beginning==cat6_start & cat11==8 | beginning==cat6_start & cat12==8 | beginning==cat6_start & cat13==8 | beginning==cat6_start & cat14==8 | beginning==cat6_start & cat15==8 | beginning==cat6_start & cat16==8 | beginning==cat6_start & cat17==8 | beginning==cat6_start & cat18==8 | beginning==cat6_start & cat19==8 | beginning==cat6_start & cat20==8 | beginning==cat6_start & cat21==8 | beginning==cat6_start & cat22==8 | beginning==cat6_start & cat23==8 | beginning==cat6_start & cat24==8 | beginning==cat6_start & cat25==8 | beginning==cat6_start & cat26==8 | beginning==cat6_start & cat27==8 | beginning==cat6_start & cat28==8 | beginning==cat6_start & cat29==8 | beginning==cat6_start & cat30==8 | beginning==cat6_start & cat31==8 | beginning==cat6_start & cat32==8 | beginning==cat6_start & cat33==8 | beginning==cat6_start & cat34==8 | beginning==cat6_start & cat35==8 | beginning==cat6_start & cat36==8 | beginning==cat6_start & cat37==8 | beginning==cat6_start & cat38==8 | beginning==cat6_start & cat39==8 | beginning==cat6_start & cat40==8 | beginning==cat6_start & cat41==8 | beginning==cat6_start & cat42==8 | beginning==cat6_start & cat43==8 | beginning==cat6_start & cat44==8 | beginning==cat6_start & cat45==8 | beginning==cat6_start & cat46==8 | beginning==cat6_start & cat47==8 | beginning==cat6_start & cat48==8 | beginning==cat6_start & cat49==8 | beginning==cat6_start & cat50==8 | beginning==cat6_start & cat51==8 | beginning==cat6_start & cat52==8 | beginning==cat6_start & cat53==8 | beginning==cat6_start & cat54==8 | beginning==cat6_start & cat55==8 | beginning==cat6_start & cat56==8 | beginning==cat6_start & cat57==8 | beginning==cat6_start & cat58==8 | beginning==cat6_start & cat59==8 | beginning==cat6_start & cat60==8 | beginning==cat6_start & cat61==8 | beginning==cat6_start & cat62==8 | beginning==cat6_start & cat63==8 | beginning==cat6_start & cat64==8 | beginning==cat6_start & cat65==8 | beginning==cat6_start & cat66==8 | beginning==cat6_start & cat67==8 | beginning==cat6_start & cat68==8 | beginning==cat6_start & cat69==8 | beginning==cat6_start & cat70==8 | beginning==cat6_start & cat71==8 | beginning==cat6_start & cat72==8 | beginning==cat6_start & cat73==8 | beginning==cat6_start & cat74==8 | beginning==cat6_start & cat75==8 | beginning==cat6_start & cat76==8 | beginning==cat6_start & cat77==8 | beginning==cat6_start & cat78==8 | beginning==cat6_start & cat79==8 | beginning==cat6_start & cat80==8 | beginning==cat6_start & cat81==8 | beginning==cat6_start & cat82==8 | beginning==cat6_start & cat83==8 | beginning==cat6_start & cat84==8 | beginning==cat6_start & cat85==8 | beginning==cat6_start & cat86==8 | beginning==cat6_start & cat87==8 | beginning==cat6_start & cat88==8
replace indicator=0 if beginning==cat6_start & indicator==.
replace indicator=1 if beginning==cat7_start & cat8==8 | beginning==cat7_start & cat9==8 | beginning==cat7_start & cat10==8 | beginning==cat7_start & cat11==8 | beginning==cat7_start & cat12==8 | beginning==cat7_start & cat13==8 | beginning==cat7_start & cat14==8 | beginning==cat7_start & cat15==8 | beginning==cat7_start & cat16==8 | beginning==cat7_start & cat17==8 | beginning==cat7_start & cat18==8 | beginning==cat7_start & cat19==8 | beginning==cat7_start & cat20==8 | beginning==cat7_start & cat21==8 | beginning==cat7_start & cat22==8 | beginning==cat7_start & cat23==8 | beginning==cat7_start & cat24==8 | beginning==cat7_start & cat25==8 | beginning==cat7_start & cat26==8 | beginning==cat7_start & cat27==8 | beginning==cat7_start & cat28==8 | beginning==cat7_start & cat29==8 | beginning==cat7_start & cat30==8 | beginning==cat7_start & cat31==8 | beginning==cat7_start & cat32==8 | beginning==cat7_start & cat33==8 | beginning==cat7_start & cat34==8 | beginning==cat7_start & cat35==8 | beginning==cat7_start & cat36==8 | beginning==cat7_start & cat37==8 | beginning==cat7_start & cat38==8 | beginning==cat7_start & cat39==8 | beginning==cat7_start & cat40==8 | beginning==cat7_start & cat41==8 | beginning==cat7_start & cat42==8 | beginning==cat7_start & cat43==8 | beginning==cat7_start & cat44==8 | beginning==cat7_start & cat45==8 | beginning==cat7_start & cat46==8 | beginning==cat7_start & cat47==8 | beginning==cat7_start & cat48==8 | beginning==cat7_start & cat49==8 | beginning==cat7_start & cat50==8 | beginning==cat7_start & cat51==8 | beginning==cat7_start & cat52==8 | beginning==cat7_start & cat53==8 | beginning==cat7_start & cat54==8 | beginning==cat7_start & cat55==8 | beginning==cat7_start & cat56==8 | beginning==cat7_start & cat57==8 | beginning==cat7_start & cat58==8 | beginning==cat7_start & cat59==8 | beginning==cat7_start & cat60==8 | beginning==cat7_start & cat61==8 | beginning==cat7_start & cat62==8 | beginning==cat7_start & cat63==8 | beginning==cat7_start & cat64==8 | beginning==cat7_start & cat65==8 | beginning==cat7_start & cat66==8 | beginning==cat7_start & cat67==8 | beginning==cat7_start & cat68==8 | beginning==cat7_start & cat69==8 | beginning==cat7_start & cat70==8 | beginning==cat7_start & cat71==8 | beginning==cat7_start & cat72==8 | beginning==cat7_start & cat73==8 | beginning==cat7_start & cat74==8 | beginning==cat7_start & cat75==8 | beginning==cat7_start & cat76==8 | beginning==cat7_start & cat77==8 | beginning==cat7_start & cat78==8 | beginning==cat7_start & cat79==8 | beginning==cat7_start & cat80==8 | beginning==cat7_start & cat81==8 | beginning==cat7_start & cat82==8 | beginning==cat7_start & cat83==8 | beginning==cat7_start & cat84==8 | beginning==cat7_start & cat85==8 | beginning==cat7_start & cat86==8 | beginning==cat7_start & cat87==8 | beginning==cat7_start & cat88==8
replace indicator=0 if beginning==cat7_start & indicator==.
replace indicator=1 if beginning==cat8_start & cat9==8 | beginning==cat8_start & cat10==8 | beginning==cat8_start & cat11==8 | beginning==cat8_start & cat12==8 | beginning==cat8_start & cat13==8 | beginning==cat8_start & cat14==8 | beginning==cat8_start & cat15==8 | beginning==cat8_start & cat16==8 | beginning==cat8_start & cat17==8 | beginning==cat8_start & cat18==8 | beginning==cat8_start & cat19==8 | beginning==cat8_start & cat20==8 | beginning==cat8_start & cat21==8 | beginning==cat8_start & cat22==8 | beginning==cat8_start & cat23==8 | beginning==cat8_start & cat24==8 | beginning==cat8_start & cat25==8 | beginning==cat8_start & cat26==8 | beginning==cat8_start & cat27==8 | beginning==cat8_start & cat28==8 | beginning==cat8_start & cat29==8 | beginning==cat8_start & cat30==8 | beginning==cat8_start & cat31==8 | beginning==cat8_start & cat32==8 | beginning==cat8_start & cat33==8 | beginning==cat8_start & cat34==8 | beginning==cat8_start & cat35==8 | beginning==cat8_start & cat36==8 | beginning==cat8_start & cat37==8 | beginning==cat8_start & cat38==8 | beginning==cat8_start & cat39==8 | beginning==cat8_start & cat40==8 | beginning==cat8_start & cat41==8 | beginning==cat8_start & cat42==8 | beginning==cat8_start & cat43==8 | beginning==cat8_start & cat44==8 | beginning==cat8_start & cat45==8 | beginning==cat8_start & cat46==8 | beginning==cat8_start & cat47==8 | beginning==cat8_start & cat48==8 | beginning==cat8_start & cat49==8 | beginning==cat8_start & cat50==8 | beginning==cat8_start & cat51==8 | beginning==cat8_start & cat52==8 | beginning==cat8_start & cat53==8 | beginning==cat8_start & cat54==8 | beginning==cat8_start & cat55==8 | beginning==cat8_start & cat56==8 | beginning==cat8_start & cat57==8 | beginning==cat8_start & cat58==8 | beginning==cat8_start & cat59==8 | beginning==cat8_start & cat60==8 | beginning==cat8_start & cat61==8 | beginning==cat8_start & cat62==8 | beginning==cat8_start & cat63==8 | beginning==cat8_start & cat64==8 | beginning==cat8_start & cat65==8 | beginning==cat8_start & cat66==8 | beginning==cat8_start & cat67==8 | beginning==cat8_start & cat68==8 | beginning==cat8_start & cat69==8 | beginning==cat8_start & cat70==8 | beginning==cat8_start & cat71==8 | beginning==cat8_start & cat72==8 | beginning==cat8_start & cat73==8 | beginning==cat8_start & cat74==8 | beginning==cat8_start & cat75==8 | beginning==cat8_start & cat76==8 | beginning==cat8_start & cat77==8 | beginning==cat8_start & cat78==8 | beginning==cat8_start & cat79==8 | beginning==cat8_start & cat80==8 | beginning==cat8_start & cat81==8 | beginning==cat8_start & cat82==8 | beginning==cat8_start & cat83==8 | beginning==cat8_start & cat84==8 | beginning==cat8_start & cat85==8 | beginning==cat8_start & cat86==8 | beginning==cat8_start & cat87==8 | beginning==cat8_start & cat88==8
replace indicator=0 if beginning==cat8_start & indicator==.
replace indicator=0 if beginning==end
replace indicator=1 if beginning==cat9_start & cat10==8 | beginning==cat9_start & cat11==8 | beginning==cat9_start & cat12==8 | beginning==cat9_start & cat13==8 | beginning==cat9_start & cat14==8 | beginning==cat9_start & cat15==8 | beginning==cat9_start & cat16==8 | beginning==cat9_start & cat17==8 | beginning==cat9_start & cat18==8 | beginning==cat9_start & cat19==8 | beginning==cat9_start & cat20==8 | beginning==cat9_start & cat21==8 | beginning==cat9_start & cat22==8 | beginning==cat9_start & cat23==8 | beginning==cat9_start & cat24==8 | beginning==cat9_start & cat25==8 | beginning==cat9_start & cat26==8 | beginning==cat9_start & cat27==8 | beginning==cat9_start & cat28==8 | beginning==cat9_start & cat29==8 | beginning==cat9_start & cat30==8 | beginning==cat9_start & cat31==8 | beginning==cat9_start & cat32==8 | beginning==cat9_start & cat33==8 | beginning==cat9_start & cat34==8 | beginning==cat9_start & cat35==8 | beginning==cat9_start & cat36==8 | beginning==cat9_start & cat37==8 | beginning==cat9_start & cat38==8 | beginning==cat9_start & cat39==8 | beginning==cat9_start & cat40==8 | beginning==cat9_start & cat41==8 | beginning==cat9_start & cat42==8 | beginning==cat9_start & cat43==8 | beginning==cat9_start & cat44==8 | beginning==cat9_start & cat45==8 | beginning==cat9_start & cat46==8 | beginning==cat9_start & cat47==8 | beginning==cat9_start & cat48==8 | beginning==cat9_start & cat49==8 | beginning==cat9_start & cat50==8 | beginning==cat9_start & cat51==8 | beginning==cat9_start & cat52==8 | beginning==cat9_start & cat53==8 | beginning==cat9_start & cat54==8 | beginning==cat9_start & cat55==8 | beginning==cat9_start & cat56==8 | beginning==cat9_start & cat57==8 | beginning==cat9_start & cat58==8 | beginning==cat9_start & cat59==8 | beginning==cat9_start & cat60==8 | beginning==cat9_start & cat61==8 | beginning==cat9_start & cat62==8 | beginning==cat9_start & cat63==8 | beginning==cat9_start & cat64==8 | beginning==cat9_start & cat65==8 | beginning==cat9_start & cat66==8 | beginning==cat9_start & cat67==8 | beginning==cat9_start & cat68==8 | beginning==cat9_start & cat69==8 | beginning==cat9_start & cat70==8 | beginning==cat9_start & cat71==8 | beginning==cat9_start & cat72==8 | beginning==cat9_start & cat73==8 | beginning==cat9_start & cat74==8 | beginning==cat9_start & cat75==8 | beginning==cat9_start & cat76==8 | beginning==cat9_start & cat77==8 | beginning==cat9_start & cat78==8 | beginning==cat9_start & cat79==8 | beginning==cat9_start & cat80==8 | beginning==cat9_start & cat81==8 | beginning==cat9_start & cat82==8 | beginning==cat9_start & cat83==8 | beginning==cat9_start & cat84==8 | beginning==cat9_start & cat85==8 | beginning==cat9_start & cat86==8 | beginning==cat9_start & cat87==8 | beginning==cat9_start & cat88==8
replace indicator=0 if beginning==cat9_start & indicator==.
replace indicator=1 if beginning==cat10_start & cat11==8 | beginning==cat10_start & cat12==8 | beginning==cat10_start & cat13==8 | beginning==cat10_start & cat14==8 | beginning==cat10_start & cat15==8 | beginning==cat10_start & cat16==8 | beginning==cat10_start & cat17==8 | beginning==cat10_start & cat18==8 | beginning==cat10_start & cat19==8 | beginning==cat10_start & cat20==8 | beginning==cat10_start & cat21==8 | beginning==cat10_start & cat22==8 | beginning==cat10_start & cat23==8 | beginning==cat10_start & cat24==8 | beginning==cat10_start & cat25==8 | beginning==cat10_start & cat26==8 | beginning==cat10_start & cat27==8 | beginning==cat10_start & cat28==8 | beginning==cat10_start & cat29==8 | beginning==cat10_start & cat30==8 | beginning==cat10_start & cat31==8 | beginning==cat10_start & cat32==8 | beginning==cat10_start & cat33==8 | beginning==cat10_start & cat34==8 | beginning==cat10_start & cat35==8 | beginning==cat10_start & cat36==8 | beginning==cat10_start & cat37==8 | beginning==cat10_start & cat38==8 | beginning==cat10_start & cat39==8 | beginning==cat10_start & cat40==8 | beginning==cat10_start & cat41==8 | beginning==cat10_start & cat42==8 | beginning==cat10_start & cat43==8 | beginning==cat10_start & cat44==8 | beginning==cat10_start & cat45==8 | beginning==cat10_start & cat46==8 | beginning==cat10_start & cat47==8 | beginning==cat10_start & cat48==8 | beginning==cat10_start & cat49==8 | beginning==cat10_start & cat50==8 | beginning==cat10_start & cat51==8 | beginning==cat10_start & cat52==8 | beginning==cat10_start & cat53==8 | beginning==cat10_start & cat54==8 | beginning==cat10_start & cat55==8 | beginning==cat10_start & cat56==8 | beginning==cat10_start & cat57==8 | beginning==cat10_start & cat58==8 | beginning==cat10_start & cat59==8 | beginning==cat10_start & cat60==8 | beginning==cat10_start & cat61==8 | beginning==cat10_start & cat62==8 | beginning==cat10_start & cat63==8 | beginning==cat10_start & cat64==8 | beginning==cat10_start & cat65==8 | beginning==cat10_start & cat66==8 | beginning==cat10_start & cat67==8 | beginning==cat10_start & cat68==8 | beginning==cat10_start & cat69==8 | beginning==cat10_start & cat70==8 | beginning==cat10_start & cat71==8 | beginning==cat10_start & cat72==8 | beginning==cat10_start & cat73==8 | beginning==cat10_start & cat74==8 | beginning==cat10_start & cat75==8 | beginning==cat10_start & cat76==8 | beginning==cat10_start & cat77==8 | beginning==cat10_start & cat78==8 | beginning==cat10_start & cat79==8 | beginning==cat10_start & cat80==8 | beginning==cat10_start & cat81==8 | beginning==cat10_start & cat82==8 | beginning==cat10_start & cat83==8 | beginning==cat10_start & cat84==8 | beginning==cat10_start & cat85==8 | beginning==cat10_start & cat86==8 | beginning==cat10_start & cat87==8 | beginning==cat10_start & cat88==8
replace indicator=0 if beginning==cat10_start & indicator==.
replace indicator=1 if beginning==cat11_start & cat12==8 | beginning==cat11_start & cat13==8 | beginning==cat11_start & cat14==8 | beginning==cat11_start & cat15==8 | beginning==cat11_start & cat16==8 | beginning==cat11_start & cat17==8 | beginning==cat11_start & cat18==8 | beginning==cat11_start & cat19==8 | beginning==cat11_start & cat20==8 | beginning==cat11_start & cat21==8 | beginning==cat11_start & cat22==8 | beginning==cat11_start & cat23==8 | beginning==cat11_start & cat24==8 | beginning==cat11_start & cat25==8 | beginning==cat11_start & cat26==8 | beginning==cat11_start & cat27==8 | beginning==cat11_start & cat28==8 | beginning==cat11_start & cat29==8 | beginning==cat11_start & cat30==8 | beginning==cat11_start & cat31==8 | beginning==cat11_start & cat32==8 | beginning==cat11_start & cat33==8 | beginning==cat11_start & cat34==8 | beginning==cat11_start & cat35==8 | beginning==cat11_start & cat36==8 | beginning==cat11_start & cat37==8 | beginning==cat11_start & cat38==8 | beginning==cat11_start & cat39==8 | beginning==cat11_start & cat40==8 | beginning==cat11_start & cat41==8 | beginning==cat11_start & cat42==8 | beginning==cat11_start & cat43==8 | beginning==cat11_start & cat44==8 | beginning==cat11_start & cat45==8 | beginning==cat11_start & cat46==8 | beginning==cat11_start & cat47==8 | beginning==cat11_start & cat48==8 | beginning==cat11_start & cat49==8 | beginning==cat11_start & cat50==8 | beginning==cat11_start & cat51==8 | beginning==cat11_start & cat52==8 | beginning==cat11_start & cat53==8 | beginning==cat11_start & cat54==8 | beginning==cat11_start & cat55==8 | beginning==cat11_start & cat56==8 | beginning==cat11_start & cat57==8 | beginning==cat11_start & cat58==8 | beginning==cat11_start & cat59==8 | beginning==cat11_start & cat60==8 | beginning==cat11_start & cat61==8 | beginning==cat11_start & cat62==8 | beginning==cat11_start & cat63==8 | beginning==cat11_start & cat64==8 | beginning==cat11_start & cat65==8 | beginning==cat11_start & cat66==8 | beginning==cat11_start & cat67==8 | beginning==cat11_start & cat68==8 | beginning==cat11_start & cat69==8 | beginning==cat11_start & cat70==8 | beginning==cat11_start & cat71==8 | beginning==cat11_start & cat72==8 | beginning==cat11_start & cat73==8 | beginning==cat11_start & cat74==8 | beginning==cat11_start & cat75==8 | beginning==cat11_start & cat76==8 | beginning==cat11_start & cat77==8 | beginning==cat11_start & cat78==8 | beginning==cat11_start & cat79==8 | beginning==cat11_start & cat80==8 | beginning==cat11_start & cat81==8 | beginning==cat11_start & cat82==8 | beginning==cat11_start & cat83==8 | beginning==cat11_start & cat84==8 | beginning==cat11_start & cat85==8 | beginning==cat11_start & cat86==8 | beginning==cat11_start & cat87==8 | beginning==cat11_start & cat88==8
replace indicator=0 if beginning==cat11_start & indicator==.
replace indicator=1 if beginning==cat12_start & cat13==8 | beginning==cat12_start & cat14==8 | beginning==cat12_start & cat15==8 | beginning==cat12_start & cat16==8 | beginning==cat12_start & cat17==8 | beginning==cat12_start & cat18==8 | beginning==cat12_start & cat19==8 | beginning==cat12_start & cat20==8 | beginning==cat12_start & cat21==8 | beginning==cat12_start & cat22==8 | beginning==cat12_start & cat23==8 | beginning==cat12_start & cat24==8 | beginning==cat12_start & cat25==8 | beginning==cat12_start & cat26==8 | beginning==cat12_start & cat27==8 | beginning==cat12_start & cat28==8 | beginning==cat12_start & cat29==8 | beginning==cat12_start & cat30==8 | beginning==cat12_start & cat31==8 | beginning==cat12_start & cat32==8 | beginning==cat12_start & cat33==8 | beginning==cat12_start & cat34==8 | beginning==cat12_start & cat35==8 | beginning==cat12_start & cat36==8 | beginning==cat12_start & cat37==8 | beginning==cat12_start & cat38==8 | beginning==cat12_start & cat39==8 | beginning==cat12_start & cat40==8 | beginning==cat12_start & cat41==8 | beginning==cat12_start & cat42==8 | beginning==cat12_start & cat43==8 | beginning==cat12_start & cat44==8 | beginning==cat12_start & cat45==8 | beginning==cat12_start & cat46==8 | beginning==cat12_start & cat47==8 | beginning==cat12_start & cat48==8 | beginning==cat12_start & cat49==8 | beginning==cat12_start & cat50==8 | beginning==cat12_start & cat51==8 | beginning==cat12_start & cat52==8 | beginning==cat12_start & cat53==8 | beginning==cat12_start & cat54==8 | beginning==cat12_start & cat55==8 | beginning==cat12_start & cat56==8 | beginning==cat12_start & cat57==8 | beginning==cat12_start & cat58==8 | beginning==cat12_start & cat59==8 | beginning==cat12_start & cat60==8 | beginning==cat12_start & cat61==8 | beginning==cat12_start & cat62==8 | beginning==cat12_start & cat63==8 | beginning==cat12_start & cat64==8 | beginning==cat12_start & cat65==8 | beginning==cat12_start & cat66==8 | beginning==cat12_start & cat67==8 | beginning==cat12_start & cat68==8 | beginning==cat12_start & cat69==8 | beginning==cat12_start & cat70==8 | beginning==cat12_start & cat71==8 | beginning==cat12_start & cat72==8 | beginning==cat12_start & cat73==8 | beginning==cat12_start & cat74==8 | beginning==cat12_start & cat75==8 | beginning==cat12_start & cat76==8 | beginning==cat12_start & cat77==8 | beginning==cat12_start & cat78==8 | beginning==cat12_start & cat79==8 | beginning==cat12_start & cat80==8 | beginning==cat12_start & cat81==8 | beginning==cat12_start & cat82==8 | beginning==cat12_start & cat83==8 | beginning==cat12_start & cat84==8 | beginning==cat12_start & cat85==8 | beginning==cat12_start & cat86==8 | beginning==cat12_start & cat87==8 | beginning==cat12_start & cat88==8
replace indicator=0 if beginning==cat12_start & indicator==.
replace indicator=1 if beginning==cat13_start & cat14==8 | beginning==cat13_start & cat15==8 | beginning==cat13_start & cat16==8 | beginning==cat13_start & cat17==8 | beginning==cat13_start & cat18==8 | beginning==cat13_start & cat19==8 | beginning==cat13_start & cat20==8 | beginning==cat13_start & cat21==8 | beginning==cat13_start & cat22==8 | beginning==cat13_start & cat23==8 | beginning==cat13_start & cat24==8 | beginning==cat13_start & cat25==8 | beginning==cat13_start & cat26==8 | beginning==cat13_start & cat27==8 | beginning==cat13_start & cat28==8 | beginning==cat13_start & cat29==8 | beginning==cat13_start & cat30==8 | beginning==cat13_start & cat31==8 | beginning==cat13_start & cat32==8 | beginning==cat13_start & cat33==8 | beginning==cat13_start & cat34==8 | beginning==cat13_start & cat35==8 | beginning==cat13_start & cat36==8 | beginning==cat13_start & cat37==8 | beginning==cat13_start & cat38==8 | beginning==cat13_start & cat39==8 | beginning==cat13_start & cat40==8 | beginning==cat13_start & cat41==8 | beginning==cat13_start & cat42==8 | beginning==cat13_start & cat43==8 | beginning==cat13_start & cat44==8 | beginning==cat13_start & cat45==8 | beginning==cat13_start & cat46==8 | beginning==cat13_start & cat47==8 | beginning==cat13_start & cat48==8 | beginning==cat13_start & cat49==8 | beginning==cat13_start & cat50==8 | beginning==cat13_start & cat51==8 | beginning==cat13_start & cat52==8 | beginning==cat13_start & cat53==8 | beginning==cat13_start & cat54==8 | beginning==cat13_start & cat55==8 | beginning==cat13_start & cat56==8 | beginning==cat13_start & cat57==8 | beginning==cat13_start & cat58==8 | beginning==cat13_start & cat59==8 | beginning==cat13_start & cat60==8 | beginning==cat13_start & cat61==8 | beginning==cat13_start & cat62==8 | beginning==cat13_start & cat63==8 | beginning==cat13_start & cat64==8 | beginning==cat13_start & cat65==8 | beginning==cat13_start & cat66==8 | beginning==cat13_start & cat67==8 | beginning==cat13_start & cat68==8 | beginning==cat13_start & cat69==8 | beginning==cat13_start & cat70==8 | beginning==cat13_start & cat71==8 | beginning==cat13_start & cat72==8 | beginning==cat13_start & cat73==8 | beginning==cat13_start & cat74==8 | beginning==cat13_start & cat75==8 | beginning==cat13_start & cat76==8 | beginning==cat13_start & cat77==8 | beginning==cat13_start & cat78==8 | beginning==cat13_start & cat79==8 | beginning==cat13_start & cat80==8 | beginning==cat13_start & cat81==8 | beginning==cat13_start & cat82==8 | beginning==cat13_start & cat83==8 | beginning==cat13_start & cat84==8 | beginning==cat13_start & cat85==8 | beginning==cat13_start & cat86==8 | beginning==cat13_start & cat87==8 | beginning==cat13_start & cat88==8
replace indicator=0 if beginning==cat13_start & indicator==.
replace indicator=1 if beginning==cat14_start & cat15==8 | beginning==cat14_start & cat16==8 | beginning==cat14_start & cat17==8 | beginning==cat14_start & cat18==8 | beginning==cat14_start & cat19==8 | beginning==cat14_start & cat20==8 | beginning==cat14_start & cat21==8 | beginning==cat14_start & cat22==8 | beginning==cat14_start & cat23==8 | beginning==cat14_start & cat24==8 | beginning==cat14_start & cat25==8 | beginning==cat14_start & cat26==8 | beginning==cat14_start & cat27==8 | beginning==cat14_start & cat28==8 | beginning==cat14_start & cat29==8 | beginning==cat14_start & cat30==8 | beginning==cat14_start & cat31==8 | beginning==cat14_start & cat32==8 | beginning==cat14_start & cat33==8 | beginning==cat14_start & cat34==8 | beginning==cat14_start & cat35==8 | beginning==cat14_start & cat36==8 | beginning==cat14_start & cat37==8 | beginning==cat14_start & cat38==8 | beginning==cat14_start & cat39==8 | beginning==cat14_start & cat40==8 | beginning==cat14_start & cat41==8 | beginning==cat14_start & cat42==8 | beginning==cat14_start & cat43==8 | beginning==cat14_start & cat44==8 | beginning==cat14_start & cat45==8 | beginning==cat14_start & cat46==8 | beginning==cat14_start & cat47==8 | beginning==cat14_start & cat48==8 | beginning==cat14_start & cat49==8 | beginning==cat14_start & cat50==8 | beginning==cat14_start & cat51==8 | beginning==cat14_start & cat52==8 | beginning==cat14_start & cat53==8 | beginning==cat14_start & cat54==8 | beginning==cat14_start & cat55==8 | beginning==cat14_start & cat56==8 | beginning==cat14_start & cat57==8 | beginning==cat14_start & cat58==8 | beginning==cat14_start & cat59==8 | beginning==cat14_start & cat60==8 | beginning==cat14_start & cat61==8 | beginning==cat14_start & cat62==8 | beginning==cat14_start & cat63==8 | beginning==cat14_start & cat64==8 | beginning==cat14_start & cat65==8 | beginning==cat14_start & cat66==8 | beginning==cat14_start & cat67==8 | beginning==cat14_start & cat68==8 | beginning==cat14_start & cat69==8 | beginning==cat14_start & cat70==8 | beginning==cat14_start & cat71==8 | beginning==cat14_start & cat72==8 | beginning==cat14_start & cat73==8 | beginning==cat14_start & cat74==8 | beginning==cat14_start & cat75==8 | beginning==cat14_start & cat76==8 | beginning==cat14_start & cat77==8 | beginning==cat14_start & cat78==8 | beginning==cat14_start & cat79==8 | beginning==cat14_start & cat80==8 | beginning==cat14_start & cat81==8 | beginning==cat14_start & cat82==8 | beginning==cat14_start & cat83==8 | beginning==cat14_start & cat84==8 | beginning==cat14_start & cat85==8 | beginning==cat14_start & cat86==8 | beginning==cat14_start & cat87==8 | beginning==cat14_start & cat88==8
replace indicator=0 if beginning==cat14_start & indicator==.
replace indicator=0 if beginning==cat15_start & cat16==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==.
replace indicator=1 if beginning==cat15_start & cat16==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat16_start & cat17==.
replace indicator=1 if beginning==cat16_start & cat17==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18==.
replace indicator=1 if beginning==cat17_start & cat18==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==.
replace indicator=0 if beginning==cat18_start & cat19==.
replace indicator=1 if beginning==cat18_start & cat19==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21==.
replace indicator=1 if beginning==cat19_start & cat20==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat21_start & cat22==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31==.
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat24_start & cat25==.
replace indicator=0 if beginning==cat39_start & cat73!=8 & cat74==.
replace indicator=1 if beginning==cat48_start & cat49==8
replace indicator=1 if beginning==cat50_start & cat51==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==.
replace indicator=1 if beginning==cat25_start & cat26==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==.
replace indicator=0 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==.
replace indicator=1 if beginning==cat21_start & cat22==8
replace indicator=1 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat46_start & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52==.
replace indicator=0 if beginning==cat36_start & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49==.
replace indicator=0 if beginning==cat24_start & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat53_start & cat54==.
replace indicator=0 if beginning==cat34_start & cat35!=8 & cat36!=8 & cat37!=8 & cat38==.
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace indicator=0 if beginning==cat52_start & cat53!=8 & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58==.
replace indicator=1 if beginning==cat27_start & cat28==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=1 if beginning==cat20_start & cat21==8
replace indicator=1 if beginning==cat23_start & cat24==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29==.
replace indicator=1 if beginning==cat29_start & cat30==8
replace indicator=1 if beginning==cat22_start & cat23==8
replace indicator=1 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace indicator=1 if beginning==cat31_start & cat32==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat33_start & cat34==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=1 if beginning==cat19_start & cat20!=8 & cat21==8
tab indicator,m
* Drop individuals that are not in the risk set
drop if indicator==0
drop indicator

* Construct the 'beginning' variable
gen beginning2 = .
replace beginning2 = cat3_start if beginning==cat2_start & cat3==8
order folio_n20 beginning beginning2
replace beginning2 = cat4_start if beginning==cat2_start & cat3!=8 & cat4==8
replace beginning2 = cat5_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat4_start if beginning==cat3_start & cat4==8
replace beginning2 = cat5_start if beginning==cat3_start & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat5_start if beginning==cat4_start & cat5==8
replace beginning2 = cat6_start if beginning==cat4_start & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat6_start if beginning==cat5_start & cat6==8
replace beginning2 = cat7_start if beginning==cat5_start & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat7_start if beginning==cat6_start & cat7==8
replace beginning2 = cat8_start if beginning==cat6_start & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat23_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat24_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat8_start if beginning==cat7_start & cat8==8
replace beginning2 = cat9_start if beginning==cat7_start & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat9_start if beginning==cat8_start & cat9==8
replace beginning2 = cat10_start if beginning==cat8_start & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat10_start if beginning==cat9_start & cat10==8
replace beginning2 = cat11_start if beginning==cat9_start & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat16_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat11_start if beginning==cat10_start & cat11==8
replace beginning2 = cat12_start if beginning==cat10_start & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat17_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat12_start if beginning==cat11_start & cat12==8
replace beginning2 = cat13_start if beginning==cat11_start & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat13_start if beginning==cat12_start & cat13==8
replace beginning2 = cat14_start if beginning==cat12_start & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat14_start if beginning==cat13_start & cat14==8
replace beginning2 = cat15_start if beginning==cat13_start & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat15_start if beginning==cat14_start & cat15==8
replace beginning2 = cat16_start if beginning==cat14_start & cat15!=8 & cat16==8
replace beginning2 = cat16_start if beginning==cat15_start & cat16==8
replace beginning2 = cat17_start if beginning==cat15_start & cat16!=8 & cat17==8
replace beginning2 = cat17_start if beginning==cat16_start & cat17==8
replace beginning2 = cat18_start if beginning==cat17_start & cat18==8
replace beginning2 = cat19_start if beginning==cat18_start & cat19==8
replace beginning2 = cat20_start if beginning==cat19_start & cat20==8
replace beginning2 = cat25_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23!=2 & cat24!=2 & cat25==2
replace beginning2 = cat35_start if beginning==cat32_start & cat33!=8 & cat34!=8 & cat35==8
replace beginning2 = cat17_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat16_start & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat24_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat19_start if beginning==cat17_start & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat18_start & cat19!=8 & cat20==8
replace beginning2 = cat21_start if beginning==cat19_start & cat20!=8 & cat21==8
replace beginning2 = cat22_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat22_start if beginning==cat21_start & cat22==8
replace beginning2 = cat18_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat14_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat15_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat14_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat25_start if beginning==cat24_start & cat25==8
replace beginning2 = cat16_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat24_start if beginning==cat23_start & cat24==8
replace beginning2 = cat20_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat23_start if beginning==cat21_start & cat22!=8 & cat23==8
replace beginning2 = cat19_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat17_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat21_start if beginning==cat20_start & cat21==8
replace beginning2 = cat30_start if beginning==cat29_start & cat30==8
replace beginning2 = cat23_start if beginning==cat22_start & cat23==8
replace beginning2 = cat17_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat24_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat26_start if beginning==cat25_start & cat26==8
replace beginning2 = cat20_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat32_start if beginning==cat31_start & cat32==8
replace beginning2 = cat20_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat18_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8

* Make sure that there are no missings
tab beginning2,m
drop beginning
rename beginning2 beginning

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat3_start & cat4==1
order event,after(folio_n20)
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=0 if beginning==cat29_start & cat30==.
replace event=3 if beginning==cat48_start & cat49==3
replace event=4 if beginning==cat26_start & cat27==4
replace event=6 if beginning==cat27_start & cat28==6
replace event=5 if beginning==cat35_start & cat36==5
replace event=9 if beginning==cat30_start & cat31==10
replace event=6 if beginning==cat26_start & cat27==6
replace event=2 if beginning==cat32_start & cat33==2

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat29_start - beginning if beginning==cat28_start & cat29!=8 & cat29!=.
replace duration = cat31_start - beginning if beginning==cat30_start & cat31!=8 & cat31!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat33_start - beginning if beginning==cat32_start & cat33!=8 & cat33!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat52_start - beginning if beginning==cat51_start & cat52!=8 & cat52!=.

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC8_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =8

* Define the education variable
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079)
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC8_informal", replace

* ---------------------------------------------------------------------------- *
* Outcomes of RC informal of order 9: Variable Creation and Data Setup
* ---------------------------------------------------------------------------- *

* Clear current data, set directory and load the dataset for analysis
clear
use "$resultdir\sample_RC8_informal"

drop event
replace beginning=beginning+duration
drop duration

* Create risk set: individuals that are in RC informal of order 9 across multiple categories
gen indicator = .  // Initialize the variable
replace indicator=1 if beginning==cat2_start & cat3==8 | beginning==cat2_start & cat4==8 | beginning==cat2_start & cat5==8 | beginning==cat2_start & cat6==8 | beginning==cat2_start & cat7==8 | beginning==cat2_start & cat8==8 | beginning==cat2_start & cat9==8 | beginning==cat2_start & cat10==8 | beginning==cat2_start & cat11==8 | beginning==cat2_start & cat12==8 | beginning==cat2_start & cat13==8 | beginning==cat2_start & cat14==8 | beginning==cat2_start & cat15==8 | beginning==cat2_start & cat16==8 | beginning==cat2_start & cat17==8 | beginning==cat2_start & cat18==8 | beginning==cat2_start & cat19==8 | beginning==cat2_start & cat20==8 | beginning==cat2_start & cat21==8 | beginning==cat2_start & cat22==8 | beginning==cat2_start & cat23==8 | beginning==cat2_start & cat24==8 | beginning==cat2_start & cat25==8 | beginning==cat2_start & cat26==8 | beginning==cat2_start & cat27==8 | beginning==cat2_start & cat28==8 | beginning==cat2_start & cat29==8 | beginning==cat2_start & cat30==8 | beginning==cat2_start & cat31==8 | beginning==cat2_start & cat32==8 | beginning==cat2_start & cat33==8 | beginning==cat2_start & cat34==8 | beginning==cat2_start & cat35==8 | beginning==cat2_start & cat36==8 | beginning==cat2_start & cat37==8 | beginning==cat2_start & cat38==8 | beginning==cat2_start & cat39==8 | beginning==cat2_start & cat40==8 | beginning==cat2_start & cat41==8 | beginning==cat2_start & cat42==8 | beginning==cat2_start & cat43==8 | beginning==cat2_start & cat44==8 | beginning==cat2_start & cat45==8 | beginning==cat2_start & cat46==8 | beginning==cat2_start & cat47==8 | beginning==cat2_start & cat48==8 | beginning==cat2_start & cat49==8 | beginning==cat2_start & cat50==8 | beginning==cat2_start & cat51==8 | beginning==cat2_start & cat52==8 | beginning==cat2_start & cat53==8 | beginning==cat2_start & cat54==8 | beginning==cat2_start & cat55==8 | beginning==cat2_start & cat56==8 | beginning==cat2_start & cat57==8 | beginning==cat2_start & cat58==8 | beginning==cat2_start & cat59==8 | beginning==cat2_start & cat60==8 | beginning==cat2_start & cat61==8 | beginning==cat2_start & cat62==8 | beginning==cat2_start & cat63==8 | beginning==cat2_start & cat64==8 | beginning==cat2_start & cat65==8 | beginning==cat2_start & cat66==8 | beginning==cat2_start & cat67==8 | beginning==cat2_start & cat68==8 | beginning==cat2_start & cat69==8 | beginning==cat2_start & cat70==8 | beginning==cat2_start & cat71==8 | beginning==cat2_start & cat72==8 | beginning==cat2_start & cat73==8 | beginning==cat2_start & cat74==8 | beginning==cat2_start & cat75==8 | beginning==cat2_start & cat76==8 | beginning==cat2_start & cat77==8 | beginning==cat2_start & cat78==8 | beginning==cat2_start & cat79==8 | beginning==cat2_start & cat80==8 | beginning==cat2_start & cat81==8 | beginning==cat2_start & cat82==8 | beginning==cat2_start & cat83==8 | beginning==cat2_start & cat84==8 | beginning==cat2_start & cat85==8 | beginning==cat2_start & cat86==8 | beginning==cat2_start & cat87==8 | beginning==cat2_start & cat88==8
replace indicator=0 if beginning==cat2_start & indicator==.
replace indicator=1 if beginning==cat3_start & cat4==8 | beginning==cat3_start & cat5==8 | beginning==cat3_start & cat6==8 | beginning==cat3_start & cat7==8 | beginning==cat3_start & cat8==8 | beginning==cat3_start & cat9==8 | beginning==cat3_start & cat10==8 | beginning==cat3_start & cat11==8 | beginning==cat3_start & cat12==8 | beginning==cat3_start & cat13==8 | beginning==cat3_start & cat14==8 | beginning==cat3_start & cat15==8 | beginning==cat3_start & cat16==8 | beginning==cat3_start & cat17==8 | beginning==cat3_start & cat18==8 | beginning==cat3_start & cat19==8 | beginning==cat3_start & cat20==8 | beginning==cat3_start & cat21==8 | beginning==cat3_start & cat22==8 | beginning==cat3_start & cat23==8 | beginning==cat3_start & cat24==8 | beginning==cat3_start & cat25==8 | beginning==cat3_start & cat26==8 | beginning==cat3_start & cat27==8 | beginning==cat3_start & cat28==8 | beginning==cat3_start & cat29==8 | beginning==cat3_start & cat30==8 | beginning==cat3_start & cat31==8 | beginning==cat3_start & cat32==8 | beginning==cat3_start & cat33==8 | beginning==cat3_start & cat34==8 | beginning==cat3_start & cat35==8 | beginning==cat3_start & cat36==8 | beginning==cat3_start & cat37==8 | beginning==cat3_start & cat38==8 | beginning==cat3_start & cat39==8 | beginning==cat3_start & cat40==8 | beginning==cat3_start & cat41==8 | beginning==cat3_start & cat42==8 | beginning==cat3_start & cat43==8 | beginning==cat3_start & cat44==8 | beginning==cat3_start & cat45==8 | beginning==cat3_start & cat46==8 | beginning==cat3_start & cat47==8 | beginning==cat3_start & cat48==8 | beginning==cat3_start & cat49==8 | beginning==cat3_start & cat50==8 | beginning==cat3_start & cat51==8 | beginning==cat3_start & cat52==8 | beginning==cat3_start & cat53==8 | beginning==cat3_start & cat54==8 | beginning==cat3_start & cat55==8 | beginning==cat3_start & cat56==8 | beginning==cat3_start & cat57==8 | beginning==cat3_start & cat58==8 | beginning==cat3_start & cat59==8 | beginning==cat3_start & cat60==8 | beginning==cat3_start & cat61==8 | beginning==cat3_start & cat62==8 | beginning==cat3_start & cat63==8 | beginning==cat3_start & cat64==8 | beginning==cat3_start & cat65==8 | beginning==cat3_start & cat66==8 | beginning==cat3_start & cat67==8 | beginning==cat3_start & cat68==8 | beginning==cat3_start & cat69==8 | beginning==cat3_start & cat70==8 | beginning==cat3_start & cat71==8 | beginning==cat3_start & cat72==8 | beginning==cat3_start & cat73==8 | beginning==cat3_start & cat74==8 | beginning==cat3_start & cat75==8 | beginning==cat3_start & cat76==8 | beginning==cat3_start & cat77==8 | beginning==cat3_start & cat78==8 | beginning==cat3_start & cat79==8 | beginning==cat3_start & cat80==8 | beginning==cat3_start & cat81==8 | beginning==cat3_start & cat82==8 | beginning==cat3_start & cat83==8 | beginning==cat3_start & cat84==8 | beginning==cat3_start & cat85==8 | beginning==cat3_start & cat86==8 | beginning==cat3_start & cat87==8 | beginning==cat3_start & cat88==8
replace indicator=0 if beginning==cat3_start & indicator==.
replace indicator=1 if beginning==cat4_start & cat5==8 | beginning==cat4_start & cat6==8 | beginning==cat4_start & cat7==8 | beginning==cat4_start & cat8==8 | beginning==cat4_start & cat9==8 | beginning==cat4_start & cat10==8 | beginning==cat4_start & cat11==8 | beginning==cat4_start & cat12==8 | beginning==cat4_start & cat13==8 | beginning==cat4_start & cat14==8 | beginning==cat4_start & cat15==8 | beginning==cat4_start & cat16==8 | beginning==cat4_start & cat17==8 | beginning==cat4_start & cat18==8 | beginning==cat4_start & cat19==8 | beginning==cat4_start & cat20==8 | beginning==cat4_start & cat21==8 | beginning==cat4_start & cat22==8 | beginning==cat4_start & cat23==8 | beginning==cat4_start & cat24==8 | beginning==cat4_start & cat25==8 | beginning==cat4_start & cat26==8 | beginning==cat4_start & cat27==8 | beginning==cat4_start & cat28==8 | beginning==cat4_start & cat29==8 | beginning==cat4_start & cat30==8 | beginning==cat4_start & cat31==8 | beginning==cat4_start & cat32==8 | beginning==cat4_start & cat33==8 | beginning==cat4_start & cat34==8 | beginning==cat4_start & cat35==8 | beginning==cat4_start & cat36==8 | beginning==cat4_start & cat37==8 | beginning==cat4_start & cat38==8 | beginning==cat4_start & cat39==8 | beginning==cat4_start & cat40==8 | beginning==cat4_start & cat41==8 | beginning==cat4_start & cat42==8 | beginning==cat4_start & cat43==8 | beginning==cat4_start & cat44==8 | beginning==cat4_start & cat45==8 | beginning==cat4_start & cat46==8 | beginning==cat4_start & cat47==8 | beginning==cat4_start & cat48==8 | beginning==cat4_start & cat49==8 | beginning==cat4_start & cat50==8 | beginning==cat4_start & cat51==8 | beginning==cat4_start & cat52==8 | beginning==cat4_start & cat53==8 | beginning==cat4_start & cat54==8 | beginning==cat4_start & cat55==8 | beginning==cat4_start & cat56==8 | beginning==cat4_start & cat57==8 | beginning==cat4_start & cat58==8 | beginning==cat4_start & cat59==8 | beginning==cat4_start & cat60==8 | beginning==cat4_start & cat61==8 | beginning==cat4_start & cat62==8 | beginning==cat4_start & cat63==8 | beginning==cat4_start & cat64==8 | beginning==cat4_start & cat65==8 | beginning==cat4_start & cat66==8 | beginning==cat4_start & cat67==8 | beginning==cat4_start & cat68==8 | beginning==cat4_start & cat69==8 | beginning==cat4_start & cat70==8 | beginning==cat4_start & cat71==8 | beginning==cat4_start & cat72==8 | beginning==cat4_start & cat73==8 | beginning==cat4_start & cat74==8 | beginning==cat4_start & cat75==8 | beginning==cat4_start & cat76==8 | beginning==cat4_start & cat77==8 | beginning==cat4_start & cat78==8 | beginning==cat4_start & cat79==8 | beginning==cat4_start & cat80==8 | beginning==cat4_start & cat81==8 | beginning==cat4_start & cat82==8 | beginning==cat4_start & cat83==8 | beginning==cat4_start & cat84==8 | beginning==cat4_start & cat85==8 | beginning==cat4_start & cat86==8 | beginning==cat4_start & cat87==8 | beginning==cat4_start & cat88==8
replace indicator=0 if beginning==cat4_start & indicator==.
replace indicator=1 if beginning==cat5_start & cat6==8 | beginning==cat5_start & cat7==8 | beginning==cat5_start & cat8==8 | beginning==cat5_start & cat9==8 | beginning==cat5_start & cat10==8 | beginning==cat5_start & cat11==8 | beginning==cat5_start & cat12==8 | beginning==cat5_start & cat13==8 | beginning==cat5_start & cat14==8 | beginning==cat5_start & cat15==8 | beginning==cat5_start & cat16==8 | beginning==cat5_start & cat17==8 | beginning==cat5_start & cat18==8 | beginning==cat5_start & cat19==8 | beginning==cat5_start & cat20==8 | beginning==cat5_start & cat21==8 | beginning==cat5_start & cat22==8 | beginning==cat5_start & cat23==8 | beginning==cat5_start & cat24==8 | beginning==cat5_start & cat25==8 | beginning==cat5_start & cat26==8 | beginning==cat5_start & cat27==8 | beginning==cat5_start & cat28==8 | beginning==cat5_start & cat29==8 | beginning==cat5_start & cat30==8 | beginning==cat5_start & cat31==8 | beginning==cat5_start & cat32==8 | beginning==cat5_start & cat33==8 | beginning==cat5_start & cat34==8 | beginning==cat5_start & cat35==8 | beginning==cat5_start & cat36==8 | beginning==cat5_start & cat37==8 | beginning==cat5_start & cat38==8 | beginning==cat5_start & cat39==8 | beginning==cat5_start & cat40==8 | beginning==cat5_start & cat41==8 | beginning==cat5_start & cat42==8 | beginning==cat5_start & cat43==8 | beginning==cat5_start & cat44==8 | beginning==cat5_start & cat45==8 | beginning==cat5_start & cat46==8 | beginning==cat5_start & cat47==8 | beginning==cat5_start & cat48==8 | beginning==cat5_start & cat49==8 | beginning==cat5_start & cat50==8 | beginning==cat5_start & cat51==8 | beginning==cat5_start & cat52==8 | beginning==cat5_start & cat53==8 | beginning==cat5_start & cat54==8 | beginning==cat5_start & cat55==8 | beginning==cat5_start & cat56==8 | beginning==cat5_start & cat57==8 | beginning==cat5_start & cat58==8 | beginning==cat5_start & cat59==8 | beginning==cat5_start & cat60==8 | beginning==cat5_start & cat61==8 | beginning==cat5_start & cat62==8 | beginning==cat5_start & cat63==8 | beginning==cat5_start & cat64==8 | beginning==cat5_start & cat65==8 | beginning==cat5_start & cat66==8 | beginning==cat5_start & cat67==8 | beginning==cat5_start & cat68==8 | beginning==cat5_start & cat69==8 | beginning==cat5_start & cat70==8 | beginning==cat5_start & cat71==8 | beginning==cat5_start & cat72==8 | beginning==cat5_start & cat73==8 | beginning==cat5_start & cat74==8 | beginning==cat5_start & cat75==8 | beginning==cat5_start & cat76==8 | beginning==cat5_start & cat77==8 | beginning==cat5_start & cat78==8 | beginning==cat5_start & cat79==8 | beginning==cat5_start & cat80==8 | beginning==cat5_start & cat81==8 | beginning==cat5_start & cat82==8 | beginning==cat5_start & cat83==8 | beginning==cat5_start & cat84==8 | beginning==cat5_start & cat85==8 | beginning==cat5_start & cat86==8 | beginning==cat5_start & cat87==8 | beginning==cat5_start & cat88==8
replace indicator=0 if beginning==cat5_start & indicator==.
replace indicator=1 if beginning==cat6_start & cat7==8 | beginning==cat6_start & cat8==8 | beginning==cat6_start & cat9==8 | beginning==cat6_start & cat10==8 | beginning==cat6_start & cat11==8 | beginning==cat6_start & cat12==8 | beginning==cat6_start & cat13==8 | beginning==cat6_start & cat14==8 | beginning==cat6_start & cat15==8 | beginning==cat6_start & cat16==8 | beginning==cat6_start & cat17==8 | beginning==cat6_start & cat18==8 | beginning==cat6_start & cat19==8 | beginning==cat6_start & cat20==8 | beginning==cat6_start & cat21==8 | beginning==cat6_start & cat22==8 | beginning==cat6_start & cat23==8 | beginning==cat6_start & cat24==8 | beginning==cat6_start & cat25==8 | beginning==cat6_start & cat26==8 | beginning==cat6_start & cat27==8 | beginning==cat6_start & cat28==8 | beginning==cat6_start & cat29==8 | beginning==cat6_start & cat30==8 | beginning==cat6_start & cat31==8 | beginning==cat6_start & cat32==8 | beginning==cat6_start & cat33==8 | beginning==cat6_start & cat34==8 | beginning==cat6_start & cat35==8 | beginning==cat6_start & cat36==8 | beginning==cat6_start & cat37==8 | beginning==cat6_start & cat38==8 | beginning==cat6_start & cat39==8 | beginning==cat6_start & cat40==8 | beginning==cat6_start & cat41==8 | beginning==cat6_start & cat42==8 | beginning==cat6_start & cat43==8 | beginning==cat6_start & cat44==8 | beginning==cat6_start & cat45==8 | beginning==cat6_start & cat46==8 | beginning==cat6_start & cat47==8 | beginning==cat6_start & cat48==8 | beginning==cat6_start & cat49==8 | beginning==cat6_start & cat50==8 | beginning==cat6_start & cat51==8 | beginning==cat6_start & cat52==8 | beginning==cat6_start & cat53==8 | beginning==cat6_start & cat54==8 | beginning==cat6_start & cat55==8 | beginning==cat6_start & cat56==8 | beginning==cat6_start & cat57==8 | beginning==cat6_start & cat58==8 | beginning==cat6_start & cat59==8 | beginning==cat6_start & cat60==8 | beginning==cat6_start & cat61==8 | beginning==cat6_start & cat62==8 | beginning==cat6_start & cat63==8 | beginning==cat6_start & cat64==8 | beginning==cat6_start & cat65==8 | beginning==cat6_start & cat66==8 | beginning==cat6_start & cat67==8 | beginning==cat6_start & cat68==8 | beginning==cat6_start & cat69==8 | beginning==cat6_start & cat70==8 | beginning==cat6_start & cat71==8 | beginning==cat6_start & cat72==8 | beginning==cat6_start & cat73==8 | beginning==cat6_start & cat74==8 | beginning==cat6_start & cat75==8 | beginning==cat6_start & cat76==8 | beginning==cat6_start & cat77==8 | beginning==cat6_start & cat78==8 | beginning==cat6_start & cat79==8 | beginning==cat6_start & cat80==8 | beginning==cat6_start & cat81==8 | beginning==cat6_start & cat82==8 | beginning==cat6_start & cat83==8 | beginning==cat6_start & cat84==8 | beginning==cat6_start & cat85==8 | beginning==cat6_start & cat86==8 | beginning==cat6_start & cat87==8 | beginning==cat6_start & cat88==8
replace indicator=0 if beginning==cat6_start & indicator==.
replace indicator=1 if beginning==cat7_start & cat8==8 | beginning==cat7_start & cat9==8 | beginning==cat7_start & cat10==8 | beginning==cat7_start & cat11==8 | beginning==cat7_start & cat12==8 | beginning==cat7_start & cat13==8 | beginning==cat7_start & cat14==8 | beginning==cat7_start & cat15==8 | beginning==cat7_start & cat16==8 | beginning==cat7_start & cat17==8 | beginning==cat7_start & cat18==8 | beginning==cat7_start & cat19==8 | beginning==cat7_start & cat20==8 | beginning==cat7_start & cat21==8 | beginning==cat7_start & cat22==8 | beginning==cat7_start & cat23==8 | beginning==cat7_start & cat24==8 | beginning==cat7_start & cat25==8 | beginning==cat7_start & cat26==8 | beginning==cat7_start & cat27==8 | beginning==cat7_start & cat28==8 | beginning==cat7_start & cat29==8 | beginning==cat7_start & cat30==8 | beginning==cat7_start & cat31==8 | beginning==cat7_start & cat32==8 | beginning==cat7_start & cat33==8 | beginning==cat7_start & cat34==8 | beginning==cat7_start & cat35==8 | beginning==cat7_start & cat36==8 | beginning==cat7_start & cat37==8 | beginning==cat7_start & cat38==8 | beginning==cat7_start & cat39==8 | beginning==cat7_start & cat40==8 | beginning==cat7_start & cat41==8 | beginning==cat7_start & cat42==8 | beginning==cat7_start & cat43==8 | beginning==cat7_start & cat44==8 | beginning==cat7_start & cat45==8 | beginning==cat7_start & cat46==8 | beginning==cat7_start & cat47==8 | beginning==cat7_start & cat48==8 | beginning==cat7_start & cat49==8 | beginning==cat7_start & cat50==8 | beginning==cat7_start & cat51==8 | beginning==cat7_start & cat52==8 | beginning==cat7_start & cat53==8 | beginning==cat7_start & cat54==8 | beginning==cat7_start & cat55==8 | beginning==cat7_start & cat56==8 | beginning==cat7_start & cat57==8 | beginning==cat7_start & cat58==8 | beginning==cat7_start & cat59==8 | beginning==cat7_start & cat60==8 | beginning==cat7_start & cat61==8 | beginning==cat7_start & cat62==8 | beginning==cat7_start & cat63==8 | beginning==cat7_start & cat64==8 | beginning==cat7_start & cat65==8 | beginning==cat7_start & cat66==8 | beginning==cat7_start & cat67==8 | beginning==cat7_start & cat68==8 | beginning==cat7_start & cat69==8 | beginning==cat7_start & cat70==8 | beginning==cat7_start & cat71==8 | beginning==cat7_start & cat72==8 | beginning==cat7_start & cat73==8 | beginning==cat7_start & cat74==8 | beginning==cat7_start & cat75==8 | beginning==cat7_start & cat76==8 | beginning==cat7_start & cat77==8 | beginning==cat7_start & cat78==8 | beginning==cat7_start & cat79==8 | beginning==cat7_start & cat80==8 | beginning==cat7_start & cat81==8 | beginning==cat7_start & cat82==8 | beginning==cat7_start & cat83==8 | beginning==cat7_start & cat84==8 | beginning==cat7_start & cat85==8 | beginning==cat7_start & cat86==8 | beginning==cat7_start & cat87==8 | beginning==cat7_start & cat88==8
replace indicator=0 if beginning==cat7_start & indicator==.
replace indicator=1 if beginning==cat8_start & cat9==8 | beginning==cat8_start & cat10==8 | beginning==cat8_start & cat11==8 | beginning==cat8_start & cat12==8 | beginning==cat8_start & cat13==8 | beginning==cat8_start & cat14==8 | beginning==cat8_start & cat15==8 | beginning==cat8_start & cat16==8 | beginning==cat8_start & cat17==8 | beginning==cat8_start & cat18==8 | beginning==cat8_start & cat19==8 | beginning==cat8_start & cat20==8 | beginning==cat8_start & cat21==8 | beginning==cat8_start & cat22==8 | beginning==cat8_start & cat23==8 | beginning==cat8_start & cat24==8 | beginning==cat8_start & cat25==8 | beginning==cat8_start & cat26==8 | beginning==cat8_start & cat27==8 | beginning==cat8_start & cat28==8 | beginning==cat8_start & cat29==8 | beginning==cat8_start & cat30==8 | beginning==cat8_start & cat31==8 | beginning==cat8_start & cat32==8 | beginning==cat8_start & cat33==8 | beginning==cat8_start & cat34==8 | beginning==cat8_start & cat35==8 | beginning==cat8_start & cat36==8 | beginning==cat8_start & cat37==8 | beginning==cat8_start & cat38==8 | beginning==cat8_start & cat39==8 | beginning==cat8_start & cat40==8 | beginning==cat8_start & cat41==8 | beginning==cat8_start & cat42==8 | beginning==cat8_start & cat43==8 | beginning==cat8_start & cat44==8 | beginning==cat8_start & cat45==8 | beginning==cat8_start & cat46==8 | beginning==cat8_start & cat47==8 | beginning==cat8_start & cat48==8 | beginning==cat8_start & cat49==8 | beginning==cat8_start & cat50==8 | beginning==cat8_start & cat51==8 | beginning==cat8_start & cat52==8 | beginning==cat8_start & cat53==8 | beginning==cat8_start & cat54==8 | beginning==cat8_start & cat55==8 | beginning==cat8_start & cat56==8 | beginning==cat8_start & cat57==8 | beginning==cat8_start & cat58==8 | beginning==cat8_start & cat59==8 | beginning==cat8_start & cat60==8 | beginning==cat8_start & cat61==8 | beginning==cat8_start & cat62==8 | beginning==cat8_start & cat63==8 | beginning==cat8_start & cat64==8 | beginning==cat8_start & cat65==8 | beginning==cat8_start & cat66==8 | beginning==cat8_start & cat67==8 | beginning==cat8_start & cat68==8 | beginning==cat8_start & cat69==8 | beginning==cat8_start & cat70==8 | beginning==cat8_start & cat71==8 | beginning==cat8_start & cat72==8 | beginning==cat8_start & cat73==8 | beginning==cat8_start & cat74==8 | beginning==cat8_start & cat75==8 | beginning==cat8_start & cat76==8 | beginning==cat8_start & cat77==8 | beginning==cat8_start & cat78==8 | beginning==cat8_start & cat79==8 | beginning==cat8_start & cat80==8 | beginning==cat8_start & cat81==8 | beginning==cat8_start & cat82==8 | beginning==cat8_start & cat83==8 | beginning==cat8_start & cat84==8 | beginning==cat8_start & cat85==8 | beginning==cat8_start & cat86==8 | beginning==cat8_start & cat87==8 | beginning==cat8_start & cat88==8
replace indicator=0 if beginning==cat8_start & indicator==.
replace indicator=0 if beginning==end
replace indicator=1 if beginning==cat9_start & cat10==8 | beginning==cat9_start & cat11==8 | beginning==cat9_start & cat12==8 | beginning==cat9_start & cat13==8 | beginning==cat9_start & cat14==8 | beginning==cat9_start & cat15==8 | beginning==cat9_start & cat16==8 | beginning==cat9_start & cat17==8 | beginning==cat9_start & cat18==8 | beginning==cat9_start & cat19==8 | beginning==cat9_start & cat20==8 | beginning==cat9_start & cat21==8 | beginning==cat9_start & cat22==8 | beginning==cat9_start & cat23==8 | beginning==cat9_start & cat24==8 | beginning==cat9_start & cat25==8 | beginning==cat9_start & cat26==8 | beginning==cat9_start & cat27==8 | beginning==cat9_start & cat28==8 | beginning==cat9_start & cat29==8 | beginning==cat9_start & cat30==8 | beginning==cat9_start & cat31==8 | beginning==cat9_start & cat32==8 | beginning==cat9_start & cat33==8 | beginning==cat9_start & cat34==8 | beginning==cat9_start & cat35==8 | beginning==cat9_start & cat36==8 | beginning==cat9_start & cat37==8 | beginning==cat9_start & cat38==8 | beginning==cat9_start & cat39==8 | beginning==cat9_start & cat40==8 | beginning==cat9_start & cat41==8 | beginning==cat9_start & cat42==8 | beginning==cat9_start & cat43==8 | beginning==cat9_start & cat44==8 | beginning==cat9_start & cat45==8 | beginning==cat9_start & cat46==8 | beginning==cat9_start & cat47==8 | beginning==cat9_start & cat48==8 | beginning==cat9_start & cat49==8 | beginning==cat9_start & cat50==8 | beginning==cat9_start & cat51==8 | beginning==cat9_start & cat52==8 | beginning==cat9_start & cat53==8 | beginning==cat9_start & cat54==8 | beginning==cat9_start & cat55==8 | beginning==cat9_start & cat56==8 | beginning==cat9_start & cat57==8 | beginning==cat9_start & cat58==8 | beginning==cat9_start & cat59==8 | beginning==cat9_start & cat60==8 | beginning==cat9_start & cat61==8 | beginning==cat9_start & cat62==8 | beginning==cat9_start & cat63==8 | beginning==cat9_start & cat64==8 | beginning==cat9_start & cat65==8 | beginning==cat9_start & cat66==8 | beginning==cat9_start & cat67==8 | beginning==cat9_start & cat68==8 | beginning==cat9_start & cat69==8 | beginning==cat9_start & cat70==8 | beginning==cat9_start & cat71==8 | beginning==cat9_start & cat72==8 | beginning==cat9_start & cat73==8 | beginning==cat9_start & cat74==8 | beginning==cat9_start & cat75==8 | beginning==cat9_start & cat76==8 | beginning==cat9_start & cat77==8 | beginning==cat9_start & cat78==8 | beginning==cat9_start & cat79==8 | beginning==cat9_start & cat80==8 | beginning==cat9_start & cat81==8 | beginning==cat9_start & cat82==8 | beginning==cat9_start & cat83==8 | beginning==cat9_start & cat84==8 | beginning==cat9_start & cat85==8 | beginning==cat9_start & cat86==8 | beginning==cat9_start & cat87==8 | beginning==cat9_start & cat88==8
replace indicator=0 if beginning==cat9_start & indicator==.
replace indicator=1 if beginning==cat10_start & cat11==8 | beginning==cat10_start & cat12==8 | beginning==cat10_start & cat13==8 | beginning==cat10_start & cat14==8 | beginning==cat10_start & cat15==8 | beginning==cat10_start & cat16==8 | beginning==cat10_start & cat17==8 | beginning==cat10_start & cat18==8 | beginning==cat10_start & cat19==8 | beginning==cat10_start & cat20==8 | beginning==cat10_start & cat21==8 | beginning==cat10_start & cat22==8 | beginning==cat10_start & cat23==8 | beginning==cat10_start & cat24==8 | beginning==cat10_start & cat25==8 | beginning==cat10_start & cat26==8 | beginning==cat10_start & cat27==8 | beginning==cat10_start & cat28==8 | beginning==cat10_start & cat29==8 | beginning==cat10_start & cat30==8 | beginning==cat10_start & cat31==8 | beginning==cat10_start & cat32==8 | beginning==cat10_start & cat33==8 | beginning==cat10_start & cat34==8 | beginning==cat10_start & cat35==8 | beginning==cat10_start & cat36==8 | beginning==cat10_start & cat37==8 | beginning==cat10_start & cat38==8 | beginning==cat10_start & cat39==8 | beginning==cat10_start & cat40==8 | beginning==cat10_start & cat41==8 | beginning==cat10_start & cat42==8 | beginning==cat10_start & cat43==8 | beginning==cat10_start & cat44==8 | beginning==cat10_start & cat45==8 | beginning==cat10_start & cat46==8 | beginning==cat10_start & cat47==8 | beginning==cat10_start & cat48==8 | beginning==cat10_start & cat49==8 | beginning==cat10_start & cat50==8 | beginning==cat10_start & cat51==8 | beginning==cat10_start & cat52==8 | beginning==cat10_start & cat53==8 | beginning==cat10_start & cat54==8 | beginning==cat10_start & cat55==8 | beginning==cat10_start & cat56==8 | beginning==cat10_start & cat57==8 | beginning==cat10_start & cat58==8 | beginning==cat10_start & cat59==8 | beginning==cat10_start & cat60==8 | beginning==cat10_start & cat61==8 | beginning==cat10_start & cat62==8 | beginning==cat10_start & cat63==8 | beginning==cat10_start & cat64==8 | beginning==cat10_start & cat65==8 | beginning==cat10_start & cat66==8 | beginning==cat10_start & cat67==8 | beginning==cat10_start & cat68==8 | beginning==cat10_start & cat69==8 | beginning==cat10_start & cat70==8 | beginning==cat10_start & cat71==8 | beginning==cat10_start & cat72==8 | beginning==cat10_start & cat73==8 | beginning==cat10_start & cat74==8 | beginning==cat10_start & cat75==8 | beginning==cat10_start & cat76==8 | beginning==cat10_start & cat77==8 | beginning==cat10_start & cat78==8 | beginning==cat10_start & cat79==8 | beginning==cat10_start & cat80==8 | beginning==cat10_start & cat81==8 | beginning==cat10_start & cat82==8 | beginning==cat10_start & cat83==8 | beginning==cat10_start & cat84==8 | beginning==cat10_start & cat85==8 | beginning==cat10_start & cat86==8 | beginning==cat10_start & cat87==8 | beginning==cat10_start & cat88==8
replace indicator=0 if beginning==cat10_start & indicator==.
replace indicator=1 if beginning==cat11_start & cat12==8 | beginning==cat11_start & cat13==8 | beginning==cat11_start & cat14==8 | beginning==cat11_start & cat15==8 | beginning==cat11_start & cat16==8 | beginning==cat11_start & cat17==8 | beginning==cat11_start & cat18==8 | beginning==cat11_start & cat19==8 | beginning==cat11_start & cat20==8 | beginning==cat11_start & cat21==8 | beginning==cat11_start & cat22==8 | beginning==cat11_start & cat23==8 | beginning==cat11_start & cat24==8 | beginning==cat11_start & cat25==8 | beginning==cat11_start & cat26==8 | beginning==cat11_start & cat27==8 | beginning==cat11_start & cat28==8 | beginning==cat11_start & cat29==8 | beginning==cat11_start & cat30==8 | beginning==cat11_start & cat31==8 | beginning==cat11_start & cat32==8 | beginning==cat11_start & cat33==8 | beginning==cat11_start & cat34==8 | beginning==cat11_start & cat35==8 | beginning==cat11_start & cat36==8 | beginning==cat11_start & cat37==8 | beginning==cat11_start & cat38==8 | beginning==cat11_start & cat39==8 | beginning==cat11_start & cat40==8 | beginning==cat11_start & cat41==8 | beginning==cat11_start & cat42==8 | beginning==cat11_start & cat43==8 | beginning==cat11_start & cat44==8 | beginning==cat11_start & cat45==8 | beginning==cat11_start & cat46==8 | beginning==cat11_start & cat47==8 | beginning==cat11_start & cat48==8 | beginning==cat11_start & cat49==8 | beginning==cat11_start & cat50==8 | beginning==cat11_start & cat51==8 | beginning==cat11_start & cat52==8 | beginning==cat11_start & cat53==8 | beginning==cat11_start & cat54==8 | beginning==cat11_start & cat55==8 | beginning==cat11_start & cat56==8 | beginning==cat11_start & cat57==8 | beginning==cat11_start & cat58==8 | beginning==cat11_start & cat59==8 | beginning==cat11_start & cat60==8 | beginning==cat11_start & cat61==8 | beginning==cat11_start & cat62==8 | beginning==cat11_start & cat63==8 | beginning==cat11_start & cat64==8 | beginning==cat11_start & cat65==8 | beginning==cat11_start & cat66==8 | beginning==cat11_start & cat67==8 | beginning==cat11_start & cat68==8 | beginning==cat11_start & cat69==8 | beginning==cat11_start & cat70==8 | beginning==cat11_start & cat71==8 | beginning==cat11_start & cat72==8 | beginning==cat11_start & cat73==8 | beginning==cat11_start & cat74==8 | beginning==cat11_start & cat75==8 | beginning==cat11_start & cat76==8 | beginning==cat11_start & cat77==8 | beginning==cat11_start & cat78==8 | beginning==cat11_start & cat79==8 | beginning==cat11_start & cat80==8 | beginning==cat11_start & cat81==8 | beginning==cat11_start & cat82==8 | beginning==cat11_start & cat83==8 | beginning==cat11_start & cat84==8 | beginning==cat11_start & cat85==8 | beginning==cat11_start & cat86==8 | beginning==cat11_start & cat87==8 | beginning==cat11_start & cat88==8
replace indicator=0 if beginning==cat11_start & indicator==.
replace indicator=1 if beginning==cat12_start & cat13==8 | beginning==cat12_start & cat14==8 | beginning==cat12_start & cat15==8 | beginning==cat12_start & cat16==8 | beginning==cat12_start & cat17==8 | beginning==cat12_start & cat18==8 | beginning==cat12_start & cat19==8 | beginning==cat12_start & cat20==8 | beginning==cat12_start & cat21==8 | beginning==cat12_start & cat22==8 | beginning==cat12_start & cat23==8 | beginning==cat12_start & cat24==8 | beginning==cat12_start & cat25==8 | beginning==cat12_start & cat26==8 | beginning==cat12_start & cat27==8 | beginning==cat12_start & cat28==8 | beginning==cat12_start & cat29==8 | beginning==cat12_start & cat30==8 | beginning==cat12_start & cat31==8 | beginning==cat12_start & cat32==8 | beginning==cat12_start & cat33==8 | beginning==cat12_start & cat34==8 | beginning==cat12_start & cat35==8 | beginning==cat12_start & cat36==8 | beginning==cat12_start & cat37==8 | beginning==cat12_start & cat38==8 | beginning==cat12_start & cat39==8 | beginning==cat12_start & cat40==8 | beginning==cat12_start & cat41==8 | beginning==cat12_start & cat42==8 | beginning==cat12_start & cat43==8 | beginning==cat12_start & cat44==8 | beginning==cat12_start & cat45==8 | beginning==cat12_start & cat46==8 | beginning==cat12_start & cat47==8 | beginning==cat12_start & cat48==8 | beginning==cat12_start & cat49==8 | beginning==cat12_start & cat50==8 | beginning==cat12_start & cat51==8 | beginning==cat12_start & cat52==8 | beginning==cat12_start & cat53==8 | beginning==cat12_start & cat54==8 | beginning==cat12_start & cat55==8 | beginning==cat12_start & cat56==8 | beginning==cat12_start & cat57==8 | beginning==cat12_start & cat58==8 | beginning==cat12_start & cat59==8 | beginning==cat12_start & cat60==8 | beginning==cat12_start & cat61==8 | beginning==cat12_start & cat62==8 | beginning==cat12_start & cat63==8 | beginning==cat12_start & cat64==8 | beginning==cat12_start & cat65==8 | beginning==cat12_start & cat66==8 | beginning==cat12_start & cat67==8 | beginning==cat12_start & cat68==8 | beginning==cat12_start & cat69==8 | beginning==cat12_start & cat70==8 | beginning==cat12_start & cat71==8 | beginning==cat12_start & cat72==8 | beginning==cat12_start & cat73==8 | beginning==cat12_start & cat74==8 | beginning==cat12_start & cat75==8 | beginning==cat12_start & cat76==8 | beginning==cat12_start & cat77==8 | beginning==cat12_start & cat78==8 | beginning==cat12_start & cat79==8 | beginning==cat12_start & cat80==8 | beginning==cat12_start & cat81==8 | beginning==cat12_start & cat82==8 | beginning==cat12_start & cat83==8 | beginning==cat12_start & cat84==8 | beginning==cat12_start & cat85==8 | beginning==cat12_start & cat86==8 | beginning==cat12_start & cat87==8 | beginning==cat12_start & cat88==8
replace indicator=0 if beginning==cat12_start & indicator==.
replace indicator=1 if beginning==cat13_start & cat14==8 | beginning==cat13_start & cat15==8 | beginning==cat13_start & cat16==8 | beginning==cat13_start & cat17==8 | beginning==cat13_start & cat18==8 | beginning==cat13_start & cat19==8 | beginning==cat13_start & cat20==8 | beginning==cat13_start & cat21==8 | beginning==cat13_start & cat22==8 | beginning==cat13_start & cat23==8 | beginning==cat13_start & cat24==8 | beginning==cat13_start & cat25==8 | beginning==cat13_start & cat26==8 | beginning==cat13_start & cat27==8 | beginning==cat13_start & cat28==8 | beginning==cat13_start & cat29==8 | beginning==cat13_start & cat30==8 | beginning==cat13_start & cat31==8 | beginning==cat13_start & cat32==8 | beginning==cat13_start & cat33==8 | beginning==cat13_start & cat34==8 | beginning==cat13_start & cat35==8 | beginning==cat13_start & cat36==8 | beginning==cat13_start & cat37==8 | beginning==cat13_start & cat38==8 | beginning==cat13_start & cat39==8 | beginning==cat13_start & cat40==8 | beginning==cat13_start & cat41==8 | beginning==cat13_start & cat42==8 | beginning==cat13_start & cat43==8 | beginning==cat13_start & cat44==8 | beginning==cat13_start & cat45==8 | beginning==cat13_start & cat46==8 | beginning==cat13_start & cat47==8 | beginning==cat13_start & cat48==8 | beginning==cat13_start & cat49==8 | beginning==cat13_start & cat50==8 | beginning==cat13_start & cat51==8 | beginning==cat13_start & cat52==8 | beginning==cat13_start & cat53==8 | beginning==cat13_start & cat54==8 | beginning==cat13_start & cat55==8 | beginning==cat13_start & cat56==8 | beginning==cat13_start & cat57==8 | beginning==cat13_start & cat58==8 | beginning==cat13_start & cat59==8 | beginning==cat13_start & cat60==8 | beginning==cat13_start & cat61==8 | beginning==cat13_start & cat62==8 | beginning==cat13_start & cat63==8 | beginning==cat13_start & cat64==8 | beginning==cat13_start & cat65==8 | beginning==cat13_start & cat66==8 | beginning==cat13_start & cat67==8 | beginning==cat13_start & cat68==8 | beginning==cat13_start & cat69==8 | beginning==cat13_start & cat70==8 | beginning==cat13_start & cat71==8 | beginning==cat13_start & cat72==8 | beginning==cat13_start & cat73==8 | beginning==cat13_start & cat74==8 | beginning==cat13_start & cat75==8 | beginning==cat13_start & cat76==8 | beginning==cat13_start & cat77==8 | beginning==cat13_start & cat78==8 | beginning==cat13_start & cat79==8 | beginning==cat13_start & cat80==8 | beginning==cat13_start & cat81==8 | beginning==cat13_start & cat82==8 | beginning==cat13_start & cat83==8 | beginning==cat13_start & cat84==8 | beginning==cat13_start & cat85==8 | beginning==cat13_start & cat86==8 | beginning==cat13_start & cat87==8 | beginning==cat13_start & cat88==8
replace indicator=0 if beginning==cat13_start & indicator==.
replace indicator=1 if beginning==cat14_start & cat15==8 | beginning==cat14_start & cat16==8 | beginning==cat14_start & cat17==8 | beginning==cat14_start & cat18==8 | beginning==cat14_start & cat19==8 | beginning==cat14_start & cat20==8 | beginning==cat14_start & cat21==8 | beginning==cat14_start & cat22==8 | beginning==cat14_start & cat23==8 | beginning==cat14_start & cat24==8 | beginning==cat14_start & cat25==8 | beginning==cat14_start & cat26==8 | beginning==cat14_start & cat27==8 | beginning==cat14_start & cat28==8 | beginning==cat14_start & cat29==8 | beginning==cat14_start & cat30==8 | beginning==cat14_start & cat31==8 | beginning==cat14_start & cat32==8 | beginning==cat14_start & cat33==8 | beginning==cat14_start & cat34==8 | beginning==cat14_start & cat35==8 | beginning==cat14_start & cat36==8 | beginning==cat14_start & cat37==8 | beginning==cat14_start & cat38==8 | beginning==cat14_start & cat39==8 | beginning==cat14_start & cat40==8 | beginning==cat14_start & cat41==8 | beginning==cat14_start & cat42==8 | beginning==cat14_start & cat43==8 | beginning==cat14_start & cat44==8 | beginning==cat14_start & cat45==8 | beginning==cat14_start & cat46==8 | beginning==cat14_start & cat47==8 | beginning==cat14_start & cat48==8 | beginning==cat14_start & cat49==8 | beginning==cat14_start & cat50==8 | beginning==cat14_start & cat51==8 | beginning==cat14_start & cat52==8 | beginning==cat14_start & cat53==8 | beginning==cat14_start & cat54==8 | beginning==cat14_start & cat55==8 | beginning==cat14_start & cat56==8 | beginning==cat14_start & cat57==8 | beginning==cat14_start & cat58==8 | beginning==cat14_start & cat59==8 | beginning==cat14_start & cat60==8 | beginning==cat14_start & cat61==8 | beginning==cat14_start & cat62==8 | beginning==cat14_start & cat63==8 | beginning==cat14_start & cat64==8 | beginning==cat14_start & cat65==8 | beginning==cat14_start & cat66==8 | beginning==cat14_start & cat67==8 | beginning==cat14_start & cat68==8 | beginning==cat14_start & cat69==8 | beginning==cat14_start & cat70==8 | beginning==cat14_start & cat71==8 | beginning==cat14_start & cat72==8 | beginning==cat14_start & cat73==8 | beginning==cat14_start & cat74==8 | beginning==cat14_start & cat75==8 | beginning==cat14_start & cat76==8 | beginning==cat14_start & cat77==8 | beginning==cat14_start & cat78==8 | beginning==cat14_start & cat79==8 | beginning==cat14_start & cat80==8 | beginning==cat14_start & cat81==8 | beginning==cat14_start & cat82==8 | beginning==cat14_start & cat83==8 | beginning==cat14_start & cat84==8 | beginning==cat14_start & cat85==8 | beginning==cat14_start & cat86==8 | beginning==cat14_start & cat87==8 | beginning==cat14_start & cat88==8
replace indicator=0 if beginning==cat14_start & indicator==.
replace indicator=0 if beginning==cat15_start & cat16==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==.
replace indicator=1 if beginning==cat15_start & cat16==8
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat16_start & cat17==.
replace indicator=1 if beginning==cat16_start & cat17==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18==.
replace indicator=1 if beginning==cat17_start & cat18==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20==.
replace indicator=0 if beginning==cat18_start & cat19==.
replace indicator=1 if beginning==cat18_start & cat19==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21==.
replace indicator=1 if beginning==cat19_start & cat20==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==.
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat21_start & cat22==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=0 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat22_start & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30!=8 & cat31==.
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26==.
replace indicator=0 if beginning==cat24_start & cat25==.
replace indicator=0 if beginning==cat39_start & cat73!=8 & cat74==.
replace indicator=1 if beginning==cat48_start & cat49==8
replace indicator=1 if beginning==cat50_start & cat51==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27==.
replace indicator=0 if beginning==cat26_start & cat27!=8 & cat28!=8 & cat29==.
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22==.
replace indicator=1 if beginning==cat25_start & cat26==8
replace indicator=0 if beginning==cat27_start & cat28!=8 & cat29!=8 & cat30!=8 & cat31!=8 & cat32!=8 & cat33!=8 & cat34!=8 & cat35!=8 & cat36!=8 & cat37!=8 & cat38!=8 & cat39==.
replace indicator=0 if beginning==cat28_start & cat29!=8 & cat30==.
replace indicator=1 if beginning==cat18_start & cat19!=8 & cat20==8
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==.
replace indicator=0 if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23==.
replace indicator=1 if beginning==cat21_start & cat22==8
replace indicator=1 if beginning==cat21_start & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat46_start & cat47!=8 & cat48!=8 & cat49!=8 & cat50!=8 & cat51!=8 & cat52==.
replace indicator=0 if beginning==cat36_start & cat37!=8 & cat38!=8 & cat39!=8 & cat40!=8 & cat41!=8 & cat42!=8 & cat43!=8 & cat44!=8 & cat45!=8 & cat46!=8 & cat47!=8 & cat48!=8 & cat49==.
replace indicator=0 if beginning==cat24_start & cat25!=8 & cat26!=8 & cat27!=8 & cat28==.
replace indicator=0 if beginning==cat53_start & cat54==.
replace indicator=0 if beginning==cat34_start & cat35!=8 & cat36!=8 & cat37!=8 & cat38==.
replace indicator=1 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace indicator=0 if beginning==cat52_start & cat53!=8 & cat54!=8 & cat55!=8 & cat56!=8 & cat57!=8 & cat58==.
replace indicator=1 if beginning==cat27_start & cat28==8
replace indicator=0 if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26==.
replace indicator=1 if beginning==cat20_start & cat21==8
replace indicator=1 if beginning==cat23_start & cat24==8
replace indicator=0 if beginning==cat23_start & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29==.
replace indicator=1 if beginning==cat29_start & cat30==8
replace indicator=1 if beginning==cat22_start & cat23==8
replace indicator=1 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==.
replace indicator=0 if beginning==cat18_start & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace indicator=1 if beginning==cat31_start & cat32==8
replace indicator=0 if beginning==cat17_start & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25!=8 & cat26!=8 & cat27!=8 & cat28!=8 & cat29!=8 & cat30==.
replace indicator=0 if beginning==cat33_start & cat34==.
replace indicator=1 if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace indicator=0 if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24!=8 & cat25==.
replace indicator=1 if beginning==cat19_start & cat20!=8 & cat21==8
replace indicator=1 if beginning==cat24_start & cat25==8
replace indicator=0 if beginning==cat25_start & cat26!=8 & cat27!=8 & cat28!=8 & cat29==.
tab indicator,m
* Drop individuals that are not in the risk set
drop if indicator==0
drop indicator

* Construct the 'beginning' variable
gen beginning2 = .
replace beginning2 = cat3_start if beginning==cat2_start & cat3==8
order folio_n20 beginning beginning2
replace beginning2 = cat4_start if beginning==cat2_start & cat3!=8 & cat4==8
replace beginning2 = cat5_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat2_start & cat3!=8 & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat4_start if beginning==cat3_start & cat4==8
replace beginning2 = cat5_start if beginning==cat3_start & cat4!=8 & cat5==8
replace beginning2 = cat6_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat3_start & cat4!=8 & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat5_start if beginning==cat4_start & cat5==8
replace beginning2 = cat6_start if beginning==cat4_start & cat5!=8 & cat6==8
replace beginning2 = cat7_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat4_start & cat5!=8 & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat6_start if beginning==cat5_start & cat6==8
replace beginning2 = cat7_start if beginning==cat5_start & cat6!=8 & cat7==8
replace beginning2 = cat8_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat5_start & cat6!=8 & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat7_start if beginning==cat6_start & cat7==8
replace beginning2 = cat8_start if beginning==cat6_start & cat7!=8 & cat8==8
replace beginning2 = cat9_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat17_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat23_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23==8
replace beginning2 = cat24_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat8_start if beginning==cat7_start & cat8==8
replace beginning2 = cat9_start if beginning==cat7_start & cat8!=8 & cat9==8
replace beginning2 = cat10_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat15_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat9_start if beginning==cat8_start & cat9==8
replace beginning2 = cat10_start if beginning==cat8_start & cat9!=8 & cat10==8
replace beginning2 = cat11_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat10_start if beginning==cat9_start & cat10==8
replace beginning2 = cat11_start if beginning==cat9_start & cat10!=8 & cat11==8
replace beginning2 = cat12_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat16_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat17_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat11_start if beginning==cat10_start & cat11==8
replace beginning2 = cat12_start if beginning==cat10_start & cat11!=8 & cat12==8
replace beginning2 = cat13_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat17_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat12_start if beginning==cat11_start & cat12==8
replace beginning2 = cat13_start if beginning==cat11_start & cat12!=8 & cat13==8
replace beginning2 = cat14_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat19_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat13_start if beginning==cat12_start & cat13==8
replace beginning2 = cat14_start if beginning==cat12_start & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat14_start if beginning==cat13_start & cat14==8
replace beginning2 = cat15_start if beginning==cat13_start & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat18_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat15_start if beginning==cat14_start & cat15==8
replace beginning2 = cat16_start if beginning==cat14_start & cat15!=8 & cat16==8
replace beginning2 = cat16_start if beginning==cat15_start & cat16==8
replace beginning2 = cat17_start if beginning==cat15_start & cat16!=8 & cat17==8
replace beginning2 = cat17_start if beginning==cat16_start & cat17==8
replace beginning2 = cat18_start if beginning==cat17_start & cat18==8
replace beginning2 = cat19_start if beginning==cat18_start & cat19==8
replace beginning2 = cat20_start if beginning==cat19_start & cat20==8
replace beginning2 = cat25_start if beginning==cat20_start & cat21!=8 & cat22!=8 & cat23!=2 & cat24!=2 & cat25==2
replace beginning2 = cat35_start if beginning==cat32_start & cat33!=8 & cat34!=8 & cat35==8
replace beginning2 = cat17_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat16_start & cat17!=8 & cat18==8
replace beginning2 = cat19_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat21_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8
replace beginning2 = cat24_start if beginning==cat16_start & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat19_start if beginning==cat17_start & cat18!=8 & cat19==8
replace beginning2 = cat20_start if beginning==cat18_start & cat19!=8 & cat20==8
replace beginning2 = cat21_start if beginning==cat19_start & cat20!=8 & cat21==8
replace beginning2 = cat22_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22==8
replace beginning2 = cat22_start if beginning==cat21_start & cat22==8
replace beginning2 = cat18_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat14_start if beginning==cat6_start & cat7!=8 & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat15_start if beginning==cat9_start & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat15_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15==8
replace beginning2 = cat16_start if beginning==cat8_start & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat14_start if beginning==cat7_start & cat8!=8 & cat9!=8 & cat10!=8 & cat11!=8 & cat12!=8 & cat13!=8 & cat14==8
replace beginning2 = cat25_start if beginning==cat24_start & cat25==8
replace beginning2 = cat16_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16==8
replace beginning2 = cat24_start if beginning==cat23_start & cat24==8
replace beginning2 = cat20_start if beginning==cat10_start & cat11!=8 & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat23_start if beginning==cat21_start & cat22!=8 & cat23==8
replace beginning2 = cat19_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19==8
replace beginning2 = cat17_start if beginning==cat13_start & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat21_start if beginning==cat20_start & cat21==8
replace beginning2 = cat30_start if beginning==cat29_start & cat30==8
replace beginning2 = cat23_start if beginning==cat22_start & cat23==8
replace beginning2 = cat17_start if beginning==cat12_start & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17==8
replace beginning2 = cat24_start if beginning==cat19_start & cat20!=8 & cat21!=8 & cat22!=8 & cat23!=8 & cat24==8
replace beginning2 = cat26_start if beginning==cat25_start & cat26==8
replace beginning2 = cat20_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat32_start if beginning==cat31_start & cat32==8
replace beginning2 = cat20_start if beginning==cat11_start & cat12!=8 & cat13!=8 & cat14!=8 & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20==8
replace beginning2 = cat18_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat18_start if beginning==cat15_start & cat16!=8 & cat17!=8 & cat18==8
replace beginning2 = cat21_start if beginning==cat14_start & cat15!=8 & cat16!=8 & cat17!=8 & cat18!=8 & cat19!=8 & cat20!=8 & cat21==8

* Make sure that there are no missings
tab beginning2,m
drop beginning
rename beginning2 beginning

* Re-order variables
order folio_n20 beginning

* Make sure that all the statuses correspond to RC informal
forvalues i=1/88 {
tab cat`i' if beginning==cat`i'_start
}

* Construct the 'event' variable
* event: 1 NRC formal, 2 RC formal, 3 RM formal, 4 NRM formal, 5 unemp, 6 inactive, 7 NRC informal, 8 RM informal, 9 NRM informal
gen event = .
replace event=1 if beginning==cat3_start & cat4==1
order event,after(folio_n20)
replace event=2 if beginning==cat3_start & cat4==2
replace event=3 if beginning==cat3_start & cat4==3
replace event=4 if beginning==cat3_start & cat4==4
replace event=5 if beginning==cat3_start & cat4==5
replace event=6 if beginning==cat3_start & cat4==6
replace event=7 if beginning==cat3_start & cat4==7
replace event=8 if beginning==cat3_start & cat4==9
replace event=9 if beginning==cat3_start & cat4==10
replace event=0 if beginning==cat3_start & cat4==.
replace event=1 if beginning==cat4_start & cat5==1
replace event=2 if beginning==cat4_start & cat5==2
replace event=3 if beginning==cat4_start & cat5==3
replace event=4 if beginning==cat4_start & cat5==4
replace event=5 if beginning==cat4_start & cat5==5
replace event=6 if beginning==cat4_start & cat5==6
replace event=7 if beginning==cat4_start & cat5==7
replace event=8 if beginning==cat4_start & cat5==9
replace event=9 if beginning==cat4_start & cat5==10
replace event=0 if beginning==cat4_start & cat5==.
replace event=1 if beginning==cat5_start & cat6==1
replace event=2 if beginning==cat5_start & cat6==2
replace event=3 if beginning==cat5_start & cat6==3
replace event=4 if beginning==cat5_start & cat6==4
replace event=5 if beginning==cat5_start & cat6==5
replace event=6 if beginning==cat5_start & cat6==6
replace event=7 if beginning==cat5_start & cat6==7
replace event=8 if beginning==cat5_start & cat6==9
replace event=9 if beginning==cat5_start & cat6==10
replace event=0 if beginning==cat5_start & cat6==.
replace event=1 if beginning==cat6_start & cat7==1
replace event=2 if beginning==cat6_start & cat7==2
replace event=3 if beginning==cat6_start & cat7==3
replace event=4 if beginning==cat6_start & cat7==4
replace event=5 if beginning==cat6_start & cat7==5
replace event=6 if beginning==cat6_start & cat7==6
replace event=7 if beginning==cat6_start & cat7==7
replace event=8 if beginning==cat6_start & cat7==9
replace event=9 if beginning==cat6_start & cat7==10
replace event=0 if beginning==cat6_start & cat7==.
replace event=1 if beginning==cat7_start & cat8==1
replace event=2 if beginning==cat7_start & cat8==2
replace event=3 if beginning==cat7_start & cat8==3
replace event=4 if beginning==cat7_start & cat8==4
replace event=5 if beginning==cat7_start & cat8==5
replace event=6 if beginning==cat7_start & cat8==6
replace event=7 if beginning==cat7_start & cat8==7
replace event=8 if beginning==cat7_start & cat8==9
replace event=9 if beginning==cat7_start & cat8==10
replace event=0 if beginning==cat7_start & cat8==.
replace event=1 if beginning==cat8_start & cat9==1
replace event=2 if beginning==cat8_start & cat9==2
replace event=3 if beginning==cat8_start & cat9==3
replace event=4 if beginning==cat8_start & cat9==4
replace event=5 if beginning==cat8_start & cat9==5
replace event=6 if beginning==cat8_start & cat9==6
replace event=7 if beginning==cat8_start & cat9==7
replace event=8 if beginning==cat8_start & cat9==9
replace event=9 if beginning==cat8_start & cat9==10
replace event=0 if beginning==cat8_start & cat9==.
replace event=1 if beginning==cat9_start & cat10==1
replace event=2 if beginning==cat9_start & cat10==2
replace event=3 if beginning==cat9_start & cat10==3
replace event=4 if beginning==cat9_start & cat10==4
replace event=5 if beginning==cat9_start & cat10==5
replace event=6 if beginning==cat9_start & cat10==6
replace event=7 if beginning==cat9_start & cat10==7
replace event=8 if beginning==cat9_start & cat10==9
replace event=9 if beginning==cat9_start & cat10==10
replace event=0 if beginning==cat9_start & cat10==.
replace event=1 if beginning==cat10_start & cat11==1
replace event=2 if beginning==cat10_start & cat11==2
replace event=3 if beginning==cat10_start & cat11==3
replace event=4 if beginning==cat10_start & cat11==4
replace event=5 if beginning==cat10_start & cat11==5
replace event=6 if beginning==cat10_start & cat11==6
replace event=7 if beginning==cat10_start & cat11==7
replace event=8 if beginning==cat10_start & cat11==9
replace event=9 if beginning==cat10_start & cat11==10
replace event=0 if beginning==cat10_start & cat11==.
replace event=1 if beginning==cat11_start & cat12==1
replace event=2 if beginning==cat11_start & cat12==2
replace event=3 if beginning==cat11_start & cat12==3
replace event=4 if beginning==cat11_start & cat12==4
replace event=5 if beginning==cat11_start & cat12==5
replace event=6 if beginning==cat11_start & cat12==6
replace event=7 if beginning==cat11_start & cat12==7
replace event=8 if beginning==cat11_start & cat12==9
replace event=9 if beginning==cat11_start & cat12==10
replace event=0 if beginning==cat11_start & cat12==.
replace event=1 if beginning==cat12_start & cat13==1
replace event=2 if beginning==cat12_start & cat13==2
replace event=3 if beginning==cat12_start & cat13==3
replace event=4 if beginning==cat12_start & cat13==4
replace event=5 if beginning==cat12_start & cat13==5
replace event=6 if beginning==cat12_start & cat13==6
replace event=7 if beginning==cat12_start & cat13==7
replace event=8 if beginning==cat12_start & cat13==9
replace event=9 if beginning==cat12_start & cat13==10
replace event=0 if beginning==cat12_start & cat13==.
replace event=1 if beginning==cat13_start & cat14==1
replace event=2 if beginning==cat13_start & cat14==2
replace event=3 if beginning==cat13_start & cat14==3
replace event=4 if beginning==cat13_start & cat14==4
replace event=5 if beginning==cat13_start & cat14==5
replace event=6 if beginning==cat13_start & cat14==6
replace event=7 if beginning==cat13_start & cat14==7
replace event=8 if beginning==cat13_start & cat14==9
replace event=9 if beginning==cat13_start & cat14==10
replace event=0 if beginning==cat13_start & cat14==.
replace event=1 if beginning==cat14_start & cat15==1
replace event=2 if beginning==cat14_start & cat15==2
replace event=3 if beginning==cat14_start & cat15==3
replace event=4 if beginning==cat14_start & cat15==4
replace event=5 if beginning==cat14_start & cat15==5
replace event=6 if beginning==cat14_start & cat15==6
replace event=7 if beginning==cat14_start & cat15==7
replace event=8 if beginning==cat14_start & cat15==9
replace event=9 if beginning==cat14_start & cat15==10
replace event=0 if beginning==cat14_start & cat15==.
replace event=1 if beginning==cat15_start & cat16==1
replace event=2 if beginning==cat15_start & cat16==2
replace event=3 if beginning==cat15_start & cat16==3
replace event=4 if beginning==cat15_start & cat16==4
replace event=5 if beginning==cat15_start & cat16==5
replace event=6 if beginning==cat15_start & cat16==6
replace event=7 if beginning==cat15_start & cat16==7
replace event=8 if beginning==cat15_start & cat16==9
replace event=9 if beginning==cat15_start & cat16==10
replace event=0 if beginning==cat15_start & cat16==.
replace event=1 if beginning==cat16_start & cat17==1
replace event=2 if beginning==cat16_start & cat17==2
replace event=3 if beginning==cat16_start & cat17==3
replace event=4 if beginning==cat16_start & cat17==4
replace event=5 if beginning==cat16_start & cat17==5
replace event=6 if beginning==cat16_start & cat17==6
replace event=7 if beginning==cat16_start & cat17==7
replace event=8 if beginning==cat16_start & cat17==9
replace event=9 if beginning==cat16_start & cat17==10
replace event=0 if beginning==cat16_start & cat17==.
replace event=1 if beginning==cat17_start & cat18==1
replace event=2 if beginning==cat17_start & cat18==2
replace event=3 if beginning==cat17_start & cat18==3
replace event=4 if beginning==cat17_start & cat18==4
replace event=5 if beginning==cat17_start & cat18==5
replace event=6 if beginning==cat17_start & cat18==6
replace event=7 if beginning==cat17_start & cat18==7
replace event=8 if beginning==cat17_start & cat18==9
replace event=9 if beginning==cat17_start & cat18==10
replace event=0 if beginning==cat17_start & cat18==.
replace event=1 if beginning==cat18_start & cat19==1
replace event=2 if beginning==cat18_start & cat19==2
replace event=3 if beginning==cat18_start & cat19==3
replace event=4 if beginning==cat18_start & cat19==4
replace event=5 if beginning==cat18_start & cat19==5
replace event=6 if beginning==cat18_start & cat19==6
replace event=7 if beginning==cat18_start & cat19==7
replace event=8 if beginning==cat18_start & cat19==9
replace event=9 if beginning==cat18_start & cat19==10
replace event=0 if beginning==cat18_start & cat19==.
replace event=1 if beginning==cat19_start & cat20==1
replace event=2 if beginning==cat19_start & cat20==2
replace event=3 if beginning==cat19_start & cat20==3
replace event=4 if beginning==cat19_start & cat20==4
replace event=5 if beginning==cat19_start & cat20==5
replace event=6 if beginning==cat19_start & cat20==6
replace event=7 if beginning==cat19_start & cat20==7
replace event=8 if beginning==cat19_start & cat20==9
replace event=9 if beginning==cat19_start & cat20==10
replace event=0 if beginning==cat19_start & cat20==.
replace event=1 if beginning==cat20_start & cat21==1
replace event=2 if beginning==cat20_start & cat21==2
replace event=3 if beginning==cat20_start & cat21==3
replace event=4 if beginning==cat20_start & cat21==4
replace event=5 if beginning==cat20_start & cat21==5
replace event=6 if beginning==cat20_start & cat21==6
replace event=7 if beginning==cat20_start & cat21==7
replace event=8 if beginning==cat20_start & cat21==9
replace event=9 if beginning==cat20_start & cat21==10
replace event=0 if beginning==cat20_start & cat21==.
replace event=1 if beginning==cat21_start & cat22==1
replace event=2 if beginning==cat21_start & cat22==2
replace event=3 if beginning==cat21_start & cat22==3
replace event=4 if beginning==cat21_start & cat22==4
replace event=5 if beginning==cat21_start & cat22==5
replace event=6 if beginning==cat21_start & cat22==6
replace event=7 if beginning==cat21_start & cat22==7
replace event=8 if beginning==cat21_start & cat22==9
replace event=9 if beginning==cat21_start & cat22==10
replace event=0 if beginning==cat21_start & cat22==.
replace event=1 if beginning==cat22_start & cat23==1
replace event=2 if beginning==cat22_start & cat23==2
replace event=3 if beginning==cat22_start & cat23==3
replace event=4 if beginning==cat22_start & cat23==4
replace event=5 if beginning==cat22_start & cat23==5
replace event=6 if beginning==cat22_start & cat23==6
replace event=7 if beginning==cat22_start & cat23==7
replace event=8 if beginning==cat22_start & cat23==9
replace event=9 if beginning==cat22_start & cat23==10
replace event=0 if beginning==cat22_start & cat23==.
replace event=1 if beginning==cat23_start & cat24==1
replace event=2 if beginning==cat23_start & cat24==2
replace event=3 if beginning==cat23_start & cat24==3
replace event=4 if beginning==cat23_start & cat24==4
replace event=5 if beginning==cat23_start & cat24==5
replace event=6 if beginning==cat23_start & cat24==6
replace event=7 if beginning==cat23_start & cat24==7
replace event=8 if beginning==cat23_start & cat24==9
replace event=9 if beginning==cat23_start & cat24==10
replace event=0 if beginning==cat23_start & cat24==.
replace event=1 if beginning==cat24_start & cat25==1
replace event=2 if beginning==cat24_start & cat25==2
replace event=3 if beginning==cat24_start & cat25==3
replace event=4 if beginning==cat24_start & cat25==4
replace event=5 if beginning==cat24_start & cat25==5
replace event=6 if beginning==cat24_start & cat25==6
replace event=7 if beginning==cat24_start & cat25==7
replace event=8 if beginning==cat24_start & cat25==9
replace event=9 if beginning==cat24_start & cat25==10
replace event=0 if beginning==cat24_start & cat25==.
replace event=1 if beginning==cat25_start & cat26==1
replace event=2 if beginning==cat25_start & cat26==2
replace event=3 if beginning==cat25_start & cat26==3
replace event=4 if beginning==cat25_start & cat26==4
replace event=5 if beginning==cat25_start & cat26==5
replace event=6 if beginning==cat25_start & cat26==6
replace event=7 if beginning==cat25_start & cat26==7
replace event=8 if beginning==cat25_start & cat26==9
replace event=9 if beginning==cat25_start & cat26==10
replace event=0 if beginning==cat25_start & cat26==.
replace event=0 if beginning==cat33_start & cat34==.
replace event=0 if beginning==cat44_start & cat45==.
replace event=4 if beginning==cat31_start & cat32==4
replace event=9 if beginning==cat38_start & cat39==10
replace event=0 if beginning==cat29_start & cat30==.
replace event=3 if beginning==cat48_start & cat49==3
replace event=4 if beginning==cat26_start & cat27==4
replace event=6 if beginning==cat27_start & cat28==6
replace event=5 if beginning==cat35_start & cat36==5
replace event=9 if beginning==cat30_start & cat31==10
replace event=6 if beginning==cat26_start & cat27==6
replace event=2 if beginning==cat32_start & cat33==2

* Make sure that there are no missings
tab event,m

* Construct the 'duration' variable
gen duration = end - beginning if event == 0
order event duration,after(end)
replace duration = cat2_start - beginning if beginning==cat1_start & cat2!=8 & cat2!=.
replace duration = cat3_start - beginning if beginning==cat2_start & cat3!=8 & cat3!=.
replace duration = cat4_start - beginning if beginning==cat3_start & cat4!=8 & cat4!=.
replace duration = cat5_start - beginning if beginning==cat4_start & cat5!=8 & cat5!=.
replace duration = cat6_start - beginning if beginning==cat5_start & cat6!=8 & cat6!=.
replace duration = cat7_start - beginning if beginning==cat6_start & cat7!=8 & cat7!=.
replace duration = cat8_start - beginning if beginning==cat7_start & cat8!=8 & cat8!=.
replace duration = cat9_start - beginning if beginning==cat8_start & cat9!=8 & cat9!=.
replace duration = cat10_start - beginning if beginning==cat9_start & cat10!=8 & cat10!=.
replace duration = cat11_start - beginning if beginning==cat10_start & cat11!=8 & cat11!=.
replace duration = cat12_start - beginning if beginning==cat11_start & cat12!=8 & cat12!=.
replace duration = cat13_start - beginning if beginning==cat12_start & cat13!=8 & cat13!=.
replace duration = cat14_start - beginning if beginning==cat13_start & cat14!=8 & cat14!=.
replace duration = cat15_start - beginning if beginning==cat14_start & cat15!=8 & cat15!=.
replace duration = cat16_start - beginning if beginning==cat15_start & cat16!=8 & cat16!=.
replace duration = cat17_start - beginning if beginning==cat16_start & cat17!=8 & cat17!=.
replace duration = cat18_start - beginning if beginning==cat17_start & cat18!=8 & cat18!=.
replace duration = cat19_start - beginning if beginning==cat18_start & cat19!=8 & cat19!=.
replace duration = cat20_start - beginning if beginning==cat19_start & cat20!=8 & cat20!=.
replace duration = cat21_start - beginning if beginning==cat20_start & cat21!=8 & cat21!=.
replace duration = cat22_start - beginning if beginning==cat21_start & cat22!=8 & cat22!=.
replace duration = cat23_start - beginning if beginning==cat22_start & cat23!=8 & cat23!=.
replace duration = cat24_start - beginning if beginning==cat23_start & cat24!=8 & cat24!=.
replace duration = cat25_start - beginning if beginning==cat24_start & cat25!=8 & cat25!=.
replace duration = cat26_start - beginning if beginning==cat25_start & cat26!=8 & cat26!=.
replace duration = cat27_start - beginning if beginning==cat26_start & cat27!=8 & cat27!=.
replace duration = cat28_start - beginning if beginning==cat27_start & cat28!=8 & cat28!=.
replace duration = cat29_start - beginning if beginning==cat28_start & cat29!=8 & cat29!=.
replace duration = cat31_start - beginning if beginning==cat30_start & cat31!=8 & cat31!=.
replace duration = cat32_start - beginning if beginning==cat31_start & cat32!=8 & cat32!=.
replace duration = cat33_start - beginning if beginning==cat32_start & cat33!=8 & cat33!=.
replace duration = cat34_start - beginning if beginning==cat33_start & cat34!=8 & cat34!=.
replace duration = cat36_start - beginning if beginning==cat35_start & cat36!=8 & cat36!=.
replace duration = cat38_start - beginning if beginning==cat37_start & cat38!=8 & cat38!=.
replace duration = cat39_start - beginning if beginning==cat38_start & cat39!=8 & cat39!=.
replace duration = cat46_start - beginning if beginning==cat45_start & cat46!=8 & cat46!=.
replace duration = cat48_start - beginning if beginning==cat47_start & cat48!=8 & cat48!=.
replace duration = cat49_start - beginning if beginning==cat48_start & cat49!=8 & cat49!=.
replace duration = cat50_start - beginning if beginning==cat49_start & cat50!=8 & cat50!=.
replace duration = cat52_start - beginning if beginning==cat51_start & cat52!=8 & cat52!=.

* Make sure that there are no missings
tab duration,m

save "$resultdir\sample_RC9_informal", replace

gen type = event 

/*
recode type 1=1 2=2 3=3 4=4 5=5 6=6 7=6 8=6 9=6
*/

replace event = 1 if inrange(event, 1, 9)

* stset the data
stset duration, failure(event==1) id(folio_n20)
order folio_n20 _t0 _t _d _st event duration

sort folio_n20 _t0
gen order =9

* Define the education variable
gen education=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit educ_time_varying, at(0) after(time=cat2_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling1 if educ_time_varying==0
replace education = schooling2 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit educ_time_varying, at(0) after(time=cat3_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling3 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit educ_time_varying, at(0) after(time=cat4_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling4 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit educ_time_varying, at(0) after(time=cat5_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling5 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit educ_time_varying, at(0) after(time=cat6_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling6 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit educ_time_varying, at(0) after(time=cat7_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling7 if educ_time_varying==1
drop educ_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit educ_time_varying, at(0) after(time=cat8_start - cat1_start)
replace educ_time_varying=educ_time_varying+1
replace education = schooling8 if educ_time_varying==1
drop educ_time_varying

replace education=schooling2 if beginning==cat2_start & education==.
replace education=schooling5 if beginning==cat5_start & education==.
replace education=schooling6 if beginning==cat6_start & education==.
replace education=schooling7 if beginning==cat7_start & education==.
replace education=schooling8 if beginning==cat8_start & education==.
replace education=schooling9 if beginning==cat9_start & education==.
replace education=schooling11 if beginning==cat11_start & education==.
replace education=schooling14 if beginning==cat14_start & education==.
tab education,m

* Time since in RC:
* Splitting 'time_since_RC' into periods
stsplit time_since_RC, at(0 12 36 60 120)
* Recoding 'time_since_RC' into categories
recode time_since_RC 0=1 12=2 36=3 60=4 120=5
label define time_since_RC 1 "0-1" 2 "1-3" 3 "3-5" 4 "5-10" 5 "10+"
label values time_since_RC time_since_RC

* Cleaning 'event' values
replace event = 0 if missing(event)

* Generating 'time_RC' based on the 'beginning' time period
gen time_RC = .
replace time_RC = 1 if inrange(beginning, 961, 1079)
replace time_RC = 2 if inrange(beginning, 1080, 1199)
replace time_RC = 3 if inrange(beginning, 1200, 1319)
replace time_RC = 4 if inrange(beginning, 1320, 1439)

* Labeling the time_RC categories
label define time_RC 1 "1980-1990" 2 "1990-2000" 3 "2000-2010" 4 "2010-2020"
label values time_RC time_RC

order time_since_RC time_RC, after(end)

* Move to competing risk framework
* keep folio_n20 _t0 _t _d _st event type duration order
*** the respondents were at risk of 6 types of events, 
* so each row needs to be replicated 6 times
* type represents the type of transition; type2 shows the number of rows

expand 9
/*
expand 6
*/

bysort folio_n20 _t0: gen type2 = _n

*** create new failure variable
gen fail = 0
replace fail = 1 if type == type2 & _d==1

drop type
rename type2 type

*** replace _d with the new event variable 'fail'
replace _d = fail
drop fail
order type,before(duration)
drop event

save "$resultdir\outcomes_RC9_informal", replace

* ---------------------------------------------------------------------------- *
* Append all transitions together
* ---------------------------------------------------------------------------- *

clear
use "$resultdir\outcomes_RC1_informal"
append using outcomes_RC2_informal
append using outcomes_RC3_informal
append using outcomes_RC4_informal
append using outcomes_RC5_informal
append using outcomes_RC6_informal
append using outcomes_RC7_informal
append using outcomes_RC8_informal
append using outcomes_RC9_informal
sort folio_n20 order _t0 type
order folio_n20 order
recode order 4=3 5=3 6=3 7=3 8=3 9=3
label define order 1 "1" 2 "2" 3 "3+"
label values order order

* Construct the age variable 
gen age=.
* split episodes at time of change	
replace cat2_start=99999 if cat2_start==.	
stsplit age_time_varying, at(0) after(time=cat2_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age1 if age_time_varying==0
replace age = age2 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat3_start=99999 if cat3_start==.	
stsplit age_time_varying, at(0) after(time=cat3_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age3 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat4_start=99999 if cat4_start==.	
stsplit age_time_varying, at(0) after(time=cat4_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age4 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat5_start=99999 if cat5_start==.	
stsplit age_time_varying, at(0) after(time=cat5_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age5 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat6_start=99999 if cat6_start==.	
stsplit age_time_varying, at(0) after(time=cat6_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age6 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat7_start=99999 if cat7_start==.	
stsplit age_time_varying, at(0) after(time=cat7_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age7 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat8_start=99999 if cat8_start==.	
stsplit age_time_varying, at(0) after(time=cat8_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age8 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat9_start=99999 if cat9_start==.	
stsplit age_time_varying, at(0) after(time=cat9_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age9 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat10_start=99999 if cat10_start==.	
stsplit age_time_varying, at(0) after(time=cat10_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age10 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat11_start=99999 if cat11_start==.	
stsplit age_time_varying, at(0) after(time=cat11_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age11 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat12_start=99999 if cat12_start==.	
stsplit age_time_varying, at(0) after(time=cat12_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age12 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat13_start=99999 if cat13_start==.	
stsplit age_time_varying, at(0) after(time=cat13_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age13 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat14_start=99999 if cat14_start==.	
stsplit age_time_varying, at(0) after(time=cat14_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age14 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat15_start=99999 if cat15_start==.	
stsplit age_time_varying, at(0) after(time=cat15_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age15 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat16_start=99999 if cat16_start==.	
stsplit age_time_varying, at(0) after(time=cat16_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age16 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat17_start=99999 if cat17_start==.	
stsplit age_time_varying, at(0) after(time=cat17_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age17 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat18_start=99999 if cat18_start==.	
stsplit age_time_varying, at(0) after(time=cat18_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age18 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat19_start=99999 if cat19_start==.	
stsplit age_time_varying, at(0) after(time=cat19_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age19 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat20_start=99999 if cat20_start==.	
stsplit age_time_varying, at(0) after(time=cat20_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age20 if age_time_varying==1
drop age_time_varying
* split episodes at time of change	
replace cat21_start=99999 if cat21_start==.	
stsplit age_time_varying, at(0) after(time=cat21_start - cat1_start)
replace age_time_varying=age_time_varying+1
replace age = age21 if age_time_varying==1
drop age_time_varying
* There are some missings
replace age=age1 if beginning==end & beginning==cat1_start
replace age=age2 if beginning==end & beginning==cat2_start
replace age=age3 if beginning==end & beginning==cat3_start
replace age=age4 if beginning==end & beginning==cat4_start
replace age=age5 if beginning==end & beginning==cat5_start
replace age=age6 if beginning==end & beginning==cat6_start
replace age=age7 if beginning==end & beginning==cat7_start
replace age=age8 if beginning==end & beginning==cat8_start
replace age=age9 if beginning==end & beginning==cat9_start
replace age=age10 if beginning==end & beginning==cat10_start
replace age=age11 if beginning==end & beginning==cat11_start
replace age=age12 if beginning==end & beginning==cat12_start
replace age=age13 if beginning==end & beginning==cat13_start
replace age=age14 if beginning==end & beginning==cat14_start
replace age=age15 if beginning==end & beginning==cat15_start
replace age=age17 if beginning==end & beginning==cat17_start
* Make sure that there are no missings
tab age,m

* Construct the age group variable based on age
gen agegroup = 1 if age > 14 & age < 19
replace agegroup = 2 if age > 18 & age < 25
replace agegroup = 3 if age > 24 & age < 30
replace agegroup = 4 if age > 29 & age < 35
replace agegroup = 5 if age > 34 & age < 40
replace agegroup = 6 if age > 39 & age < 45
replace agegroup = 7 if age > 44 & age < 50
replace agegroup = 8 if age > 49 & age < 55
replace agegroup = 9 if age > 54 & age < 60
replace agegroup = 10 if age > 59

label define agegroup 1 "15-19" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44" 7 "45-49" 8 "50-54" 9 "55-59" 10 "60+"
label values agegroup agegroup
tab agegroup,m

save "$resultdir\outcomes_RC_informal", replace

cd "$resultdir"
erase "sample_RC1_informal.dta"
erase "sample_RC2_informal.dta"
erase "sample_RC3_informal.dta"
erase "sample_RC4_informal.dta"
erase "sample_RC5_informal.dta"
erase "sample_RC6_informal.dta"
erase "sample_RC7_informal.dta"
erase "sample_RC8_informal.dta"
erase "sample_RC9_informal.dta"

erase "outcomes_RC1_informal.dta"
erase "outcomes_RC2_informal.dta"
erase "outcomes_RC3_informal.dta"
erase "outcomes_RC4_informal.dta"
erase "outcomes_RC5_informal.dta"
erase "outcomes_RC6_informal.dta"
erase "outcomes_RC7_informal.dta"
erase "outcomes_RC8_informal.dta"
erase "outcomes_RC9_informal.dta"

* ---------------------------------------------------------------------------- *
* End of RC Informal Outcomes Analysis do-file
* ---------------------------------------------------------------------------- *
