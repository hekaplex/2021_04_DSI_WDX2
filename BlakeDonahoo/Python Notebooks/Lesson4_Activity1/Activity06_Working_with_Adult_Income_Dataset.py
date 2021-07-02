#!/usr/bin/env python
# coding: utf-8

# # Leasson 4, Activity 1: Working with adult income dataset (UCI)
# 
# In this activity, you will work with **Adult Income Dataset** from UCI Machine Learning portal. The Adult Income data set has been used in many machine learning papers that address classification problems. You will read the data from a CSV file into a Pandas DataFrame and do practice some of the advanced data wrangling you learned in this Lesson.
# 
# ### URL for downloading the data
# We have the data downloaded as a CSV file on the disk for your ease. However, it is recommended to practice data download on your own so that you are familiar with the process.
# 
# **Here is the URL for the data set**: https://archive.ics.uci.edu/ml/machine-learning-databases/adult/
# 
# **Here is the URL for the description of the data set and the variables (at the end of the document)**: https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.names
# 
# ### Attributes/Variables
# 
# Following are the details of the type of the attributes of this dataset for your reference. You may have to refer them while answering question on this activity. Note that, many of the attributes are of discrete factor type. These are common type for a classification problem unlike continuous numeric values used for regression problems.
# 
# * __age__: continuous.
# * __workclass__: Private, Self-emp-not-inc, Self-emp-inc, Federal-gov, Local-gov, State-gov, Without-pay, Never-worked.
# * __fnlwgt__: continuous.
# * __education__: Bachelors, Some-college, 11th, HS-grad, Prof-school, Assoc-acdm, Assoc-voc, 9th, 7th-8th, 12th, Masters, 1st-4th, 10th, Doctorate, 5th-6th, Preschool.
# * __education-num__: continuous.
# * __marital-status__: Married-civ-spouse, Divorced, Never-married, Separated, Widowed, Married-spouse-absent, Married-AF-spouse.
# * __occupation__: Tech-support, Craft-repair, Other-service, Sales, Exec-managerial, Prof-specialty, Handlers-cleaners, Machine-op-inspct, Adm-clerical, Farming-fishing, Transport-moving, Priv-house-serv, Protective-serv, Armed-Forces.
# * __relationship__: Wife, Own-child, Husband, Not-in-family, Other-relative, Unmarried.
# * __race__: White, Asian-Pac-Islander, Amer-Indian-Eskimo, Other, Black.
# * __sex__: Female, Male.
# * __capital-gain__: continuous.
# * __capital-loss__: continuous.
# * __hours-per-week__: continuous.
# * __native-country__: United-States, Cambodia, England, Puerto-Rico, Canada, Germany, Outlying-US(Guam-USVI-etc), India, Japan, Greece, South, China, Cuba, Iran, Honduras, Philippines, Italy, Poland, Jamaica, Vietnam, Mexico, Portugal, Ireland, France, Dominican-Republic, Laos, Ecuador, Taiwan, Haiti, Columbia, Hungary, Guatemala, Nicaragua, Scotland, Thailand, Yugoslavia, El-Salvador, Trinadad&Tobago, Peru, Hong, Holand-Netherlands.
# 
# ### A special note on the variable 'fnlwgt':
# 
# The weights on the CPS files are controlled to independent estimates of the civilian noninstitutional population of the US.  These are prepared monthly for us by Population Division here at the Census Bureau.  We use 3 sets of controls. These are:
# 1.  A single cell estimate of the population 16+ for each state.
# 2.  Controls for Hispanic Origin by age and sex.
# 3.  Controls by Race, age and sex.
# 
# We use all three sets of controls in our weighting program and "rake" through them 6 times so that by the end we come back to all the controls we used. The term estimate refers to population totals derived from CPS by creating "weighted tallies" of any specified socio-economic characteristics of the population. 
# 
# People with similar demographic characteristics should have similar weights. There is one important caveat to remember about this statement.  That is that since the CPS sample is actually a collection of 51 state samples, each with its own probability of selection, the statement only applies within state.

# ### Load necessary libraries

# In[1]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


# ### Read in the adult income data set (given as a .csv file) from the local directory and check first 5 records

# In[2]:


df = pd.read_csv("adult_income_data.csv",header=None)
df.head()


# ### Do you think the column names (headers) make sense?

# In[ ]:


# No, the column names appear to be a zero-based index of the information contained within the *.csv


# ### Time to read in the text file with data descriptions and extract header names
# Write a file reading script which reads the text file line by line, and extracts the first phrase which is the header name

# In[3]:


names = []
with open('adult_income_names.txt','r') as f:
        for line in f:
                f.readline()
                readout = line.split(':')[0]
               # readout = (line.split(':')[0]).replace('\n','')
                names.append(readout)
                print(readout)          


# ### Add a name ("_Income_") for the response variable (last column) to the dataset and read it again with the column names supplied 

# In[4]:


names.append('Income')
print(names)


# In[5]:


df = pd.read_csv("adult_income_data.csv",names=names)
df.head()


# In[6]:


help(df.describe())


# ### Show a statistical summary of the data set. Did you notice only a small number of columns are included?

# In[7]:


df.describe(include=[object])


# ### Many variables in the dataset have multiple factors or classes. Can you write a loop to count and print them?

# In[8]:


variable_classes = ['workclass','education','marital-status','occupation','relationship','race','sex','native-country']


# In[9]:


type(variable_classes)


# In[10]:


# df


# In[11]:


for c in variable_classes: 
    classes = df[c].unique()
    num_classes = len(classes)
    print("There are {} classes in the \"{}\" column. They are: {}". format(num_classes,c,classes))
    print("\n\n\n")


# ### Is there any missing (NULL) data in the dataset? Write a single line of code to show this for all coumns

# In[12]:


df.isnull().sum()


# ### Practice subsetting: Create a DataFrame with only 
# * age, 
# * education,
# * occupation
# * race

# In[13]:


df_subset = df.loc[[i for i in range(0,9)] , ['age','education','occupation','race']]
df_subset.head()


# ### Show the histogram of age with bin size = 20

# In[14]:


df_subset['age'].hist(bins=20)


# ### Show boxplots of _age_ grouped by _race_ (Use a long figure size 15x6 and make _x_ ticks font size 15 )

# In[15]:


df_subset.boxplot(column='age',by='race',figsize=(15,6))
plt.xticks(fontsize=15)
plt.xlabel("Race",fontsize=20)
plt.show()


# ### Before doing further operation, we need to use the skill with 'apply' method we learned in this lesson. <br><br> But why? - Turns out that during reading the dataset from the CSV file, all the strings came with a whitespace character in front. So, we need to remove that whitespace from all the strings. 

# ### Let's write a small function to strip the whitespace character

# In[48]:


def strip_whitespace(s):
    return s.strip()


# In[61]:


def countf(s):
    return s + 'count'


# ### Use the 'apply' method to apply this function to all the columns with string values, create a new column, copy the values from this new column to the old column, and drop the new column.
# 
# #### This is the preferred method so that you don't accidentally delete valuable data. Most of the time, create a new column with a desired operation and then copy it back to the old column if necessary.
# 
# #### IGNORE any warning messages printed.

# In[62]:


# Education column
df_subset['education_stripped']=df['education'].apply(strip_whitespace)
df_subset['education']=df_subset['education_stripped']
df_subset.drop(labels=['education_stripped'],axis=1,inplace=True)

# Occupation column
df_subset['occupation_stripped']=df['occupation'].apply(strip_whitespace)
df_subset['occupation']=df_subset['occupation_stripped']
df_subset.drop(labels=['occupation_stripped'],axis=1,inplace=True)

# Race column
df_subset['race_stripped']=df['race'].apply(strip_whitespace)
df_subset['race']=df_subset['race_stripped']
df_subset.drop(labels=['race_stripped'],axis=1,inplace=True)


# In[63]:


df_subset['count'] = df['race'].apply(countf)
df_subset


# In[64]:


df_subset


# ### Answer the following question using conditional filtering/boolean indexing: <br><br> _"How many black people of age between 30 and 50 (inclusive) are represented in this dataset?"_

# In[65]:


# Write a code with conditional clauses and join them by & (AND) to filter the dataframe

df_filtered = df_subset[
    (df_subset['race']=='Black')
    & (df_subset['age']>=30)
    & (df_subset['age']<=50)
]


# In[68]:


# We can look at the shape of the filtered dataframe and take the 1st element at 0 index of the tuple

df_filtered.head()


# In[72]:


answer = df_filtered.shape[0]
answer


# In[73]:


# Print out the number of black people between 30 and 50
print("There are {} black people that are between the ages of 30 & 50 in this dataset".format(answer))


# ### Practice "GroupBy": Group by race and education to show how the mean age is distributed

# In[76]:


df_subset.groupby(['race','education']).mean()


# ### Group by occupation and show the summary statistics of age. Try to answer the following questions,
# * Which profession has oldest workers on the average?
# * Which profession has its largest share of workforce above 75th percentile?

# In[77]:


df_agg = pd.DataFrame(df_subset.groupby('occupation').describe()['age'])
df_agg


# ### Detecting outlier: Is there a particular occupation group which has very low representation? Perhaps we should remove those data because with very low data the group won't be useful in analysis
# 
# Actually, just by looking at the table above, you should be able to see that **'Armed-Forces'** group has only 9 count i.e. 9 data points. But how to detect it. Plot the count column in a bar chart.
# 
# Note, how the first argument to the barh function is the index of the dataframe which is the summary stats of the occupation groups. We see that 'Armed-Forces' group has almost no data.
# 
# #### This exercise teaches you that sometimes, outlier is not just a value but can be a whole group. The data of this group is fine but it is too small to be useful for any analysis. So it can be treated as an outlier in this case. 
# 
# #### But always use your business knowledge and engineering judgement for such outlier detection and how to process them.

# In[135]:


occupation_stats = df_subset.groupby('occupation').describe()['age']
occupation_stats


# In[123]:


# Create a horizontal bar chart
df_o = pd.DataFrame(occupation_stats)


# In[137]:


df_o.count().hist(bins=20)


# In[146]:


plt.figure(figsize = (15,8))
plt.barh(y = df_o.count(), width = df_o.count())
plt.yticks(fontsize = 13)
plt.show()


# ### Practice Merging by common keys: Suppose you are given two datasets where the common key is `occupation`. Can you merge them? 
# 
# #### First create two such disjoint datasets by taking random samples from the full dataset and then try merging. Include at least 2 other columns along with the common key column for each dataset.
# 
# #### Notice how the resulting dataset, after merging, may have more data points than either of the two starting datasets if your common key is not unique? Why is it so?

# In[150]:


# Sample first dataframe with 5 elements and your chosen random_state
df_1 = df[['age','workclass','occupation']].sample(5,random_state=101)
df_1


# In[152]:


# Sample second dataframe with 5 elements and your chosen random_state
df_2 = df[['education','race','occupation']].sample(5,random_state=101)
df_2


# In[153]:


# Merge the dataframes
df_merged = pd.merge(df_1,df_2,on='occupation',how='right').drop_duplicates()
df_merged


# In[154]:


df_merged.count()


# In[ ]:




