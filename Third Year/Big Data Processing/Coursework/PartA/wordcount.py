"""Lab5
"""
from mrjob.job import MRJob
import re
from datetime import datetime
import time

class Lab5(MRJob):
# this class will define two additional methods: the mapper method goes here
    def mapper(self, _, line):
       fields = line.split(",")
       try:
           if (len(fields)== 5):
               time_epoch = int(fields[2])
               date = time.strftime("%Y-%B-%m",time.gmtime(time_epoch))
               date_fields = date.split("-")
               year = date_fields[0]
               month = date_fields[1]
               number = date_fields[2]
               yield((year,number,month),1)
       except:
           pass
            #no need to do anything, just ignore the line, as it was malformed
    def combiner(self, line, sums):
        sorted_values = sorted(line, reverse= True,key=lambda x: x[1])
        yield(line,sum(sums))

    def reducer(self, line, sums):
        print("{}, {}, {}".format(line[0],line[2],sum(sums)))
        #yield(",{}, {}, {},".format(line[0],line[2],sum(sums)),1)

#you have to implement the body of this method. Python's sum() function will probably be useful
#this part of the python script tells to actually run the defined MapReduce job. Note that Lab1 is the name of the class

if __name__ == '__main__':
    Lab5.JOBCONF = {'mapreduce.job.reduces': '1'}
    Lab5.run()
#python wordcount.py sherlock.txt > out.txt (as sherlock is the same folder location)
