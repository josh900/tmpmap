


OpenStreetMap 3D Scene Layers
=============================

This document provides a high-level overview of the OpenStreetMap (OSM) 3D scene\
layers published to ArcGIS Online.

OSM 3D Buildings Layer
----------------------

Introduction
------------

The "OpenStreetMap 3D Buildings" is a 3D Object layer representing 3D buildings.

This layer is created from OpenStreetMap (OSM) data found in the Daylight map\
distribution.

This document gives a high-level overview of this layer and some OSM tagging advices to\
users who would like to enhance the layers by improving the OSM content accuracy.

OSM Nodes, Ways and Relationships
---------------------------------

##### OSM Nodes

Nodes represent a 2D spatial location on the earth.

##### OSM Ways

Two types of ways are used to define buildings:

-   Closed ways consist of four or more nodes where the start and end vertices reference the\
    same node. See the OSM documentation: Closed way (Closed polyline). For simple\
    buildings, a single closed way is all that is required.
-   Open ways consists of two or more nodes where the start and end vertices do not reference\
    the same node. See the OSM documentation: Open way (Open polyline). Two or more open\
    ways can be used in conjunction to define polygons.
-   Multiple ways forming a ring. The osm_builder_app supports chaining together multiple\
    open ways to form closed polygons but is currently in development and not all cases are\
    handled correctly. Currently it is recommended to avoid using open ways to define building\
    components if at all possible.

##### Modeled buildings fall into two categories

-   Simple: The building is defined by a single closed way.
-   Complex: The building is defined by one or more complex or simple polygons. Polygons can\
    contain holes and participate as footprints or parts of the building.

##### OSM Building Relations

The osm_builder_app supports relations for defining complex buildings. Currently it does\
not support relations of relations. For existing OSM data with relations within relations, the\
behavior is to ignore the sub relations when constructing the building. The sub relations\
will be treated as a separate buildings. No geometry is lost, but two or more buildings are\
generated and not grouped into a single building.

### Tagging recommendations

There are two classes of tags used by osm_builder_app:

##### Descriptive

The tags name and building are used only for attribution, symbology, and definition queries.

-   name: The name of the building.
-   building: The class of the building. For symbology the following classes are\
    excepted: house, commercial, garage, apartments, shed, school, retail, residential, indust\
    rial, warehouse, hospital, service, supermarket, hotel, university, office, parking, churc\
    h, public, and historic. If the class of the building does not fit properly into the\
    forementioned classes, then tag with a descriptive word. If the class is unknown, then tag\
    with yes.

##### Geometry Related

These tags are used to define the 3D characteristics of the building components and fall\
into two categories:

*Height and Levels*

See: Simple 3D Buildings, height and levels For height and min-height, values with\
unspecified units are in meters. Height must be greater then min-height by definition. The\
following unit specifiers are accepted:

-   Feet: ft, feet, '
-   Inches: in, inches, "
-   Meters: m
-   Centimeters: cm
-   Kilometers: km
-   Millimeters: mm
-   Miles: mi
-   NauticalMiles: nmi

The tag building:levels can be used to define the height. The value is simply multiplied by\
3.0 meters. Both height and building:levels can be defined for a component. When the 3D\
geometry is generated height will take precedence. The value of building:levels is used to\
populate the attributes. Additionally, building:min_level can be used to define the\
minimum height and works the same as building:levels where min-height takes\
precedence.\
The osm_builder_app has the ability to infer the height and minimum height in some cases,\
but it is recommended to tag building components such that inference is not required.\
Examples:

-   https://www.openstreetmap.org/way/159135199 The height must be inferred.
-   https://www.openstreetmap.org/way/220721682 The minimum height must be inferred.
-   The base https://www.openstreetmap.org/way/24513641 has it's height defined as "0". It\
    needs to be inferred from the parts.

*Shape*

-   roof:shape See Roof shape for supported tag values.
-   roof:direction See Roof direction.
-   roof:height See Roof height.
-   roof:orientation See Roof orientation.
-   building:shape is synonymous with roof:shape, it is supported but not recommended\
    being a non-standard tag.

Note: There are other ways to define complex shapes such as: roof:edge and roof:ridge,\
but these are currently not supported.

##### OSM Complex Buildings

There are two methods to define complex buildings.

The first method does not require the use of relations. A closed way defining the footprint\
of the building contains keys defining the descriptive attributes name and building. The\
height and minimum height are also defined as mentioned. Components can be defined as

closed ways and are tagged with building:part. The osm_builder_app will collect parts\
attached to the building footprint by checking for partial containment. Parts can be fully\
contained in the footprint, or contained by no less than 40%. An example of this\
case: https://www.openstreetmap.org/way/224253366 is not part of a relation, but is\
clearly attached to the building.\
The second method is done by using a relation. The relation is identified as a building\
relation under the following tag conditions:

-   key:type where the value is building (OSM\
    recommended) https://wiki.openstreetmap.org/wiki/Relation:building
-   key:building where the value does not equal no
-   key:building:part where the value does not equal no

It is recommended to clearly define the roles for all components of the relation. Some non-\
standard role descriptions are supported but it is recommended to use the standard ones.\
Currently supported roles are outline, outer, inner, and part. If the role is not specified then\
it will default to a part. The role specifier will override the tag specifier of the component.\
For example, if a way of the relation has the tag building:part, but it's role is defined in the\
relation as inner, then the way will be used to create a hole. When defining a complex\
polygon using a relation, the associated height and minimum height tags of the relation\
will be used. Outer and inner polygons can be defined using multiple open ways but it is\
not recommended.

Just like the first method, not all building parts need to be assigned to the relation. The\
outline and footprints of the relation are used to gather parts not directly attached to the\
relation. The same containment check procedure is used. It is recommended to add all\
parts to the relation. Relation components with the roles roof:edge, roof:ridge,\
and street are ignored.

The osm_builder_app with respect to descriptive tags and relations looks for the tag in the\
relation first. If it is not found, then the components of the relation are inspected for the\
tag. The value of the first component with the tag found is used. It first inspects footprint\
components, and then the part components. Note that the OSM mapping\
guidelines suggests that descriptive tags should be placed in the outline way only. In\
practice, there is OSM data where descriptive tags are not in the outline way but in the\
inner components so osm_builder_app supports this as well.

OSM 3D Trees Layer
------------------

### Introduction

The "OpenStreetMap 3D Trees (Thematic)" and "OpenStreetMap 3D Trees (Realistic)" are\
point layers representing 3D trees.

These layers are created from OpenStreetMap (OSM) data found in the Daylight map\
distribution.

This document gives a high level overview of these layers and gives some OSM tagging\
advices to users who would like to enhance the layers by improving the OSM content\
accuracy.

### OSM Nodes and Ways taken into account

Trees in the OSM data are modeled as Nodes and Ways.

#### OSM Nodes

OSM nodes that have natural=tree (individual trees) are taken into account, unless they\
have barrier=block or barrier=flowerpot or barrier=bollard.

#### OSM Ways

OSM ways with natural=tree_row (lines of trees) are taken into account, unless they\
have denotation=road or denotation=avenue or denotation=alley, because in that case the\
trees would be placed in the middle of the road/avenue/alley.\
Note that OSM ways describing an *area* with trees (i.e with forest or landuse) are *not* taken\
into account.

### 3D symbol inference

The layers use 3D symbols from the Esri trees library.

We read different OSM tags related to tree type, and deduce from this information the\
closest matching symbol.

Initially, the symbol candidates are all possible symbols, and then we filter them like this:

-   we read taxon, genus, species, taxon:species, taxon:genus, taxon:cultivar to extract a\
    set of keywords which we use to filter the candidates.
-   if no keyword was found or if the keywords didn't contain any known genus, we\
    read leaf_type to filter candidates.
-   if at this point there are still 2 or more candidates, we pick the candidate that is\
    most frequent in this region of the world using spatial statistics.

### Symbol dimension inference

We use min_height to define the altitude of the *base* of the tree.\
To define the altitude of the *top* of the tree, by order of priority:

-   we use height or est_height if they are present, or
-   we use crown_diameter if it is present (combining this information with the known\
    aspect ratio of the symbol), or
-   (for individual trees only) we take into account the distance to neighbour trees, to\
    ensure that 3D symbols won't overlap
-   if none of the above succeeded, we use the default symbol height.

To improve realism, a jitter of 10% is applied to the height and diameter of the 3D symbol.\
The jitter is based on the longitude and latitude of the tree.

The rotation of the 3D symbol is also randomized, based on the "object id" of the tree.

### Placing trees of a line of trees

OSM ways corresponding to lines of trees specify a line along which trees are located.

In the layers, we place trees evenly along this line, using a spacing based on trees\
dimensions. If the line has intersections, a tree will be placed at each intersection, and there\
will be at most 256 trees in the line of trees.

### Tagging recommendations

Symbol accuracy can be improved by writing the scientific name of the OSM trees in\
the species tag, and the height of the tree in the height tag.



[leaflet-shadow-simulator](https://www.npmjs.com/package/leaflet-shadow-simulator#leaflet-shadow-simulator)
===========================================================================================================

Using Mapbox GL JS/Maplibre GL JS? Try [mapbox-gl-shadow-simulator](https://www.npmjs.com/package/mapbox-gl-shadow-simulator)

Shadow simulator for Leaflet. Visualize sunlight and shadow on a map for any date and time of year.

[![Leaflet Shadow Simulator demo](https://raw.githubusercontent.com/ted-piotrowski/leaflet-shadow-simulator/HEAD/demo.jpg)](https://ted-piotrowski.github.io/leaflet-shadow-simulator/examples/map.html)

[Live Demo](https://ted-piotrowski.github.io/leaflet-shadow-simulator/examples/map.html)

[Download](https://www.npmjs.com/package/leaflet-shadow-simulator#download)
---------------------------------------------------------------------------

[unpkg CDN](https://unpkg.com/leaflet-shadow-simulator/dist/leaflet-shadow-simulator.umd.min.js)

[Installation](https://www.npmjs.com/package/leaflet-shadow-simulator#installation)
-----------------------------------------------------------------------------------

In a browser:

`<script src="https://unpkg.com/leaflet-shadow-simulator/dist/leaflet-shadow-simulator.umd.min.js"></script>`

Using npm:

`npm i leaflet-shadow-simulator --save`

[Usage](https://www.npmjs.com/package/leaflet-shadow-simulator#usage)
---------------------------------------------------------------------

In a browser:

```text-html-basic
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
<script src="https://unpkg.com/leaflet-shadow-simulator/dist/leaflet-shadow-simulator.umd.min.js"></script>
<script>
  var map = L.map("mapid");

  const shadeMap = L.shadeMap({
    date: new Date(),    // display shadows for current date
    color: '#01112f',    // shade color
    opacity: 0.7,        // opacity of shade color
    apiKey: "XXXXXX",    // obtain from https://shademap.app/about/
    terrainSource: {
      tileSize: 256,       // DEM tile size
      maxZoom: 15,         // Maximum zoom of DEM tile set
      getSourceUrl: ({ x, y, z }) => {
        // return DEM tile url for given x,y,z coordinates
        return `https://s3.amazonaws.com/elevation-tiles-prod/terrarium/${z}/${x}/${y}.png`
      },
      getElevation: ({ r, g, b, a }) => {
        // return elevation in meters for a given DEM tile pixel
        return (r * 256 + g + b / 256) - 32768
      }
    },
  }).addTo(map);

  // advance shade by 1 hour
  shadeMap.setDate(new Date(Date.now() + 1000 * 60 * 60));

  // sometime later...
  // ...remove layer
  shadeMap.remove();
</script>
```

Using Node.js:

```source-js
import * as L from 'leaflet'
import ShadeMap from 'leaflet-shadow-simulator';

const map = L.map("mapid");

const shadeMap = new ShadeMap({
  date: new Date(),    // display shadows for current date
  color: '#01112f',    // shade color
  opacity: 0.7,        // opacity of shade color
  apiKey: "XXXXXX",    // obtain from https://shademap.app/about/
  terrainSource: {
    tileSize: 256,       // DEM tile size
    maxZoom: 15,         // Maximum zoom of DEM tile set
    getSourceUrl: ({ x, y, z }) => {
      // return DEM tile url for given x,y,z coordinates
      return `https://s3.amazonaws.com/elevation-tiles-prod/terrarium/${z}/${x}/${y}.png`
    },
    getElevation: ({ r, g, b, a }) => {
      // return elevation in meters for a given DEM tile pixel
      return (r * 256 + g + b / 256) - 32768
    }
  },
}).addTo(map);

// advance shade by 1 hour
shadeMap.setDate(new Date(Date.now() + 1000 * 60 * 60));

// sometime later
// ...remove layer
shadeMap.remove();
```

### [Constructor options](https://www.npmjs.com/package/leaflet-shadow-simulator#constructor-options)

| Property name | Type | Default value | Comment |
| :-- | :-- | :-- | :-- |
| `apiKey` | `String` | `''` | See <https://shademap.app/about/> |
| `date` | `Date` | `new Date()` | Sun's position in the sky is based on this date |
| `color` | `String` | `#000` | 3 or 6 digit hexadecimal number |
| `opacity` | `Number` | `0.3` |  |
| `sunExposure` | `Object` | See [sunExposure](https://www.npmjs.com/package/leaflet-shadow-simulator#sunExposure) | Display sun exposure for provided date range |
| `terrainSource` | `Object` | See [terrainSource](https://www.npmjs.com/package/leaflet-shadow-simulator#terrainsource) | Specify DEM or DSM tiles containing terrain elevation data |
| `getFeatures` | `Function` | See [getFeatures](https://www.npmjs.com/package/leaflet-shadow-simulator#getfeatures) | Returns GeoJSON of objects, such as buildings, to display on the map |

#### [terrainSource](https://www.npmjs.com/package/leaflet-shadow-simulator#terrainsource)

An object describing a DEM tile set to use for terrain shadows

| Property name | Type | Default value | Comment |
| :-- | :-- | :-- | :-- |
| `maxZoom` | `Number` | `15` | Max zoom for custom DEM tile source |
| `tileSize` | `Number` | `256` | Tile size for custom DEM tile source |
| `sourceUrl` | `Function` | `Returns tile encoding 0m elevation for all locations` | Returns url of DEM tile for given `(x, y, z)` coordinate |
| `getElevation` | `Function` | `return (r * 256 + g + b / 256) - 32768` | Returns elevation in meters for each (r,g,b,a) pixel of DEM tile |

#### [sunExposure](https://www.npmjs.com/package/leaflet-shadow-simulator#sunexposure)

An object describing sun exposure settings

| Property name | Type | Default value | Comment |
| :-- | :-- | :-- | :-- |
| `enabled` | `Boolean` | `false` | Should sun exposure be displayed |
| `startDate` | `Date` | `new Date()` | Start date of sun exposure time interval |
| `endDate` | `Date` | `new Date()` | End date of sun exposure time interval |
| `iterations` | `number` | `32` | Number of discrete chunks to calculate shadows for between startDate and endDate. A larger number will provide more detail but take longer to compute. |

##### [Open Data on AWS for terrainSource](https://www.npmjs.com/package/leaflet-shadow-simulator#open-data-on-aws-for-terrainsource)

A global dataset providing bare-earth terrain heights, tiled for easy usage and provided on S3 - [More info](https://registry.opendata.aws/terrain-tiles/)

```source-js
{
  tileSize: 256,
  maxZoom: 15,
  getSourceUrl: ({x, y, z}) => {
    return `https://s3.amazonaws.com/elevation-tiles-prod/terrarium/${z}/${x}/${y}.png`;
  },
  getElevation: ({r, g, b, a}) => {
    return (r * 256 + g + b / 256) - 32768;
  }
}
```

##### [Mapbox Terrain DEM V1 for terrainSource](https://www.npmjs.com/package/leaflet-shadow-simulator#mapbox-terrain-dem-v1-for-terrainsource)

Mapbox Terrain-DEM v1 is a Mapbox-provided raster tileset is a global elevation layer. This tileset contains raw height values in meters in the Red, Green, and Blue channels of PNG tiles that can be decoded to raw heights in meters - [More info](https://docs.mapbox.com/data/tilesets/reference/mapbox-terrain-dem-v1/)

```source-js
{
  tileSize: 514,
  maxZoom: 14,
  getSourceUrl: ({x, y, z}) => {
    const subdomain = ['a', 'b', 'c', 'd'][(x + y) % 4];
    return `https://${subdomain}.tiles.mapbox.com/raster/v1/mapbox.mapbox-terrain-dem-v1/${z}/${x}/${y}.webp?sku=101wuwGrczDtH&access_token=${MAPBOX_API_KEY}`;
  },
  getElevation: ({r, g, b, a}) => {
    return -10000 + ((r * 256 * 256 + g * 256 + b) * .1);
  }
}
```

##### [Maptiler Terrain RGB v2](https://www.npmjs.com/package/leaflet-shadow-simulator#maptiler-terrain-rgb-v2)

[More info](https://cloud.maptiler.com/tiles/terrain-rgb-v2/)

```source-js
{
  tileSize: 514,
  maxZoom: 12,
  getSourceUrl: ({x, y, z}) => {
    return `https://api.maptiler.com/tiles/terrain-rgb-v2/${z}/${x}/${y}.webp?key=${MAPTILER_KEY}`;
  },
  getElevation: ({r, g, b, a}) => {
    return -10000 + ((r * 256 * 256 + g * 256 + b) * .1);
  }
}
```

#### [getFeatures](https://www.npmjs.com/package/leaflet-shadow-simulator#getfeatures)

Returns a GeoJSON collection of features whose shadows will be displayed on the map. Currently only supports `Polygon` and `MultiPolygon`.

##### [Adds a 1000 meter tall structure near Alexandria, Egypt](https://www.npmjs.com/package/leaflet-shadow-simulator#adds-a-1000-meter-tall-structure-near-alexandria-egypt)

```source-js
getFeatures: () => {
  return [{
    "type": "Feature",
    "geometry": {
      "type": "Polygon",
      "coordinates": [
        [29.8148007, 31.2240349],
        [29.8248007, 31.2240349],
        [29.8248007, 31.2140349],
        [29.8148007, 31.2140349],
      ]
    },
    "properties": {
      "height": 1000,
      "render_height": 1000,
      "name": "Alexandria column"
    }
  },
},
```

##### [Using overpass turbo to load buildings](https://www.npmjs.com/package/leaflet-shadow-simulator#using-overpass-turbo-to-load-buildings)

```source-js
getFeatures: async () => {
  if (map.getZoom() > 15) {
    const bounds = map.getBounds();
    const north = bounds.getNorth();
    const south = bounds.getSouth();
    const east = bounds.getEast();
    const west = bounds.getWest();
    const query = `https://overpass-api.de/api/interpreter?data=%2F*%0AThis%20has%20been%20generated%20by%20the%20overpass-turbo%20wizard.%0AThe%20original%20search%20was%3A%0A%E2%80%9Cbuilding%E2%80%9D%0A*%2F%0A%5Bout%3Ajson%5D%5Btimeout%3A25%5D%3B%0A%2F%2F%20gather%20results%0A%28%0A%20%20%2F%2F%20query%20part%20for%3A%20%E2%80%9Cbuilding%E2%80%9D%0A%20%20way%5B%22building%22%5D%28${south}%2C${west}%2C${north}%2C${east}%29%3B%0A%29%3B%0A%2F%2F%20print%20results%0Aout%20body%3B%0A%3E%3B%0Aout%20skel%20qt%3B`;
    const response = await fetch(query)
    const json = await response.json();
    const geojson = osmtogeojson(json);
    // If no building height, default to one storey of 3 meters
    geojson.features.forEach(feature => {
      if (!feature.properties) {
        feature.properties = {};
      }
      if (!feature.properties.height) {
        feature.properties.height = 3;
      }
    });
    return geojson.features;
  }
  return [];
},
```

### [Available functions](https://www.npmjs.com/package/leaflet-shadow-simulator#available-functions)

`setDate(date: Date)` - update shade layer to reflect new `date`

`setColor(color: String)` - change shade color

`setOpacity(opacity: Number)` - change shade opacity

`setSunExposure(enabled: Boolean, options: SunExposureOptions)` - toggle between shadows and sun exposure mode

`getHoursOfSun(x: Number, y: Number)` - if sun exposure mode enabled, returns the hours of sunlight for a given pixel on the map

`remove()` - remove the layer from the map



mapbox-gl-shadow-simulator
==========================

Shadow simulator for Mapbox GL JS and MapLibre GL JS. Visualize sunlight and shadow on a map for any date and time of year.

NOTE: Shadow layer will not render if map pitch is greater than 45 degrees. Set the map's `maxPitch` to 45 degrees.

[![Mapbox GL Shadow Simulator demo](https://raw.githubusercontent.com/ted-piotrowski/mapbox-gl-shadow-simulator/HEAD/demo.jpg)](https://ted-piotrowski.github.io/mapbox-gl-shadow-simulator/examples/map.html)

[Live Demo](https://ted-piotrowski.github.io/mapbox-gl-shadow-simulator/examples/map.html)

[](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#download)Download
-----------------------------------------------------------------------------

[unpkg CDN](https://unpkg.com/mapbox-gl-shadow-simulator/dist/mapbox-gl-shadow-simulator.umd.min.js)

[](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#installation)Installation
-------------------------------------------------------------------------------------

In a browser:

`<script src="https://unpkg.com/mapbox-gl-shadow-simulator/dist/mapbox-gl-shadow-simulator.umd.min.js"></script>`

Using npm:

`npm i mapbox-gl-shadow-simulator --save`

[](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#usage)Usage
-----------------------------------------------------------------------

In a browser:

```text-html-basic
<script src='https://api.mapbox.com/mapbox-gl-js/v2.8.2/mapbox-gl.js'></script>
<link href='https://api.mapbox.com/mapbox-gl-js/v2.8.2/mapbox-gl.css' rel='stylesheet' />
<script src="https://unpkg.com/mapbox-gl-shadow-simulator/dist/mapbox-gl-shadow-simulator.umd.min.js"></script>
<script>
  const map = new mapboxgl.Map({
    // mapboxgl Map options
    // ...
  });

  map.on('load', () => {
    const shadeMap = new ShadeMap({
      date: new Date(),    // display shadows for current date
      color: '#01112f',    // shade color
      opacity: 0.7,        // opacity of shade color
      apiKey: "XXXXXX",    // obtain from https://shademap.app/about/
      terrainSource: {
        tileSize: 256,       // DEM tile size
        maxZoom: 15,         // Maximum zoom of DEM tile set
        getSourceUrl: ({ x, y, z }) => {
          // return DEM tile url for given x,y,z coordinates
          return `https://s3.amazonaws.com/elevation-tiles-prod/terrarium/${z}/${x}/${y}.png`
        },
        getElevation: ({ r, g, b, a }) => {
          // return elevation in meters for a given DEM tile pixel
          return (r * 256 + g + b / 256) - 32768
        }
      },
      debug: (msg) => { console.log(new Date().toISOString(), msg) },
    }).addTo(map);

    // advance shade by 1 hour
    shadeMap.setDate(new Date(Date.now() + 1000 * 60 * 60));

    // sometime later...
    // ...remove layer
    shadeMap.remove();
  });
</script>
```

Using Node.js:

```source-js
import mapboxgl from 'mapbox-gl/dist/mapbox-gl';
import ShadeMap from 'mapbox-gl-shadow-simulator';

const map = new mapboxgl.Map({
  // mapboxgl Map options
  // ...
});

map.on('load', () => {
  const shadeMap = new ShadeMap({
    date: new Date(),    // display shadows for current date
    color: '#01112f',    // shade color
    opacity: 0.7,        // opacity of shade color
    apiKey: "XXXXXX",    // obtain from https://shademap.app/about/
    terrainSource: {
      tileSize: 256,       // DEM tile size
      maxZoom: 15,         // Maximum zoom of DEM tile set
      getSourceUrl: ({ x, y, z }) => {
        // return DEM tile url for given x,y,z coordinates
        return `https://s3.amazonaws.com/elevation-tiles-prod/terrarium/${z}/${x}/${y}.png`
      },
      getElevation: ({ r, g, b, a }) => {
        // return elevation in meters for a given DEM tile pixel
        return (r * 256 + g + b / 256) - 32768
      }
    },
    debug: (msg) => { console.log(new Date().toISOString(), msg) },
  }).addTo(map);

  // advance shade by 1 hour
  shadeMap.setDate(new Date(Date.now() + 1000 * 60 * 60));

  // sometime later
  // ...remove layer
  shadeMap.remove();
});
```

### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#constructor-options)Constructor options

| Property name | Type | Default value | Comment |
| :-- | :-- | :-- | :-- |
| `apiKey` | `String` | `''` | See <https://shademap.app/about/> |
| `date` | `Date` | `new Date()` | Sun's position in the sky is based on this date |
| `color` | `String` | `#000` | 3 or 6 digit hexadecimal number |
| `opacity` | `Number` | `0.3` |  |
| `sunExposure` | `Object` | See [sunExposure](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#sunExposure) | Display sun exposure for provided date range |
| `terrainSource` | `Object` | See [terrainSource](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#terrainsource) | Specify DEM or DSM tiles containing terrain elevation data |
| `getFeatures` | `Function` | See [getFeatures](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#getfeatures) | Returns GeoJSON of objects, such as buildings, to display on the map |

#### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#terrainsource)terrainSource

An object describing a DEM tile set to use for terrain shadows

| Property name | Type | Default value | Comment |
| :-- | :-- | :-- | :-- |
| `maxZoom` | `Number` | `15` | Max zoom for custom DEM tile source |
| `tileSize` | `Number` | `256` | Tile size for custom DEM tile source |
| `sourceUrl` | `Function` | `Returns tile encoding 0m elevation for all locations` | Returns url of DEM tile for given `(x, y, z)` coordinate |
| `getElevation` | `Function` | `return (r * 256 + g + b / 256) - 32768` | Returns elevation in meters for each (r,g,b,a) pixel of DEM tile |

#### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#sunexposure)sunExposure

An object describing sun exposure settings

| Property name | Type | Default value | Comment |
| :-- | :-- | :-- | :-- |
| `enabled` | `Boolean` | `false` | Should sun exposure be displayed |
| `startDate` | `Date` | `new Date()` | Start date of sun exposure time interval |
| `endDate` | `Date` | `new Date()` | End date of sun exposure time interval |
| `iterations` | `number` | `32` | Number of discrete chunks to calculate shadows for between startDate and endDate. A larger number will provide more detail but take longer to compute. |

##### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#open-data-on-aws-for-terrainsource)Open Data on AWS for terrainSource

A global dataset providing bare-earth terrain heights, tiled for easy usage and provided on S3 - [More info](https://registry.opendata.aws/terrain-tiles/)

```source-js
{
  tileSize: 256,
  maxZoom: 15,
  getSourceUrl: ({x, y, z}) => {
    return `https://s3.amazonaws.com/elevation-tiles-prod/terrarium/${z}/${x}/${y}.png`;
  },
  getElevation: ({r, g, b, a}) => {
    return (r * 256 + g + b / 256) - 32768;
  }
}
```

##### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#mapbox-terrain-dem-v1-for-terrainsource)Mapbox Terrain DEM V1 for terrainSource

Mapbox Terrain-DEM v1 is a Mapbox-provided raster tileset is a global elevation layer. This tileset contains raw height values in meters in the Red, Green, and Blue channels of PNG tiles that can be decoded to raw heights in meters - [More info](https://docs.mapbox.com/data/tilesets/reference/mapbox-terrain-dem-v1/)

```source-js
{
  tileSize: 514,
  maxZoom: 14,
  getSourceUrl: ({x, y, z}) => {
    const subdomain = ['a', 'b', 'c', 'd'][(x + y) % 4];
    return `https://${subdomain}.tiles.mapbox.com/raster/v1/mapbox.mapbox-terrain-dem-v1/${z}/${x}/${y}.webp?sku=101wuwGrczDtH&access_token=${MAPBOX_API_KEY}`;
  },
  getElevation: ({r, g, b, a}) => {
    return -10000 + ((r * 256 * 256 + g * 256 + b) * .1);
  }
}
```

##### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#maptiler-terrain-rgb-v2)Maptiler Terrain RGB v2

[More info](https://cloud.maptiler.com/tiles/terrain-rgb-v2/)

```source-js
{
  tileSize: 514,
  maxZoom: 12,
  getSourceUrl: ({x, y, z}) => {
    return `https://api.maptiler.com/tiles/terrain-rgb-v2/${z}/${x}/${y}.webp?key=${MAPTILER_KEY}`;
  },
  getElevation: ({r, g, b, a}) => {
    return -10000 + ((r * 256 * 256 + g * 256 + b) * .1);
  }
}
```

#### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#getfeatures)getFeatures

Returns a GeoJSON collection of features whose shadows will be displayed on the map. Currently only supports `Polygon` and `MultiPolygon`.

##### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#extracting-buildings-from-mapbox-vector-tiles)Extracting buildings from Mapbox vector tiles

```source-js
getFeatures: () => {
  // wait for map.loaded() to ensure all vector tile data downloaded
  const buildingData = map.querySourceFeatures('composite', { sourceLayer: 'building' }).filter((feature) => {
    return feature.properties && feature.properties.underground !== "true" && (feature.properties.height || feature.properties.render_height)
  });
  return buildingData;
},
```

### [](https://www.npmjs.com/package/mapbox-gl-shadow-simulator#available-functions)Available functions

`setDate(date: Date)` - update shade layer to reflect new `date`

`setColor(color: String)` - change shade color

`setOpacity(opacity: Number)` - change shade opacity

`setSunExposure(enabled: Boolean, options: SunExposureOptions)` - toggle between shadows and sun exposure mode

`getHoursOfSun(x: Number, y: Number)` - if sun exposure mode enabled, returns the hours of sunlight for a given pixel on the map

`remove()` - remove the layer from the map

Readme
------

### Keywords

-   [mapbox](https://www.npmjs.com/search?q=keywords:mapbox)
-   [mapbox-gl](https://www.npmjs.com/search?q=keywords:mapbox-gl)
-   [maplibre](https://www.npmjs.com/search?q=keywords:maplibre)
-   [maplibre-gl](https://www.npmjs.com/search?q=keywords:maplibre-gl)
-   [shade](https://www.npmjs.com/search?q=keywords:shade)
-   [layer](https://www.npmjs.com/search?q=keywords:layer)



example of how one might create a shadow map without the map graphics like roads and buildings, just the shadow:
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shadow Map with OSM Buildings</title>
    <style>
        #map {
            width: 100vw;
            height: 100vh;
        }
        .leaflet-container {
            touch-action: none;
        }
    </style>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-shadow-simulator/dist/leaflet-shadow-simulator.umd.min.js"></script>
</head>
<body>
    <div id="map"></div>

    <script>
        const apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFkbWluMUBza29vcC5kaWdpdGFsIiwiY3JlYXRlZCI6MTcwNDY1NDIwNzE0MywiaWF0IjoxNzA0NjU0MjA3fQ.GEB9lUcyzGUATxEcgPgPMZUCaXrsYDWSP1y4xZC15WE'; // Replace with your actual API key

        // Initialize the map
        var map = L.map('map', {
            center: [0, 0], // temporary center
            zoom: 18, // zoomed in to a few blocks
            scrollWheelZoom: false, // disable scroll zoom
            dragging: false, // disable dragging
            touchZoom: false, // disable touch zoom
            doubleClickZoom: false, // disable double click zoom
            boxZoom: false, // disable box zoom
            keyboard: false // disable keyboard controls
        });

        // Function to load buildings from OpenStreetMap using overpass turbo
        async function loadOSMBuildings(bounds) {
            const query = `
                [out:json][timeout:25];
                (way["building"](${bounds.getSouth()},${bounds.getWest()},${bounds.getNorth()},${bounds.getEast()}););
                out body;
                >;
                out skel qt;
            `;
            const response = await fetch('https://overpass-api.de/api/interpreter', {
                method: 'POST',
                body: query,
                headers: {'Content-Type': 'text/plain'}
            });
            const data = await response.json();
            return data.elements.map(element => {
                const geometry = element.type === "way"
                    ? { type: "Polygon", coordinates: [element.nodes.map(nodeId => {
                        const node = data.elements.find(e => e.id === nodeId);
                        return [node.lon, node.lat];
                    })]}
                    : null;

                return geometry ? {
                    type: "Feature",
                    properties: {height: element.tags['building:levels'] * 3 || 10}, // Default to 10 meters if no height is specified
                    geometry: geometry
                } : null;
            }).filter(feature => feature !== null);
        }

        // Get the user's current location and load buildings
        map.locate({setView: true, maxZoom: 18});

        map.on('locationfound', async function(e) {
            L.marker(e.latlng).addTo(map);
            const bounds = map.getBounds();
            const buildings = await loadOSMBuildings(bounds);

            const shadeMap = L.shadeMap({
                date: new Date(),
                color: '#01112f',
                opacity: 0.7,
                apiKey: apiKey,
                terrainSource: {
                    tileSize: 256,
                    maxZoom: 15,
                    getSourceUrl: ({ x, y, z }) => {
                        return `https://s3.amazonaws.com/elevation-tiles-prod/terrarium/${z}/${x}/${y}.png`;
                    },
                    getElevation: ({ r, g, b, a }) => {
                        return (r * 256 + g + b / 256) - 32768;
                    }
                },
                getFeatures: () => buildings
            }).addTo(map);
        });

        map.on('locationerror', function() {
            map.setView([51.505, -0.09], 18); // Coordinates for a default location
        });
    </script>
</body>
</html>
```


https://github.com/tyrasd/osmtogeojson docs:
```
osmtogeojson
============

Converts [OSM](https://www.openstreetmap.org/) [data](https://wiki.openstreetmap.org/wiki/OSM_XML) to [GeoJSON](https://geojson.org/). Try the [demo](https://tyrasd.github.io/osmtogeojson/)!

-   stable
-   real OSM [polygon detection](https://wiki.openstreetmap.org/wiki/Overpass_turbo/Polygon_Features)
-   proper OSM multipolygon support
-   full support for extended Overpass API [geometry modes](https://wiki.openstreetmap.org/wiki/Overpass_API/Overpass_QL#Print_.28out.29)
-   well [tested](https://github.com/tyrasd/osmtogeojson/tree/gh-pages/test/) and proven
-   fast

This code is used in and maintained by the [overpass turbo](https://github.com/tyrasd/overpass-turbo) project.

[![Build Status](https://camo.githubusercontent.com/eb30ee5c75029807a37b64012bb2cc1a256d4e3eaf8c0bff246920c78e0561b0/68747470733a2f2f7365637572652e7472617669732d63692e6f72672f7479726173642f6f736d746f67656f6a736f6e2e706e67)](https://travis-ci.org/github/tyrasd/osmtogeojson)

[](https://github.com/tyrasd/osmtogeojson#usage)Usage
-----------------------------------------------------

### [](https://github.com/tyrasd/osmtogeojson#command-line-tool)command line tool

Installation:

```
  $ npm install -g osmtogeojson

```

Usage:

```
$ osmtogeojson file.osm > file.geojson

```

Supported command line options are shown with:

```
$ osmtogeojson --help

```

When working with extra large data files (≳ 100 MB) it is recommended to run the programm with a little extra memory to avoid *process out of memory* errors. The easiest way to do this is by running the command as `node <path-to-osmtogeojson>` and setting the `--max_old_space_size=...` parameter to the available memory size in MB (osmtogeojson typically needs about 4-5 times the input data size). On a Unix system, you can use the following command:

```
$ node --max_old_space_size=8192 `which osmtogeojson` large.osm > large.geojson

```

### [](https://github.com/tyrasd/osmtogeojson#nodejs-library)nodejs library

Installation:

```
$ npm install osmtogeojson

```

Usage:

```
var osmtogeojson = require('osmtogeojson');
osmtogeojson(osm_data);

```

### [](https://github.com/tyrasd/osmtogeojson#browser-library)browser library

```
<script src='osmtogeojson.js'></script>

osmtogeojson(osm_data);

```

[](https://github.com/tyrasd/osmtogeojson#api)API
-------------------------------------------------

### [](https://github.com/tyrasd/osmtogeojson#osmtogeojson-data-options-)`osmtogeojson( data, options )`

Converts OSM data into GeoJSON.

-   `data`: the OSM data. Either as a XML DOM or in [OSM JSON](https://overpass-api.de/output_formats.html#json).
-   `options`: optional. The following options can be used:
    -   `flatProperties`: If true, the resulting GeoJSON feature's properties will be a simple key-value list instead of a structured json object (with separate tags and metadata). default: false
    -   `uninterestingTags`: Either a [blacklist](https://github.com/tyrasd/osmtogeojson/blob/2.0.0/index.js#L14-L24) of tag keys or a callback function. Will be used to decide if a feature is *interesting* enough for its own GeoJSON feature.
    -   `polygonFeatures`: Either a [json object](https://github.com/tyrasd/osmtogeojson/blob/2.0.0/polygon_features.json) or callback function that is used to determine if a closed way should be treated as a Polygon or LineString. [read more](https://wiki.openstreetmap.org/wiki/Overpass_turbo/Polygon_Features)

The result is a javascript object of GeoJSON data:

[](https://github.com/tyrasd/osmtogeojson#geojson)GeoJSON
---------------------------------------------------------

The GeoJSON produced by this library will include exactly one GeoJSON-feature for each of the following OSM objects (that is everything that is also visible in overpass turbo's map view):

-   all unconnected or [*interesting*](https://github.com/tyrasd/osmtogeojson#api) tagged nodes (POIs)
-   all ways (except [*uninteresting*](https://github.com/tyrasd/osmtogeojson#api) multipolygon outlines)
-   all multipolygons (simple multipolygons with exactly one closed outer way are present via their outer way)

All data is given as a FeatureCollection. Each Feature in the collection has an `id` property that is formed from the type and id of the original OSM object (e.g. `node/123`) and has the member `properties` containing the following data:

-   `type`: the OSM data type
-   `id`: the OSM id
-   `tags`: a collection of all tags
-   `meta`: metainformaton about the feature (e.g. version, timestamp, user, etc.)
-   `relations`: an array of relations the feature is member of. Each relation is encoded as an object literal containing the following properties: `role` (membership role), `rel` (the relation's id) and `reltags` (contains all tags of the relation)
-   `tainted`: this flag is set when the feature's geometry is incomplete (e.g. missing nodes of a way or missing ways of a multipolygon)

If the [option](https://github.com/tyrasd/osmtogeojson#api) `flatProperties` is set to true, the `properties` object will not contain any nested object literals, but directly provide a concise id, meta data and the tags of the respective OSM object.
```




With this information, you have a solid foundation to start building your web app. You have the names of the required libraries, basic instructions on how to use them, code examples, and references to official documentation for further reading.

server/hosting info:
I will be hosting this locally, with a python server, and then reverse proxy it to my domain at sm.skoop.digital as my key only allows access over localhost. 
I have my server all set up with ubuntu 22, a folder in /home/ubuntu/shademap fro the files we generate, using caddy to reverse proxy the locally hosted site served with python on port 8000 which all start on boot. My domain (sm.skoop.digital) is pointed to the public ip of my instance which is 52.33.184.219, and all ports are open.


Create a simple web application using HTML, JavaScript, and CSS that displays a high-resolution shadow map centered on the user's current location. The map should be zoomed in to cover a few blocks, providing detailed views of the shadows cast by buildings and other structures.

### Application Requirements:

1. **Location Detection**:
   - The application should detect the user's current location using their device or browser geolocation capabilities.
   - The map should only be rendered after the user's location is successfully acquired to avoid unnecessary panning or re-centering.

2. **Map View**:
   - The map should display a top-down view (no tilt) and be zoomed in to show a few city blocks in detail.
   - The user's location should be marked on the map with a distinctive pin or marker.

3. **Map Interactivity**:
   - Once loaded, the map should be fixed and not scrollable.
   - Minimize the presence of controls or interactive UI elements to maintain a clean and focused user experience.

4. **Shadow Simulation**:
   - Utilize the Leaflet library and the `leaflet-shadow-simulator` plugin to simulate shadows on the map.
   - Ensure the shadow map is of high resolution to prevent pixelation when zoomed in.
   - Your Shademap API key is `eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFkbWluMUBza29vcC5kaWdpdGFsIiwiY3JlYXRlZCI6MTcwNDY1NDIwNzE0MywiaWF0IjoxNzA0NjU0MjA3fQ.GEB9lUcyzGUATxEcgPgPMZUCaXrsYDWSP1y4xZC15WE`.

5. **Building Data**:
   - Retrieve building data from OpenStreetMap for the map bounds using the Overpass API to query OpenStreetMap directly to ensure that we're getting as many buildings as we can from OSM.
   - Format the retrieved data into GeoJSON, if necessary.
   - Add the building data to the shadow simulator to accurately render the building shadows.

6. **Map Tiles**:
   - Integrate Mapbox tiles to populate the map with UI elements such as roads and buildings.
   - Your Mapbox API key is `pk.eyJ1Ijoiam01NTIyIiwiYSI6ImNrZXE1aDF3ODBnYmQydXF4aTV2YXh0am8ifQ.xjp7KWFJBh5RG8hfWijfSA`.

8. **Code Consolidation**:
   - Aim to consolidate all the code into a single `index.html` file for simplicity and ease of maintenance.

### Deliverable:

Submit a complete `index.html` file that fulfills all the above requirements and can be directly hosted and tested on the specified server setup.




Deliverable so far:
```
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shadow Map with OSM Buildings</title>
    <style>
        body {
            margin: 0;
            overflow: hidden; /* Hide scrollbars */
        }
        #map {
            width: 100vw;
            height: 100vh;
        }
        .leaflet-container {
            touch-action: none;
        }
        .time-control {
            position: absolute;
            top: 10px;
            left: 10px;
            z-index: 1000;
            background: white;
            padding: 10px;
            border-radius: 4px;
            box-shadow: 0 1px 5px rgba(0,0,0,0.65);
        }
        .time-control button {
            margin-right: 5px;
        }
    </style>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-shadow-simulator/dist/leaflet-shadow-simulator.umd.min.js"></script>
</head>

<body>
    <div id="map"></div>
    <div class="time-control">
        <button id="decrease-time">-15 min</button>
        <button id="current-time">Current Time</button>
        <button id="increase-time">+15 min</button>
    </div>

    <script>
        const apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFkbWluMUBza29vcC5kaWdpdGFsIiwiY3JlYXRlZCI6MTcwNDY1NDIwNzE0MywiaWF0IjoxNzA0NjU0MjA3fQ.GEB9lUcyzGUATxEcgPgPMZUCaXrsYDWSP1y4xZC15WE';
        const mapboxApiKey = 'pk.eyJ1Ijoiam01NTIyIiwiYSI6ImNrZXE1aDF3ODBnYmQydXF4aTV2YXh0am8ifQ.xjp7KWFJBh5RG8hfWijfSA';

        var map = L.map('map', {
            center: [0, 0],
            zoom: 18,
            maxZoom: 19,
            scrollWheelZoom: false,
            dragging: false,
            touchZoom: false,
            doubleClickZoom: false,
            boxZoom: false,
            keyboard: false,
            zoomControl: false
        });

        L.tileLayer(`https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=${mapboxApiKey}`, {
            maxZoom: 19
        }).addTo(map);

        let shadeMap;
        let touchStartX;
        let touchStartY;
        let touchEndX;
        let touchEndY;
        let swipeStartTimestamp;

        map.locate({ setView: true, maxZoom: 19 });

        map.on('locationfound', async function (e) {
            L.marker(e.latlng).addTo(map);
            const bounds = map.getBounds();
            const buildings = await loadOSMBuildings(bounds);

            shadeMap = L.shadeMap({
                date: new Date(),
                color: '#01112f',
                opacity: 0.7,
                apiKey: apiKey,
                terrainSource: {
                    tileSize: 256,
                    maxZoom: 19,
                    getSourceUrl: ({ x, y, z }) => {
                        return `https://s3.amazonaws.com/elevation-tiles-prod/terrarium/${z}/${x}/${y}.png`;
                    },
                    getElevation: ({ r, g, b, a }) => {
                        return (r * 256 + g + b / 256) - 32768;
                    }
                },
                getFeatures: () => buildings
            }).addTo(map);
        });

        map.on('locationerror', function () {
            map.setView([51.505, -0.09], 20);
        });

        async function loadOSMBuildings(bounds) {
            const query = `
                [out:json][timeout:25];
                (way["building"](${bounds.getSouth()},${bounds.getWest()},${bounds.getNorth()},${bounds.getEast()}););
                out body;
                >;
                out skel qt;
            `;
            const response = await fetch('https://overpass-api.de/api/interpreter', {
                method: 'POST',
                body: query,
                headers: { 'Content-Type': 'text/plain' }
            });
            const data = await response.json();
            return data.elements.map(element => {
                const geometry = element.type === "way"
                    ? {
                        type: "Polygon", coordinates: [element.nodes.map(nodeId => {
                            const node = data.elements.find(e => e.id === nodeId);
                            return [node.lon, node.lat];
                        })]
                    }
                    : null;

                return geometry ? {
                    type: "Feature",
                    properties: { height: element.tags['building:levels'] * 3 || 10 },
                    geometry: geometry
                } : null;
            }).filter(feature => feature !== null);
        }

        // Time control buttons functionality
        document.getElementById('decrease-time').addEventListener('click', function () {
            var currentDate = shadeMap.options.date;
            shadeMap.setDate(new Date(currentDate.getTime() - 15 * 60000));
        });

        document.getElementById('increase-time').addEventListener('click', function () {
            var currentDate = shadeMap.options.date;
            shadeMap.setDate(new Date(currentDate.getTime() + 15 * 60000));
        });

        document.getElementById('current-time').addEventListener('click', function () {
            shadeMap.setDate(new Date());
        });

        // Detect touch gestures
        map.getContainer().addEventListener('touchstart', function (e) {
            touchStartX = e.touches[0].clientX;
            swipeStartTimestamp = shadeMap.options.date.getTime(); // Record the timestamp at the start of the swipe
        });

        map.getContainer().addEventListener('touchmove', function (e) {
            touchEndX = e.changedTouches[0].clientX;

            if (touchStartX && touchEndX) {
                // Calculate the distance swiped
                const distanceX = touchStartX - touchEndX;

                // Only consider horizontal swipes
                const minutesToAdjust = distanceX / 4; // Adjust the time by 1 minute for every 10 pixels swiped
                const adjustedTimestamp = swipeStartTimestamp - minutesToAdjust * 60000;

                shadeMap.setDate(new Date(adjustedTimestamp));
            }
        });

        map.getContainer().addEventListener('touchend', function () {
            // Reset to current time after the user releases their finger
            shadeMap.setDate(new Date());

            // Reset touch start and end coordinates
            touchStartX = null;
            touchEndX = null;
        });
    </script>
</body>

</html>


```

This code works well, however can you increse the speed at which the time of day changes per the swiping action?