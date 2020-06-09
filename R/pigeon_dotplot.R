pigeon_dotplot <- function(QuantA, QuantB, Radius, LocationSize, PlotID, seed = 112211){
  # TODO: Different Radii per Quant
  # TODO: Colors/Shapes/OtherThemes
  # TODO: Overlapping & Opacity
  # TODO: Equal among different stim
  # TODO: iterable, but not by Radius
  # TODO: Set Density (grep(median$y, y)) & rbinom?, Not sure how to do with x?
  # TODO: Replace grid creation with createGrid/seqGrid

  set.seed(seed)

  DotGrid <- data.frame(NULL)

  for(i in seq(length(Radius))){
    DotGridA <- tibble(
        XCords = seq((Radius[i]-LocationSize[i])/2, (LocationSize[i]-Radius[i])/2, by = Radius[i]/2),
        YCords = XCords) %>%
      expand(XCords, YCords)
    DotGridA <- DotGridA[sample(seq(length(DotGridA$XCords)), QuantA[i]),] %>%
      mutate(
        Ratio = QuantA[i]/QuantB[i],
        Type = "A",
        QuantA = QuantA[i],
        QuantB = QuantB[i],
        Radius = Radius[i],
        LocationSize = LocationSize[i],
        stimID = paste0("IR",Ratio*100,"A")
      )
    ggplot(DotGridA, aes(x = XCords, y = YCords)) +
      geom_jitter(size = DotGridA$Radius) +
      theme_void() +
      coord_cartesian(xlim = c(-10, 10), ylim = c(-10,10))
    ggsave(paste0(PlotID[i],"A.jpg"), device = "jpeg", height = 20, width = 20, units = "cm")


    DotGridB <- tibble(
      XCords = seq((Radius[i]-LocationSize[i])/2, (LocationSize[i]-Radius[i])/2, by = Radius[i]/2),
      YCords = XCords) %>%
      expand(XCords, YCords)
    DotGridB <- DotGridB[sample(seq(length(DotGridB$XCords)), QuantB[i]),] %>%
      mutate(
        stimID = i,
        Ratio = QuantA[i]/QuantB[i],
        Type = "B",
        QuantA = QuantA[i],
        QuantB = QuantB[i],
        Radius = Radius[i],
        LocationSize = LocationSize[i]
      )

    ggplot(DotGridB, aes(x = XCords, y = YCords)) +
      geom_jitter(size = DotGridB$Radius) +
      theme_void() +
      coord_cartesian(xlim = c(-10, 10), ylim = c(-10,10))
    ggsave(paste0(PlotID[i],"B.jpg"), device = "jpeg", height = 20, width = 20, units = "cm")

    print(i)
  }

  #write.csv(DotGrid, "ANSdotgrid.csv", append = FALSE)

}




#### What do I want from this script ----
# Creating randomized dot arrays in ggplot'
# Split creation of controlled inputs with actual array creation



#### Non-functioned Script ----
# Dot Creator

# library(tidyverse)
#
# set.seed(112211)
#
# Dots <- read_csv("~/Git/naturalistic-numbers/Experiment/NewDotConditions.csv")
# DotRecord <- data.frame(NULL)
# setwd("~/Git/naturalistic-numbers/Experiment/Stimuli/Dots/")
#
# for(i in 1:length(Dots$Stimuli)){
#   for(j in 1:2){
#     if(j == 1){
#       Dotplot1 <- tibble(Set = rep(Dots[i,]$ggsaveA, Dots[i,]$QuantA),
#                          Radius = rep(Dots[i,]$IRadiusA, length(Set)),
#                          Dotsx = sample(c(seq(10 - Dots[i,]$LA/2, 10 + Dots[i,]$LA/2, Radius[1]/12)), Dots[i,]$QuantA),
#                          Dotsy = sample(c(seq(10 - Dots[i,]$LA/2, 10 + Dots[i,]$LA/2, Radius[1]/12)), Dots[i,]$QuantA))
#
#       ggplot(Dotplot1, aes(x = Dotsx, y = Dotsy)) +
#         geom_point(size = Dotplot1$Radius) +
#         cowplot::theme_nothing() +
#         scale_x_continuous(expand=c(0,0)) +
#         scale_y_continuous(expand=c(0,0)) +
#         labs(x = NULL, y = NULL) +
#         coord_cartesian(xlim = c(0, 20), ylim = c(0,20))
#
#       ggsave(Dots[i,]$ggsaveA, device = "jpeg", height = 20, width = 20, units = "cm")
#
#     } else {
#       Dotplot2 <- tibble(Set = rep(Dots[i,]$ggsaveB, Dots[i,]$QuantB),
#                          Radius = rep(Dots[i,]$IRadiusB, length(Set)),
#                          Dotsx = sample(c(seq(10 - Dots[i,]$LB/2, 10 + Dots[i,]$LB/2, Radius[1]/12)), Dots[i,]$QuantB),
#                          Dotsy = sample(c(seq(10 - Dots[i,]$LB/2, 10 + Dots[i,]$LB/2, Radius[1]/12)), Dots[i,]$QuantB))
#
#       ggplot(Dotplot2, aes(x = Dotsx, y = Dotsy)) +
#         geom_point(size = Dotplot2$Radius) +
#         cowplot::theme_nothing() +
#         scale_x_continuous(expand=c(0,0)) +
#         scale_y_continuous(expand=c(0,0)) +
#         labs(x = NULL, y = NULL) +
#         coord_cartesian(xlim = c(0, 20), ylim = c(0,20))
#
#       ggsave(Dots[i,]$ggsaveB, device = "jpeg", height = 20, width = 20, units = "cm")
#
#     }
#     # dev.off()
#
#   }
#
#   DotRecord <- rbind(DotRecord, Dotplot1, Dotplot2)
#   print(i)
#
# }
#
# write_csv(DotRecord, "DOTSRecord.csv")
