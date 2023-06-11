#!/data/data/com.termux/files/usr/bin/bash
echo '================ cantrol architecture and android version ==================='
case $(uname -m) in
    aarch64)   echo 'aarch64 is allow, continue' ;;
    arm)  dpkg --print-architecture | grep -q "arm64" && \
          echo ' aarch64 is allow, continue' || \
          echo 'unfortunately arm is not allow, only suported is aarch64  it must exist' && exit 1  ;;
    *) echo 'unfortunately not allow, only suported is aarch64 it must exist' && exit 1   ;;
esac
s_version=$(termux-info | grep -A1 "Android version" | grep -Po "\\d+")
version=$(($s_version+0))
if (version < 9) then
	echo 'unfortunately anroid must be 9 or above'
	exit 1
fi
echo '================================================================'
echo '                     install dependencies'
echo '================================================================'
pkg update && pkg upgrade && pkg install aapt apksigner dx ecj openjdk-17 git wget

echo '================================================================'
echo '                     download sdk.zip'
echo '================================================================'
cd ~ && wget https://github.com/Lzhiyong/termux-ndk/releases/download/android-sdk/android-sdk-aarch64.zip
echo '================================================================'
echo '                               unzip sdk.zip'
echo '================================================================'
cd ~ && unzip -qq android-sdk-aarch64.zip
echo '================================================================'
echo '                              tidy sdk.zip'
echo '================================================================'
cd ~ && rm android-sdk-aarch64.zip

echo '================================================================'
echo '                     download ndk.zip'
echo '================================================================'
cd ~ && wget https://github.com/Lzhiyong/termux-ndk/releases/download/ndk-r23/android-ndk-r23c-aarch64.zip

echo '================================================================'
echo '                               unzip ndk.zip'
echo '================================================================'
cd ~ && unzip -qq android-ndk-r23c-aarch64.zip
echo '================================================================'
echo '                               fix sh in ndk path'
echo '================================================================'
cd ~ && termux-fix-shebang /data/data/com.termux/files/home/android-ndk-r23c/toolchains/llvm/prebuilt/linux-aarch64/bin/*
echo '================================================================'
echo '                               tidy ndk.zip'
echo '================================================================'
cd ~ && rm android-ndk-r23c-aarch64.zip


echo '================================================================'
echo '                               set env variables'
echo '================================================================'
echo 'export ANDROID_HOME=/data/data/com.termux/files/home/android-sdk/' >> ~/../usr/etc/profile
echo 'export ANDROID_NDK_HOME=/data/data/com.termux/files/home/android-ndk-r23c/' >> ~/../usr/etc/profile
echo 'export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME' >> ~/../usr/etc/profile


echo '================================================================'
echo '                               resolving versions'
echo '================================================================'
/data/data/com.termux/files/home/android-sdk/tools/bin/sdkmanager --sdk_root=/data/data/com.termux/files/home/android-sdk/ --uninstall "platforms;android-33"
/data/data/com.termux/files/home/android-sdk/tools/bin/sdkmanager --sdk_root=/data/data/com.termux/files/home/android-sdk/ --uninstall "platforms;android-32"


echo '================================================================'
echo '                               install golang'
echo '================================================================'
pkg install golang
cd ~ && mkdir -p go/bin
echo 'export PATH=$PATH:/data/data/com.termux/files/home/go/bin/' >> ~/../usr/etc/profile

echo '================================================================'
echo '                               install fyne'
echo '================================================================'
cd ~ && git clone https://github.com/fyne-io/fyne.git && cd fyne && git checkout develop && cd cmd/fyne && go build && chmod 1777 fyne && mv fyne /data/data/com.termux/files/home/go/bin/ && cd ~ && rm -rf fyne

echo '================================================================'
echo '                                 complete'
echo '================================================================'
echo ''
echo 'put "source ~/../usr/etc/profile"'
