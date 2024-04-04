********* Systematic review meta-analys MI for PA ******************************
********* Overall effects ******************************************************
**** Total PA ******************************************************************
clear

use "all_data.dta"
keep if outcome =="Total PA"

sort study_id follow_up_time
bysort study_id: keep if _n==_N


metan smd se if outcome=="Total PA" , model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)
use forest,clear
label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) xscale(range(-2.0 4.0) noextend) favours(Favours control # Favours MI) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Supplementary_Figure_3.gph", replace


**** MVPA **********************************************************************
clear

use "all_data.dta"
keep if outcome =="MVPA"

sort study_id follow_up_time
bysort study_id: keep if _n==_N


metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)
use forest,clear
label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) xscale(range(-2.0 4.0) noextend) favours(Favours control # Favours MI) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_4.gph", replace

**** Sednetary time ************************************************************
clear

use "all_data.dta"
keep if outcome =="Sedentary"

sort study_id follow_up_time
bysort study_id: keep if _n==_N


metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)
use forest,clear
label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) xscale(range(-2.0 4.0) noextend) favours(Favours MI # Favours control) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_5.gph", replace

******************* Effects by comparator Type *********************************
********************************************************************************
*** Comparator interventions of similar intensity ******************************
********************************************************************************
**** Total PA ******************************************************************

clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if controltype=="similarly intensive intervention"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)

***** MVPA *********************************************************************

clear
use "all_data.dta"

keep if outcome =="MVPA"
keep if controltype=="similarly intensive intervention"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest2,replace)

clear
use "all_data.dta"

keep if outcome =="Sedentary"
keep if controltype=="similarly intensive intervention"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest3,replace)

use forest,clear
gen outcome ="Total PA"
append using forest2
replace outcome ="MVPA" if missing(outcome)
append using forest3
replace outcome ="Sedentary" if missing(outcome)

insobs 3
replace _USE = 0 in 15
replace _USE = 0 in 16
replace _USE = 0 in 17
replace _BY = 1 in 15
replace _BY = 2 in 16
replace _BY = 3 in 17
format %14.0g _BY
label define _BY 1 "Total PA" 2 "MVPA" 3 "Sedentary time"
label values _BY _BY

replace _LABELS = "{bf:Total PA}" in 15
replace _LABELS = "{bf:MVPA}" in 16
replace _LABELS = "{bf:Sedentary time}" in 17


label var _LABELS `"`"{bf:Outcome}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) xscale(range(-2.0 4.0) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_6.gph", replace

********************************************************************************
*** No or minimal intervention comparators *************************************
********************************************************************************
**** Total PA ******************************************************************

clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if controltyperegroup=="no or minimal intervention"


sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)

use forest,clear
label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) xscale(range(-2.0 4.0) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)


graph save Graph "Suplementary_Figure_7.gph", replace

***** MVPA *********************************************************************
clear

use "all_data.dta"

keep if outcome =="MVPA"
keep if controltyperegroup=="no or minimal intervention"


sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)

use forest,clear
label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) xscale(range(-2.0 4.0) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)


graph save Graph "Suplementary_Figure_8.gph", replace

***** Sedentary time ***********************************************************
clear

use "all_data.dta"

keep if outcome =="Sedentary"
keep if controltyperegroup=="no or minimal intervention"


sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)

use forest,clear
label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) xscale(range(-2.0 4.0) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)


graph save Graph "Suplementary_Figure_9.gph", replace

********************************************************************************
******** Less intensive (active interventions) *********************************
********************************************************************************
**** Total PA ******************************************************************

clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if controltyperegroup=="less intensive intervention"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))lcols(ntotal)) saving(forest,replace)

**** MVPA **********************************************************************

clear
use "all_data.dta"

keep if outcome =="MVPA"
keep if controltyperegroup=="less intensive intervention"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))lcols(ntotal)) saving(forest2,replace)

**** Sednetary time ************************************************************

clear
use "all_data.dta"

keep if outcome =="Sedentary"
keep if controltyperegroup=="less intensive intervention"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest3,replace)


****** Combine all three outcomes into one Forest plot *************************
use forest,clear
gen outcome ="Total PA"
append using forest2
replace outcome ="MVPA" if missing(outcome)
append using forest3
replace outcome ="Sedentary" if missing(outcome)

insobs 3

replace _USE = 0 if missing(_USE)
sort _USE
gen _BY=_n if _USE==0
format %14.0g _BY

label define _BY 1 "Total PA" 2 "MVPA" 3 "Sedentary time"
label values _BY _BY

replace _BY=1 if outcome=="Total PA"
replace _BY=2 if outcome=="MVPA"
replace _BY=3 if outcome=="Sedentary"


replace _LABELS = "{bf:Total PA}" if _BY==1 & _USE==0
replace _LABELS = "{bf:MVPA}" if _BY==2 & _USE==0
replace _LABELS = "{bf:Sedentary time}" if _BY==3 & _USE==0

sort _BY _USE

label var _LABELS `"`"{bf:Outcome}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-4.0 -3.0 -2.0 -1.0 0 1.0 2.0 3 4 5 6 7 8, format(%6.1f)) xscale(range(-4.0 8.0) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_10.gph", replace

********************************************************************************
******************** Device measured outcomes **********************************
************************ Total PA  *********************************************
clear


use "all_data.dta"
keep if outcome=="Total PA"
keep if measurement =="Objective measurement" 

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)

**** MVPA ***********
clear


use "all_data.dta"
keep if outcome=="MVPA"
keep if measurement =="Objective measurement" 

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest2,replace)

****** Sedentary time **********************************************************
clear


use "all_data.dta"
keep if outcome=="Sedentary"
keep if measurement =="Objective measurement" 

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest3,replace)


use forest,clear
gen outcome ="Total PA"
append using forest2
replace outcome ="MVPA" if missing(outcome)
append using forest3
replace outcome ="Sedentary" if missing(outcome)

use forest,clear
gen outcome ="Total PA"
append using forest2
replace outcome ="MVPA" if missing(outcome)
append using forest3
replace outcome ="Sedentary" if missing(outcome)

insobs 3

replace _USE = 0 if missing(_USE)
sort _USE
gen _BY=_n if _USE==0
format %14.0g _BY

label define _BY 1 "Total PA" 2 "MVPA" 3 "Sedentary time"
label values _BY _BY

replace _BY=1 if outcome=="Total PA"
replace _BY=2 if outcome=="MVPA"
replace _BY=3 if outcome=="Sedentary"


replace _LABELS = "{bf:Total PA}" if _BY==1 & _USE==0
replace _LABELS = "{bf:MVPA}" if _BY==2 & _USE==0
replace _LABELS = "{bf:Sedentary time}" if _BY==3 & _USE==0

sort _BY _USE

label var _LABELS `"`"{bf:Outcome}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-4.0 -2.0 0 2.0 4.0 6.0, format(%6.1f)) xscale(range(-4.0 6.0) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_11.gph", replace

********************************************************************************
****** Self-reported measured outcomes *****************************************
**** Total PA  *****************************************************************
clear


use "all_data.dta"
keep if outcome=="Total PA"
keep if measurement =="Subjective measurement" 

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest,replace)

use forest,clear
label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) xscale(range(-2.0 4.0) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_12.gph", replace

************ MVPA **************************************************************

clear

use "all_data.dta"
keep if outcome=="MVPA"
keep if measurement =="Subjective measurement" 

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest2,replace)

****** Sedentary time **********************************************************
clear


use "all_data.dta"
keep if outcome=="Sedentary"
keep if measurement =="Subjective measurement" 

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f))favours(Favours control # Favours MI) lcols(ntotal)) saving(forest3,replace)



**** Combine MVPA and Sedentary into same Forest plot **************************

use forest2, clear
gen outcome ="MVPA" 
append using forest3
replace outcome ="Sedentary" if missing(outcome)

insobs 2

replace _USE = 0 if missing(_USE)
sort _USE
gen _BY=_n if _USE==0
format %14.0g _BY

label define _BY 1 "MVPA" 2 "Sedentary time"
label values _BY _BY

replace _BY=1 if outcome=="MVPA"
replace _BY=2 if outcome=="Sedentary"


replace _LABELS = "{bf:MVPA}" if _BY==1 & _USE==0
replace _LABELS = "{bf:Sedentary time}" if _BY==2 & _USE==0


sort _BY _USE

label var _LABELS `"`"{bf:Outcome}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0
label var ntotal `"`"{bf:Participants}"'"'
label var _EFFECT `"{bf:SMD (95% CI)}"'
label var _WT `"`"{bf:Weight}"'"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) xlab(-4.0 -3.0 -2.0 -1.0 0 1.0 2.0 3.0, format(%6.1f)) xscale(range(-4.0 3.0) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_13.gph", replace

********************************************************************************
********************************************************************************
******** BY FOLLOW_UP TIME (LONGEST FOLLOW_UP WITHING FOLLOW_UP ****************
****** For Total PA outcomes ***************************************************
******** 0-3 months followup ***************************************************
clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if followup =="0-3 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_14.gph", replace

******** 4-6 months followup ***************************************************
clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if followup =="4-6 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_15.gph", replace

******** 7-12 months followup ***************************************************
clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if followup =="7-12 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_16.gph", replace
******** >1 year followup ***************************************************
clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if followup =="12+ months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_17.gph", replace

***** For MVPA outcomes ********************************************************
******** 0-3 months followup ***************************************************
clear

use "all_data.dta"

keep if outcome =="MVPA"
keep if followup =="0-3 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4 5 6 7, format(%6.1f)) xscale(range(-2 7) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_18.gph", replace

******** 4-6 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="MVPA"
keep if followup =="4-6 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4 5 6 7 8, format(%6.1f)) xscale(range(-2 8) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_19.gph", replace

******** 7-12 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="MVPA"
keep if followup =="7-12 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_20.gph", replace

******** >1 year followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="MVPA"
keep if followup =="12+ months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_21.gph", replace

***** For Sedentary time outcomes **********************************************
********************************************************************************

clear

use "all_data.dta"


keep if outcome =="Sedentary"
keep if followup =="0-3 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-5 -4 -3 -2.0 -1.0 0 1.0 2.0 3, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours MI # Favours comparator) xlab(-5 -4 -3 -2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 7) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_22.gph", replace


******** 4-6 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Sedentary"
keep if followup =="4-6 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours MI # Favours comparator) xlab(-6 -5 -4 -3 -2 -1 0 1 2 , format(%6.1f)) xscale(range(-6 2) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 
graph save Graph "Suplementary_Figure_23.gph", replace


******** 7-12 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Sedentary"
keep if followup =="7-12 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_24.gph", replace


******** >1 year followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Sedentary"
keep if followup =="12+ months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_25.gph", replace

********************************************************************************
******** BY FOLLOW_UP TIME *****************************************************
****** For Total PA outcomes ***************************************************
******** Interventions of 0-3 months duration **********************************

******** 0-3 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Total PA"
keep if interventionperiod =="0-3 months"

keep if followup =="0-3 months"



** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_26.gph", replace


******** 4-6 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Total PA"
keep if followup =="4-6 months"
keep if interventionperiod =="0-3 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_27.gph", replace


******** 7-12 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Total PA"
keep if followup =="7-12 months"
keep if interventionperiod =="0-3 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_28.gph", replace

******** >1 year followup ******************************************************
** No eligible studies *********************************************************

********************************************************************************
******** Interventions of 4-6 months duration **********************************
******** 4-6 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Total PA"
keep if followup =="4-6 months"
keep if interventionperiod =="4-6 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_29.gph", replace

******** 7-12 months followup ***************************************************
clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if followup =="7-12 months"
keep if interventionperiod =="4-6 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_30.gph", replace


******** >1 year followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Total PA"
keep if followup =="12+ months"
keep if interventionperiod =="4-6 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_31.gph", replace

******** Interventions of 7-12 months duration **********************************
******** 7-12 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Total PA"
keep if followup =="7-12 months"
keep if interventionperiod =="7-12 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_32.gph", replace


******** >1 year followup ***************************************************
clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if followup =="12+ months"
keep if interventionperiod =="7-12 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_33.gph", replace

******* Interventions of >1 year duration **********************************
******** >1 year followup ***************************************************
clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if followup =="12+ months"
keep if interventionperiod ==">12 months"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3, format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_34.gph", replace

********************************************************************************
****** For MVPA outcomes *******************************************************
******** Interventions of all duration *****************************************
** combined forest plot*********************************************************
******** 0-3 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="MVPA"


keep if followup =="0-3 months"

sort interventionperiod study_id

** keep longest follow-up for each interventions *******************************


metan smd se, by (interventionperiod) model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Intervention duration}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4 5 6 7, format(%6.1f)) xscale(range(-2 7) noextend) nooverall nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_35.gph", replace


******** 4-6 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="MVPA"


keep if followup =="4-6 months"

sort interventionperiod study_id

** keep longest follow-up for each interventions *******************************


metan smd se, by (interventionperiod) model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Intervention duration}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4 5 6 7, format(%6.1f)) xscale(range(-2 7) noextend) nooverall nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_36.gph", replace

******** 7-12 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="MVPA"


keep if followup =="7-12 months"

sort interventionperiod study_id

** keep longest follow-up for each interventions *******************************


metan smd se, by (interventionperiod) model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Intervention duration}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4 5 6 7, format(%6.1f)) xscale(range(-2 7) noextend) nooverall nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_37.gph", replace

******** >1 year followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="MVPA"


keep if followup =="12+ months"

sort interventionperiod study_id

** keep longest follow-up for each interventions *******************************


metan smd se, by (interventionperiod) model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Intervention duration}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4 5 6 7, format(%6.1f)) xscale(range(-2 7) noextend) nooverall nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_38.gph", replace

********************* SEDENTARY TIME *******************************************
********************* FOLLOW-UP 0-3 months *************************************
clear

use "all_data.dta"


keep if outcome =="Sedentary"


keep if followup =="0-3 months"

sort interventionperiod study_id

** keep longest follow-up for each interventions *******************************


metan smd se, by (interventionperiod) model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-5 -4 -3 -2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Intervention duration}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours MI # Favours control) xlab(-5 -4 -3 -2 -1 0 1 2 3 4 , format(%6.1f)) xscale(range(-5 4) noextend) nooverall nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_39.gph", replace


******** 4-6 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Sedentary"


keep if followup =="4-6 months"

sort interventionperiod study_id

** keep longest follow-up for each interventions *******************************


metan smd se, by (interventionperiod) model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Intervention duration}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours MI # Favours control) xlab(-6 -5 -4 -3 -2 -1 0 1 2 3 4 5, format(%6.1f)) xscale(range(-6 5) noextend) nooverall nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 
graph save Graph "Suplementary_Figure_40.gph", replace

******** 7-12 months followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Sedentary"


keep if followup =="7-12 months"

sort interventionperiod study_id

** keep longest follow-up for each interventions *******************************


metan smd se, by (interventionperiod) model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Intervention duration}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-3 -2 -1 0 1 2 3 , format(%6.1f)) xscale(range(-3 3) noextend) nooverall nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 
graph save Graph "Suplementary_Figure_41.gph", replace

******** >1 year followup ***************************************************
clear

use "all_data.dta"


keep if outcome =="Sedentary"


keep if followup =="12+ months"

sort interventionperiod study_id

** keep longest follow-up for each interventions *******************************


metan smd se, by (interventionperiod) model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `"`"{bf:Intervention duration}"' `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2, format(%6.1f)) xscale(range(-2 2) noextend) nooverall nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest)

graph save Graph "Suplementary_Figure_42.gph", replace

*******************************************************************************
******** By participant health status ******************************************
********************************************************************************

*******************Overall results by participant health status ****************
*** Disease/ health condition **************************************************
*** Total PA *******************************************************************

clear


use "all_data.dta"


keep if outcome =="Total PA"
keep if condition_yes =="with condition"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4, format(%6.1f)) xscale(range(-2 4) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

*** MVPA ****
clear


use "all_data.dta"
keep if outcome =="MVPA"
keep if condition_yes =="with condition"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest,replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4, format(%6.1f)) xscale(range(-2 4) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 
graph save Graph "Suplementary_Figure_44.gph", replace


*** Sedentary ***************************************
clear


use "all_data.dta"
keep if outcome =="Sedentary"
keep if condition_yes =="with condition"


sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving (forest,replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours MI # Favours control) xlab(-6 -5 -4 -3 -2 -1 0 1 2, format(%6.1f)) xscale(range(-6 2) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 
graph save Graph "Suplementary_Figure_45.gph", replace

********************************************************************************
** ****** healthy (not selected by disease) ************************************
********************************************************************************
*** Total PA********************************************************************

clear

use "all_data.dta"

keep if outcome =="Total PA"
keep if condition_yes =="healthy"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest, replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 , format(%6.1f)) xscale(range(-2 3) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 
graph save Graph "Suplementary_Figure_46.gph", replace


********************************** MVPA ****************************************
clear


use "all_data.dta"
keep if outcome =="MVPA"
keep if condition_yes =="healthy"

sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest,replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4 5 6 7 8, format(%6.1f)) xscale(range(-2 8) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_47.gph", replace


****************************** Sedentary ***************************************
clear


use "all_data.dta"
keep if outcome =="Sedentary"
keep if condition_yes =="healthy"


sort study_id follow_up_time
bysort study_id: keep if _n==_N

metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving (forest,replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours MI # Favours control) xlab(-2 -1 0 1 2 , format(%6.1f)) xscale(range(-2 2) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_48.gph", replace

********************************************************************************
********Sensitivity analysis excluding those at overall high risk of bias ******
********************************** Total PA ************************************
clear 

use "all_data.dta"


keep if outcome =="Total PA"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

drop if rob2=="H"


metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest,replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours MI # Favours control) xlab(-2 -1 0 1 2 3 4 5 , format(%6.1f)) xscale(range(-2 5) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 
graph save Graph "Suplementary_Figure_49.gph", replace


********************************* MVPA *****************************************
clear 

use "all_data.dta"


keep if outcome =="MVPA"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

drop if rob2=="H"


metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest,replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-2 -1 0 1 2 3 4 5 6 7 8 , format(%6.1f)) xscale(range(-2 8) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_50.gph", replace

****Sedentary ******************************************************************

clear 

use "all_data.dta"


keep if outcome =="Sedentary"

** keep longest follow-up for each interventions *******************************

sort study_id follow_up_time
bysort study_id: keep if _n==_N

drop if rob2=="H"


metan smd se, model(hksj) label (namevar= studyid) effect(SMD) nobox forestplot(xlab(-2.0 -1.0 0 1.0 2.0 3 4, format(%6.1f)) lcols(ntotal)) saving(forest,replace)

codebook study_no
sum ntotal
display r(sum)

use forest, clear

label var _LABELS `" `"{bf:Study}"'"'
replace _LABELS = `"{bf:"' + _LABELS + `"}"' if _USE==0

label var ntotal `"{bf:Participants}"'
label var _WT `"{bf:%Weight}"'
label var _EFFECT `"{bf:SMD (95% CI)}"'

forestplot   , use() labels() wgt() effect("Standardized Mean Difference") nohet lcols(ntotal) favours(Favours control # Favours MI) xlab(-6 -5 -4 -3 -2 -1 0 1 2 , format(%6.1f)) xscale(range(-6 2) noextend) nobox nostats nowt rcols(_EFFECT _WT) play(MI_forest) 

graph save Graph "Suplementary_Figure_51.gph", replace

********************************************************************************
******************************THE END ******************************************
********************************************************************************

