pigeon_seqgrid <- function(from, to, by){
  # This is just a simple way to create a grid sequences using
  #   seq() and expand.grid() for all the combinations possible
  #   TODO: optional name parameter as well (must match length of from)
  #     otherwise: x,y,z if length(from) <= 3, or

  # TODO: error catching
  ##### error catching: ----
  #   From & To Lengths don't match or they are not 1L
  #     error, fix wrong one
  #     warning, values not same length as from are set to repeat until length.out=length(from)
  #   From, To, By are missing arguments
  #     error, create the missing values
  #   by causes From -> To to go in the wrong direction
  #     warning, reversed the direction automatically; may be wrong if not intention
  #   grid is too large!
  #     error, too many values to calculate effectively
  #   Doesn't have purr installed

  ##### Create the full vectors for our variables ----
  from2 = from
  to2 = rep(to, length.out = length(from))
  by2 = rep(by, length.out = length(from))

  #### Creates the dataframe ----
  # TODO: maybe change to apply & remove dependency
  data_list <- purrr::pmap(list(from2,to2,by2), seq)

  ##### expand.grid function----
  grid_expanded <- expand.grid(data_list)

  ##### returns the answer ----
  return(grid_expanded)

}
