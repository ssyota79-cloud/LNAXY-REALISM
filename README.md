# LNAXY REALISM

**LNAXY REALISM 0.5.0 — Stable Compatibility Release**

Built for Minecraft Java 1.21.11 with Iris. This build deliberately removes experimental shadow and depth-buffer accesses that can cause a fallback or compile failure. It provides visible, safe color grading and a complete shader settings menu while the advanced rendering stages are developed separately.

## Installation

1. Download **LNAXY-REALISM-main.zip** using GitHub **Code → Download ZIP**.
2. Extract it completely.
3. Copy the extracted folder into the Minecraft `shaderpacks` folder:
   - Windows: `%APPDATA%\\.minecraft\\shaderpacks`
   - macOS: `~/Library/Application Support/minecraft/shaderpacks`
   - Linux: `~/.minecraft/shaderpacks`
4. Launch Minecraft 1.21.11 with Iris.
5. Open **Options → Video Settings → Shader Packs**.
6. Select **LNAXY REALISM**, then choose **Apply**.
7. Open **Shader Pack Settings** to select LOW, MEDIUM, HIGH, or ULTRA.

## What changed in 0.5.0

- Removed unsafe `depthtex0` access from the composite pass.
- Removed invalid shadow sampler assumptions from terrain and water passes.
- Replaced the experimental pipeline with colortex0-safe compatibility passes.
- Added visible post-processing instead of merely displaying a settings menu.
- Added LOW, MEDIUM, HIGH, and ULTRA profiles.
- Added exposure, contrast, saturation, cinematic color, vignette, and bloom controls.
- Added water tint, opacity, Fresnel, wave, and depth-style controls.
- Added separate English and Indonesian language labels.

## Settings

Profiles tune all implemented controls. LOW favors compatibility, MEDIUM is the balanced default, HIGH adds stronger color effects, and ULTRA enables the strongest safe appearance settings.

Advanced PBR normal/specular rendering, real shadow maps, SSR, volumetric clouds, and depth-based refraction require additional Iris-tested files and should not be enabled until each pass is validated.

## Troubleshooting

If the shader still falls back:

1. Remove every older copy of LNAXY REALISM from `shaderpacks`.
2. Extract the downloaded ZIP again.
3. Confirm that the selected folder has a direct `shaders/` directory.
4. Reopen Iris and select the pack again.
5. Send the first exact error line from the Iris compile log, your GPU model, and Iris version.

## License

MIT License.
