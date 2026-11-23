# LNAXY REALISM 0.5.1 — corrected render pipeline

The previous gray-screen issue came from the composite pass sampling `colortex0` while also writing back to the same render target. That is an undefined framebuffer feedback loop. This update routes the composite output to `colortex1`, and the final pass reads that separate target.

Shader settings are declared as Iris/OptiFine preprocessor options (`#define` with slider values), not unset runtime uniforms. The final pass uses `gl_FragColor` for GLSL 1.20 compatibility.

## Install/update

1. Close Minecraft.
2. Download the latest ZIP from the repository and extract it.
3. Remove older LNAXY folders/ZIPs from `.minecraft/shaderpacks` so Iris does not load a duplicate.
4. Copy the extracted folder containing `shaders/` into `shaderpacks`.
5. Start Minecraft with Iris and select **LNAXY REALISM 0.5.1** (rename the folder to this if needed).
6. Click **Apply**, then open Shader Pack Settings for presets and controls.

## What the settings currently do

LOW/MEDIUM/HIGH/ULTRA profiles control available post-processing, atmospheric screen haze, and water tint/distortion. This remains an early shader; it is not equivalent to Complementary Unbound or Euphoria Patches. It does not yet include full dynamic shadowing, real volumetric clouds, screen-space reflections/refraction, caustics, or full labPBR material response. No compatibility claim should be treated as tested until the shader is compiled in-game on the target Iris/GPU.
