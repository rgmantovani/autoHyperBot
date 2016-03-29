# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

runningBatchExperiments = function() {

  reg = makeExperimentRegistry(
    id = "hyperBot", 
    packages = c("ParamHelpers", "mlr", "OpenML"), 
    src.dirs = "R/"
  )

  # resources (walltime = 8 hours, memory = 10GB)
  res = list(walltime = 8*60*60, memory = 10*1024) 

  catf(" * Loading OML tasks ...")
  all.tasks = gettingActiveOMLTasks()

  measures = c("predictive_accuracy", 
        "usercpu_time_millis_testing", 
        "usercpu_time_millis_training")
 
  # Creating new jobs
  new.jobs = generatingExperiment(
    reg = reg,
    task.ids = all.tasks,
    measures = measures,
    overwrite = TRUE,
    repls = 1,
    tag = "OpenML-100-collection"
  )

  # check in if the first submission
  if( length(findDone(reg)) == 0 ) {
    catf(" * First execution of the experiments ...")
  } else {
    catf(" * Remaining jobs or new ones ...")
  }
 
  # Running what is not done
  all.jobs = setdiff(findNotDone(reg), findErrors(reg))
 
  catf(" * Submitting all jobs ...")
  submitJobs(reg = reg, ids = all.jobs, resources = res, job.delay = TRUE)
  status = waitForJobs(reg = reg, ids = all.jobs)

  catf(" * Saving results ...")
  done.jobs = findDone(reg)
  results = getReduceResults(reg, done.jobs)
  save(results, file = "finalJobResults.RData")
  catf(" * Done.")

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------