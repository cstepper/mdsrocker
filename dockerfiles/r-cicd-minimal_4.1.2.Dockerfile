FROM cstepper/r-aws-minimal:4.1.2

COPY /scripts/install-cicd.sh /rocker_scripts

RUN chmod +x /rocker_scripts/install-cicd.sh
RUN /rocker_scripts/install-cicd.sh

# default for executing container
CMD /bin/bash
