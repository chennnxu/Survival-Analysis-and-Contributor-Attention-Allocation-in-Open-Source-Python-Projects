# attach the library
library(survival)

# set the working directory (adapt)
setwd("/home/cxu/code-eventnet/output")
# read the events
events <- read.csv("python3k_rem_after_EDIT.csv")
summary(events)

var.names <- names(events)
events[, c(9:length(var.names))] <- scale(events[, c(9:length(var.names))])

## specify and estimate a Cox proportional hazard model
my.surv <- Surv(time = rep(1, dim(events)[1]), event = events$IS_OBSERVED)
my.model <- coxph(
  my.surv ~ repetition + activity + popularity + clustering
  + strata(EVENT),
  data = events
)

capture.output(summary(my.model), file="rem_after_output_std.txt", append=FALSE, split=FALSE)

