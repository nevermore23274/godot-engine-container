# Base image
FROM ubuntu:latest

# Update package information
RUN apt-get update -y

# Install dependencies for Mesa3D software drivers
RUN apt-get install -y libgl1-mesa-dri libgl1-mesa-glx mesa-vulkan-drivers

# Install additional dependencies for Godot
RUN apt-get install -y wget unzip libfontconfig1 libxcursor1 libxi6 libxinerama1 libxrandr2 libxrender1 libpulse0 libasound2 libxkbcommon0 pulseaudio

# Create a non-root user
RUN useradd -ms /bin/bash godotuser

# Set the working directory
WORKDIR /home/godotuser

# Switch to the non-root user
USER godotuser

# Install Godot
RUN wget https://github.com/godotengine/godot/releases/download/4.1.1-stable/Godot_v4.1.1-stable_linux.x86_64.zip \
    && unzip Godot_v4.1.1-stable_linux.x86_64.zip \
    && rm Godot_v4.1.1-stable_linux.x86_64.zip

# Make Godot executable
RUN chmod +x Godot_v4.1.1-stable_linux.x86_64

# Set the entrypoint to run Godot
ENTRYPOINT ["./Godot_v4.1.1-stable_linux.x86_64", "--rendering-driver", "opengl3"]

# Set the entrypoint to /bin/bash for troubleshooting
#ENTRYPOINT ["/bin/bash"]
