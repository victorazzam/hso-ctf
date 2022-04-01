# HSO CTF Docker Image

Docker image to connect to Offenburg University's internal CTF platform and solve challenges.

It is based on the latest LTS (Long Term Support) release of Ubuntu, which is **20.04 Focal Fossa** as of April 1st 2022.

Included are some helpful tools:

- **CTFd.py** - [a useful script](https://github.com/victorazzam/stash/blob/master/Scripts/ctfd.py) I wrote to track and download all challenges from any [CTFd](https://github.com/ctfd/ctfd) instance.
- **Gdb** - the infamously simplistic GBU debugger (I recommend extensions like PEDA).
- **Python 3** - the superior Python 2 successor.
- **Vim** - text editor (you can get emacs if you really want... <sub><sup>[or, god forbid, nano](https://i.redd.it/fuaws1hsssn51.jpg)</sup></sub>)
- **Curl** - simple and configurable HTTP client.
- **Netcat** - for easy interaction with sockets on any port.

You may wish to download other programs on your hacking journey. Install them via:

```console
ctf@hso:~$ sudo apt install YOUR_DESIRED_PACKAGE
```

This image is suitable for any CTF event; you can always modify it to your heart's content!

## Build

The quickest way to get started is to run the ready-made image from the registry:

```console
$ docker run -d -it --cap-add NET_ADMIN --cap-add SYS_PTRACE --security-opt seccomp=unconfined -h hso --name hso-ctf-active ghcr.io/victorazzam/hso-ctf:latest
```

Read further for an explanation of all the options.
<hr>
To build this image from source, download this repository, `cd` into it and run:

```console
$ DOCKER_BUILDKIT=1 docker build -t hso-ctf .
```

`DOCKER_BUILDKIT=1` tells Docker to use BuildKit for improved performance.

`-t hso-ctf` gives the image a recognisable tag of <em>hso-ctf</em>.

`.` tells Docker to use the current directory as the image source.

## Boot

To create and start the container:

```console
$ docker run -d -it --cap-add NET_ADMIN --cap-add SYS_PTRACE --security-opt seccomp=unconfined -h hso --name hso-ctf-active hso-ctf
```

`-d` runs in <em>detached</em> mode.[\*](#run-and-hack)

`-it` means <em>interactive</em> and allocate a pseudo-<em>TTY</em>.

`--cap-add NET_ADMIN` gives the container the necessary permissions for the VPN connection.

`--cap-add SYS_PTRACE` permits the container to use the <em>ptrace</em> syscall (needed to run debuggers).

`--security-opt seccomp=unconfined` runs the container without a Linux [seccomp profile](https://docs.docker.com/engine/security/seccomp) (needed for various reverse engineering tasks).

`-h hso` sets the hostname within the container to <em>hso</em>.

`--name hso-ctf-active` gives the container a recognisable name of <em>hso-ctf-active</em>.

`hso-ctf` references the image we built in the previous stage.

## Run and hack

The recommended way to get going is to `docker exec` into the container:

```console
$ docker exec -it hso-ctf-active bash
#...welcome message here...
ctf@hso:~$
```

You may wish to host your container in the cloud and (after allowing the necessary port on your firewall) connect to it from anywhere.

#### If you go cloud, make sure to configure passwordless key-enabled SSH access to avoid a huge security risk!

```console
$ ssh ctf@HOSTNAME -p 2222
The authenticity of host '[HOSTNAME]:2222 ([HOSTNAME]:2222)' can't be established.
ECDSA key fingerprint is SHA256:KmFUWH/lf/Vl4aJ/ctfdLH60V2KBbTOP2hbRZLMRgW4.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '[HOSTNAME]:2222' (ECDSA) to the list of known hosts.
ctf@localhost's password:
#...welcome message here...
ctf@hso:~$
```

In any event, once you're in, **change your password** from `ctf` to something reasonably more secure:

```console
ctf@hso:~$ passwd
```

### Happy hacking :D
