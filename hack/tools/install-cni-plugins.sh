#!/usr/bin/env sh
set -e

# [ -z "${CNI_RELEASE}" ] && CNI_RELEASE="v0.5.2"
[ -z "${CNI_RELEASE}" ] && CNI_RELEASE="0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff"
[ -z "${CNI_ARCH}" ]    && CNI_ARCH="amd64"
[ -z "${CNI_DIR}" ]     && CNI_DIR="/opt/cni"

# CNI_URL="https://github.com/containernetworking/cni/releases/download/${CNI_RELEASE}/cni-${CNI_ARCH}-${CNI_RELEASE}.tgz"
CNI_URL="https://storage.googleapis.com/kubernetes-release/network-plugins/cni-${CNI_ARCH}-${CNI_RELEASE}.tar.gz"

curl --silent --show-error -L -o /tmp/cni.tgz "${CNI_URL}"
[ ! -d "${CNI_DIR}" ] && mkdir -p "${CNI_DIR}"
tar -zxf /tmp/cni.tgz -C "${CNI_DIR}"
