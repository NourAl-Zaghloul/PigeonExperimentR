pigeon_dotplot <- function(Quantity, Radius, Density, DotNames = NA_character_,
                           length = 20, width = 20, units = "cm",
                           save = "jpg", csv = FALSE,
                           seed = 112211, output = "list"){


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
