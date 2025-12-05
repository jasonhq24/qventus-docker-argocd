FROM quay.io/argoproj/argocd:v3.2.0

USER root
RUN apt-get update && \
    apt-get install -y \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER argocd

ARG S3_PLUGIN_VERSION="0.17.1"
ARG S3_PLUGIN_REPO="https://github.com/hypnoglow/helm-s3.git"

RUN helm plugin install ${S3_PLUGIN_REPO} --version ${S3_PLUGIN_VERSION}

ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
