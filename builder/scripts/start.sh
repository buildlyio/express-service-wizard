#!/bin/bash

#
# This is a command line interface for creating Express.js apps for Buildly.
#
# LICENSE: GPL-3.0
#
# CONTACT: team@buildly.io
#

###############################################################################
#
# Global variables
#
###############################################################################

##
# Declare colors with autodection if output is terminal
if [ "$1" == "-nc" ] || [ "$1" == "--no-colors" ]; then
  GREEN=""
  BLUE=""
  WHITE=""
  BOLD=""
  OFF=""
else
  GREEN="$(tput setaf 2)"
  BLUE="$(tput setaf 4)"
  WHITE="$(tput setaf 7)"
  BOLD="$(tput bold)"
  OFF="$(tput sgr0)"
fi

declare -a result_color_table=( "$WHITE" "$WHITE" "$GREEN" "$WHITE" "$WHITE" )


###############################################################################
#
# Welcome message
#
###############################################################################

echo -e "${BOLD}${BLUE}==>${OFF} ${BOLD}${WHITE}Welcome to the Buildly Core Express Service wizard!${OFF}"
cat <<EOF
${GREEN}
 _           _ _     _ _
| |__  _   _(_) | __| | |_   _
| '_ \| | | | | |/ _\` | | | | |
| |_) | |_| | | | (_| | | |_| |
|_.__/ \__,_|_|_|\__,_|_|\__, |
                         |___/
${OFF}
EOF

echo -e "${BOLD}${BLUE}==>${OFF} ${BOLD}${WHITE}We will help you to set up a service :)${OFF}"

###############################################################################
#
# Global Functions
#
###############################################################################

echo -n "Type in the name of your service (e.g.: calendarService): "
read service_name

echo -n "Type in the displayed Name of your service (e.g.: Calendar Service): "
read displayed_name

# Initialize new express application
express --no-view --git "$service_name"

# Add swagger configuration to app.js
sed -i'' "8i\var swaggerUi = require('swagger-ui-express');" "/code/$service_name/app.js"
sed -i'' "9i\var swaggerDocument = require('./swagger.json');" "/code/$service_name/app.js"
sed -i'' "12i\var options = {explorer : true};" "/code/$service_name/app.js"
sed -i'' "22i\app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument, options));" "/code/$service_name/app.js"

# Add swagger schema to project
sed -i'' '12i\\t\"swagger-ui-express\": \"2.0.6\",' "/code/$service_name/package.json"
cp "/code/builder/templates/swagger.json" "/code/$service_name/swagger.json"

# Add README.md to the application
cp "/code/builder/templates/README.md" "/code/$service_name/README.md"
sed -i "s/{{ service_name }}/$service_name/g" "/code/$service_name/README.md"
sed -i "s/{{ displayed_name }}/$displayed_name/g" "/code/$service_name/README.md"

echo -e "${BOLD}${BLUE}==>${OFF} ${BOLD}${WHITE}The Express app "$service_name" was successfully created${OFF}"

# Add Docker support
echo -n "Add Docker support? (y/n): "
read docker_support
if [ "$docker_support" != "${docker_support#[Yy]}" ] ;then
  cp "/code/builder/templates/Dockerfile" "/code/$service_name/Dockerfile"
  cp "/code/builder/templates/.dockerignore" "/code/$service_name/.dockerignore"

  echo -e "${BOLD}${BLUE}==>${OFF} ${BOLD}${WHITE}Docker support was successfully added${OFF}"
fi
