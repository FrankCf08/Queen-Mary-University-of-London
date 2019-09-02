"""Lab 1. Basic wordcount
"""
from mrjob.job import MRJob
import re
from mrjob.step import MRStep
#this is a regular expression that finds all the words inside a String
#WORD_REGEX = re.compile(r"\b\w+\b")

#This line declares the class Lab1, that extends the MRJob format.
class Lab4(MRJob):

    sector_table = {}

    def mapper_join_init(self):
        # load companylist into a dictionary
        # run the job with --file input/companylist.tsv
        #with open("/homes/fecf3/Desktop/QM/ThirdYear/ecs640/lab4/companylist.tsv") as f:
        with open("companylist.tsv") as f:
            for line in f:
                fields = line.split("\t")
                key = fields[0]#company name
                val = fields[3]#Setor
                self.sector_table[key] = val

    def mapper_repl_join(self, _, line):
        fields = line.split(",")
        stock = fields[1]

        if stock in self.sector_table:
            sector = self.sector_table[stock]
            vol = float(fields[7])#volume
            # year =fields[2][:4]#year
            year = fields[2].split('-')[0]
            yield((sector, year), vol)

    # def mapper_length(self, sector, words):
    #     volume = words[0]
    #     year = words[1]
    #     yield ((sector, year), volume)#

    def reducer_sum(sef,key, data):
        yield (key, sum(data))

    def steps(self):
        return [MRStep(mapper_init=self.mapper_join_init,
                        mapper=self.mapper_repl_join,
                # MRStep(mapper=self.mapper_length,
                        reducer=self.reducer_sum)]

#this part of the python script tells to actually run the defined MapReduce job. Note that Lab1 is the name of the class
if __name__ == '__main__':
    Lab4.JOBCONF = {'mapreduce.reduce.memory.mb': 4096 }
    Lab4.run()
#python wordcount.py sherlock.txt > out.txt (as sherlock is the same folder location)


#python wordcount2.py input/NASDAQsample.csv > out2tables
