# Hermes Kasm Workspaces

Custom Kasm Workspaces images for Hermes engineering workflows.

## Forge workspace

The `forge/` image is based on `kasmweb/desktop:1.19.0` and remains the full multi-tool workspace for mechanical design, CAD, fabrication prep, and general engineering work:

- OpenSCAD
- FreeCAD
- Blender
- Bambu Studio
- git
- Python 3, pip, and venv
- curl
- jq
- build-essential, gcc/g++, make, cmake, pkg-config

Published image tags:

```text
ghcr.io/aiscribe152-hermes/hermes-kasm-forge:1.2
ghcr.io/aiscribe152-hermes/hermes-kasm-forge:latest
```

Hermes Forge is intentionally kept until explicitly retired.

## Standalone application workspaces

Standalone app images use the shorter `kasm-app_name` naming convention instead of `hermes-kasm-app_name`.

### FreeCAD workspace

The `freecad/` image is a smaller single-application workspace based on `kasmweb/core-ubuntu-jammy:1.19.0`. It installs the upstream FreeCAD AppImage and only the runtime packages needed to launch it in Kasm.

Published image tags:

```text
ghcr.io/aiscribe152-hermes/kasm-freecad:1.2
ghcr.io/aiscribe152-hermes/kasm-freecad:latest
```

### OpenSCAD workspace

The `openscad/` image is a smaller single-application workspace based on `kasmweb/core-ubuntu-jammy:1.19.0`. It installs OpenSCAD from Ubuntu packages and keeps the image focused on parametric CAD/scripted geometry work.

Published image tags:

```text
ghcr.io/aiscribe152-hermes/kasm-openscad:1.2
ghcr.io/aiscribe152-hermes/kasm-openscad:latest
```

### Bambu Studio workspace

The `bambu-studio/` image is a smaller single-application workspace based on `kasmweb/core-ubuntu-jammy:1.19.0`. It installs the Bambu Studio AppImage, its runtime dependencies, and Google Chrome as the default browser for Bambu cloud sign-in flows.

Published image tags:

```text
ghcr.io/aiscribe152-hermes/kasm-bambu-studio:1.2
ghcr.io/aiscribe152-hermes/kasm-bambu-studio:latest
```

## Build locally

```bash
docker build -t ghcr.io/aiscribe152-hermes/hermes-kasm-forge:local -f forge/Dockerfile forge
docker build -t ghcr.io/aiscribe152-hermes/kasm-freecad:local -f freecad/Dockerfile freecad
docker build -t ghcr.io/aiscribe152-hermes/kasm-openscad:local -f openscad/Dockerfile openscad
docker build -t ghcr.io/aiscribe152-hermes/kasm-bambu-studio:local -f bambu-studio/Dockerfile bambu-studio
```

## GitHub Actions publishing

The workflow at `.github/workflows/build-forge.yml` builds and pushes the Forge image to GitHub Container Registry on pushes to `main` that touch `forge/**` or the workflow file. It can also be started manually from the GitHub Actions UI.

The workflow at `.github/workflows/build-freecad.yml` builds and pushes the FreeCAD image on pushes to `main` that touch `freecad/**` or the workflow file. It can also be started manually from the GitHub Actions UI.

The standalone app images include `/dockerstartup/custom_startup.sh` so the target application opens automatically when the Kasm session starts.

The workflow at `.github/workflows/build-openscad.yml` builds and pushes the OpenSCAD image on pushes to `main` that touch `openscad/**` or the workflow file. It can also be started manually from the GitHub Actions UI.

The workflow at `.github/workflows/build-bambu-studio.yml` builds and pushes the Bambu Studio image on pushes to `main` that touch `bambu-studio/**` or the workflow file. It can also be started manually from the GitHub Actions UI.

## Register images in Kasm Workspaces

In the Kasm administrator UI:

1. Go to `Admin` -> `Workspaces` -> `Workspaces`.
2. Select `Add Workspace`.
3. Choose a Docker image based workspace.
4. Use the app name as the workspace name, for example:
   - `FreeCAD`
   - `OpenSCAD`
   - `Bambu Studio`
5. Set the Docker image to the appropriate standalone image:

   ```text
   ghcr.io/aiscribe152-hermes/kasm-freecad:latest
   ghcr.io/aiscribe152-hermes/kasm-openscad:latest
   ghcr.io/aiscribe152-hermes/kasm-bambu-studio:latest
   ```

   Or pin the versioned tags:

   ```text
   ghcr.io/aiscribe152-hermes/kasm-freecad:1.2
   ghcr.io/aiscribe152-hermes/kasm-openscad:1.2
   ghcr.io/aiscribe152-hermes/kasm-bambu-studio:1.2
   ```

6. Set the image type/compatibility to use the Kasm desktop/VNC style defaults inherited from `kasmweb/core-ubuntu-jammy:1.19.0`.
7. Configure CPU, memory, GPU, persistent profile, and sharing settings according to your Kasm environment.
8. Save the workspace.
9. Launch a test session and verify the tool is available:

   ```bash
   freecad --version
   openscad --version
   bambu-studio --help
   ```

## GHCR access notes

If the Kasm deployment cannot pull images anonymously, either:

- make the GHCR package public, or
- configure a Docker registry credential in Kasm for `ghcr.io` with a GitHub token that has package read access.
