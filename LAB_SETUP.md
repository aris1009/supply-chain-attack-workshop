# Docker Supply Chain Attack Workshop - Prerequisites (macOS)

## Required Software Installation

### 1. Everyone should have these installed already
- docker
- homebrew

### 2. Workshop Tools
Install required tools using Homebrew:
```bash
brew install nmap dive
```

### 3. Base Image Pre-pull
Pull the specific base image to ensure lab consistency:
```bash
# Pull the pinned Fedora base image (same version used in workshop)
docker pull fedora:42@sha256:6af051ad0a294182c3a957961df6203d91f643880aa41c2ffe3d1302e7505890
```

## How to extract an image file system

```bash
# run the image to have a container
docker run --rm -it image:tag /bin/bash

docker ps # find container id

mkdir -p extracted
docker export <container-id> -o somename
tar -xf somename -C extracted
cd extracted
# you can now inspect the container's file system
```