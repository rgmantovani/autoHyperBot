# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# Replacing Missing Values 

imputeMissingValues = function(oml.task) {

  dataset = oml.task$input$data.set$data
  
  if(any(is.na(dataset))) {
    temp = impute(data = dataset, target = oml.task$input$target.features,
      classes = list(numeric = imputeMedian(), factor = imputeConstant(const="Missing")))
    dataset = temp$data
    oml.task$input$data.set$data = dataset
  }
  
  return(oml.task)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# convert categorical to Numerical data

OneToNEncoding = function(oml.task) {

  dataset   = oml.task$input$data.set$data
  target    = oml.task$input$target.features
  target.id = which(colnames(dataset) == target)

  if(any(sapply(dataset[ , -target.id], class) == "factor")) {
    new.dataset = createDummyFeatures(dataset, target = target, method = "1-of-n")  
    colnames(new.dataset) = make.names(colnames(new.dataset))
    oml.task$input$data.set$data = new.dataset
    oml.task$input$data.set$colnames.new = colnames(new.dataset)
    oml.task$input$data.set$colnames.old = colnames(new.dataset)
  }
  
  return(oml.task)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
