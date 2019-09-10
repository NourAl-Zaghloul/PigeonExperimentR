pigeon_dottable <- function(Ratios){

  # TODO: Choice to supply own set of ratios or quantities
  ANSRatio <- seq(.5,.99, by = Ratios)
  fractions <- MASS::as.fractions(ANSRatio)
  fractions <- stringr::str_split(fractions, "/", simplify = TRUE)
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
