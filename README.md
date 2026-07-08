# Hermes Kasm Workspaces

Custom Kasm Workspaces images for Hermes engineering workflows.

## Forge workspace

The `forge/` image is based on `kasmweb/desktop:1.19.0` and installs tools for mechanical design, CAD, fabrication prep, and general engineering work:

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

## Build locally

```bash
docker build -t ghcr.io/aiscribe152-hermes/hermes-kasm-forge:local -f forge/Dockerfile forge
```

## GitHub Actions publishing

The workflow at `.github/workflows/build-forge.yml` builds and pushes the Forge image to GitHub Container Registry on pushes to `main` that touch `forge/**` or the workflow file. It can also be started manually from the GitHub Actions UI.

The workflow publishes:

```text
ghcr.io/aiscribe152-hermes/hermes-kasm-forge:1.2
ghcr.io/aiscribe152-hermes/hermes-kasm-forge:latest
```

## Register the image in Kasm Workspaces

In the Kasm administrator UI:

1. Go to `Admin` -> `Workspaces` -> `Workspaces`.
2. Select `Add Workspace`.
3. Choose a Docker image based workspace.
4. Use a clear name, for example:
   - `Hermes Forge`
5. Set the Docker image to:

   ```text
   ghcr.io/aiscribe152-hermes/hermes-kasm-forge:latest
   ```

   Or pin the versioned tag:

   ```text
   ghcr.io/aiscribe152-hermes/hermes-kasm-forge:1.2
   ```

6. Set the image type/compatibility to use the Kasm desktop/VNC style defaults inherited from `kasmweb/desktop:1.19.0`.
7. Configure CPU, memory, GPU, persistent profile, and sharing settings according to your Kasm environment.
8. Save the workspace.
9. Launch a test session and verify the tools are available:

   ```bash
   openscad --version
   freecad --version
   blender --version
   bambu-studio --help
   git --version
   python --version
   curl --version
   jq --version
   gcc --version
   ```

## GHCR access notes

If the Kasm deployment cannot pull the image anonymously, either:

- make the GHCR package public, or
- configure a Docker registry credential in Kasm for `ghcr.io` with a GitHub token that has package read access.
