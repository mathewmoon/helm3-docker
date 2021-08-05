FROM python:3.8-alpine
LABEL maintainer="Mathew Moon <me@mathewmoon.net>"

RUN mkdir /root/.kube && \
    mkdir -p /root/.helm/plugins && \
    export HELM_HOME=/root/.helm VERIFY_CHECKSUM=false && \
    apk update && \
    apk add --no-cache curl && \
    pip3.8 install --no-cache-dir awscli && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl >/bin/kubectl && \
    chmod +x /bin/kubectl && \
    curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 2>/dev/null | sh || echo "yes" && \
    apk del py3-pip && \
    rm -rf /usr/local/bin/pip* && \
    rm -rf /var/cache/apk && \
    rm -rf /root/.cache && \
    echo "[ -f ~/.bashrc ] && source ~/.bashrc" >>/etc/profile

COPY bashrc /root/.bashrc
ENV PS1="\[\e[0;32m\]$(pwd):\h $\[\e[m\] "

CMD ["/bin/bash"]
