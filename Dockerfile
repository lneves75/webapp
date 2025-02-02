FROM ubuntu AS stage

WORKDIR /tmp
COPY index.html ./index.tpl

ARG COMMIT_HASH
RUN sed 's/__COMMIT_HASH__/'${COMMIT_HASH}'/g' index.tpl > index.html

ARG VERSION
FROM nginxinc/nginx-unprivileged:${VERSION}-alpine AS runtime

COPY --from=stage /tmp/index.html /usr/share/nginx/html/index.html
