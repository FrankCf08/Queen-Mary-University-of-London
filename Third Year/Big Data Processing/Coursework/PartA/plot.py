"""Plot
"""
from matplotlib import pyplot as pyplot
from matplotlib import style
import numpy as np

# this class will define two additional methods: the mapper method goes here
style.use('ggplot')

sector_table = {}

with open("Sample.txt") as f:
    for line in f:
        fields = line.split(",")
        year = fields[0]
        month = fields[1]
        trans = float(fields[2])

        # print(year)
        # print(month)
        # print(trans)

#you have to implement the body of this method. Python's sum() function will probably be useful
#this part of the python script tells to actually run the defined MapReduce job. Note that Lab1 is the name of the class
#python wordcount.py sherlock.txt > out.txt (as sherlock is the same folder location)
