pigeon_seqgrid <- function(from, to, by, names.col = NULL){
  # This is just a simple way to create a grid sequences using
  #   seq() and expand.grid() for all the combinations possible

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
  # TODO: Really need a warning created here
  from2 = from
  to2 = rep(to, length.out = length(from))
  by2 = rep(by, length.out = length(from))

  #### Creates the dataframe ----
  # TODO: maybe change to apply & remove dependency
  data_list <- purrr::pmap(list(from2,to2,by2), seq)

  ##### expand.grid function----
  grid_expanded <- expand.grid(data_list)

  #### variable naming ----
  # TODO: Warning
  if(exists("names.col") && length(names.col) >= length(from2)){
    names(grid_expanded) <- names.col
  } else if(length(from2) <= 3){
    names(grid_expanded) <- c("x","y","z")[1:length(from2)]
  }

  ##### returns the answer ----
  return(grid_expanded)

}
