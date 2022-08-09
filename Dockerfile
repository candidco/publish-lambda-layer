ARG RUNTIME=python3.9

FROM public.ecr.aws/sam/build-$RUNTIME

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
