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
cp 404.html .
cp index.html .
cp robots.txt .
cp sitemap.xml .
cp style.css .
cp -r about/ .
cp -r hpmfp/ .
cp -r images/ .
cp -r posts/ .
