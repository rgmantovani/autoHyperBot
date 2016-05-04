# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# TODO: add a setup argument, when tuning be implemented
getBatchmarkAlgoWrapper = function(learner, tag = NULL) {
    
  function(job, static, dynamic) {

    # if(setup == "defaults") {
    values = runOnDefaults(task = static$task, learner = learner, tag = tag)
    # } else {
    # values = runWithTuning(task = static$task, learner = learner, control = NULL, 
    #   inner = NULL, tag = NULL)
    # }
    return(values)
  }

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
