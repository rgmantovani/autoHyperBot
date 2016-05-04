# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# Required packages
library("checkmate")
library("OpenML")
library("mlr")
library("BatchExperiments")

# mlr and OpenML configurations
saveOMLConfig(apikey = "76444ac061f2b76258c96f680f0c6ae0", overwrite = TRUE)
setOMLConfig(arff.reader = "RWeka")
setOMLConfig(confirm.upload = FALSE)
configureMlr(show.info = TRUE)

# for debuging while coding
DEBUG = TRUE

# Predefined learners for the experiments
predefined.learners = c("classif.svm", "classif.rpart", "classif.gbm", "classif.kknn", 
  "classif.nnTrain", "classif.naiveBayes", "classif.glmnet", "classif.ranger")

sel.cols = c("run.id", "task.id", "flow.id", "predictive.accuracy", 
  "usercpu.time.millis.training", "usercpu.time.millis.testing")

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
