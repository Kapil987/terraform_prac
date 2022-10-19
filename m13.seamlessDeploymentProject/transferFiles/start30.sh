#!/bin/sh
arr=(kapil0123/spotify-website-demo kapil0123/seo-website-demo kapil0123/construction-website-demo)
docker_stop_rm () {
        docker stop webapp
        docker rm -f webapp
        echo ${arr[2]}
}
docker_stop_rm
docker run -d --name webapp -p 80:80 ${arr[2]}