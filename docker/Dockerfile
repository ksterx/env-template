FROM nvcr.io/nvidia/pytorch:21.07-py3

LABEL maintainer="ksterx <kostonerx@gmail.com"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
# Set time zone as Tokyo
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#####################################
# Package Installation

# PyPI
RUN pip install --upgrade pip \
    && pip install \

    # Deep Learning
    pytorch-lightning==1.2.10 \
    torchinfo \
    torch-tb-profiler \

    # Reinforcement Learning
    stable-baselines[mpi] \

    # Hyperparameter Optimization
    optuna \

    # Debugging
    line-profiler \

    # Workflow Managemanagement
    luigi \
    mlflow \

    # Explanatory Data Analysis (EDA)
    seaborn \
    pandas-profiling[notebook] \
    dataprep \
    autoviz \

    # Code formatter and linter
    black \
    flake8 \

    # Misc
    typing \
    opencv-python \
    opencv-contrib-python

# JupyterLab
RUN pip install \
    # "jupyterlab-kite>=2.0.2" \  # Now kite is not available on Apple Silicon
    theme-darcula \
    ipywidgets \
    jupytext \
    jupyterlab-git \
    jupyter-lsp \
    nbresuse \
    'python-lsp-server[all]' \
    lckr-jupyterlab-variableinspector \
    ipympl

RUN conda install -y -q xeus-python -c conda-forge

RUN apt-get update \
    && apt-get install -y nodejs npm \
    && npm install n -g \
    && n stable \
    && apt-get purge -y nodejs npm

# TKinter
RUN apt-get update && \
    apt-get install -y \
    python3-tk \
    libgl1-mesa-dev

######################
# Jupyter setup
RUN jupyter notebook --generate-config \
    && echo "c.ServerApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo "c.ServerApp.port = 8888" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.notebook_dir = '/workspace'" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo 'c.ServerApp.contents_manager_class = "jupytext.TextFileContentsManager"' >> /root/.jupyter/jupyter_notebook_config.py \
    && echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py \
    && echo 'c.ContentsManager.default_jupytext_formats = "ipynb,py"' >> /root/.jupyter/jupyter_notebook_config.py

######################
# JupyterLab Extensions
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
# RUN jupyter labextension install @lckr/jupyterlab_variableinspector
# RUN jupyter labextension install @krassowski/jupyterlab-lsp
# RUN jupyter labextension install @jupyterlab/debugger
# RUN jupyter labextension install @telamonian/theme-darcula
# RUN jupyter labextension install @jupyterlab/toc
# RUN jupyter labextension install jupyterlab_tensorboard
# RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-system-monitor
# RUN jupyter labextension install @kiteco/jupyterlab-kite
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib@0.7.4
# RUN jupyter labextension install @bokeh/jupyter_bokeh
# RUN jupyter lab build


# Bring in changes from outside container to /tmp
# (assumes my-pytorch-modifications.patch is in same directory as Dockerfile)
# COPY my-pytorch-modifications.patch /tmp

# # Change working directory to PyTorch source path
# WORKDIR /opt/pytorch

# # Apply modifications
# RUN patch -p1 < /tmp/my-pytorch-modifications.patch

# # Rebuild PyTorch
# RUN cd pytorch && \
#     CUDA_HOME="/usr/local/cuda" \
#     CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
#     NCCL_INCLUDE_DIR="/usr/include/" \
#     NCCL_LIB_DIR="/usr/lib/" \
#     USE_SYSTEM_NCCL=1 \
#     USE_OPENCV=1 \
#     pip install --no-cache-dir -v .

# Clean up environments
RUN conda clean --all -f -y

# Reset default working directory
WORKDIR /workspace
