ROOTFS_PATH := distrod/distrod_wsl_launcher/resources/distrod_root.tar.gz

build: distro_launcher/x64/distrod_wsl_launcher.exe

distro_launcher: distro_launcher/x64/Release/DistroLauncher-Appx/DistroLauncher-Appx_1.0.0.0_x64.appx

distro_launcher/x64/Release/DistroLauncher-Appx/DistroLauncher-Appx_1.0.0.0_x64.appx: distro_launcher/x64/distrod_wsl_launcher.exe
	cd distro_launcher; cmd.exe /C "build.bat rel"

distro_launcher/x64/distrod_wsl_launcher.exe: distrod_wsl_launcher

distrod/distrod_wsl_launcher/resources/distrod_root.tar.gz: $(ROOTFS_PATH)
	cp $(ROOTFS_PATH) distrod/distrod_wsl_launcher/resources/distrod_root.tar.gz

distrod_wsl_launcher: distrod/distrod_wsl_launcher/resources/distrod_root.tar.gz
	cd distrod; cargo.exe build --release -p distrod_wsl_launcher

distrod/target/release/portproxy.exe: portproxy.exe
portproxy.exe:
	cd distrod; cargo.exe build --release -p portproxy

.PHONY: build distro_launcher distrod_wsl_launcher portproxy.exe
