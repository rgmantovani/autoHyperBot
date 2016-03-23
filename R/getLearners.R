# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

gettingMlrClassifLearners = function(task.id, measures) {

  temp.task = getOMLTask(task.id = task.id)

  if(length(temp.task$input$evaluation.measures) == 0) {
    temp.task$input$evaluation.measures = measures
  }

  # Datasets with no Class target, but it has on the task
  if (length(temp.task$input$data.set$target.features) == 0) {
    temp.task$input$data.set$target.features = temp.task$input$target.features
  }

  obj = convertOMLTaskToMlr(temp.task)
  learners.list = listLearners(obj$mlr.task, create = TRUE, properties = "prob")

  return(learners.list)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
