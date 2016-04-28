# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#TODO: default values for measures and tag?

batchmarkOML = function(reg, task.id, measures, setup, 
  tag, repls = 1L, overwrite = FALSE) {
  
  BatchExperiments:::checkExperimentRegistry(reg)
  
  if ( any(c("mlr", "OpenML") %nin% names(reg$packages)) ) {
    stop("\'mlr\' and \'OpenML\' are required on the slaves, please add them via 'addRegistryPackages'")
  }

  # TODO: more assertions ?
  assertCount(repls)
  assertFlag(overwrite)
  
  # Run all available learners if 'defaults' option was defined
  if(setup == "defaults"){
    learners = getAllPossibleLearners(task.id = task.id, measures = measures)
  } else{
    learners = getPredefinedLearners()
  }

  #just for tests
  learners = learners[1:3]
  learners.names = vcapply(learners, "[[", "id")

  # Adding problems (tasks)
  problem.designs = Map(
    f = function(id, task.id, seed) {
      task = getBatchmarkTaskWrapper(task.id, measures)
      static = list(task = task)
      addProblem(reg = reg, id = id, static = static, overwrite = overwrite, seed = seed)
      makeDesign(id = id)
    }, 
    id = paste0("OpenML_Task_", task.id), 
    task.id = task.id,
    seed = reg$seed + seq_along(task.id)
  )
  
  # TODO: Add setup as an argument here
  # Adding algorithms (learners)
  algorithm.designs = Map(
    f = function(id, learner, tag) {
      apply.fun = getBatchmarkAlgoWrapper(learner, tag)
      addAlgorithm(reg = reg, id = id, fun = apply.fun, overwrite = overwrite)
      makeDesign(id = id)
    },
    id = learners.names, 
    learner = learners,
    # setup = setup,
    tag = tag
  )

  # Creating jobs
  job.ids = addExperiments(reg = reg, prob.designs = problem.designs, 
    algo.designs = algorithm.designs, repls = repls, skip.defined = TRUE)

  return (job.ids)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------