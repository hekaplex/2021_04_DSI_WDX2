# Study of the relationship between hashing algorithm outputs through generation of SHA256 output from prime numbers (P)
# First sequential output generation script in the range of (P(SHA256)) up to (P*P*P*P*P*P*P*P*P(SHA256))
# Python 3.9.5
# Blake Donahoo 6/16/2021
import os 
import hashlib
def line_conversion():
	with open ('10kprimes.txt','r') as t: # open source file to read prime numbers from
		rl=t.readlines() # read each line of the file and classify each line as its own variable
		for p in rl: # for each line variable do:
			p=p.replace('\n','').replace('\r','') # remove any beginning or trailing spaces before hashing
			hash_int=int(hashlib.sha256(p.encode()).hexdigest(),16) # encode variable as utf-8,hash the variable through hashlib.sha256, output 256bit hex digest, convert hex string to numeric int
			print(hash_int) # print the result to watch our progress in the command terminal
			int_str=str(hash_int) # convert numerical representation of sha256 hash to string so that it can be written to a file
			with open ('output.txt','a') as o: # open our output file
				o.write(int_str) # record the new variable 
				o.write('\n') # add a new line so that next variable is written under this one
				o.close() # close the file to conserve RAM
line_conversion()
