# Creates a standard Directory for Experiments
# TODO: Flesh out .md files
#   TODO: Use .RData files to make it clean (save doc headers to variable for it)
# TODO: Able to pick-and-choose (just the certain sections if needed)
# TODO: "presentation/OpenScience Section
pigeon_createDirectory <- function(path, name){
  originalwd <- getwd()
  setwd(path)
  dir.create(name)

  #### Overall ----
  setwd(paste0("./", name))
  dir.create(paste0("0_Documents_", name))
  dir.create(paste0("1_Experiment_", name))
  dir.create(paste0("2_Analysis_", name))
  dir.create(paste0("3_Presentation_", name))

  #### Documents Directory ----
  setwd(paste0("./0_Documents_", name))
  write("# History Log",  paste0("Log_", name,".md"))
  write("---
          title: \"Pre-Registration Template\"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```", paste0("PreReg_", name,".Rmd"))
  write("# Annotated Bibliography",  paste0("ABio_", name,".md"))
  setwd("../")

  #### Experiment Directory ----
  setwd(paste0("./1_Experiment_", name))
  dir.create("Stimuli")
  dir.create("Conditions")
  dir.create("Data")
  dir.create("./Stimuli/StimCreation")
  setwd("./Stimuli/StimCreation")
    write("# Stimuli Sources & Licenses", paste0("stimuliSourcesLicenses_", name,".md"))
    write("# Stimuli Creation & Criteria", paste0("stimuliCreationCriteria_", name,".md"))
    setwd("../../")

  setwd("../")

  #### Analysis Directory ----
  setwd(paste0("./2_Analysis_", name))
  dir.create("Plots")
  dir.create("TidyData")
  write("Version: 1.0", paste0(name,".Rproj"))
  write("---\ntitle: \"Untitled\"\noutput: html_document\n---\n
```{r setup, include=FALSE}\nknitr::opts_chunk$set(echo = TRUE)\n```",
        paste0("0_Report_", name,".Rmd"))
  write("#### Setup ----", paste0("1_ImportTidy_", name,".R"))
  write("#### Setup ----", paste0("2_AnalysisPlot_", name,".R"))
  setwd("../")

  #### Presentation Directory ----
  setwd(paste0("./3_Presentation_", name))
  dir.create(paste0("Poster_", name))
  dir.create(paste0("Paper_", name))
  dir.create(paste0("OpenScience_", name))

  # Poster Documents
  setwd(paste0("./Poster_", name))
    write("# Title\n## Abstract Submission\n\n##Introduction",
          paste0("posterText_", name,".md"))
    dir.create(paste0("posterImages_", name))
    dir.create(paste0("posterDataAnalysis_", name))
    setwd(paste0("posterDataAnalysis_", name))
      dir.create(paste0("cleanedData_", name))
      write("# TITLE", paste0("dataExplanation_", name, ".md"))
      write("---
title: \"Analysis Pipeline for Poster\"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```", paste0("posterAnalysis_", name,".Rmd"))
  setwd("../../")

  #### At end, returen wd to original location ----
  setwd(originalwd)
}

