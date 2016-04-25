# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getAllPossibleLearners = function(task.id, measures) {

  temp.task = getOMLTask(task.id = task.id)

  # OML task has no evaluation measure, but it needs at least one measure defined 
  if(length(temp.task$input$evaluation.measures) == 0) {
    temp.task$input$evaluation.measures = measures
  }

  # Dataset from the task has no target feature, but needs at least one to be converted into a mlr task
  if (length(temp.task$input$data.set$target.features) == 0) {
    temp.task$input$data.set$target.features = temp.task$input$target.features
  }

  obj = convertOMLTaskToMlr(temp.task)
  learners.list = listLearners(obj$mlr.task, create = TRUE, properties = "prob")

  return(learners.list)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getPredefinedLearners = function() {

  learners.list = lapply(predefined.learners, makeLearner, predict.type = "prob")
  return(learners.list)
  
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
