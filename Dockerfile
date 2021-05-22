FROM debian:9.5-slim

RUN apt update
RUN apt -yq install openssh-client openssl


# Label
LABEL "com.github.actions.name"="Deploy with scp"
LABEL "com.github.actions.description"="Deploy to a remote server using scp"
LABEL "com.github.actions.color"="blue"
LABEL "com.github.actions.icon"="download-cloud"

LABEL "repository"="http://github.com/aericpp/scp-deploy"
LABEL "homepage"="https://github.com/aericpp/scp-deploy"
LABEL "maintainer"="aericpp <p.yue89@gmail.com>"


ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
