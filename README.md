# LNAXY REALISM

**LNAXY REALISM 0.4.0** is an original Minecraft Iris shader project targeting Minecraft Java 1.21.11.

## Install

1. Download this repository through **Code → Download ZIP**.
2. Extract it completely.
3. Copy the extracted folder containing `shaders/` into:
   - Windows: `%APPDATA%\\.minecraft\\shaderpacks`
   - macOS: `~/Library/Application Support/minecraft/shaderpacks`
   - Linux: `~/.minecraft/shaderpacks`
4. Launch Minecraft with Iris and select **LNAXY REALISM**.
5. Open **Shader Pack Settings** and choose **LOW**, **MEDIUM**, **HIGH**, or **ULTRA**.

## Features in 0.4.0

- Dynamic atmospheric horizon and sky color
- Procedural 2D clouds
- Soft shadow-map foundations and configurable shadow distance
- Screen-space fog and distance haze
- Animated water surface, Fresnel tint, and depth-dependent color
- Specular highlights and bloom
- labPBR normal/specular/emissive texture hooks
- Color grading, contrast, saturation, exposure, and vignette controls
- Performance presets

## PBR resource packs

LNAXY REALISM reads Iris labPBR-style inputs named `normals`, `specular`, and `emissive` when supported by the loaded resource pack. Resource packs are still required for per-block normal and specular maps; shader effects cannot generate them from vanilla textures.

## License

MIT License.
