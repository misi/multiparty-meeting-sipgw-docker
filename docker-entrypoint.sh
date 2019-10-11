#!/bin/sh 

echo "Container starting up..." 
set -e 

cd ${BASEDIR}/${MM_SIPGW}
node ${BASEDIR}/${MM_SIPGW}/server.js

exec "$@"
