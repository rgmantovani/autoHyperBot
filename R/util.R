# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# * This function fill some slots from OML Tasks.
# An OpenML task just can be converted to an oml object, if:
#   1. it has at least one evaluation measure defined
#   2. the task and its dataset (both) must have least one target feature specified
#   3. [optional] Impute the missing values
#   4. [optional] 1-to-N enconde: converting categorical features to numeric ones

# TODO: Rename and move this function to another file

fillOMLTask = function(task, measures) {

  task$input$evaluation.measures = measures
  if (length(task$input$data.set$target.features) == 0) {
    task$input$data.set$target.features = task$input$target.features
  }

  new.task = imputeMissingValues(oml.task = task)
  new.task = OneToNEncoding(oml.task = new.task) 

  return(new.task)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
