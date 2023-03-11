remove.packages("mdt")
remove.packages("psychTestR")

devtools::install_local("/Users/adrian/psychTestR")

devtools::install_local("/Users/adrian/Projects/mdt")

library(mdt)
library(htmltools)

standalone_mdt(num_items = 20, take_training = TRUE)
# with training
 standalone_mdt(num_items = 18, take_training = FALSE)
