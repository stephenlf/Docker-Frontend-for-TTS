# escape=`
# The above changes the default escape char used by Docker to the back apostrophe.
#   This is helpful for working with Windows filepaths

# Will use Alpine-based httpd after I confirm that this workds
# FROM    httpd:alpine AS alpine
FROM    nginx

LABEL   watermark="https://hub.docker.com/u/slfunk" `
        maintainer="stephenlfunk@gmail.com"

ENV     api_endpoint_uri=MISSING

COPY    bootstrap.sh .
COPY    files/* /usr/share/nginx/html/

CMD [ "bash", "./bootstrap.sh", "-g", "daemon", "off" ]
