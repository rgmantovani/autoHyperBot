# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getAllPossibleLearners = function(task.id, measures) {

  task = getOMLTask(task.id = task.id)
  filled.task = fillOMLTask(task = task, measures = measures)

  obj = convertOMLTaskToMlr(filled.task)
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
