# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# TODO: add a setup argument, when tuning be implemented
getBatchmarkAlgoWrapper = function(learner) {
    
  function(job, static, dynamic) {

    # if(setup == "defaults") {
    values = runOnDefaults(task = static$task, learner = learner)
    # } else {
    # values = runWithTuning(task = static$task, learner = learner, control = NULL, 
    #   inner = NULL)
    # }
    return(values)
  }

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
