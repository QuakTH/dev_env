FROM ubuntu:latest

# Create and set the default user
ENV USER_NAME=dev_user
ARG user_uid=1001
ARG user_gid=$user_uid
ARG user_pwd

# Create the user and grant sudo command access
RUN groupadd --gid $user_gid $USER_NAME \
    && useradd --uid $user_uid --gid $user_gid -m $USER_NAME \
    && echo "${USER_NAME}:${user_pwd}" | chpasswd \
    && apt-get update \
    && apt-get upgrade \
    && apt-get install -y sudo \
    && echo $USER_NAME ALL=\(root\) NOPASSWD:ALL >/etc/sudoers.d/$USER_NAME \
    && chmod 0440 /etc/sudoers.d/$USER_NAME

# Changed default shell
RUN chsh -s /bin/bash $USER_NAME

# Install packages required for building image
RUN apt-get install -y wget net-tools nano openssh-server

# Use the user created before
USER $USER_NAME

# Set working directory
WORKDIR /home/$USER_NAME

# Get and install miniconda and add it to .bashrc
# This miniconda is for arm64
# TODO : create a miniconda installment for different architecture
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh \
    && bash Miniconda3-latest-Linux-aarch64.sh -b \
    && rm Miniconda3-latest-Linux-aarch64.sh

# Add miniconda to path
ENV PATH="/home/$USER_NAME/miniconda3/bin:$PATH"

# Create environment dev
RUN set e; conda create -c conda-forge -n dev python=3.10 mamba

# Install packages required packages for development
COPY ./scripts/install_packages.sh /home/$USER_NAME
RUN ./install_packages.sh

# Add these lines to .bashrc to activate the dev env when opening bash
RUN conda init bash \
    && echo 'conda activate dev' >>  ~/.bashrc

# Added entrypoint to prevent container exiting
# And restarted sshd
ENTRYPOINT sudo service ssh restart && /bin/bash