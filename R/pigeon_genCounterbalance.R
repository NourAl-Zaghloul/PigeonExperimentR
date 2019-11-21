# To generate orders/trial structure
pigeon_genCounterbalance <- function(x, type = "latinsquare", seed = NA){
  # subtype = c("simple", "firstlast", "partial", "superpermutation", "LatinSquare")
  #   simple = every permutation (~pt)
  #   LatinSquare
  #   BalancedLatinSquare
  #   firstlast = makes sure the first and last order are differing, but middle is meh
  #     Slightly further than the latin square


  #
  if(type == "simple"){
    # TODO: Actually make the every permutation version
    OUT <- expand.grid(x)

  } else if(type == "latinsquare"){

    OUT <- data.frame(TEMP = rep(NA,length(x)))

    for(i in seq(length(x))){
      OUT[,i] <- x[c(i:length(x), 0:(i-1))]
    }

    colnames(OUT) <- paste0("order", seq(length(x)))

  } else if(type == "balancedlatinsquare"){

  } else if(type == "firstlast"){

  } else if(type == "superpermutation"){
    # Only if

  } else if(type == "interleaved"){

  }

  return(OUT)
}
