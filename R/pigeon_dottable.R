pigeon_dottable <- function(minRatio = 1.01, maxRatio = 2, steps = .01,
                            minDots = 12){

  # TODO: Replace magrittr
  require(magrittr)
  # TODO: Choice to supply own set of ratios or quantities
  # TODO: Choose Controls, currecntly only IR, +Density/CArea/CPeri
  ANSRatio <- seq(minRatio, maxRatio, by = steps)
  fractions <- MASS::as.fractions(ANSRatio)
  fractions <- as.data.frame(stringr::str_split(fractions, "/", simplify = TRUE))
  colnames(fractions) <- c("QuantA", "QuantB")
  fractions$QuantA <- type.convert(fractions$QuantA)
  fractions$QuantB <- type.convert(fractions$QuantB)
  # in case the ratio is a whole number (e.g. 2 instead of 2/1)
  fractions <- fractions %>% dplyr::mutate(QuantB = ifelse(is.na(QuantB),1,QuantB))
  fractions$Multiplier <- ceiling((minDots+runif(1,min=0,max=2*minDots))/fractions$QuantB)
  fractions$QuantA <- fractions$Multiplier * fractions$QuantA
  fractions$QuantB <- fractions$Multiplier * fractions$QuantB
  dottable <- data.frame(
    Ratio = ANSRatio,
    QuantA = fractions$QuantA,
    QuantB = fractions$QuantB
  ) %>% dplyr::mutate(
    #Assumes location size
    LocationSize = 20,
    IRadiusA = runif(length(ANSRatio), min = .5, max = LocationSize/sqrt(QuantB)),
    IRadiusB = IRadiusA,
    CAreaA = QuantA * IRadiusA^2 * pi,
    CAreaB = QuantB * IRadiusB^2 * pi,
    CPeriA = QuantA * 2 * pi * IRadiusA,
    CPeriB = QuantB * 2 * pi * IRadiusB,
    Control = "IR",
    Stimuli = ANSRatio*100,
    ggsaveA = paste0(Control,Stimuli,"A.jpg"),
    ggsaveB = paste0(Control,Stimuli,"B.jpg")
    #TODO: Add Density_px/Density_quant
    #TODO: Add stim ID
  )
  return(dottable)

  # dottable <- data.frame(
  #   Ratio = ANSRatio,
  #   QuantA = fractions[,1],
  #   QuantB = fractions[,2],
  #   # TODO: Everything below this line
  #   IRadius = runif(1, min = .01, max = 20/(2*fractions$QuantB)),
  #   CArea = rep(1,length(ANSRatio)),
  #   CPerimeter = rep(1,length(ANSRatio)),
  #   LocationSize = rep(20,length(ANSRatio)),
  #   Density_DotXPx = rep(.001, length(ANSRatio)),
  #   Density_PxXArea = rep(.001, length(ANSRatio)),
  #   Control = rep(NA, times =  length(ANSRatio)),
  # #   Serial = seq(length(ANSRatio))
  # )
  # dottable$StimID <- paste0(dottable$Serial, dottable$Control)
}

#### Goals ----

# This function will create a randomised & controlled table of dot array specs
#
