pigeon_seqgrid <- function(from, to, by, names.col = NULL){
  # This is just a simple way to create a grid sequences using
  #   seq() and expand.grid() for all the combinations possible
  #
  # TODO: make it so just the longest vector is the reference vector for length, not from every time
  #
  #
  ##### error catching: ----
  #   TODO: grid is too large!
  #             error, too many values to calculate effectively
  #   Doesn't have purr installed?
  if(any(from > to) && any(by[from > to] > 0)){
    stop("wrong sign in 'by' argument", call. = FALSE)
  }
  if(any(by == 0)){
    stop("'by' cannot equal 0", call. = FALSE)
  }

  ##### Create the full vectors for our variables ----
  # TODO: Update warning for when from is not necessarily the longest variable
  # TODO:     Add 'from' warnings for length
  if(length(to) > 1 && length(to) != length(from)){
    warning(paste("'to' variable is > 1, but < length(from),",
                  "'to' variable set to repeat out to length(from)", sep = "\n"),
            call. = FALSE)
  }
  if(length(by) > 1 && length(by) != length(from)){
    warning(paste("'by' variable is > 1, but < length(from),",
                  "'by' variable set to repeat out to length(from)", sep = "\n"),
            call. = FALSE)
  }
  from2 = from
  to2 = rep(to, length.out = length(from))
  by2 = rep(by, length.out = length(from))

  #### Creates the dataframe ----
  # TODO: maybe change to apply & remove dependency
  data_list <- purrr::pmap(list(from2,to2,by2), seq)

  ##### expand.grid function----
  grid_expanded <- expand.grid(data_list)

  #### variable naming ----
  if(exists("names.col") && length(names.col) >= length(from2)){
    names(grid_expanded) <- names.col
  } else if(length(from2) <= 3){
    names(grid_expanded) <- c("x","y","z")[1:length(from2)]
  }

  ##### returns the answer ----
  return(grid_expanded)

}
