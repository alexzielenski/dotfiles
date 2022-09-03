# Custom environment configuration
# Put configuration specific to your machine into this file
# This file is sourced before modules rc files are loaded

# set ulimits as high as possible
ulimit -n 1048576

# Add self-built kubernetes build to PATH
export PATH="$HOME/go/src/k8s.io/kubernetes/_output/local/bin/darwin/arm64":$PATH

# Add dev ETCD to PATH
export PATH=$HOME/go/src/k8s.io/kubernetes/third_party/etcd:$PATH

# Kubebuilder test environment vars
export TEST_ASSET_KUBECTL="$(which kubectl)"
export TEST_ASSET_KUBE_APISERVER="$(which kube-apiserver)"
export TEST_ASSET_ETCD="$(which etcd)"


# ADd mono
export PATH="/Library/Frameworks/Mono.framework/Versions/Current/bin":$PATH

export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"