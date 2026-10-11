library(data.table)

data_dir <- file.path("data", "raw")
archive_path <- file.path(data_dir, "household_power_consumption.zip")
data_path <- file.path(data_dir, "household_power_consumption.txt")
data_url <- "https://archive.ics.uci.edu/static/public/235/individual+household+electric+power+consumption.zip"

dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
if (!file.exists(data_path)) {
  if (!file.exists(archive_path)) {
    download.file(data_url, archive_path, mode = "wb")
  }
  unzip(archive_path, exdir = data_dir)
}

powerDT <- fread(data_path, na.strings = "?")
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
powerDT <- powerDT[dateTime >= as.POSIXct("2007-02-01") & dateTime < as.POSIXct("2007-02-03")]
