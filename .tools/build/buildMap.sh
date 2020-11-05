#!/bin/sh
set -e

toolsDir=$(dirname $0)
mapPath=$1
worldName=$(basename $mapPath)

mehUtils=$toolsDir/meh-utils
layerSettings=$toolsDir/layer_settings.json

mapOutDir=/out/$worldName

echo "--------------------------------------------------"
echo "🗺️ $worldName"
echo "--------------------------------------------------"

echo ""
echo "📁 Creating output directory ($worldName)"
mkdir -p $mapOutDir

echo ""
echo "📁 Copying meta.json ($worldName)"
cp $mapPath/meta.json $mapOutDir/meta.json

echo ""
echo "📁 Building preview images ($worldName)"
$mehUtils preview -in $mapPath -out $mapOutDir

echo ""
echo "📁 Building satellite tiles ($worldName)"
mkdir -p $mapOutDir/sat
$mehUtils sat -in $mapPath -out $mapOutDir/sat

echo ""
echo "📁 Building Mapbox Terrain-RGB tiles ($worldName)"
mkdir -p $mapOutDir/terrainrgb
$mehUtils terrainrgb -in $mapPath -out $mapOutDir/terrainrgb

echo ""
echo "📁 Building mapbox vector tiles ($worldName)"
mkdir -p $mapOutDir/mvt
$mehUtils mvt -in $mapPath -out $mapOutDir/mvt -layer_settings $layerSettings
echo ""

