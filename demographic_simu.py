# verion 2.0
# Change allowed number of children to expected number of children for 
# each women between 15-49

# http://www.stats.gov.cn/tjsj/pcsj/rkpc/6rp/indexch.htm
import pandas as pd
import numpy as np
import copy
import sys
# import multiprocessing as Pool


TOTAL_POP_CURRENT  = 1411780000
CURRENT_YEAR = 2021
#BIRTH_GAP    = 2 # assume 2 years(fixed) between children birth
CHILD_MEAN  = float(sys.argv[1])
SCALE_DOWN   = 10000
SEX_BIRTH_RATIO = 0.5


# 3-1  全国分年龄、性别的人口
age_sex = pd.read_csv("./age_sex.csv", header=None, 
	names=["age","total","male","female","total_prop","male_prop","female_prop","sex_ratio"])
# Using 6th census prop on the 7th census due to the unknown age-sex data
male_prop = age_sex['male']/sum(age_sex['total'])
female_prop = age_sex['female']/sum(age_sex['total'])

sex_n = pd.DataFrame({"male" : male_prop*TOTAL_POP_CURRENT/SCALE_DOWN,
					"female" : female_prop*TOTAL_POP_CURRENT/SCALE_DOWN})
sex_n = sex_n.astype({"male":"int", "female":"int"})


# 6-4  全国分年龄、性别的死亡人口状况(2009.11.1-2010.10.31)								

age_death = pd.read_csv("./age_death_per_year.csv", header=None, 
	names=["age","total","male","female", "total_death", "male_death" ,"female_death",
	       "total_dt","male_dt","female_dt"])
death_rate = age_death[{"male_dt","female_dt"}]/1000

# 6-3  全国育龄妇女分年龄、孩次的生育状况（2009.11.1-2010.10.31）									

age_birth = pd.read_csv("./birth.csv", header = None,
	names=["age","total_women","total_birth","birth_rate","firstBirth_number","firstBirth_rate",
	       "secondBirth_number","secondBirth_rate","thirdBirth_number","thirdBirth_rate"])

birth_rate_adj = pd.DataFrame({'age' : age_birth['age'], 
				   "firstBirth_rate" : age_birth["firstBirth_rate"]/sum(age_birth["firstBirth_rate"])})





class Person(object):
	"""docstring for Person"""
	def __init__(self, sex, birth_year, childNO):
		self.sex = sex 	# 1 for male; 2 for female
		self.birth_year = birth_year
		self.childNO = childNO
	def age(self, Year):
		return Year - self.birth_year
	def status(self, Year):
		if self.sex == 1: sexname = "male_dt"
		if self.sex == 2: sexname = "female_dt"
		if self.age(Year) > 100:
			dr = death_rate.iloc[100][sexname]
		else:
			dr = death_rate.iloc[self.age(Year)][sexname]
		return np.random.binomial(1,dr) # 1 for death, 0 for alive
	def birth(self, Year, CHILD_MEAN):
		if self.age(Year) < 15 or self.age(Year)>49 or self.sex==1 or self.status(Year)==1: 
			return None
		else:
			br = birth_rate_adj.loc[birth_rate_adj['age']==self.age(Year)]['firstBirth_rate']
			bn = np.random.binomial(1,br*CHILD_MEAN)
			if bn==1:
				self.childNO += bn
				cc = Person(np.random.binomial(1,SEX_BIRTH_RATIO)+1, Year, 0) #
				return cc
			return None


# initiate a pool of starting population
def initPop():
	p_pool = []
	for iage, irow in sex_n.iterrows():
		for ii in range(irow['female']):
			p_pool.append(Person(2,CURRENT_YEAR - iage,0))
		for jj in range(irow['male']):
			p_pool.append(Person(1,CURRENT_YEAR - iage,0))
	return p_pool


if __name__ == '__main__':
	p_pool = initPop()
	pop_log = {}
	year = 2022
	while True:
		print(year)
		for p in p_pool:
			pbirth = p.birth(year, CHILD_MEAN)
			if pbirth is not None:
				p_pool.append(pbirth)
			if p.status(year)==1:
				p_pool.remove(p)
		pop_log[year] = copy.deepcopy(p_pool) # deep copy. 
		if year == 2149: break
		year = year + 1
	# output results
	out = open("birth_" + str(CHILD_MEAN) + "_version2.txt","w")
	out.write("Year\tMale_pop\tFemale_pop\n")
	for k,plist in pop_log.items():
		male_no = len([p for p in plist if p.sex == 1])
		female_no = len([p for p in plist if p.sex == 2])
		out.write(str(k) + "\t" + str(male_no) + "\t" + str(female_no) + "\n")
	out.close()
