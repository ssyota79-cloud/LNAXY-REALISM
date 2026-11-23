# LNAXY REALISM

**Status: installable starter build (0.2.0)** for Minecraft Java 1.21.11 with Iris. This is an early, lightweight shader—not yet a full Complementary/Euphoria-level shader.

## Requirements

- Minecraft Java Edition 1.21.11
- Iris installed (Sodium is normally installed with Iris)
- A graphics card with OpenGL support

## Install

1. On GitHub, choose **Code → Download ZIP** and extract the archive.
2. Open the extracted `LNAXY-REALISM-main` folder. Confirm that it contains a `shaders` folder directly inside it.
3. Copy that entire folder to your Minecraft `shaderpacks` directory:
   - Windows: `%APPDATA%\\.minecraft\\shaderpacks`
   - macOS: `~/Library/Application Support/minecraft/shaderpacks`
   - Linux: `~/.minecraft/shaderpacks`
4. Start the Minecraft 1.21.11 profile with Iris.
5. Open **Options → Video Settings → Shader Packs**, select **LNAXY REALISM**, and press **Apply**.

You may also keep the downloaded ZIP in `shaderpacks` (do not put a ZIP inside another ZIP). The ZIP must contain `shaders/` at its top level.

## PBR resource packs

Install a PBR resource pack separately through **Options → Resource Packs**. The starter shaders use the regular block texture and vanilla lightmap; full labPBR normal/specular-map rendering is **not implemented yet**. A PBR resource pack by itself will not add PBR effects until that shader feature is implemented.

## Current limitations

This starter build provides Iris shader programs for terrain, entities, hand, water, sky, and final color output. Advanced shadow mapping, PBR material lighting, volumetric atmosphere, and reflective/refractive water are still planned. The files have not yet been compiled or visually tested in a Minecraft client; if Iris reports an error, share the exact message and GPU model to help diagnose it.

## License

MIT. See [LICENSE](LICENSE).
