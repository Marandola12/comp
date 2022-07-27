# Start of Andrea's classes
# RGDAL is gonna be switched to sf i guess

library(raster)
library(sf)
library(tmap)
library(ggplot2)
library(dplyr)

data("World")
tm_shape(World) +
    tm_borders()

head(World)
names(World)
class(World)
dplyr::glimpse(World)

plot(World[,1])
plot(World[1,])
plot(World["pop_est"])
a
head(World[,1:4])
class(World)
class(World$geometry)

head(sf::st_coordinates(World))

no_geom <- sf::st_drop_geometry(World)

class(no_geom)

st_bbox(World)

names(World)

unique(World$continent)

World %>%
  filter(continent == "South America") %>%
  tm_shape() +
  tm_borders()

## u can also not break the line and write filter(World, continent == "")


World %>%
  mutate(our_countries = if_else(iso_a3 %in% c("COL","BRA", "MEX"), "red", "grey")) %>%
  tm_shape() +
  tm_borders() +
  tm_fill(col = "our_countries") +
  tm_add_legend("fill",
                "Countries",
                col = "red")

# sp objects are going to be replaced with sf objects and packages rgdal, rgeos will be archived by the end of 2023. However, it is extremely possible that the data and tutorials you find use sp objects rather than sf and that you may have to go transform them into sf objects (function sf::st_as_sf().


# install.packages("rnaturalearthhires")
# install.packages("remotes")
#remotes::install_github("ropensci/rnaturalearthhires")
library(rnaturalearth)
library(rnaturalearthhires)
bra <- ne_states(country = "brazil", returnclass = "sf")
plot(bra)

dir.create("data/shapefiles", recursive = TRUE)
# with recursive true, you can create 2 folders with one function, cause it makes it recursive
st_write(obj = bra, dsn = "data/shapefiles/bra.shp", delete_layer =  TRUE)

bra2 <- read_sf("data/shapefiles/bra.shp")
plot(bra2)


# Load, plot, save a raster from disk

library(raster)
dir.create(path = "data/raster/", recursive = TRUE)
tmax_data <- getData(name = 'worldclim', var = 'tmax', res = 10, path = "data/raster/")
plot(tmax_data)

is(tmax_data)

dim(tmax_data)

extent(tmax_data)

res(tmax_data)

#
# This is really the tip of the iceberg. Choose your own adventure:
#
#   Check the vignettes in sf
# Check the tutorials in rspatialdata
# Check the multiple CRAN TaskViews regarding spatial data

# check WKT notation (Well-Known Text)

# colorbrewer2.org
# #| eval: false
# library(RColorBrewer)
# display.brewer.all(type = "seq")
# display.brewer.all(type = "div")


