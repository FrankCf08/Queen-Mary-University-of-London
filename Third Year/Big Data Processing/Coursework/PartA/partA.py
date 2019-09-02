"""PartA
"""
from mrjob.job import MRJob
import re
import time

class PartA(MRJob):
# this class will define two additional methods: the mapper method goes here
    def mapper(self, _, line):
       fields = line.split(",")# Split lines
       try:
           if (len(fields)== 5):#only carry on if fields len is equal to 5
               time_epoch = int(fields[2])#get the third field of fields array
               date = time.strftime("%Y-%B-%m",time.gmtime(time_epoch))#convert time_epoch into fix date_fields
               date_fields = date.split("-")
               year = date_fields[0]# %Y --> Year with century as a decimal number
               month = date_fields[1]# %B --> Full month name
               number = date_fields[2]# %m --> Month as a decimal number [0,12]
               yield((year,number,month),1)
       except:
           pass
            #no need to do anything, just ignore the line, as it was malformed
    def combiner(self, line, sums):
        sorted_values = sorted(line, reverse= True,key=lambda x: x[1])#It sorts the line array according the second element line[1], which the month as a decimal
        yield(line,sum(sums))

    def reducer(self, line, sums):
        print("{}, {}, {}".format(line[0],line[2],sum(sums)))#Print lines in the format "{}, {}, {}"
        #yield(",{}, {}, {},".format(line[0],line[2],sum(sums)),1)

if __name__ == '__main__':
    PartA.JOBCONF = {'mapreduce.job.reduces': '1'}
    PartA.run()
