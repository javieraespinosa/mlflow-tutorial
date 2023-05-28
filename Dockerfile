
FROM jupyter/minimal-notebook:2022-06-13
USER root

# Jupyter config
RUN echo 'c.NotebookApp.open_browser = False' >> /home/jovyan/.jupyter/jupyter_notebook_config.py \
 && echo 'c.NotebookApp.allow_root   = True'  >> /home/jovyan/.jupyter/jupyter_notebook_config.py \
 && echo 'c.NotebookApp.base_url     = "/"'   >> /home/jovyan/.jupyter/jupyter_notebook_config.py \
 && echo 'c.NotebookApp.ip           = "*"'   >> /home/jovyan/.jupyter/jupyter_notebook_config.py \
 && echo 'c.NotebookApp.token        = ""'    >> /home/jovyan/.jupyter/jupyter_notebook_config.py

# Python modules
RUN pip install mlflow[extras]

RUN apt-get update && apt-get install -y curl 

# Prepare conda envs for selected examples
COPY examples  /examples
RUN conda env create -f /examples/sklearn_elasticnet_wine/conda.yaml
RUN conda env create -f /examples/hyperparam/conda.yaml

WORKDIR $HOME