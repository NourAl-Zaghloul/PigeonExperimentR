# Creates a wrapper around seqgrid for more complex grids
# seqggrid works great for simple grids or more complex grids where you do the math beforehand
# creategrid is to do the math for complex grids for you (since they're always the same)
pigeon_creategrid <- function(stim_dim, grid_dim, buffer = 0, margins = buffer, location_jitter = FALSE){
  # TODO: remove grid creation from pigeon_dotplot to simplify it
  # TODO: Location Jitter
  # make pipeable? purrr::map2-able?
  # TODO: Warning for lengths not 1 or max size that variables are set to repeat

  size <- max(length(stim_dim), length(grid_dim), length(buffer), length(margins))

  # if only 1 variable of each is given, it assumes the grid is square
  if(size == 1){
    stim_dim <- rep(stim_dim,2)
    grid_dim <- rep(grid_dim,2)
    buffer <- rep(buffer,2)
    margins <- rep(margins,2)
    size = 2
  } else{
    stim_dim <- rep(stim_dim, length.out = size)
    grid_dim <- rep(grid_dim, length.out = size)
    buffer <- rep(buffer, length.out = size)
    margins <- rep(margins, length.out = size)
  }

  seq_from <- rep(NA,size)
  seq_to <- rep(NA,size)
  seq_by <- rep(NA,size)

  for(i in seq(size)){
    seq_from[i] = stim_dim[i]/2 + margins[i]
    seq_to[i] = grid_dim[i] - seq_from[i]
    seq_by[i] = stim_dim[i] + buffer[i]
  }


  return(pigeon_seqgrid(seq_from, seq_to, seq_by))

}

#### createGrid.R ----
# library(tidyr)
# library(magrittr)
#
# # Creates a roughly square 7x4 grid for the center location of our stimuli
# # .Assumes a 16:9 monitor (~1.77 where 7/4 == 1.75)
# # .Our display monitor has a viewing size of approx. 52cm x 29.3cm
# # .Enough distance b/w locations (7.42 or 7.25 here) for random jitter by 2cm w/o overlap
# horizontal <- seq(22.26, -22.26, length.out = 7)
# vertical <- seq(-10.88, 10.88, length.out = 4)
#
#
# # Creates every iteration of the grid locations
# grid <- data.frame(horizontal,  vertical = rep(vertical, length(horizontal)))
# grid %>% expand(horizontal, vertical)
#
# write.csv(grid, "pseudogrid.csv", row.names = FALSE)

#### pigeon_dotplot ----
# pigeon_dotplot <- function(QuantA, QuantB, Radius, LocationSize, PlotID, seed = 112211){
#   # TODO: Different Radii per Quant
#
#   set.seed(seed)
#
#   DotGrid <- data.frame(NULL)
#
#   for(i in seq(length(Radius))){
#     DotGridA <- tibble(
#       XCords = seq((Radius[i]-LocationSize[i])/2, (LocationSize[i]-Radius[i])/2, by = Radius[i]/2),
#       YCords = XCords) %>%
#       expand(XCords, YCords)
#     DotGridA <- DotGridA[sample(seq(length(DotGridA$XCords)), QuantA[i]),] %>%
#       mutate(
#         Ratio = QuantA[i]/QuantB[i],
#         Type = "A",
#         QuantA = QuantA[i],
#         QuantB = QuantB[i],
#         Radius = Radius[i],
#         LocationSize = LocationSize[i],
#         stimID = paste0("IR",Ratio*100,"A")
#       )
#     ggplot(DotGridA, aes(x = XCords, y = YCords)) +
#       geom_jitter(size = DotGridA$Radius) +
#       theme_void() +
#       coord_cartesian(xlim = c(-10, 10), ylim = c(-10,10))
#     ggsave(paste0(PlotID[i],"A.jpg"), device = "jpeg", height = 20, width = 20, units = "cm")
#
#
#     DotGridB <- tibble(
#       XCords = seq((Radius[i]-LocationSize[i])/2, (LocationSize[i]-Radius[i])/2, by = Radius[i]/2),
#       YCords = XCords) %>%
#       expand(XCords, YCords)
#     DotGridB <- DotGridB[sample(seq(length(DotGridB$XCords)), QuantB[i]),] %>%
#       mutate(
#         stimID = i,
#         Ratio = QuantA[i]/QuantB[i],
#         Type = "B",
#         QuantA = QuantA[i],
#         QuantB = QuantB[i],
#         Radius = Radius[i],
#         LocationSize = LocationSize[i]
#       )
#
#     ggplot(DotGridB, aes(x = XCords, y = YCords)) +
#       geom_jitter(size = DotGridB$Radius) +
#       theme_void() +
#       coord_cartesian(xlim = c(-10, 10), ylim = c(-10,10))
#     ggsave(paste0(PlotID[i],"B.jpg"), device = "jpeg", height = 20, width = 20, units = "cm")
#
#     print(i)
#   }
#
# }

