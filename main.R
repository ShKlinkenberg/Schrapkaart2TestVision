# Author: Adam Sasiadek
# Description: This script reads in Teleform output (as csv) and turns it into a 
# TestVision usable format. 

# Read the csv file with output

data <-
  read.csv(
    file.choose(),
    header = FALSE,
    na.strings = 9,
    stringsAsFactors = FALSE
  )

head(data)

# The amount of MC answers. 

aantalVragen <- 15

# Extract student number from input.

aanmeldnaam <- data[3:dim(data)[1], 1]

# Test ID. 

toetsId <- 12345

toetsId <- rep(toetsId, length(aanmeldnaam))

# Production Code.

productieCode <- 54321

productieCode <- rep(productieCode, length(aanmeldnaam))

# Test Datum. Format is YYYYMMDDHHmm! 

toetsDatum <- "201708010101"

toetsDatum <- rep(as.Date(toetsDatum,format = "%Y%m%d%H%M"),length(aanmeldnaam)) 

# Extracting the answers. 

antwoorden <- data[3:dim(data)[1], 3:dim(data)[2]]

antwoorden <- antwoorden[, 1:aantalVragen]

# Put everything into a data frame and generate output.csv

output <-
  data.frame(aanmeldnaam, toetsId, productieCode, toetsDatum , antwoorden)

# Check for anomalies in the data before writing. Are there empty student numbers?
# Students that only have NA as their answer etc. 

write.table(
  output,
  "output.csv",
  na = " ",
  row.names = FALSE,
  col.names = FALSE,
  sep = ","
)
