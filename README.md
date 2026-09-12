# R OpenStreetMap Basemaps — Tile Fetching, Reprojection and Cartography

R scripts that build topographic and cartographic basemaps by downloading
raster tiles from OpenStreetMap and other web tile servers, reprojecting them to
a target coordinate reference system, and rendering them for map figures. The
primary script maps Peru; companion scripts apply the same technique to Turkey
and to a generic template region.

## Related publication

The Peru script (openstreetmap_basemaps_peru.R) produced the R figures in:

Lemenkova, P. Scripting Cartographic Techniques of R and GMT for
Geomorphological and Topographic Mapping of Peru. Entorno Geografico 2021, 22,
36-55.

- DOI:    https://doi.org/10.25100/eg.v0i22.11331
- Zenodo: https://doi.org/10.5281/zenodo.5059867
- HAL:    https://hal.science/hal-03276386
- SSRN:   https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3878727
- Journal: https://entornogeografico.univalle.edu.co/index.php/entornogeografico/article/view/11331/13750 (ISSN 1692-0074, Web of Science)

The article combines two scripting toolsets, R and GMT (Generic Mapping Tools);
this repository holds the R OpenStreetMap basemap scripts.

## Scripts

### openstreetmap_basemaps_peru.R
- Downloads raster basemap tiles for a Peru bounding box (upper-left and
  lower-right latitude/longitude) with OpenStreetMap::openmap, from several tile
  servers (esri-topo, osm, stamen-terrain, bing, nps, esri, stamen-watercolor,
  apple-iphoto) for visual comparison.
- Projects coordinates to Web Mercator (projectMercator) and reprojects the
  downloaded map to a Lambert Conformal Conic projection tuned for Peru with
  openproj and a PROJ.4 definition (+proj=lcc +lat_1=0 +lat_2=-18 +lat_0=-9
  +lon_0=-75).
- Renders single maps and a multi-panel grid of tile types (par(mfrow)), and
  draws vector country choropleths with maps / mapdata and ggplot2 geom_polygon.

### openstreetmap_basemaps_template.R
The generic template of the same workflow (tile download, Mercator projection,
Lambert Conformal Conic reprojection, choropleth mapping) over example regions.

### openstreetmap_basemaps_turkey.R
The same basemap workflow applied to Turkey.

## Methods and algorithms

- Web tile-server basemap retrieval by bounding box (OpenStreetMap::openmap).
- Map projection and reprojection: Web Mercator (projectMercator) and
  reprojection to arbitrary CRS via PROJ.4 strings (openproj), including Lambert
  Conformal Conic.
- Raster basemap rendering and multi-panel tile-type comparison.
- Vector choropleth mapping of administrative regions (maps / mapdata, ggplot2
  geom_polygon with fixed aspect coordinates).

## Requirements

- R (>= 3.5)
- Packages: OpenStreetMap, sp, maps, mapdata, ggplot2
- Java runtime (required by the OpenStreetMap package / rJava)

Install with:

    install.packages(c("OpenStreetMap", "sp", "maps", "mapdata", "ggplot2"))

## Usage

Run a script directly, e.g.:

    Rscript openstreetmap_basemaps_peru.R

Tile downloads require a network connection. Adjust the upper-left / lower-right
coordinates and the tile type at the top of each block to change the study area.

## Author and citation

Polina Lemenkova
ORCID: https://orcid.org/0000-0002-5759-1089

If you use the Peru script, please cite:

Lemenkova, P. Scripting Cartographic Techniques of R and GMT for
Geomorphological and Topographic Mapping of Peru. Entorno Geografico 2021, 22,
36-55. https://doi.org/10.25100/eg.v0i22.11331

## License

No license file is currently included. For reuse terms, please contact the
author via the ORCID record above.
