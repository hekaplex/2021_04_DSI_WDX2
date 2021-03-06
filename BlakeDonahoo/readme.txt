capstone_visionStatement

05/11/2021-------------------------------------------***Update/complete 180 for my Vision Statement***-----------------------------------------------------------------

Originally, I wanted to use one of my python programs that I wrote for reversing the elliptic curve in the Koblitz itteration of ECDSA, 
tying in the results into a database and using that information to narrow the window of brute-force needed to recover lost access to 
cryptocurrency wallets. I say "reversing" very toung-in-cheek. It's really more of a full hash from seed number >> Private Key >> Public Key >> Addresses. 
The goal of that being, in a nut-shell, bringing together what I know and what I learned into a cohesive display for my Capstone. 
Upon further thought, however, I found myself perfectly capable of doing that now....so how exactly would that be an outline of what I 
am yet to learn between now and August when the course is complete?

Right, that's what I was thinking too. 

So, given my love for conspiracy theories, my aim is to develop a web and mobile application written in React Native, 
using Power Bi and Python to publish reports based on real data and information WITHOUT any kind of political or social bias 
in order to combat the only real pandemic that I acknowledge: Fake News. I am going to call it "Real Data". 

The concept is simple. While there won't be any kind of partisan naritive that is trying to be imposed upon the applications readers, the reports will 
address current, and sometimes hot-button topics. 

In fact, it's being designed to work hand-in-hand with social media and news outlets so that people will be able to readily fact-check 
what they're being told and what they hear, right in the palm of their hands. 

Everything else is within reach, right? Why shoulnd't Real Data? 

I have purchased RealData.app, the website will be launched earlier than the mobile app as it will serve as the blueprint for the application,. 
From there it will be regularly maintained. While many people will be able to add data-sets and reports to the app through aggregation of sources and integrated API, 
all data will go through a central vetting process to maintain the apps integrity and primary mission. 

Coming to the iOS & Android App Store sooner than you might expect!

Go to https://www.RealData.app to see my progress along the way,

***To all of my classmates: If there is a topic that you have in mind that you would like to publish to RealData.app and be listed as a contributor feel free to get in touch with me

Looking forward to sharing this with everybody!
<<<<<<< HEAD
=======

----05/18/2021----
I am writing a letter and sending it to every major hospital in Texas (starting with Parkland) in the hopes of recieving uncensored information and statistics on the covid-19 
mortality rate. Including wether or not the deceased was previously "vaccinated", and if any co-morbidity was present. More updates to come!
>>>>>>> 24e5f477c5599c4081c1157866235c69d431ae82

----05/27/2021----
-Subtle name change from "RealData" to "RealData Application" ("RDA").
-I am currently working on a python program to incorporate a polling mechanism for developing organic data reports through the RDA website. 
Users (after creating an account) will be compensated for their opinions and answers to survey questions in cryptocurrency. I am thinking of using one that I already deployed 
and supplied liquidity to (BEP20 token [https://www.Bep20.dev]) but I may create another just for this purpose. 
-User accounts will be created into a cloud-hosted data server that I am building with resources through DigitalOcean
-The cryptocurrency reports section is going to be populated with data via my own custom Python API scripts that I am developing through resources available through
TrustWallet//BSCscan//EtherScan (It is almost complete but still a little buggy). Even still, I am contemplating scrapping the python API script I made and restarting 
with GraphIQL [https://graphql.org/learn/queries/] since what I am reading about it says that it works a lot cleaner and feeds directly into data science oriented tools and graphs
More updates to come!

----06/10/2021----
After copious amounts of troubleshooting connectivity issues inside my develpment environment for Django (Ubuntu 18.04 on WSL/WSL2 with Python 3.8.6) I have decided last minute
to change my programming construct of choice for the Survey/Polling feature inside of RDA to a more traditional HTML/CSS/PHP user input form that will feed data into an 
external database in order to meet my weekly completion goals. I will be putting together a "dummy" survey (no real questions, just layouts and user input options) so that 
the database linkage can be completed on schedule. Later down the line, with more time to fix my Django development environment, this feature may be migrated.

----06/16/2021----
As a last minute change in plans, I decided to put the RDA application on hold so that I can focus more on displaying deep analytic and data manipulation comprehension, 
and take a break from the UI-intensive requirements of a user-based application.
Not to say that I am scrapping all of the work that's gone into RDA thus far, but I am choosing a different project as an approach to exhibiting a more relevant skillset. 
That said, I have decided to analyze the relationship between the numeric representations of the hexadecimal output of the sha256 encryption algorithm, with a broader goal
of discovering a pattern leading to a hash collision. I have chosen to generate my raw data in Python by using a list of the first 10k prime numbers 
and then putting those numbers through the sha256 algorithm and feeding the data to a new file. The formula for each of my colums is as follows in pseudo-code:
column 1: index #
column 2: prime number(P)
column 3: Range in numbers since last prime
column 4: P(sha256)
column 5: P*P(SHA256)
column 6: P*P*P(SHA256)
column 7: P*P*P*P(SHA256)
column 8: P*P*P*P*P(SHA256)
column 9: P*P*P*P*P*P(SHA256)
column 10: P*P*P*P*P*P*P(SHA256)
column 11: P*P*P*P*P*P*P*P(SHA256)
column 12: P*P*P*P*P*P*P*P*P(SHA256)

After generating my dataset, the information will be analyzed with a scatterplot in Jupyter Notebooks where further analysis can be conducted, such as a calculation of 
entropy as it pertains to number scale.

I will be uploading the python scripts used to generate my data as well as the original text files that are being generated along the way. (semi)finished product will be in
*.ipynb format using a sample amount of only 100 prime numbers. The full dataset that I am using on the command line is in excess of the first 1 million prime numbers. 

----06/24/2021----
The above SHA256 analysis is currently on hold, and possibly being scrapped all together. I understand the right way to produce a hash collision, and the above analysis 
would simply serve as a supplemental tool, so to speak, of that outcome. The main goal was to focus on something that had a broader depth of analytical questions that could be
asked and answered as well as feed into visual models of those findings in order to outline the DSI coursework. The SHA256 analysis, however, can only really be produced 
through pure python since no other data analysis software can handle integers of 256bits. There is a folder for it in my directory showing the bit of work I did with the 
concept that includes:::
- *.txt of the original prime numbers being analyzed
- the python script I wrote to process the raw data:
    (automated system readout from file>> change data type>> remove blank spaces>> hash>> convert to HEX>> convert to INT>> write to new txt file)
- output.txt of the integers that were generated    

Instead, I created the Real Estate Analysis folder. Data was sourced through Zillow's data research page and built into a SQL database where further data manipulation can be 
performed and displayed. As of now, that will be my "secondary" capstone target project. RDA isn't completely retired, but I am taking a break from it so that I am not 
putting too much time into UI/UX. Check out the README.txt in the RealEstateAnalysis folder for a better overview of the project.



