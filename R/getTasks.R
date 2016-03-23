# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getTaggedTasks = function(tag) {

  tasks = listOMLTasks(tag = tag)
  tasks$dim = tasks$NumberOfInstances * tasks$NumberOfFeatures
  tasks = tasks[ order(tasks$dim, decreasing = FALSE), ]

  return(tasks$task.id)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

gettingActiveOMLTasks = function() {

  tasks = listOMLTasks(status = "active")

  tasks.ids = which(tasks$task.type == "Supervised Classification"	 
    & tasks$estimation.procedure == "10-fold Crossvalidation"
    & tasks$NumberOfInstances >= 100 
    & tasks$NumberOfInstances <= 100000
    & tasks$NumberOfMissingValues == 0)

  sel.tasks = tasks[tasks.ids, ]
  
  sel.tasks$dims = sel.tasks$NumberOfInstances * sel.tasks$NumberOfFeatures
  sel.tasks = sel.tasks[ order(sel.tasks$dims, decreasing = FALSE), ]

  # Remove big datasets
  sel.tasks = sel.tasks[sel.tasks$dims < 10^6,]

  # Tasks with errors
  remove.tasks = c(3509, 3508, 8, 10107, 10109)
  ret = setdiff(sel.tasks$task.id, remove.tasks)

  return (ret)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
