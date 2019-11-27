# Creates a wrapper around seqgrid for more complex grids
# seqggrid works great for simple grids or more complex grids where you do the math beforehand
# creategrid is to do the math for complex grids for you (since they're always the same)
pigeon_creategrid <- function(stim_dim, grid_dim, buffer = 0, margins = buffer, location_jitter = FALSE){
  # TODO: error if length(location_jitter) > size
  # make pipeable? purrr::map2-able?
  # TODO: warning that abs() taken if any argument < 0

  size <- max(length(stim_dim), length(grid_dim), length(buffer), length(margins))

  # if only 1 variable of each is given, it assumes the grid is square
  #   TODO: warning for this
  if(size == 1){
    stim_dim <- rep(abs(stim_dim),2)
    grid_dim <- rep(abs(grid_dim),2)
    buffer <- rep(abs(buffer),2)
    margins <- rep(abs(margins),2)
    size = 2
  } else{
    # TODO: Warning that lengths not 1 or max size will re-iterate the list until it hits size
    stim_dim <- rep(abs(stim_dim), length.out = size)
    grid_dim <- rep(abs(grid_dim), length.out = size)
    buffer <- rep(abs(buffer), length.out = size)
    margins <- rep(abs(margins), length.out = size)
  }

  seq_from <- rep(NA,size)
  seq_to <- rep(NA,size)
  seq_by <- rep(NA,size)

  for(i in seq(size)){
    seq_from[i] = stim_dim[i]/2 + margins[i]
    seq_to[i] = grid_dim[i] - seq_from[i]
    seq_by[i] = stim_dim[i] + buffer[i]
  }

  OUT <- pigeon_seqgrid(seq_from, seq_to, seq_by)

  # Location jittering
  if(any(location_jitter != FALSE)){

    location_jitter <- rep(location_jitter, length.out = size)
    for(i in seq(size)){

      if(location_jitter[i] == TRUE){

        location_jitter[i] <- buffer[i]/2
        OUT[,i] <- OUT[,i] + runif(length(OUT[,i]),
                                   min = -location_jitter[i],
                                   max = location_jitter[i])

      } else if(is.numeric(location_jitter[i])){

        OUT[,i] <- OUT[,i] + runif(length(OUT[,i]),
                                   min = -location_jitter[i],
                                   max = location_jitter[i])

      }
    }
  }

  return(OUT)

}

