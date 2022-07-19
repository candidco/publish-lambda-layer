ARG RUNTIME=python3.8

FROM public.ecr.aws/sam/build-$RUNTIME

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
