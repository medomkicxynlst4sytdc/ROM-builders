# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/omnirom/android.git -b android-10 -g default,-mips,-darwin,-notdefault
git clone --depth 1 https://github.com/risawitama/android_.repo_local_manifests.git -b omni-10 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
breakfast onclite
export TZ=Asia/Jakarta #put before last build command
brunch onclite

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
