"""Lab 1. Basic wordcount
"""
from mrjob.job import MRJob
import re


#this is a regular expression that finds all the words inside a String
#WORD_REGEX = re.compile(r"\b\w+\b")

#This line declares the class Lab1, that extends the MRJob format.
class Lab4(MRJob):

# this class will define two additional methods: the mapper method goes here
    def mapper(self, _, line):
        fields = line.split(",")
        try:
            # if (len(fields)==9):
            comp = fields[1]
            date = fields[2]
            vol = float(fields[7])
            price = float(fields[6])
            cost = int(price*vol)
            yield(fields[0], (comp,date,cost))
        except:
            pass
            #access the fields you want, assuming the format is correct now
    def reducer(self, key, words):
        sorted_values = sorted(words, reverse=True,key=lambda x: x[2])[:10]
        rank=0
        for line in sorted_values:
            rank=rank+1
            yield(rank,'{} - {} - {}'.format(line[0],line[1],line[2]))

        #you have to implement the bodyL of this method. Python's sum() function will probably be useful

#this part of the python script tells to actually run the defined MapReduce job. Note that Lab1 is the name of the class
if __name__ == '__main__':
    Lab4.JOBCONF = {'mapreduce.reduce.memory.mb': 4096 }
    Lab4.run()
#python wordcount.py sherlock.txt > out.txt (as sherlock is the same folder location)
