# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# Replacing Missing Values 

imputeMissingValues = function(oml.task) {

  #Remove columns with just NAs
  dataset = oml.task$input$data.set$data
  dataset = dataset[,colSums(is.na(dataset)) < nrow(dataset)]
  colnames(dataset) = make.names(names = colnames(dataset), unique = TRUE, allow_ = TRUE)

  if(any(is.na(dataset))) {
    cat(" - imputing data\n")
    temp = mlr::impute(dataset, target = oml.task$input$target.features,
      classes = list(numeric = imputeMean(), factor = imputeConstant(const="Missing")))
    dataset = temp$data
    oml.task$input$data.set$data = dataset
  }else {
    cat(" - no missing values (NAs)\n")
  }

  return(oml.task)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# convert categorical to Numerical data
# FIX ME: check this function, not working properly
OneToNEncoding = function(oml.task) {

  dataset   = oml.task$input$data.set$data
  target    = oml.task$input$target.features
  target.id = which(colnames(dataset) == target)
  new.task  = oml.task
  
  if(any(sapply(dataset[ , -target.id], class) == "factor")) {
    catf(" - converting categorical features to numeric ones\n")
    temp = convertOMLTaskToMlr(oml.task)
    ret = createDummyFeatures(obj = temp$mlr.task, method = "1-of-n")
    new.data = ret$env$data 
    colnames(new.data) = make.names(colnames(new.data), unique = TRUE, allow_ = FALSE)
    new.task$input$data.set$data = new.data
    new.task$input$data.set$colnames.new = colnames(new.data)
  }

  return(new.task)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# oml.task = getOMLTask(14967)
# task2 = imputeMissingValues(oml.task)
 # runTaskMlr(new.task, makeLearner("classif.J48"))

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
