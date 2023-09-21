# Godot Engine Container
This is basically just what the title says, a containerized version of Godot.

# On Local System
- Ensure mesa and vulkan utils are on system
```
sudo apt install mesa-utils vulkan-tools
```
Or, if you're on Fedora:
```
sudo dnf install mesa-demos vulkan-tools
```
- Grant the root user access to the X server
```
xhost +local:root
```
- Ensure the user running the container is part of the video group (or the appropriate group for GPU access on your system).
```
sudo gpasswd -a $USER video && sudo gpasswd -a $USER render
```
- You can check your users permissions with:
```
ls -l /dev/dri
```
Card0 and your Render are the groups you're trying to add USER to.

- If you're having issues, try this to ensure your vulkan is working properly and is configured right
```
vulkaninfo
```

# Commands
- Build
```
podman build -t godot_in_docker .
```
- Run
```
podman run -it -e DISPLAY=$DISPLAY -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
-v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-v /dev/dri:/dev/dri:rw \
-v /dev/snd:/dev/snd \
--group-add $(getent group audio | cut -d: -f3) \
--group-add $(getent group video | cut -d: -f3) \
--rm godot_in_docker
```

Biggest help: https://github.com/jamesbrink/docker-opengl
