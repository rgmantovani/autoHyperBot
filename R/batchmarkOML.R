# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

batchmarkOML = function(reg, task.id, measures, setup, repls = 1L, 
  overwrite = FALSE) {
  
  BatchExperiments:::checkExperimentRegistry(reg)
  
  if ( any(c("mlr", "OpenML") %nin% names(reg$packages)) ) {
    stop("\'mlr\' and \'OpenML\' are required on the slaves, please add them via 'addRegistryPackages'")
  }

  assertCount(repls)
  assertFlag(overwrite)
  
  # Get Task (just once)
  task = getOMLTask(task.id = task.id)
  filled.task = fillOMLTask(task = task, measures = measures)

  # Run all available learners if 'defaults' option was defined
  if(setup == "defaults"){
    learners = getAllPossibleLearners(filled.task = filled.task)[1:3]
  } else{
    learners = getPredefinedLearners()[1:3]
  }
  # learners = learners[1] #just for tests
  learners.names = vcapply(learners, "[[", "id")

  # Adding problems (tasks)
  problem.designs = Map(
    f = function(id, task.id, seed) {
      task = filled.task
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
    f = function(id, learner) {
      apply.fun = getBatchmarkAlgoWrapper(learner)
      addAlgorithm(reg = reg, id = id, fun = apply.fun, overwrite = overwrite)
      makeDesign(id = id)
    },
    id = learners.names, 
    learner = learners
  )

  # Creating jobs
  job.ids = addExperiments(reg = reg, prob.designs = problem.designs, 
    algo.designs = algorithm.designs, repls = repls, skip.defined = TRUE)

  return (job.ids)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
