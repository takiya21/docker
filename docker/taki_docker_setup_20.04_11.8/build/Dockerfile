FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

#RUN rm /etc/apt/sources.list.d/cuda.list \
#&& rm /etc/apt/sources.list.d/nvidia-ml.list \
#&& apt-key del 7fa2af80 \
#&& apt-get update && apt-get install -y --no-install-recommends wget \
#&& wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.#0-1_all.deb \
#&& dpkg -i cuda-keyring_1.0-1_all.deb

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#ADD ./config/resolv.conf /root/
# RUN cat /root/resolv.conf > /etc/resolv.conf

RUN apt-get update

#  activate add-apt-repository
RUN apt-get install -y software-properties-common
#RUN add-apt-repository ppa:kelleyk/emacs
#RUN apt-add-repository ppa:fish-shell/release-2
RUN add-apt-repository ppa:opencpn/opencpn
RUN apt-get update

RUN apt-get -y install openssh-server \
nfs-common \
graphviz \
git \
curl \
tree \
tmux \
incron \
vim \
libgtk2.0-0 \
language-pack-ja-base \
language-pack-ja \
fish \
libsndfile1-dev \
libasound2-dev \
libgl1-mesa-glx

# for NFS
RUN mkdir /mnt/qnap1 /mnt/qnap2

# ssh
RUN sed -ri 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
RUN /etc/init.d/ssh start

# language
ENV LANG=ja_JP.UTF-8

RUN echo 'export PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:$PATH' >> /etc/bash.bashrc
RUN echo 'export LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64:$LD_LIBRARY_PATH' >> /etc/bash.bashrc

EXPOSE 22

# LDAP
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ldap-auth-config \
libnss-ldap \
libpam-ldap \
ldap-utils

ADD ./config/ldap.conf /root/
ADD ./config/nsswitch.conf /root/
RUN cat /root/ldap.conf > /etc/ldap.conf
RUN cat /root/nsswitch.conf > /etc/nsswitch.conf
RUN echo katlab >> /etc/ldap.secret

# gstatc
RUN apt-get install  jq -y
ADD ./config/gstat-client_0.0.1_amd64.deb /
RUN dpkg -i /gstat-client_0.0.1_amd64.deb

# miniconda
# ENV CONDA_DIR /opt/miniconda3
# ENV PATH $CONDA_DIR/bin:$PATH

# RUN wget --quiet --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh && \
#     echo "bfe34e1fa28d6d75a7ad05fd02fa5472275673d5f5621b77380898dee1be15d2 *Miniconda3-4.7.12.1-Linux-x86_64.sh" | sha256sum -c - && \
#     /bin/bash /Miniconda3-4.7.12.1-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
#     rm Miniconda3-4.7.12.1-Linux-x86_64.sh && \
#     echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh
# RUN echo 'export PATH=$CONDA_DIR/bin:$PATH' >> /etc/bash.bashrc

# reconstruct conda enviroment
# ADD ./config/requirements.yml /
# RUN conda env create -f=/requirements.yml

# tensorflow environment
# RUN conda create -y -n tf python=3.6 anaconda
# RUN /opt/conda/envs/tf/bin/pip install tensorflow-gpu==1.12.0 keras==2.2.4
# RUN /opt/conda/envs/tf/bin/pip install -r /requirements.txt

# chainer environment
# RUN conda create -y -n chainer python=3.6 anaconda
# RUN /opt/conda/envs/chainer/bin/pip install cupy-cuda90==5.1.0 chainer==5.1.0
# RUN /opt/conda/envs/chainer/bin/pip install -r /requirements.txt

# #pytorch environment
#RUN conda create -y -n pytorch python=3.8 anaconda
#RUN /opt/conda/envs/pytorch/bin/pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 #torchaudio===0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
# RUN /opt/conda/envs/pytorch/bin/pip install -r /requirements.txt


RUN apt-get clean

# RUN conda init bash
ADD ./script/run.sh /
RUN chmod 777 /run.sh
CMD /run.sh
