#!/bin/bash
#
# Generate the site
#

# Build the site
( cd src && zola build ) || exit 1

# Delete built files
rm -f 404.html
rm -f atom.xml
rm -f index.html
rm -f robots.txt
rm -f sitemap.xml
rm -f style.css
rm -f extra.css
rm -f morkborg.css
rm -f poirot.css
rm -rf images/
rm -rf morkborg/
rm -rf callofcthulhu/
rm -rf projects/
rm -rf fonts/

# Copy built files
cp src/public/404.html .
cp src/public/index.html .
cp src/public/robots.txt .
cp src/public/sitemap.xml .
cp src/public/style.css .
cp src/public/extra.css .
cp src/public/morkborg.css .
cp src/public/poirot.css .
cp src/public/atom.xml .
cp -r src/public/images/ .
cp -r src/public/morkborg/ .
cp -r src/public/callofcthulhu/ .
cp -r src/public/projects/ .
cp -r src/public/fonts/ .
