#!/bin/bash

#
# This is a command line interface for creating Express.js apps for Buildly.
#
# LICENSE: GPL-3.0
#
# CONTACT: team@buildly.io
#

cat <<EOF
 _           _ _     _ _
| |__  _   _(_) | __| | |_   _
| '_ \| | | | | |/ _\` | | | | |
| |_) | |_| | | | (_| | | |_| |
|_.__/ \__,_|_|_|\__,_|_|\__, |
                         |___/
EOF


###############################################################################
#
# Global Functions
#
###############################################################################

if [ -z "$1" ]; then
  echo -n "Type a name for your new application: "
  read app_name
else
  app_name=$1
fi

# Initialize new express application
express --no-view --git "$app_name"

# Add swagger configuration to app.js
sed -i'' "8i\var swaggerUi = require('swagger-ui-express');" "/code/$app_name/app.js"
sed -i'' "9i\var swaggerDocument = require('./swagger.json');" "/code/$app_name/app.js"
sed -i'' "12i\var options = {explorer : true};" "/code/$app_name/app.js"
sed -i'' "22i\app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument, options));" "/code/$app_name/app.js"

# Add swagger dependency to package.json
sed -i'' '12i\\t\"swagger-ui-express\": \"2.0.6\",' "/code/$app_name/package.json"

# create swagger.json
touch "/code/$app_name/swagger.json"
echo "{}" >> "/code/$app_name/swagger.json"
