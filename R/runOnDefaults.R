# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

runOnDefaults = function(task, learner, debug = DEBUG) {

  l.name = paste(learner$type, learner$short.name, sep=".")
  flows = listOMLFlows()
  ids = which(tolower(flows$name) == l.name)
  f.ids = flows[ids, ]$flow.id

  # Access previous runs for this task
  prev.runs = listOMLRunEvaluations(task.id = task$task.id, verbosity = 2)
  sel.ids = which(f.ids %in% prev.runs$flow.id)
  
  # Check if something already exists, if no creates a new run
  if(length(sel.ids) == 0) {
    
    catf(" * New run required for this task and learner")
    flow.id = uploadOMLFlow(x = learner)
    obj = runTaskMlr(task = task, learner = learner) 
    obj$flow$flow.id = flow.id 
    obj$run$flow$flow.id = flow.id

    if(!debug) {
      catf(" - uploading result")
      run.id = uploadOMLRun(run = obj)    
    } 

    values = getBMRAggrPerformances(obj$bmr, as.df = TRUE)
    values$flow.id = flow.id

    if(debug) {
      values$run.id = 999999
    } else {
      values$run.id = run.id
    }
  
    values = renameDfColumns(values = values)
    values = values[, c(sel.cols, "learner.id")]
    values$task.id = as.numeric(as.character(gsub(x = values$task.id, 
      pattern = "OpenML-Task-", replacement = "")))

  } else { 
   
    catf(" * Retrieving results from OpenML")
    f.list = f.ids[sel.ids] 
    results.list = lapply(f.list, function(id) {
      ret = prev.runs[which(prev.runs$flow.id == id),]
      if(length(grep(colnames(ret), pattern = "usercpu.time")) == 0) {
        return(NULL)
      }
      else {
        aux = ret[, sel.cols]
        aux$learner.id = l.name
        return(aux)
      }
    })

    res.df = data.frame(do.call("rbind", results.list))
    values = res.df[which.max(res.df$run.id), ]
  }

  return(values)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


