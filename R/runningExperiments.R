# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

runningBatchExperiments = function(setup) {

  if(setup %nin% c("defaults", "tuning")) {
    stopf("Setup option not valid: choose between \'defaults\' or \'tuning\'")
  }
  
  reg = makeExperimentRegistry(
    id = paste0("hyperBot", R.utils::capitalize(setup)), 
    packages = c("ParamHelpers", "mlr", "OpenML"), 
    src.dirs = "R/"
  )

  # Resources (walltime = 8 hours, memory = 10GB)
  res = list(walltime = 8*60*60, memory = 10*1024) 

  catf(" * Loading OML tasks ...")
  tasks = getTaggedTasks(tag = "study_14")
  df.tasks = getTaggedTasks(tag = "study_7")

  # Running the tasks (with default) that were not run before
  if(setup == "defaults") {
    tasks = setdiff(tasks, df.tasks)
    tag = "defaults"  
  } else {
    tag = "OpenML-classification-v1"
  }

  measures = c("predictive_accuracy", 
    "usercpu_time_millis_testing", 
    "usercpu_time_millis_training"
  )
 
  # Creating new jobs
  new.jobs = settingExperiment(
    reg       = reg,
    task.ids  = tasks,
    measures  = measures,
    setup     = setup,
    overwrite = TRUE,
    repls     = 1,
    tag       = tag
  )

  # Checking if is the first submission
  if( length(findDone(reg)) == 0 ) {
    catf(" * First execution of the experiments ...")
  } else {
    catf(" * There are remaining jobs or new ones ...")
  }
 
  # Running what is not done
  all.jobs = setdiff(findNotDone(reg), findErrors(reg))
 
  catf(" * Submitting all jobs ...")
  submitJobs(reg = reg, ids = all.jobs, resources = res, job.delay = TRUE)
  status = waitForJobs(reg = reg, ids = all.jobs)

  # catf(" * Saving results ...")
  # done.jobs = findDone(reg)
  catf(" * Done.")

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# results = getReduceResults(reg, done.jobs)
  # save(results, file = "finalJobResults.RData")

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------