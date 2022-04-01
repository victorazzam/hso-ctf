# syntax = docker/dockerfile:1
## syntax = docker/dockerfile-upstream:master-experimental

## DOCKER_BUILDKIT=1 docker build -t hso-ctf .
## docker run -d -it --cap-add NET_ADMIN --cap-add SYS_PTRACE --security-opt seccomp=unconfined -h hso --name hso-ctf-active hso-ctf

FROM ubuntu:latest
LABEL org.opencontainers.image.source="https://github.com/victorazzam/hso-ctf"

# Update system and install necessary packages
RUN dpkg --add-architecture i386 && apt-get update -qq && DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin apt-get install -yq sudo libc6:i386 libncurses5:i386 libstdc++6:i386 build-essential gdb vim curl python3-pip netcat openconnect

# Run as non-superuser by default - CHANGE THE PASSWORD AFTER LOGGING IN (NOT HERE)
RUN useradd -ms /bin/bash ctf && echo "ctf:ctf" | chpasswd && adduser ctf sudo

# Set everything up
WORKDIR /home/ctf
COPY --chown=ctf . ./
RUN printf '%s\n%s\n' 'cat /etc/motd' 'export TERM=xterm-256color' >> /etc/bash.bashrc && mv motd /etc/motd && cat vpnc-script > /usr/share/vpnc-scripts/vpnc-script && rm vpnc-script
USER ctf

# Hack away :P
CMD ["sleep", "infinity"]
