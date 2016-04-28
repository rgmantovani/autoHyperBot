# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

renameDfColumns = function(values) {

  colnames(values)[grep("acc.test.mean", colnames(values))] = "predictive.accuracy"
  colnames(values)[grep("timetrain.test.sum", colnames(values))] = "usercpu.time.millis.training"
  colnames(values)[grep("timepredict.test.sum", colnames(values))] = "usercpu.time.millis.testing"

  return(values)
}

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
