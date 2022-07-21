

library(dplyr)
library(ggplot2)
library(lubridate) # HAS A REALLY GOOD CHEAT SHEET FOR MAPS AND TIME SERIES
library(zoo)



covid <- read.csv("data/raw/covid19-dd7bc8e57412439098d9b25129ae6f35.csv")
# covid[522,10] <- 70


# First checking the class
class(covid$date)


# Changing to date format
covid$date <- as_date(covid$date)
# Checking the class
class(covid$date)

# Now we can make numeric operations
range(covid$date)




# First, we will create a column containing the number of new cases.

ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal()

# fixing broken vals

# for i in covid$new_confirmed[i]{
#   if i !numeric():
#     as.numeric(covid$new_confirmed[i])
# }


covid$new_confirmed[covid$new_confirmed < 0] <-
  ggplot(covid) +
  geom_line(aes(x = date, y = new_confirmed)) +
  theme_minimal() +
  labs(x = "Date", y = "New cases")

# rolling mean fill na to mainain object with same dimensions  sizes
#
# covid$roll_mean <- zoo::rollmean(covid$new_confirmed, 14, fill = NA)
#
# head(covid)
#
# ggplot(covid) +
#   geom_line(aes(x = date, y = new_confirmed)) +
#   theme_minimal() +
#   labs(x = "Date", y = "New cases")
#   scale_x_date(breaks = )
#   geom_line(aes(x = date, y = roll_mean, col = 'red', size = 1.2))
