# -VA-VetRisk
VA Vet Risk assessment prediction models using ICPSR 35037 dataset

Disclaimer: Due to very poor datasets provided (no outcomes, some outcomes but very few patients, etc.) this risk assessment models are not tied to a particular outcome (i.e suicide), but rather a set out potential outcomes
which one of them might (probably) be suicide

<h1>The short and swift explanation </h1>

Utility: When trying to tacke suicide prediction, it is imperative to have a nice dataset with outcomes. However, ICPSR 35037 provided the second best thing - Veterans that have been admitted to substance abuse treatment facilities. This project is flexible enough as to be able to take any similar input (for later years) or allow researchers to format their data in this way to take advantage of the project's models. This will allow researchers to asses the risk of any veteran in real time (can be formulated as a questionary) and run the model to get an outcome probability.

Ambition: To my knowledge there hasn't been a project for risk assessment done on this particular dataset (due to the lack of an outcome variable probably). This project is an exploratory piece on the dataset and its variables to try to classify veteran patients to a finite set of potential outcomes.

Polish: All code has been included here for reproducibility. Due to the DUA of the dataset, I am not attaching it to the repository. However, all analysis results and variables of interest are described in the files.

<h1> The long and heavy duty description </h1>

The ICPSR3507 dataset provides information for around 1.8 million people that entered substance abuse facilities in 2012. This dataset provides the admision variables, 63 to be precise. Out of those people, 54K are veterans. This exploratory analysis started by first clustering the ICPSR 3507 dataset into the optimal number of clusters. This was done as a proxy to having a particular 'outcome'. Each cluster provides a 'type of patient', some of which might have a higher risk to suicide (or any other thing, such as incidence, crime, etc.). I did not make any calls as to which cluster means what, in order to not make any bogus assumtions. 

With each veteran assigned a cluster center (risk group), I have now built randomforest models for classification of veterans into any of those 4 groups. Each model was built using 5-fold cross validation. I built an individual model for each probable outcome. Performance analysis of the models is as follows:


Once we have the models, we then look at their features of importance to try to make sense as out of the outcomes. 



<h1> Model building decisions </h1>

After a couple of iterations of the randomforest model, variables have been dropped from the dataset in order to prevent over fitting on spurious variables such as AGE, GENDER, PREG (and a few others). This refinement allows us to really see what other variables are contributing to the different outcomes. More feature engineering and cleanup can definitely improve the models.

