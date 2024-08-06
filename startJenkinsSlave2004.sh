#!/bin/bash

DOCKER_IMAGE_NAME=actin_dev
DOCKER_CONTAINER_NAME=actin_dev


# source ~/environment.source

docker stop ${DOCKER_CONTAINER_NAME}
docker rm ${DOCKER_CONTAINER_NAME}

docker build -t ${DOCKER_IMAGE_NAME} .


#docker network rm ${DOCKER_CONTAINER_NAME}
# docker network create --subnet=172.80.0.160/30 ${DOCKER_CONTAINER_NAME}

HOST_WORKSPACE_DIR=${HOST_ROOT_DIR}/workspace
HOST_CONFIG_DIR=${HOST_ROOT_DIR_B}/${JENKINS_NODE_NAME}/config
#mkdir -p ${HOST_CACHE_DIR} && chown -R $USER:$GROUP ${HOST_CACHE_DIR}
#mkdir -p ${HOST_WORKSPACE_DIR} && chown -R $USER:$GROUP ${HOST_WORKSPACE_DIR}
#cp -R ${HOST_INITIAL_CONFIG_DIR} ${HOST_CONFIG_DIR} && chown -R $USER:$GROUP ${HOST_CONFIG_DIR}
#cp ~/ftpCredentials ${HOST_WORKSPACE_DIR}

docker run  -u jenkins -it  \
    --detach \
    --cpus=8 \
    --name ${DOCKER_CONTAINER_NAME} \
    --add-host jenkins.energid.net:10.0.0.114 \
    --add-host gitlab.energid.net:10.0.0.114 \
    --add-host github.com:20.207.73.82 \
    --add-host packages.energid.info:10.0.0.114 \
    --restart always \
    --volume /home/craghu/Desktop/workspace:/home/jenkins/workspace \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume ${HOME}/.ssh:${DOCKER_HOME_DIR}/.ssh \
    ${DOCKER_IMAGE_NAME} bash

#docker run -u jenkins -it --name ${DOCKER_CONTAINER_NAME} --cpus=8 --add-host jenkins.energid.net:10.0.0.114 --add-host gitlab.energid.net:10.0.0.114 --add-host github.com:20.207.73.82 --add-host packages.energid.info:10.0.0.114 --restart always --volume /home/craghu/Desktop/workspace:/home/jenkins/workspace --volume /tmp/.X11-unix:/tmp/.X11-unix --volume ${HOME}/.ssh:${DOCKER_HOME_DIR}/.ssh --volume ${HOME}/bin:${DOCKER_HOME_DIR}/bin actin_dev  bash
