# ============================================================================
# OpenStreetMap tile basemaps of Peru in R (topographic/cartographic mapping)
#
# This script produced the R figures in the peer-reviewed article:
#   Lemenkova, P. (2021). Scripting Cartographic Techniques of R and GMT for
#   Geomorphological and Topographic Mapping of Peru.
#   Entorno Geografico, 22, 36-55.
#   DOI:    https://doi.org/10.25100/eg.v0i22.11331
#   Zenodo: https://doi.org/10.5281/zenodo.5059867
#   HAL:    https://hal.science/hal-03276386
#   SSRN:   https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3878727
#
# The article combines R and GMT; this repository holds the R OpenStreetMap
# basemap scripts.
#
# Author: Polina Lemenkova  |  ORCID: 0000-0002-5759-1089
# ============================================================================

# Hillshade map. Hillshade maps show the topographical shape of hills and mountains using levels of gray on a map. The role of this kind of maps is to display relative slopes, but not absolute height. https://geocompr.github.io/geocompkg/articles/maps.html
# set working directory to data folder
setwd("/Users/pauline/")

################ -- LIBRARIES -- ##################

library(maps)
library(ggplot2)
library(OpenStreetMap)
library(sp)


################# --Plot an open street map using ggplot2-- ##############

m <- c(25.7738889,-80.1938889)
j <- c(58.3019444,-134.4197222)
miami <- projectMercator(25.7738889,-80.1938889)
jun <- projectMercator(58.3019444,-134.4197222)
data(states)
map <- openmap(j,m,4,type="stamen-terrain")
plot(map,removeMargin=FALSE)
plot(states,add=TRUE)


################# --openmap: Get a map based on lat long coordinates-- ##############
# the upper left lat and long; the lower right lat and long
# the tile server from which to get the map, or the url pattern.
# like Google map tiles, their grid counting starts from the top-left to bottom right.
# France 6 W - 9 E, 42 - 52 N
# Portugal 6-10 W, 36-43 N.
# type = c("osm", "osm-bw", "bing", "stamen-toner", "stamen-terrain", "stamen-watercolor", "esri", "esri-topo", "nps", "apple-iphoto", "skobbler", "hillshade", "opencyclemap", "osm-transport", "osm-public-transport", "osm-bbike", "osm-bbike-german")


# Projecting by 'openproj': Projects the open street map to an alternate coordinate system
# Lambert Conic Conformal
map_peru <- openproj(map_osm,
    projection="+proj=lcc +lat_1=0 +lat_2=-18 +lat_0=-9 +lon_0=-75")
plot(map_peru, removeMargin=TRUE)

# Map of Peru
# esri-topo
# upper_left  <- c(LAT, LON)
upper_left  <- c(3, -82.0)
lower_right <- c(-22.0, -68)
map_osm  <- openmap(upper_left, lower_right, type = c('esri-topo'))
plot(map_osm)
print(map_osm)

# osm
upper_left  <- c(3, -82.0)
lower_right <- c(-22.0, -68)
map_osm  <- openmap(upper_left, lower_right, type = c('osm'))
plot(map_osm)

# stamen-terrain
upper_left  <- c(3, -82.0)
lower_right <- c(-22.0, -68)
map_osm  <- openmap(upper_left, lower_right, type = c('stamen-terrain'))
plot(map_osm)

# nps (National Park Service)
upper_left  <- c(3, -82.0)
lower_right <- c(-22.0, -68)
map_osm  <- openmap(upper_left, lower_right, type = c('nps'))
plot(map_osm,add=TRUE)

# bing
upper_left  <- c(3, -82.0)
lower_right <- c(-22.0, -68)
map_osm  <- openmap(upper_left, lower_right, type = c('bing'))
plot(map_osm,add=TRUE)

# stamen-watercolor
upper_left  <- c(3, -82.0)
lower_right <- c(-22.0, -68)
map_osm  <- openmap(upper_left, lower_right, type = c('stamen-watercolor'))
plot(map_osm)

# apple-iphoto
upper_left  <- c(3, -82.0)
lower_right <- c(-22.0, -68)
map_osm  <- openmap(upper_left, lower_right, type = c('apple-iphoto'))
plot(map_osm)

# esri
upper_left  <- c(3, -82.0)
lower_right <- c(-22.0, -68)
map_osm  <- openmap(upper_left, lower_right, type = c('esri'))
plot(map_osm)

getMapInfo()

par(mfrow=c(3,4))

#Korea
for(i in 1:12){
map <- openmap(c(43.46886761482925,119.94873046875), c(33.22949814144951,133.9892578125), minNumTiles=3,type=nm[i])
plot(map)
}
























############################### -- CHECK UP DATA -- ##################

italy <- map_data("italy")
dim(italy)
head(italy) # region
tail(italy)

############################### -- MAPPING ITALY -- ##################

gg1 <- ggplot() +
    geom_polygon(data = italy, aes(x = long, y = lat, fill = region, group = group),
        color = "blue", linetype = 1, size = 0.2) +
    coord_fixed(1.3) +
    xlab("Longitude") +
    ylab("Latitude") +
    labs(title="Italy",
        subtitle = "Mapping: R",
        caption = "Packages: ggmap, ggplot2, mapdata, maps") +
    guides(fill = guide_legend(reverse=TRUE))
 #   guides(col = guide_legend(ncol = 2, byrow = TRUE))# do this to leave off the color legend
gg1

map('italy', fill = TRUE, col = 1:95)

#map('italy', fill = TRUE, col = 1:10)

############################### -- transparent -- ##################

ggplot() +
geom_polygon(data = japan, aes(x=long, y = lat, group = group), fill = NA, color = "red") +
coord_fixed(1.3)

ggplot() +
geom_polygon(data = france, aes(x=long, y = lat, group = group), fill = NA, color = "red") +
coord_fixed(1.3)

################################# -- color -- #################

gg2 <- ggplot() +
    geom_polygon(data = japan, aes(x=long, y = lat, group = group),
        fill = "pink", color = "blue", linetype = 1, size = 0.2) +
    coord_fixed(1.3) +
    xlab("Longitude") +
    ylab("Latitude") +
    labs(title="Japan",
        subtitle = "Mapping: R",
        caption = "Packages: ggmap, ggplot2, mapdata, maps")
gg2

################################################################
