#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 28 18:37:33 2020

@author: amr
"""

import os
import pandas as pd

# change the first column of the combined csv file to contain the group name  

# group names

A = ['242','243','244','245','252','253','255','281','282','286','287','288','362','363','364','365','366']

B = ['228','229','230','232','233','234', '235', '236','237','261','262','263','264','271','272','273','274']

# first we do open field

os.chdir('/media/amr/Amr_4TB/Work/October_Acquistion/Open_Field_output')

df = pd.read_csv('/media/amr/Amr_4TB/Work/October_Acquistion/Open_Field_output/open_field.csv')


i = 0
for name in df.iloc[:,0]:
    if name[11:14] in A:
        df.iloc[i,0] = 'A_{0}'.format(name[11:14])
        i = i + 1
    elif name[11:14] in B:
        df.iloc[i,0] = 'B_{0}'.format(name[11:14])
        i = i + 1
        

df.to_csv('/media/amr/Amr_4TB/Work/October_Acquistion/Open_Field_output/open_field_gp_names.csv')

#------------------------------------------------------------------------------------------------

# second we do plus maze

os.chdir('/media/amr/Amr_4TB/Work/October_Acquistion/Plus_Maze_output')

df = pd.read_csv('/media/amr/Amr_4TB/Work/October_Acquistion/Plus_Maze_output/plus_maze.csv')


i = 0
for name in df.iloc[:,0]:
    if name[10:13] in A:
        df.iloc[i,0] = 'A_{0}'.format(name[10:13])
        i = i + 1
    elif name[10:13] in B:
        df.iloc[i,0] = 'B_{0}'.format(name[10:13])
        i = i + 1
        

df.to_csv('/media/amr/Amr_4TB/Work/October_Acquistion/Plus_Maze_output/plus_maze_gp_names.csv')

        
