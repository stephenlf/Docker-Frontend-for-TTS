#!/bin/sh
echo "slfunk/text-to-speech-frontend: api_endpoint_uri=${api_endpoint_uri}";

# Check to see if the 'api_endpoint_url' environmental variable has been specified.
if [ "${api_endpoint_uri}" == "MISSING" ]
# If not, print an error to STDOUT
    then
        YELLOW="\e[33m"
        ENDCOLOR="\e[0m"
        echo -e "slfunk/text-to-speech-frontend: ${YELLOW}An endpoint URI was not specified. This container likely won't work properly.\n \
        Please specify the endpoint URI during the run phase with the following environment parameter:\n \
        -env api_endpoint_uri=YOUR.ENDPOINT.HERE.EXAMPLE.COM${ENDCOLOR}"
# If so, 
    else
        echo "slfunk/text-to-speech-frontend: enpoint_uri detected, updating logic.json"
        echo "const endpoint_url = \"${api_endpoint_uri}\";" >> /usr/share/nginx/html/logic.js
    fi

echo "Running docker-entrypoint.sh"

# The NGINX daemon allows NGINX to run in background mode. This is great for most applications. \
#   However, in Docker, when the NGINX service gets shifted to the background, the Docker       \
#   daemon interprets this as its ENTRYPOINT script coming to an end. This causes Docker to shut\
#   down the container early. To fix this, we run NGINX in the foreground.                      \
#   The docker-entrypoint.sh file is provided by the nginx parent container and is maintained by\
#   NGINX Docker Maintainers. https://hub.docker.com/_/nginx
bash docker-entrypoint.sh nginx -g 'daemon off;'