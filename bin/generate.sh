#!/bin/bash
#
# Generate the site
#

# Build the site
( cd src && zola build ) || exit 1

# Delete built files
rm -f 404.html
rm -f index.html
rm -f robots.txt
rm -f sitemap.xml
rm -f style.css
rm -rf about/
rm -rf hpmfp/
rm -rf images/
rm -rf posts/

# Copy built files
cp src/public/404.html .
cp src/public/index.html .
cp src/public/robots.txt .
cp src/public/sitemap.xml .
cp src/public/style.css .
cp -r src/public/about/ .
cp -r src/public/hpmfp/ .
cp -r src/public/images/ .
cp -r src/public/posts/ .
