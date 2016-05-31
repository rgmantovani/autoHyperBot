# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

settingExperiment = function(reg, task.ids, measures, setup, 
  repls = 1L, overwrite = FALSE) {

  # Calling batchmark for each task id
  aux = lapply(task.ids, function(task.id) {
    
    exec = batchmarkOML(
      reg       = reg, 
      task.id   = task.id,
      measures  = measures,
      setup     = setup,
      repls     = repls, 
      overwrite = overwrite
    )
    return(exec)
  
  })

  job.ids = unlist(aux)
  return(job.ids)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------