# Creates a standard Directory for Experiments
pigeon_createDirectory <- function(path, name){
  originalwd <- getwd()
  setwd(path)
  dir.create(name)

  # Overall
  setwd(paste0("./",name))
  dir.create(paste0("0_Documents_",name))
  dir.create(paste0("1_Experiment",name))
  dir.create(paste0("2_Analysis",name))
  dir.create(paste0("3_Presentation",name))

  # Documents Directory
  setwd(paste0("0_Documents_",name))
  write("# History Log",  paste0("Log_",name,".md"))
  write("# Pre-Registration Template", paste0("PreReg_",name,".Rmd"))
  write("# Annotated Bibliography",  paste0("ABio_",name,".md"))
  setwd("../")

  # Experiment Directory
  setwd(paste0("./1_Experiment/",name))
  dir.create("Stimuli")
  dir.create("Conditions")
  dir.create("Data")
  dir.create("./Stimuli/StimCreation")

  setwd("../")

  # Analysis Directory
  setwd(paste0("2_Analysis",name))

  setwd("../")

  # Presentation Directory
  setwd(paste0("3_Presentation",name))

  setwd("../")

  # At end, returen wd to original location
  setwd(originalwd)
}
