FROM jupyter/pyspark-notebook

USER root

COPY requirements*.txt /home/jovyan/

RUN apt-get update && \
    apt-get install vim -y
    
USER $NB_UID

RUN pip install --upgrade pip && \
    pip install -r /home/jovyan/requirements.txt && \
    pip install -r /home/jovyan/requirements-test.txt && \
    jupyter labextension install nbdime-jupyterlab && \
    jupyter labextension install @jupyterlab/toc

CMD start.sh jupyter lab --LabApp.token=''
