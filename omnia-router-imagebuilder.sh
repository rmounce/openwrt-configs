#!/bin/bash
set -euo pipefail
shopt -s nullglob

main() {
    PACKAGES_ARR=()
    add_pkgs

    exec make image \
        PROFILE=cznic_turris-omnia \
        PACKAGES="${PACKAGES_ARR[*]}"
}

add_pkgs() {
    # basic webui
    PACKAGES_ARR+=(
        luci-ssl
    )

    # new dns block thingo
    PACKAGES_ARR+=(
        adguardhome
    )

    # router stuff
    PACKAGES_ARR+=(
        luci-app-wol
        luci-app-upnp
        luci-app-wireguard
        luci-app-vnstat2
        luci-app-ddns
        ddns-scripts-cloudflare
    )

    # SMP performance
    PACKAGES_ARR+=(
        irqbalance
    )

    # SQM stuff
    PACKAGES_ARR+=(
        kmod-ifb
        kmod-sched-cake
        iptables-mod-ipopt
        iptables-mod-conntrack-extra
        conntrack
        kmod-sched-ctinfo
        kmod-sched-connmark
    )

    # basic diag
    PACKAGES_ARR+=(
        ethtool
        ip-bridge
        iperf
        mtr-json
        tc-tiny
        tcpdump-mini
    )

    # extra quality of life
    PACKAGES_ARR+=(
        htop
        iftop
        iperf3
        nano
        tmux
    )
}

main "$@"
