FROM jupyter/scipy-notebook

USER root

COPY requirements.txt /home/jovyan/

RUN apt-get update && \
    apt-get install vim -y && \
    pip install -r /home/jovyan/requirements.txt && \
    jupyter labextension install nbdime-jupyterlab

CMD start.sh jupyter lab --LabApp.token=''
