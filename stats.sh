#!/bin/bash


# # -*- coding: utf-8 -*-
# """
# Created on Tue Apr 28 23:50:35 2020
#
# @author: amr
# """
#
#entries in closed arm p = 0.017
gp_A = [21,28,17,21,37,24,27,7,20,29,24,14,18,18,17,26,]

gp_B = [17,15,11,14,12,11,19,11,27,22,18,21,10,14,23,16,]
#
# ]

# entries in open arm not sig
gp_A = [19,12,19,15,30,18,18,11,5,12,20,8,14,19,10,12,]

gp_B = [13,6,22,12, 28,8,17,12,15,21,15,12,6,7,22,7,]

# time in open zone not signifcant
gp_A = [108.70,80.62,90.05,73.94,183.03,98.82,70.30,43.58,22.44,84.94,107.50,24.38,97.88,99.88,107.15,45.37,]

gp_B = [94.08,60.07,74.05,56.50,181.28,154.20,68.10,58.35,75.83,165.45,99.20,53.45,7.47,137.17,151.85,20.05,]

# time in closed arm

gp_A = [441.68,
448.12,
449.97,
450.50,
355.75,
435.42,
463.60,
533.10,
555.81,
465.69,
428.25,
533.50,
446.62,
426.85,
425.60,
490.60,
]

gp_B = [463.00,
486.53,
471.97,
509.37,
349.42,
421.77,
496.63,
512.40,
456.03,
360.85,
447.70,
501.25,
569.53,
423.90,
367.52,
540.05,
]








mkdir -p /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/{open_field,elevated_plus_maze}


cd /media/amr/Amr_4TB/Work/October_Acquistion/Data
for file in *;do

    cp /media/amr/Amr_4TB/Work/October_Acquistion/Open_Field_workingdir/Open_Field_workflow/_subject_id_${file}/Get_Metrics/open_field_${file}metrics.csv \
    /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/open_field/${file}_OF.csv

    cp /media/amr/Amr_4TB/Work/October_Acquistion/Plus_Maze_workingdir/Plus_Maze_workflow/_subject_id_${file}/Get_Metrics/plus_maze_${file}metrics.csv \
    /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/elevated_plus_maze/${file}_EPM.csv

done


python /media/amr/Amr_4TB/Dropbox/SCRIPTS/change_files_to_contain_gp_name.py \
/media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/open_field/ 0 3

python /media/amr/Amr_4TB/Dropbox/SCRIPTS/change_files_to_contain_gp_name.py \
/media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/elevated_plus_maze/ 0 3





cat << EOF > pyscript.py

#Python code to merge all the metrics from all the subjects
import pandas as pd
import glob

dfs_OF = sorted(glob.glob('/media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/open_field/*_OF.csv', ))
result_OF = pd.concat([pd.read_csv(df) for df in dfs_OF])

# remove the column of subjects name
result_OF = result_OF.drop(result_OF.columns[0], axis=1)
result_OF.to_csv('/media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/open_field/OF_merged.csv', header=False, index=False)


dfs_EPM = sorted(glob.glob('/media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/elevated_plus_maze/*_EPM.csv', ))
result_EPM = pd.concat([pd.read_csv(df) for df in dfs_EPM])

result_EPM = result_EPM.drop(result_EPM.columns[0], axis=1)
result_EPM.to_csv('/media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/elevated_plus_maze/EPM_merged.csv', header=False, index=False)


EOF

cd /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat

design_ttest2 /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/design_behavior 16 16

palm \
-i /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/open_field/OF_merged.csv \
-d /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/design_behavior.mat \
-t /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/design_behavior.con \
-o /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/results_OF \
-corrcon -fdr



palm \
-i /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/elevated_plus_maze/EPM_merged.csv \
-d /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/design_behavior.mat \
-t /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/design_behavior.con \
-o /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/results_EPM \
-corrcon -fdr


#-----------------------------------------------------------------------------------------------------------------------------------------------
design_ttest2 smart_design_OF

palm \
-i /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/OF_SMART.csv \
-d /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/smart_design_OF.mat \
-t /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/smart_design_OF.con \
-o /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/SMART_OF \
-corrcon -fdr


# I deleted subject 288, hydrocephaly- 288, 271, 272 are still there
design_ttest2 smart_design_EPM 16 17

palm \
-i /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/EPM_SMART.csv \
-d /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/smart_design_EPM.mat \
-t /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/smart_design_EPM.con \
-o /media/amr/Amr_4TB/Work/October_Acquistion/Behavior_Stat/SMART_EPM \
-twotail -fdr
