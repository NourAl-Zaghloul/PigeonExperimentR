pigeon_dottable <- function(minRatio = .5, maxRatio = .99, steps = .01,
                            minDots = 12){

  # TODO: Choice to supply own set of ratios or quantities
  ANSRatio <- seq(minRatio, maxRatio, by = steps)
  fractions <- MASS::as.fractions(ANSRatio)
  fractions <- as.data.frame(stringr::str_split(fractions, "/", simplify = TRUE))
  colnames(fractions) <- c("QuantA", "QuantB")
  fractions$QuantA <- type.convert(fractions$QuantA)
  fractions$QuantB <- type.convert(fractions$QuantB)
  #TODO: Fix below.
  fractions <- dplyr::mutate(
    Multiplier = ceiling(QuantA/minDots),
    QuantA = QuantA * Multiplier,
    QuantB = QuantB * Multiplier
  )
  dottable <- data.frame(
    Ratio = ANSRatio,
    QuantA = fractions[,1],
    QuantB = fractions[,2],
    # TODO: Everything below this line
    IRadius = rep(1,length(ANSRatio)),
    CArea = rep(1,length(ANSRatio)),
    CPerimeter = rep(1,length(ANSRatio)),
    LocationSize = rep(20,length(ANSRatio)),
    Density_DotXPx = rep(.001, length(ANSRatio)),
    Density_PxXArea = rep(.001, length(ANSRatio)),
    Control = rep(NA, times =  length(ANSRatio)),
    Serial = seq(length(ANSRatio))
  )
  dottable$StimID <- paste0(dottable$Serial, dottable$Control)
  return(dottable)

}

#### Goals ----

# This function will create a randomised & controlled table of dot array specs
#
