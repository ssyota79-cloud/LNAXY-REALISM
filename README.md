# LNAXY REALISM

**Early Iris shader-pack starter** for Minecraft Java 1.21.11. It is not yet a full PBR or cinematic shader.

## Install

1. Download the repository ZIP from **Code → Download ZIP** and extract it.
2. Copy the extracted folder containing `shaders/` to your Minecraft `shaderpacks` directory.
3. Launch Minecraft with Iris, open **Options → Video Settings → Shader Packs**, select **LNAXY REALISM**, and apply.
4. Open **Shader Pack Settings** to choose **LOW**, **MEDIUM**, **HIGH**, or **ULTRA**, then adjust the controls.

Directories:
- Windows: `%APPDATA%\\.minecraft\\shaderpacks`
- macOS: `~/Library/Application Support/minecraft/shaderpacks`
- Linux: `~/.minecraft/shaderpacks`

## Settings in this build

- Presets: LOW, MEDIUM, HIGH, ULTRA
- Color/post-processing: exposure, contrast, saturation, vignette, bloom
- Water: tint and opacity

The presets tune the currently implemented visual controls. Bloom is a small 4-tap approximation, not a full bloom pyramid. Presets do not yet change shadow resolution or rendering quality because shadow mapping and the full PBR pipeline have not been implemented. External PBR resource packs can be installed separately, but these shaders do not yet render their normal/specular maps.

## Compatibility / troubleshooting

Iris supports the OptiFine-style shader pack format, but shader compilation depends on Iris and GPU drivers. This repository has not been tested on your specific client. If the shader fails, open the Iris shader compile log and report the first error along with your Iris version and GPU model.

## License

MIT. See [LICENSE](LICENSE).
