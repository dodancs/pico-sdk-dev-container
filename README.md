# RaspberryPi Pico SDK Dev Container for VSCode

![example workflow](https://github.com/dodancs/pico-sdk-dev-container/actions/workflows/build-docker.yml/badge.svg)


This project is aimed to provide an easy-to-set-up environment to develop software for the [RaspberryPi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) with the [Pico-SDK for C++](https://github.com/raspberrypi/pico-sdk) | [PDF Documentation](https://datasheets.raspberrypi.com/pico/raspberry-pi-pico-c-sdk.pdf). This is a Docker image primarly used via [Development containers](https://containers.dev/) in [VSCode](https://code.visualstudio.com/).

# What does this image provide?

Here is what you get:
- All the necessary development tools
  - make
  - cmake
  - gcc-arm-none-eabi
- Pico SDK
- Proper configuration of the development environment
- With the provided `devcontainer.json` you also get:
  - Pre-installed extensions to work with C++, CMake
  - Creature comfort extensions to make your coding experience better:
    - Nice themes
    - Right-click menu option to duplicate files
    - Rainbow-colored indentation
    - Path intellisense for better autocomplete experience
    - Trailing space highlighting
    - Extensions for better Markdown experience
    - Spell checking

# Usage

## Prerequisites

If you are here for the first time, we may need to do some work before you begin coding. Make sure you have the following:

- Download and install [VSCode](https://code.visualstudio.com/)
- Install the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) VSCode extension
- Download and install [Docker](https://www.docker.com/products/docker-desktop/)

## Set up your project

TODO: Simple initialization script

1. Open up VSCode, and open a folder (`CTRL + k o` on Windows/Linux ; `CMD + o` on Mac) which will be used to develop your project.
2. Create a `.devcontainer` directory in the main root of the project
3. Create a `devcontainer.json` file iside of the `.devcontainer` folder with the following contents:
   ```json
   // For format details, see https://aka.ms/devcontainer.json. For config options, see the
   // README at: https://github.com/devcontainers/templates/tree/main/src/ubuntu
   // README at: https://github.com/dodancs/pico-sdk-dev-container
   {
       "name": "Pico-SDK Dev Container",
       // Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
       "image": "ghcr.io/dodancs/pico-sdk-dev-container:latest",
       "features": {},
       // Features to add to the dev container. More info: https://containers.dev/features.
       // "features": {},
       // Use 'forwardPorts' to make a list of ports inside the container available locally.
       // "forwardPorts": [],
       // Use 'postCreateCommand' to run commands after the container is created.
       // "postCreateCommand": "",
       // Configure tool-specific properties.
       "customizations": {
           "vscode": {
               "extensions": [
                   "twxs.cmake",
                   "ms-vscode.cmake-tools",
                   "ms-vscode.cpptools",
                   "ms-vscode.cpptools-extension-pack",
                   "streetsidesoftware.code-spell-checker",
                   "ms-vscode.cpptools-themes",
                   "PKief.material-icon-theme",
                   "mrmlnc.vscode-duplicate",
                   "oderwat.indent-rainbow",
                   "christian-kohler.path-intellisense",
                   "shardulm94.trailing-spaces",
                   "shd101wyy.markdown-preview-enhanced",
                   "yzhang.markdown-all-in-one"
               ],
               "settings": {
                   "editor.bracketPairColorization.enabled": true,
                   "C_Cpp.default.includePath": [
                       "${workspaceFolder}/**",
                       "${env.PICO_SDK_PATH}/**"
                   ]
               }
           }
       }
       // Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
       // "remoteUser": "root"
   }
   ```
4. If you have C++ settings configured for your project in `.vscode/c_cpp_properties.json` in the root directory, remove the following declaration:
   ```json
   "includePath": [
       "${workspaceFolder}/**",
   ],
   ```
5. Run the project inside a Dev Container:
   Press `CTRL + SHIFT + P` to open the command palette in VSCode and select the `Dev Containers: Open Folder in Container` option.
6. Create the `CMakeLists.txt` file with the following contents:
   ```cmake
   cmake_minimum_required(VERSION 3.13)

   # initialize the SDK based on PICO_SDK_PATH
   include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

   project(my_project)

   # initialize the Raspberry Pi Pico SDK
   pico_sdk_init()

   # rest of your project
   add_executable(main
       main.cpp
   )

   # Add pico_stdlib library which aggregates commonly used features
   target_link_libraries(main pico_stdlib)

   # create map/bin/hex/uf2 file in addition to ELF.
   pico_add_extra_outputs(main)
   ```
7. Now you can use the Pico SDK in your project! Create a `main.cpp` file and have fun using the `pico` namespace:
   ```cpp
   #include <stdio.h>
   #include <pico/stdlib.h>

   int main()
   {
       setup_default_uart();
       printf("Hello, world!\n");
       return 0;
   }
   ```
8. Finally, to build your project and get the `uf2` firmware, run these commands:
   ```bash
   mkdir build
   cd build
   cmake ..
   make
   ```

You can also create a VSCode Task in `.vscode/tasks.json` for this usecase:
```json
{
    // See https://go.microsoft.com/fwlink/?LinkId=733558
    // for the documentation about the tasks.json format
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build",
            "type": "shell",
            "command": "mkdir build && cd build && cmake .. && make",
            "problemMatcher": []
        }
    ]
}
```

Feel free to check out the [example/](example/) directory to see a sample project where everything is set up properly.
