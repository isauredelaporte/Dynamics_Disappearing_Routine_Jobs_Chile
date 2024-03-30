
* ---------------------------------------------------------------------------- *
* Master do-file for "The Dynamics of Labour Market Polarization in Chile: An Analysis of the Link between Technical Change and Informality"
* Author: Isaure Delaporte & Werner Pena
* Clears workspace, sets global parameters, and defines file directories.
* ---------------------------------------------------------------------------- *

clear
set more off
set min_memory 8g

* ---------------------------------------------------------------------------- *
* User-specific settings
* ---------------------------------------------------------------------------- *
* Set the user identifier to switch between different users' paths
local user = 1

* User-specific directories (to update)
if `user' == 1 {
    global maindir "C:\Users\delaporte\Desktop\Revision WD\Replication files"
}

* ---------------------------------------------------------------------------- *
* Directory settings
* ---------------------------------------------------------------------------- *
* Define directories for data files, do-files, logs, and results
global datadir "$maindir\data_files"
global dodir "$maindir\do_files"
global resultdir "$maindir\results_files"

* ---------------------------------------------------------------------------- *
* Script execution settings
* ---------------------------------------------------------------------------- *
* Uncomment the scripts you wish to run as part of this session
*do "$dodir\1_descriptive_statistics.do"
*do "$dodir\2_general_data_setup.do"
*do "$dodir\3_outcomes_NRC_formal.do"
*do "$dodir\4_outcomes_RC_formal.do"
*do "$dodir\5_outcomes_RM_formal.do"
*do "$dodir\6_outcomes_NRM_formal.do"
*do "$dodir\7_outcomes_outofemp.do"
*do "$dodir\8_outcomes_NRC_informal.do"
*do "$dodir\9_outcomes_RC_informal.do"
*do "$dodir\10_outcomes_RM_informal.do"
*do "$dodir\11_outcomes_NRM_informal.do"

* ---------------------------------------------------------------------------- *
* End of Master do-file
* ---------------------------------------------------------------------------- *
