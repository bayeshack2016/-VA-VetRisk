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

library(caret)

## Evaluate model for outcome 1
load('/scratch/users/jmbanda/tst_hck/model_stuff/outcome1_data.rda') #testing
load('/scratch/users/jmbanda/tst_hck/model_stuff/ouctome1_model.rda') #model
#Get variables of importance
importance <- varImp(model, scale=FALSE)
options(bitmapType='cairo')
### Gradient palette of colors
pdf("/scratch/users/jmbanda/tst_hck/model_stuff/features_of_importance_outcome1.pdf")
plot(importance, top=10)
dev.off()

###Extract confusion Matrix
TP<-model$finalModel$confusion[1]
FN<-model$finalModel$confusion[2]
FP<-model$finalModel$confusion[3]
TN<-model$finalModel$confusion[4]

sensitivityVal<-TP/(TP+FN)
specificityVal<-TN/(TN+FP)
ppvVal<-TP/(TP+FP)
accuracyVal<-(TP+TN)/(TP+FP+FN+TN)
FscoreVal<-(2*TP)/((2*TP) + FP + FN )

sink('/scratch/users/jmbanda/tst_hck/model_stuff/outcome1_model_evaluation.txt')
# summarize importance
cat('RandomForest model for Outcome 1')
cat(paste('\n\nModel Accuracy: ',accuracyVal,'\n',sep=''))
cat(paste('Model Sensitivity: ',sensitivityVal,'\n',sep=''))
cat(paste('Model Specificity: ',specificityVal,'\n',sep=''))
cat(paste('Model PPV: ',ppvVal,'\n',sep=''))
cat(paste('Model F-Score: ',FscoreVal,'\n',sep=''))
print(importance, top=10)
sink()

## Evaluate model for outcome 2
load('/scratch/users/jmbanda/tst_hck/model_stuff/outcome2_data.rda') #testing
load('/scratch/users/jmbanda/tst_hck/model_stuff/ouctome2_model.rda') #model
#Get variables of importance
importance <- varImp(model, scale=FALSE)
# plot importance
options(bitmapType='cairo')
### Gradient palette of colors
pdf("/scratch/users/jmbanda/tst_hck/model_stuff/features_of_importance_outcome2.pdf")
plot(importance, top=10)
dev.off()

###Extract confusion Matrix
TP<-model$finalModel$confusion[1]
FN<-model$finalModel$confusion[2]
FP<-model$finalModel$confusion[3]
TN<-model$finalModel$confusion[4]

sensitivityVal<-TP/(TP+FN)
specificityVal<-TN/(TN+FP)
ppvVal<-TP/(TP+FP)
accuracyVal<-(TP+TN)/(TP+FP+FN+TN)
FscoreVal<-(2*TP)/((2*TP) + FP + FN )

sink('/scratch/users/jmbanda/tst_hck/model_stuff/outcome2_model_evaluation.txt')
# summarize importance
cat('RandomForest model for Outcome 2')
cat(paste('\n\nModel Accuracy: ',accuracyVal,'\n',sep=''))
cat(paste('Model Sensitivity: ',sensitivityVal,'\n',sep=''))
cat(paste('Model Specificity: ',specificityVal,'\n',sep=''))
cat(paste('Model PPV: ',ppvVal,'\n',sep=''))
cat(paste('Model F-Score: ',FscoreVal,'\n',sep=''))
print(importance, top=10)
sink()

## Evaluate model for outcome 3
load('/scratch/users/jmbanda/tst_hck/model_stuff/outcome3_data.rda') #testing
load('/scratch/users/jmbanda/tst_hck/model_stuff/ouctome3_model.rda') #model
#Get variables of importance
importance <- varImp(model, scale=FALSE)
# plot importance
options(bitmapType='cairo')
### Gradient palette of colors
pdf("/scratch/users/jmbanda/tst_hck/model_stuff/features_of_importance_outcome3.pdf")
plot(importance, top=10)
dev.off()
###Extract confusion Matrix
TP<-model$finalModel$confusion[1]
FN<-model$finalModel$confusion[2]
FP<-model$finalModel$confusion[3]
TN<-model$finalModel$confusion[4]

sensitivityVal<-TP/(TP+FN)
specificityVal<-TN/(TN+FP)
ppvVal<-TP/(TP+FP)
accuracyVal<-(TP+TN)/(TP+FP+FN+TN)
FscoreVal<-(2*TP)/((2*TP) + FP + FN )

sink('/scratch/users/jmbanda/tst_hck/model_stuff/outcome3_model_evaluation.txt')
# summarize importance
cat('RandomForest model for Outcome 3')
cat(paste('\n\nModel Accuracy: ',accuracyVal,'\n',sep=''))
cat(paste('Model Sensitivity: ',sensitivityVal,'\n',sep=''))
cat(paste('Model Specificity: ',specificityVal,'\n',sep=''))
cat(paste('Model PPV: ',ppvVal,'\n',sep=''))
cat(paste('Model F-Score: ',FscoreVal,'\n',sep=''))
print(importance, top=10)
sink()

## Evaluate model for outcome 4
load('/scratch/users/jmbanda/tst_hck/model_stuff/outcome4_data.rda') #testing
load('/scratch/users/jmbanda/tst_hck/model_stuff/ouctome4_model.rda') #model
#Get variables of importance
importance <- varImp(model, scale=FALSE)
options(bitmapType='cairo')
### Gradient palette of colors
pdf("/scratch/users/jmbanda/tst_hck/model_stuff/features_of_importance_outcome4.pdf")
plot(importance, top=10)
dev.off()

###Extract confusion Matrix
TP<-model$finalModel$confusion[1]
FN<-model$finalModel$confusion[2]
FP<-model$finalModel$confusion[3]
TN<-model$finalModel$confusion[4]

sensitivityVal<-TP/(TP+FN)
specificityVal<-TN/(TN+FP)
ppvVal<-TP/(TP+FP)
accuracyVal<-(TP+TN)/(TP+FP+FN+TN)
FscoreVal<-(2*TP)/((2*TP) + FP + FN )

sink('/scratch/users/jmbanda/tst_hck/model_stuff/outcome4_model_evaluation.txt')
# summarize importance
cat('RandomForest model for Outcome 4')
cat(paste('\n\nModel Accuracy: ',accuracyVal,'\n',sep=''))
cat(paste('Model Sensitivity: ',sensitivityVal,'\n',sep=''))
cat(paste('Model Specificity: ',specificityVal,'\n',sep=''))
cat(paste('Model PPV: ',ppvVal,'\n',sep=''))
cat(paste('Model F-Score: ',FscoreVal,'\n',sep=''))
print(importance, top=10)
sink()

#### Specific Plots

