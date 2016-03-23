# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getBatchmarkAlgoWrapper = function(learner, tag = NULL) {
  
  function(job, static, dynamic) {

    flow.id = uploadOMLFlow(x = learner)
    obj = runTaskMlr(task = static$task, learner = learner)
    obj$flow$flow.id = flow.id 
    obj$run$flow$flow.id = flow.id
   
    new.run.id = uploadOMLRun(run = obj$run)
    tagOMLObject(id = new.run.id, object = "run", tags = c("mlr", tag))

    values = getBMRAggrPerformances(obj$bmr, as.df = TRUE)
    values$flow.id = flow.id
    values$run.id = new.run.id
    
    return(values)
  }

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------