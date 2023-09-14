FROM mambaorg/micromamba:1.5.0

COPY --chown=$MAMBA_USER:$MAMBA_USER env.yml /tmp/env.yml

RUN micromamba install -y -n base -f /tmp/env.yml && \
    micromamba clean --all --yes

RUN micromamba run pip install --no-cache "quetz-server[gcs]" "pydantic<2" "xattr"

RUN micromamba run pip install quetz-frontend

COPY wait-for-it.sh /usr/bin/wait-for-it.sh

# docker run -v /Users/wolfv/Programs/quetz/demo:/quetz_config -p 8000:8000 quetz-docker:latest quetz start /quetz_config --host 0.0.0.0 --port 8000

CMD ["/bin/bash"]
