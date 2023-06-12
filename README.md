# fyne-termux
Script for easy fetch ndk (, sdk) and fyne: https://github.com/fyne-io/fyne
And compile easy apk on termux

# options
script provide 4 options
- full version NDK, which provide all C and C++ headers and tool (on termux you can build all \[4\] android main platform)
- light version NDK, which provide only headers and tools which are nesessery to library fyne and build to arm64 (on termux you can build only for arm64 devices) 
- with SDK, which is useless when you don't plan compile other projects
- without SDK - fyne don't need SDK tools
-  
# requirements
- more than free 4.1GB on storage (for full version and sdk - witout sdk and with minimal version aprox. 2.3GB is needed)
- arm64 - aarch64 (unfortunately on arm32 doesn't exist ndk)
- android 9+

# note
- The limitations is from https://github.com/Lzhiyong/termux-ndk, and new versions of NDK will on his git, this is for lazy ones and for sample what is possible ...

# curent issues

# video tutorial
https://youtu.be/uGtVjf4_Ivo
