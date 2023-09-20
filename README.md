# Godot Engine Container
This is basically just what the title says, a containerized version of Godot.

# Commands
## Build
```
podman build -t godot_in_docker .
```
## Run
```
podman run -u=$(id -u $USER):$(id -g $USER) -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw --rm godot_in_docker
```

Biggest help: https://github.com/jamesbrink/docker-opengl
