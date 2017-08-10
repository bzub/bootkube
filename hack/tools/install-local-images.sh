#!/usr/bin/env sh
# vim: noai:ts=2:sw=2:set expandtab
set -e

[ -z "${IMG_DIR}" ] && IMG_DIR="/var/tmp/images"

if [ ! -d "${IMG_DIR}" ]; then
  echo "Image directory ${IMG_DIR} does not exist. Nothing to do."
  exit 0
fi

ACI_IMAGES="$(ls ${IMG_DIR}/*.aci || echo "")"
DOCKER_IMAGES="$(ls ${IMG_DIR}/*.docker || echo "")"

# Import ACI images for rkt.
if [ -n "${ACI_IMAGES}" ]; then
  for i in ${ACI_IMAGES}; do
    echo "Importing ${i}"
    rkt --insecure-options=image fetch "${i}"
  done
else
  echo "No .aci images found in ${IMG_DIR}"
fi

# Import Docker images.
if [ -n "${DOCKER_IMAGES}" ]; then
  for i in ${DOCKER_IMAGES}; do
    echo "Importing ${i}"
    docker load -i "${i}"
  done
else
  echo "No .docker images found in ${IMG_DIR}"
fi
