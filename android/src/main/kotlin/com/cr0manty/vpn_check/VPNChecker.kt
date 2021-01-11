package com.cr0manty.vpn_check

import java.net.NetworkInterface
import java.util.*

class VPNChecker {
    companion object {
        fun isVpnActive(): Boolean {
            try {
                for (networkInterface in Collections.list(NetworkInterface.getNetworkInterfaces())) {
                    if (networkInterface.isUp && (networkInterface.name.contains("ppp") || networkInterface.name.contains("tun"))) return true
                }
            } catch (ex: Exception) {
                return false
            }
            return false
        }
    }
}