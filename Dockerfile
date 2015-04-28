# Start
FROM twiecki/pydata-docker-jupyterhub
MAINTAINER p.donoriodemeo@cineca.it
ENV myuser pydatanalysis
ENV mypw workshop

# PACKAGE FOR slides converting
RUN pip install jsonschema mistune

# PDF generation
RUN apt-get update && apt-get install -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# # Package to include to use PDF exporter...
#     texlive-latex-base texlive-latex-recommended texlive-fonts-recommended \
#     texlive-fonts-extra texlive-latex-extra \

# ADD USER
RUN wget "https://raw.githubusercontent.com/twiecki/pydata_docker_jupyterhub/master/scripts/add_user.sh" -O /tmp/add.sh
RUN echo "$myuser,$mypw" > /tmp/users && bash /tmp/add.sh /tmp/users

# LIVE RELOAD MY SLIDES
USER $myuser
ENV tmp /tmp/rise
ENV liveslides /tmp/liveslides.sh
RUN mkdir -p $tmp && \
    echo "#!/bin/bash\ngit clone https://github.com/damianavila/RISE $tmp && cd $tmp && python setup.py install && rm -rf $tmp" > $liveslides \
    && chmod +x $liveslides && ipython profile create && $liveslides

# Change keys and profiles
ADD main.js /home/$myser/.ipython/nbextensions/livereveal/main.js

# CLEAN and use admin for launching jupyter
USER root
RUN rm -fr /tmp/*
