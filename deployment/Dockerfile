# ---------- STEP 1 ----------
# Build the documentation in web format
FROM asciidoctor/docker-asciidoctor AS asciidoctor

WORKDIR /documentation
COPY . /documentation
RUN make html asciidoctor_cmd=asciidoctor

# ---------- STEP 2 ----------
# Docker image only containing nginx and the freshly built documentation
FROM vshn/nginx:1.0

# Copy the contents of the documentation to be served
COPY --from=asciidoctor /documentation/_public/README.html /usr/share/nginx/html/index.html
