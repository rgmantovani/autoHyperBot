# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

generatingExperiment = function(reg, task.ids, measures, 
  repls = 1L, overwrite = FALSE, tag = NULL) {

  # calling batchmark for each task id
  aux = lapply(task.ids, function(task.id) {
    exec = batchmarkOML(
      reg = reg, 
      task.id = task.id, 
      measures = measures,
      repls = repls, 
      overwrite = overwrite,
      tag = tag
    )
    return(exec)
  })

  job.ids = unlist(aux)
  return(job.ids)

}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------