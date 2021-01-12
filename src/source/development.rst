Software Development
====================

If you want to develop software for MNT Reform, there are a few things to consider. You can write software targeting the main CPU or modify firmware for the system controller and input devices. All of these have different architectures. Also consider that the main CPU is exchangeable, though targeting 64-bit ARM (aarch64) is a good bet until modules with other architectures become available (for example, RISC-V). This chapter covers development for the default i.MX8MQ module and some general best practices to keep your software portable.

i.MX8MQ: CPU
------------

The i.MX8MQ SoC has the following CPU cores:

- 4x Cortex-A53 at 1.5GHz
- 1x Cortex-M4F at 600MHz (TODO: verify???)

At the time of writing, the integration of the M4 core into mainline Linux is not production ready, so we don't cover it here.

Linux (or another operating system) runs on the four Cortex-A53 cores. Cortex-A53 is a power efficient in-order core. This makes it less performant but also less vulnerable to certain security weaknesses of out-of-order processors (TODO: which ones exactly?).

Optimizing your program to make use of multiple cores versus relying on single-core performance will pay off on MNT Reform. Also, make use of SIMD (NEON) optimizations. Try to keep memory usage and unnecessary UI effects minimal. If your application runs well on MNT Reform, it will run well on a broad range of older PC hardware, too.

Binary (In)compatibility
------------------------

A popular architecture for PCs and laptops is x86_64 (aka amd64). Binaries compiled for this architecture are incompatible with ARM processors. If you want to use binary software (or dependencies/modules), you have to make sure that these are built for aarch64. The vast majority of open-source software is available for aarch64, but there can be subtle problems when x86 is implicitly expected, for example:

- Optimizations written in assembler (machine code), targeting specific SIMD/vector instructions
- JIT (just-in-time) compilers
- Docker images built for x86_64

Generally, instead of using inline assembler or targeting a single architecture directly, use cross-platform libraries and code-emitting backends. Examples are LLVM and GLM.

i.MX8MQ: GPU
------------

The embedded GPU in i.MX8MQ is Vivante GC7000L. It can theoretically support OpenGL ES 3.1, but the open-source Etnaviv drivers (included in the Mesa project) don't support this level at the time of writing. The safest target for 3D graphics is OpenGL ES 2.0. Desktop OpenGL 2.1 API support is good, too. There is no support for Vulkan nor OpenCL yet.

If you want to make sure your 3D application or game works well, target:

- OpenGL ES 2.0, GLSL ES 1.00 (recommended)
- OpenGL 2.1, GLSL 1.20
- WebGL 1.0

Tested and recommended libraries/frameworks are:

- SDL 2
- GTK 3/GTK 4
- Qt 5/Qt 6
- Dear Imgui
- Godot Engine (targeting GL ES 2.0)
- Text-based interfaces (TUIs)

Wayland works better than Xorg directly, but Xorg applications work well on top of Wayland through Xwayland or Xephyr.

i.MX8MQ: VPU
------------

i.MX8MQ includes hardware accelerators for decoding H.264, H.265, VP8 and VP9. At time of writing, support for H.264 decoder ("Hantro") just landed in the Linux kernel with fully open source drivers, accessible through the gstreamer library.

WM8960 Audio
------------

The audio output defaults to 48KHz stereo. You can also sample from one microphone input channel (part of the CTIA standard TRRS headset jack) or the stereo Line In header on the motherboard (J21).

You can use the ALSA API directly or higher level APIs such as PulseAudio, Jack or OpenAL.

Languages
---------

While you can easily write programs in C and C++ -- and the Linux kernel and most layers on top of it are still written in C -- you can also use Rust, Go, SBCL, Haskell, Java or scripting languages such as JavaScript, Python, Ruby on MNT Reform. All of these have first-class aarch64 support.

Applications that use web browser engines (such as Electron) can disappoint in terms of performance on MNT Reform. Programs using native toolkits will run faster, use less memory and provide a better user experience.
