# Godot Engine Container
This is basically just what the title says, a containerized version of Godot.

# On Local System
## Grant the root user access to the X server
```
xhost +local:root
```
## Ensure the user running the container is part of the video group (or the appropriate group for GPU access on your system).
```
sudo gpasswd -a $USER video
```

# Commands
## Build
```
podman build -t godot_in_docker .
```
## Run
```
podman run -e DISPLAY=$DISPLAY -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
-v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-v /dev/dri:/dev/dri:rw \
-v /dev/snd:/dev/snd \
--group-add $(getent group audio | cut -d: -f3) \
--rm godot_in_docker
```

Biggest help: https://github.com/jamesbrink/docker-opengl
