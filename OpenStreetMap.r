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

upper_left  <- c(47.413, 8.551)
lower_right <- c(47.417, 8.556)
map_osm  <- openmap(upper_left, lower_right, type = c("osm-bbike"))
plot(map_osm,add=TRUE)

# Map of Portugal
upper_left  <- c(43.0, -10.0)
lower_right <- c(36.0, -6.0)
map_osm1  <- openmap(upper_left, lower_right, type = c("stamen-terrain"))
plot(map_osm1,add=TRUE)

# Map of France
upper_left  <- c(41.0, -6.0)
lower_right <- c(52.0, 9.0)
map_osm  <- openmap(upper_left, lower_right, type = c('esri-topo'))
plot(map_osm)

# Projecting by 'openproj': Projects the open street map to an alternate coordinate system
# Lambert Conic Conformal
map_llc <- openproj(map_osm,
    projection="+proj=lcc +lat_1=42 +lat_2=52 +lat_0=47 +lon_0=1.5")
plot(map_llc, removeMargin=TRUE)

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
