FROM fedora:34

# Add RPM Fusion
RUN dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
    && dnf clean all

# Update
RUN dnf update -y && dnf clean all

# Install build dependencies
RUN dnf install -y fedpkg fedora-packager rpmdevtools ncurses-devel pesign \
    bpftool bc bison dwarves elfutils-devel flex gcc gcc-c++ gcc-plugin-devel \
    hostname m4 make net-tools openssl openssl-devel perl-devel \
    perl-generators python3-devel \
    && dnf clean all

# Setup build directory
RUN rpmdev-setuptree

# Set up the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
