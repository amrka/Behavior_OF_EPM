#!/bin/bash

# Moving the metrics.csv files from the open_field_output directory of each subject

cd /media/amr/Amr_4TB/Work/October_Acquistion/Open_Field_output

cp  */*.csv .


# combine all the csv files with a single header

awk '(NR == 1) || (FNR > 1)' open_field_*.csv > open_field.csv

# The same with plus maze

cd /media/amr/Amr_4TB/Work/October_Acquistion/Plus_Maze_output

cp */*.csv .

awk '(NR == 1) || (FNR > 1)' plus_maze_*.csv > plus_maze.csv

