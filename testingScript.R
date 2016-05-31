# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

  devtools::load_all()

  DEBUG = TRUE

  unlink("hyperBotDefaults-files/", recursive = TRUE)

  # Creates a new registry, or loads a previous one
  setup = "defaults"
  reg = makeExperimentRegistry(
    id = paste0("hyperBot", R.utils::capitalize(setup)), 
    packages = c("ParamHelpers", "mlr", "OpenML"), 
    src.dirs = "R/"
  )

  # Resources (walltime = 8 hours, memory = 10GB)
  res = list(walltime = 8*60*60, memory = 10*1024) 

  catf(" * Loading OML tasks ...")
  df.tasks = getTaggedTasks(tag = "study_7")
  tasks = getTaggedTasks(tag = "study_14")
  
  # Running the tasks (with default) that were not run before
  if(setup == "defaults") {
    tasks = setdiff(tasks, df.tasks)
    tag = "defaults"  
  } else {
    tag = "tuned"
  }

  tasks = setdiff(tasks, 34536)
  tasks = tasks[1:3]

  measures = c("predictive_accuracy", 
    "usercpu_time_millis_testing", 
    "usercpu_time_millis_training")

  # Creating new jobs
  new.jobs = settingExperiment(
    reg       = reg,
    task.ids  = tasks, 
    measures  = measures,
    setup     = setup,
    overwrite = TRUE,
    repls     = 1
  )

  # # Checking if is the first submission
  if( length(findDone(reg)) == 0 ) {
    catf(" * First execution of the experiments ...")
  } else {
    catf(" * There are remaining jobs or new ones ...")
  }
 
  # # Running what is not done
  all.jobs = setdiff(findNotDone(reg), findErrors(reg))
  print(all.jobs)

  # Call test jobs
  for(job in all.jobs){
    testJob(reg = reg, id = job)
  }

  # catf(" * Submitting all jobs ...")
  # submitJobs(reg = reg, ids = all.jobs, resources = res, job.delay = TRUE)
  # status = waitForJobs(reg = reg, ids = all.jobs)

  # # catf(" * Saving results ...")
  # done.jobs = findDone(reg)
  # df = reduceDefaultResults(reg, done.jobs)
  catf(" * Done.")

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------