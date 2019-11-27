# To generate orders/trial structure
pigeon_genCounterbalance <- function(x, type = "latinsquare", seed = NA){
  # subtype = c("simple", "firstlast", "partial", "superpermutation", "LatinSquare")
  #   simple = every permutation (~pt)
  #   LatinSquare
  #   BalancedLatinSquare
  #   firstlast = makes sure the first and last order are differing, but middle is meh
  #     Slightly further than the latin square


  OUT <- data.frame(TEMP = rep(NA,length(x)))


  # The actual processes
  if(type == "simple"){
    # TODO: Translate this to the dataframe result
    # TODO: warning or error if permutation is going to be too large... > 5
    #       + Override if exists
    OUTtemp <- seq(length(x))
    for(i in seq(factorial(length(x)))){
      for(j in seq(length(x) - 1)){
        if(i%%factorial(j) == 0){
          OUTtemp <- OUTtemp[c(0:(length(x) - 1 - j), (length(x)-j+1):length(x), (length(x)-j))]
          print(OUTtemp)
        }
      }
    }

    OUT <- OUTtemp

  } else if(type == "latinsquare"){

    for(i in seq(length(x))){
      OUT[,i] <- x[c(i:length(x), 0:(i-1))]
    }

  } else if(type == "balancedlatinsquare"){

    z <- length(x)
    if (z%%2) {
      OUT <- data.frame(TEMP = rep(NA,z*2))
    }
    count <- 1
    OUTtemp <- c(1:2)
    for(i in seq(3,z)){
      if(i%%2){
        OUTtemp[i] <- z-(i-2-count)
      } else{
        OUTtemp[i] <- i-count
        count <- count + 1
      }
    }
    for(i in seq(z)){
      if(z%%2){
        OUT[, i] <- x[c(OUTtemp,rev(OUTtemp))]
      } else{
        OUT[, i] <- x[OUTtemp]
      }
      OUTtemp <- OUTtemp + 1
      OUTtemp[OUTtemp == z+1] <- 1
    }

  } else if(type == "firstlast"){

    # TODO: Maybe more of a balanced interior approach
    OUTfirstlast <- data.frame(First = unique(x),
                               Last = unique(x))
    OUTfirstlast <- expand.grid(OUTfirstlast)
    OUTfirstlast <- type.convert(OUTfirstlast[OUTfirstlast$First != OUTfirstlast$Last, ],
                                 as.is = TRUE)
    for(i in seq(length(OUTfirstlast$First))){
      OUT[,i] <- type.convert(
        c(OUTfirstlast[i,1],
          sample(unique(x[!(x %in% type.convert(OUTfirstlast[i, ], as.is = TRUE))])),
          OUTfirstlast[i,2]),
        as.is = TRUE)
    }

  } else if(type == "shortfirstlast"){

  } else if(type == "superpermutation"){


  } else if(type == "interleaved"){


  }

  colnames(OUT) <- paste0("order", seq(length(OUT)))

  return(OUT)
}
