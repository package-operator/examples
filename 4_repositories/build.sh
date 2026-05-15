#!/bin/bash
set -euo pipefail

# build package images
PKG_A_REPO="quay.io/nschiede/pkg-a"
kubectl package build ./pkgs/pkg-a/v0.1.0 --tag="${PKG_A_REPO}:v0.1.0" --push
kubectl package build ./pkgs/pkg-a/v0.2.0 --tag="${PKG_A_REPO}:v0.2.0" --push
kubectl package build ./pkgs/pkg-a/v0.3.0 --tag="${PKG_A_REPO}:v0.3.0" --push

rm repo.yaml
kubectl package repo initialize repo.yaml my-repo
kubectl package repo add repo.yaml "${PKG_A_REPO}:v0.1.0" 0.1.0
kubectl package repo add repo.yaml "${PKG_A_REPO}:v0.2.0" 0.2.0
kubectl package repo add repo.yaml "${PKG_A_REPO}:v0.3.0" 0.3.0