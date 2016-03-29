# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

batchmarkOML = function(reg, task.id, measures, repls = 1L, overwrite = FALSE, tag = "") {
  
  BatchExperiments:::checkExperimentRegistry(reg)
  
  if ("mlr" %nin% names(reg$packages)) {
    stop("mlr is required on the slaves, please add mlr via'addRegistryPackages'")
  }

  if ("OpenML" %nin% names(reg$packages)) {
    stop("OpenML is required on the slaves, please add OpenML via'addRegistryPackages'")
  }

  assertCount(repls)
  assertFlag(overwrite)
  
  learners = gettingMlrClassifLearners(task.id = task.id, measures = measures)
  learners.names = vcapply(learners, "[[", "id")

  # adding problems (tasks)
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
  
  # Adding algorithms (learners)
  algorithm.designs = Map(
    f = function(id, learner, tag) {
      apply.fun = getBatchmarkAlgoWrapper(learner, tag)
      addAlgorithm(reg = reg, id = id, fun = apply.fun, overwrite = overwrite)
      makeDesign(id = id)
    },
    id = learners.names, 
    learner = learners,
    tag = tag
  )

  # creating jobs
  job.ids = addExperiments(reg = reg, prob.designs = problem.designs, 
    algo.designs = algorithm.designs, repls = repls, skip.defined = TRUE)

  return (job.ids)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------