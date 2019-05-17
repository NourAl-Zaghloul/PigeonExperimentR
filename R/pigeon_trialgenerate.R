#### Order of Operations ----

# Step 1: Determine how many stimuli from each category is going to be used.
#   default = trial_quantity/(length(unique(categories)))
#   [weighting]
# Step 2: Determine the level of randomization
#   bin_repeat = 1 by default
#   bin_size = bin_repeat * (length(unique(categories)))
#   [bin_randomize & bin_size]
# Step 3: Determine stimuli assignment to each trial
#   default dist = "Uniform" (binomial for 1 is also possible)
#   [distributions]
# Step 4: Clean & Ready data for export


####  Uniform Dist, 1 Category, Equal Weights Trial ----
library(tidyverse)
library(microbenchmark)

set.seed(112211)

information <- data.frame(
  images   = c(1:100),
  category = rep(c("a","b"), each = 50),
  wayyyy   = c(rep(1/200, 50), rep(1/50, 50))
  )

trial_quantity <- 24
category_levels <- 1

categories <- unique(information$category)
bin_size <- length(categories)
bin_quantity <- trial_quantity/bin_size

sampled_list <- list()

for(i in categories){
  n <- grep(i, categories)
  filtered <- information[information[1+category_levels] == i, 1 ]
  sampled <- sample(filtered, bin_quantity, replace = FALSE)
  sampled_list[[n[1]]] <- sampled
}

filtered <- sapply(sampled_list, function(x) x[1:bin_quantity])
final_list <- list()
for(j in seq(bin_quantity)){
  final_list[[j]] <- sample(filtered[j,])
}

# rows are trial blocks, columns are the sequence
trials <- do.call(rbind, final_list)

#### Binomial Dist, 1 Category,


#### Notes ----

# Method: Figure out how the cats are going to fill the bins, and then do the stim
# TODO: Replace most for loops with lappy!
# TODO: "Counterbalanced" or fullly balanced option (for small #s)
# Additional Categories are just levels of recursion really
# Binomial distribution assumes sd = trial_quantity/6 by default
# Different distributions just fill the bins differently
# Different weights affect bin filling
# Weight Values > 1 are considered to be exact amount to be displayed
# Weight Values < 1 are considered to be percentage of total trials
# Distributions include "Uniform", "Binomial" (Req mean & sd), "Poisson" (),
#   "Fixed_Block" (e.g. c("Face", "Shape", "Number")), "Fixed_Complete" (all them)

#### Function ----
#' Generates trial order for
pigeon_trialgenerate <- function(x, trial_quantity = length(x[,1]), category_levels = 1,
                                 distribution = "Uniform", weights = FALSE,
                                 seed = 112211){
  sset.seed(seed)

  categories <- unique(x[,2])
  bin_size <- length(categories)
  bin_quantity <- trial_quantity/bin_size

  sampled_list <- list()

  for(i in categories){
    n <- grep(i, categories)
    filtered <- x[information[1+category_levels] == i, 1 ]
    sampled <- sample(filtered, bin_quantity, replace = FALSE)
    sampled_list[[n[1]]] <- sampled
  }

  filtered <- sapply(sampled_list, function(x) x[1:bin_quantity])
  final_list <- list()
  for(j in seq(bin_quantity)){
    final_list[[j]] <- sample(filtered[j,])
  }
  trials <- do.call(rbind, final_list)

  invisible(return(
    as.data.frame(trials)
    ))

}
