# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/AOSPA/manifest -b sapphire -g default,-mips,-darwin,-notdefault
git clone https://github.com/Shreedhan003/local_manifest.git --depth 1 -b sapphire .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build from [10]
source build/envsetup.sh
lunch aospa_lavender-eng
export KBUILD_BUILD_USER=xtra_sharif
export KBUILD_BUILD_HOST=xtra_sharif
export BUILD_USERNAME=xtra_sharif
export BUILD_HOSTNAME=xtra_sharif
export TZ=Asia/Delhi #put before last build command
./rom-build.sh lavender -t eng -v beta

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
