# Start
FROM pdonorio/ipynb_data_slides:latest
MAINTAINER p.donoriodemeo@cineca.it

## This was defined in previous image
#ENV myuser
#ENV mypw

# Add metl package for parsing
RUN pip install metl

USER $myuser
# Install MathJax locally because it has some problems with https
#as reported here: https://github.com/bgruening/galaxy-ipython/pull/8
RUN python -c 'from IPython.external import mathjax; mathjax.install_mathjax("2.5.1")'

USER root

#RUN apt-get remove r-base-core
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" >> /etc/apt/sources.list
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && gpg -a --export E084DAB9 | sudo apt-key add -
# R packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y r-base r-base-dev
# R configuration of repository profile
RUN echo "local({r <- getOption('repos'); r['CRAN'] <- 'http://cran.r-project.org'; options(repos=r)});" >> /root/.Rprofile

ENV rscript /tmp/Rscripting.R
ENV rlibs library(RCurl);library(devtools);
# R libraries devtools
RUN echo "install.packages('devtools')" > $rscript
RUN R --no-save < $rscript
## R kernel for ipython
# install rzmq
RUN echo "$rlibs install_github('armstrtw/rzmq');" > $rscript
RUN R --no-save < $rscript
# install repr
RUN echo "$rlibs install_github('IRkernel/repr');" > $rscript
RUN R --no-save < $rscript
# install kernels
RUN echo "$rlibs install_github('IRkernel/IRdisplay'); install_github('IRkernel/IRkernel')" > $rscript
RUN R --no-save < $rscript

# Install data packages
ADD data_analysis_packages.r /tmp/data_analysis_packages.r
RUN R --no-save < /tmp/data_analysis_packages.r

# Install kernel
USER $myuser
ENV rscript /tmp/Rscripting.Ruser
RUN ipython kernelspec install --replace --name ir --user /usr/local/lib/R/site-library/IRkernel/kernelspec
RUN echo "library(IRdisplay); library(IRkernel); installspec()" > $rscript && R --no-save < $rscript

USER root