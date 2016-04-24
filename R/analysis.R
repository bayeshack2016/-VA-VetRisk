################################################################
#### Bayes Hackathon 2016 - San Francisco                   ####
####                                                        ####
#### Vet Risk                                               ####
#### Flagging Veterans at risk of possible suicide project  ####
####                                                        ####
#### Juan M. Banda                                          ####
################################################################
#Uses data from: 
# United States Department of Health and Human Services. Substance Abuse and Mental Health Services Administration. Center for 
# Behavioral Health Statistics and Quality. Treatment Episode Data Set -- Admissions (TEDS-A), 2012. ICPSR35037-v1. Ann Arbor, MI: 
# Inter-university Consortium for Political and Social Research [distributor], 2014-05-07. http://doi.org/10.3886/ICPSR35037.v1
# 
#Link: http://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/35037

admission_ds <- read.table("35037-0001-Data.tsv",sep="\t", header=TRUE)
#Get me all veterans only
veterans <- subset(admission_ds,admission_ds$VET==1)
#Data cleaning step
drops <- c("CASEID", "CBSA", "PMSA", "REGION", "DIVISION", "FRSTUSE3", "FREQ3", "ROUTE3", "SUB3", "FRSTUSE2", "FREQ2","ROUTE2", "SUB2", "FRSTUSE1", "FREQ1", 
           "ROUTE1","SUB1","YEAR", "VET", "DAYWAIT")

#After the first round of modeling these variables are biasing the models

veterans<-veterans[ , !(names(veterans) %in% drops)]
#Clean the non-vets, they will be used as 'controls'
non_veterans <- subset(admission_ds,admission_ds$VET==2)  #We ignore the people with missing data
non_veterans <- non_veterans[ , !(names(non_veterans) %in% drops)]
#######################################
########### Data cleaning #############

#Reduce missing data values to zeros.
veterans[veterans==-9]<-0
non_veterans[non_veterans==-9]<-0


############### Test for optimal number of clusters #######
mydata <- veterans
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i, algorithm="MacQueen", iter.max=100)$withinss)

### Ploting option for cluster!!
options(bitmapType='cairo')
### Gradient palette of colors
pdf("number_of_clusters_plot.pdf")
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")
dev.off()

#This shows that we should idealy pick 3 or 4 clusters


#### Use K-means to cluster the VET persons
set.seed(1234)
fit.km <- kmeans(veterans, 4, nstart=25)

#Create a labeled vector
veterans_labeled<-veterans
veterans_labeled$label<-fit.km$cluster


# We now have 4 possible 'outcomes' or atleast four different types of 'paths' that the Veterans will take.
# with no outcome label, we will assume each one leads to 'something'. This will be determined later by the top
# features

############ After first round of iterations these variables seem to bias the model, removed them
drops <- c("PRIMINC","STFIPS","AGE", "EDUC","GENDER", "PREG")
veterans_labeled<-veterans_labeled[ , !(names(veterans_labeled) %in% drops)]
non_veterans <- non_veterans[ , !(names(non_veterans) %in% drops)]

library(caret)
library(dplyr)
library(doMC)
registerDoMC(cores = 12)

veterans_outcome1 <- subset(veterans_labeled,veterans_labeled$label==1)
veterans_outcome2 <- subset(veterans_labeled,veterans_labeled$label==2)
veterans_outcome3 <- subset(veterans_labeled,veterans_labeled$label==3)
veterans_outcome4 <- subset(veterans_labeled,veterans_labeled$label==4)

#Lets get some randomly sampled 'controls' from the non-vet section
non_veterans$label<-"F"
controls_outcome1 <- sample_n(non_veterans,nrow(veterans_outcome1)*2)
controls_outcome2 <- sample_n(non_veterans,nrow(veterans_outcome2)*2)
controls_outcome3 <- sample_n(non_veterans,nrow(veterans_outcome3)*2)
controls_outcome4 <- sample_n(non_veterans,nrow(veterans_outcome4)*2)

#fix outcome labels
veterans_outcome1$label<-"A"
veterans_outcome2$label<-"B"
veterans_outcome3$label<-"C"
veterans_outcome4$label<-"D"

FV_outcome1<-rbind(veterans_outcome1, controls_outcome2)
FV_outcome2<-rbind(veterans_outcome3, controls_outcome4)
FV_outcome3<-rbind(veterans_outcome3, controls_outcome3)
FV_outcome4<-rbind(veterans_outcome4, controls_outcome4)

#create a 75-25 test and training set
############################ Outcome 1 model training #################################
set.seed(42)
training <- FV_outcome1
save(training, file='outcome1_data.rda')
charCols <- c("label") #Get all the predictors name and remove labels and pid's for model training
predictorsNames <- colnames(training)[!colnames(training) %in% charCols]
cvLabels <- training$label

objControl <- trainControl(method="cv", number=5)
# fix the parameters of the algorithm
# train the model
model <- train(x=training[,predictorsNames],y=cvLabels, method="rf",importance = TRUE, trControl=objControl)
# summarize results
sink("model-output-outcome1.txt")
print(model)
save(model,file='ouctome1_model.rda')
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
#plot(importance)
sink()
############################ Outcome 2 model training #################################
set.seed(42)
training <- FV_outcome2
save(training, file='outcome2_data.rda')
charCols <- c("label") #Get all the predictors name and remove labels and pid's for model training
predictorsNames <- colnames(training)[!colnames(training) %in% charCols]
cvLabels <- training$label

objControl <- trainControl(method="cv", number=5)
# fix the parameters of the algorithm
# train the model
model <- train(x=training[,predictorsNames],y=cvLabels, method="rf",importance = TRUE, trControl=objControl)
# summarize results
sink("model-output-outcome2.txt")
print(model)
save(model, file='ouctome2_model.rda')
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
#plot(importance)
sink()

############################ Outcome 3 model training #################################
set.seed(42)
training <- FV_outcome3
save(training, file='outcome3_data.rda')
charCols <- c("label") #Get all the predictors name and remove labels and pid's for model training
predictorsNames <- colnames(training)[!colnames(training) %in% charCols]
cvLabels <- training$label

objControl <- trainControl(method="cv", number=5)
# fix the parameters of the algorithm
# train the model
model <- train(x=training[,predictorsNames],y=cvLabels, method="rf",importance = TRUE, trControl=objControl)
# summarize results
sink("model-output-outcome3.txt")
print(model)
save(model, file='ouctome3_model.rda')
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
#plot(importance)
sink()

############################ Outcome 4 model training #################################
set.seed(42)
training <- FV_outcome4
save(training, file='outcome4_data.rda')
charCols <- c("label") #Get all the predictors name and remove labels and pid's for model training
predictorsNames <- colnames(training)[!colnames(training) %in% charCols]
cvLabels <- training$label

objControl <- trainControl(method="cv", number=5)
# fix the parameters of the algorithm
# train the model
model <- train(x=training[,predictorsNames],y=cvLabels, method="rf",importance = TRUE, trControl=objControl)
# summarize results

sink("model-output-outcome4.txt")
print(model)
save(model, file='ouctome4_model.rda')
importance <- varImp(model, scale=FALSE)
# summarize importance
print(importance)
# plot importance
#plot(importance)
sink()




