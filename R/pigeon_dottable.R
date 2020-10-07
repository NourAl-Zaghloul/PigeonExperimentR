pigeon_dottable <- function(minRatio = 1.01, maxRatio = 2, steps = .01,
                            minDots = 12, controls = c('IR', 'CA', 'CP')){

  # TODO: Replace magrittr
  require(magrittr)
  require(dplyr)
  # TODO: Choice to supply own set of ratios or quantities
  # TODO: Choose Controls, currently only IR, +Density/CArea/CPeri
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
  dotList <- list();
  for(i in seq(length(controls))){
    dotList[[i]] <- data.frame(
      Ratio = ANSRatio,
      QuantA = fractions$QuantA,
      QuantB = fractions$QuantB
    )

    if(controls[i] == 'IR'){
      dotList[[i]] <- dotList[[i]] %>% dplyr::mutate(
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
        ggsaveA = paste0(Control,Stimuli,"A"),
        ggsaveB = paste0(Control,Stimuli,"B")
      )
    } else if(controls[i] == 'CA'){
      dotList[[i]] <- dotList[[i]] %>% dplyr::mutate(
        #Assumes location size
        LocationSize = 20,
        CAreaA = runif(length(ANSRatio), min = LocationSize, max = LocationSize^2*2),
        CAreaB = CAreaA,
        IRadiusA = sqrt(CAreaA/(QuantA * pi)),
        IRadiusB = sqrt(CAreaB/(QuantB * pi)),
        CPeriA = QuantA * 2 * pi * IRadiusA,
        CPeriB = QuantB * 2 * pi * IRadiusB,
        Control = "CA",
        Stimuli = ANSRatio*100, #TODO: *whatever it needs to be a whole number
        ggsaveA = paste0(Control,Stimuli,"A"),
        ggsaveB = paste0(Control,Stimuli,"B")
      )
    } else if(controls[i] == 'CP'){
      dotList[[i]] <- dotList[[i]] %>% dplyr::mutate(
        #Assumes location size
        LocationSize = 20,
        CPeriA = runif(length(ANSRatio), min = LocationSize * 5, max = LocationSize^2 * 5), #Random-ish min/max size
        CPeriB = CPeriA,
        IRadiusA = CPeriA/(2*pi*QuantA),
        IRadiusB = CPeriB/(2*pi*QuantB),
        CAreaA = QuantA * IRadiusA^2 * pi,
        CAreaB = QuantB * IRadiusB^2 * pi,
        Control = "CP",
        Stimuli = ANSRatio*100, #TODO: *whatever it needs to be a whole number
        ggsaveA = paste0(Control,Stimuli,"A"),
        ggsaveB = paste0(Control,Stimuli,"B")
      )
    }
  }

  dottable <- dplyr::bind_rows(dotList)
    #TODO: Add Density_px/Density_quant
  return(dottable)
}

#### Goals ----

# This function will create a randomised & controlled table of dot array specs
#
