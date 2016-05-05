# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

resubmitJobs = function() {

  devtools::load_all()

  setup = "defaults"
  reg = makeExperimentRegistry(
    id = paste0("hyperBot", R.utils::capitalize(setup)), 
    packages = c("ParamHelpers", "mlr", "OpenML"), 
    src.dirs = "R/"
  )

  # Resources (walltime = 8 hours, memory = 10GB)
  res = list(walltime = (8*60*60), memory = (10*1024)) 

  catf(" * There are remaining jobs or new ones ...")
  all.jobs = setdiff(findNotDone(reg), findErrors(reg))

  # catf(" * Submitting all jobs ...")
  submitJobs(reg = reg, ids = all.jobs, resources = res, job.delay = TRUE)
  status = waitForJobs(reg = reg, ids = all.jobs)
  catf(" * Done.")

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

resubmitJobs()

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
