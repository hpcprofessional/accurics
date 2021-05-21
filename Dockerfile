FROM node:10-alpine

LABEL "com.azure.dev.pipelines.agent.handler.node.path"="/usr/local/bin/node"

RUN apk update && apk add --no-cache python3 linux-pam ca-certificates curl jq \
    bash sudo shadow git && \
    apk add --virtual=build python3-dev gcc libffi-dev musl-dev openssl-dev make && \
    pip3 --no-cache-dir install azure-cli && \
    apk del --purge build

RUN curl -s https://downloads.accurics.com/cli/1.0.18b1/accurics_linux -o /usr/bin/accurics && \
  chmod 755 /usr/bin/accurics && \
  curl -s -S -L -o /tmp/terraform_0.12.24_linux_amd64.zip https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip && \
  unzip -d /usr/local/bin /tmp/terraform_0.12.24_linux_amd64.zip

CMD [ "node" ]
