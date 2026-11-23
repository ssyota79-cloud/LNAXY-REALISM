# LNAXY REALISM 0.5.1

- Composite pass samples colortex0 and writes to colortex1 to avoid framebuffer feedback.
- Final pass samples colortex1 and uses GLSL 1.20 gl_FragColor.
- Options have shader-side defaults and profile-tunable preprocessor values.
- Added install/update steps to avoid duplicate old shader packs.

Still an experimental starter and not yet visually or GPU-tested against Complementary Unbound/Euphoria.
