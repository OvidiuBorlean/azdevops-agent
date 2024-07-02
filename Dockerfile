FROM ubuntu:22.04
ENV TARGETARCH="linux-x64"
# Also can be "linux-arm", "linux-arm64".

RUN apt update
RUN apt upgrade -y
RUN apt install -y curl git jq libicu70 unzip python3 python3-pip
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && chmod +x ./kubectl && mv ./kubectl /usr/sbin
COPY ./install-cli.sh ./
RUN chmod +x ./install-cli.sh && ./install-cli.sh
#RUN curl -O https://get.helm.sh/helm-v3.15.2-linux-arm64.tar.gz && chmod +x ./helm && mv ./helm /usr/sbin
COPY ./helm-v3.15.2-linux-amd64.tar.gz ./
RUN tar zxvf helm-v3.15.2-linux-amd64.tar.gz && chmod +x ./linux-amd64/helm && mv ./linux-amd64/helm /usr/sbin
WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

# Create agent user and set up home directory
RUN useradd -m -d /home/agent agent
RUN chown -R agent:agent /azp /home/agent

USER agent
# Another option is to run the agent as root.
# ENV AGENT_ALLOW_RUNASROOT="true"

ENTRYPOINT [ "./start.sh" ]
