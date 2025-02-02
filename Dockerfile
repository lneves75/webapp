ARG COMMIT_HASH
ARG TAG
FROM ubuntu AS stage

WORKDIR /tmp
COPY index.html ./index.tpl

RUN sed 's/__COMMIT_HASH__/'${COMMIT_HASH}'/g' index.tpl > index.html

FROM nginxinc/nginx-unprivileged:${TAG} AS runtime

COPY --from=stage /tmp/index.html /usr/share/nginx/html/index.html
