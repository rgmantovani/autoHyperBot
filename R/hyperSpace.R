# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getSvmSpace = function(...) {
  par.set = makeParamSet(
    makeDiscreteParam("kernel", values = "radial", default = "radial", tunable = FALSE),
    makeNumericParam("cost" , lower = -12, upper = 12, trafo = function(x) 2^x),
    makeNumericParam("gamma", lower = -12, upper = 12, trafo = function(x) 2^x)
  )
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getRpartSpace = function(...) {
  par.set = makeParamSet(
    makeNumericParam("cp", lower = -4, upper = -1, trafo = function(x) 10^x),
    makeIntegerParam("minsplit", lower = 1, upper = 7, trafo = function(x) 2^x),
    makeIntegerParam("minbucket", lower = 0, upper = 6, trafo = function(x) 2^x)
  )
  return(par.set)  
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getGbmSpace = function(...) {
  par.set = makeParamSet(
    makeIntegerParam("iters", lower = 500, upper = 10000),
    makeIntegerParam("interaction.depth", lower = 1, upper = 5),
    makeNumericParam("shrinkage", lower = -4, upper = -1, trafo = function(x) 10^x)
  )
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getKknnSpace = function(...) {
  par.set = makeParamSet(
    makeIntegerParam("k", lower = 1, upper = 50, default = 1)
  )
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# NO - Error
getNnTrainSpace = function(...) {

  args = list(...)

  par.set = makeParamSet(
    makeIntegerVectorParam("hidden", len = 2, lower = 32, upper = 2048, cnames = NULL),
    makeIntegerParam("batchsize", lower = round(0.01 * args$n), upper = round(0.1 * args$n)),
    makeNumericParam("learningrate", lower = -5, upper = 0, trafo = function(x) 10^x),
    makeNumericParam("momentum", lower = 0.1, upper = 0.9),
    makeIntegerParam("numepochs", lower = 2, upper = 1000),
    makeNumericParam("learningrate_scale", lower = -7, upper = -4, trafo = function(x) 10^x)
  )
  return(par.set)
}

# hidden: vector for number of units of hidden layers.Default is c(10).
  #   - hidden layer size (32-2048)
  #   - number of layers (1 or 2)

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# getNaiveBayesSpace = function (...) {
#   return(NULL)
# }

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# ERROR
getGlmnetSpace = function(...) {

  par.set = makeParamSet(
    makeNumericParam("alpha", default = 0, tunable = FALSE)
    # makeNumericVectorParam("lambda", len = ?, lower = -12, upper = 12, trafo = funciton(x) 2^x)
  )
  return(par.set)
}

  # alpha = 0
  # lambda/s (preditc)
  # 2^-12, 2^12

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

getRangerSpace = function(...) {

  args = list(...)
  par.set = makeParamSet(
    makeIntegerParam("mtry", lower = round(args$p * 0.1), upper = round(args$p * 0.9))
  )
  return(par.set)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
#  ***** Defined Hyper-spaces not used *** 
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# getAvNNetSpace = function(...) {
#   par.set = makeParamSet(
#     makeLogicalParam("bag"),
#     makeIntegerParam("repeats", lower = 1, upper = 50)
#   )
#   return(par.set)
# }

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# getAdaSpace = function(...) {
#   par.set = makeParamSet(
#     makeIntegerParam("iter", lower = 2, upper = 128, default = 50),
#     makeNumericParam("nu", lower = 0, upper = 0.5, default = 0.1),
#     makeIntegerParam("minsplit", lower = 1, upper = 64, default = 20),
#     makeIntegerParam("maxdepth", lower = 1, upper = 30, default = 30)
#   )
#   return(par.set)
# }

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# getRandomForestSpace = function(...) {
#   par.set = makeParamSet(
#     makeIntegerParam("ntree", lower = 2, upper = 512, default = 500),
#     makeIntegerParam("mtry",  lower = 2, upper = 50)
#   )
#   return(par.set)
# }

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# getJ48Space = function(...) {
#   par.set = makeParamSet(
#     makeNumericParam("C", lower = 0.001, upper = 0.5, default = 0.25),
#     makeIntegerParam("M", lower = 1, upper = 64, default = 2)
#   )
#   return(par.set)  
# }


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# getPARTSpace = function(...) {
#   par.set = makeParamSet(
#     makeIntegerParam("M", lower = 1, upper = 64, default = 2),
#     makeIntegerParam("N", lower = 2, upper = 5, default = 3)
#   )
#   return(par.set)
# }

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# getBoostingSpace = function(...) {
#   par.set = makeParamSet(
#     makeIntegerParam("minsplit", lower = 1, upper = 64, default = 20),
#     makeNumericParam("cp", lower = 0, upper = 1, default = 0.01),
#     makeIntegerParam("maxdepth", lower = 1, upper = 30, default = 30)
#   )
#   return(par.set)
# }

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
