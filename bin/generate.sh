#
# Generate the site
#

( cd src && zola build -o .. ) || exit 1
