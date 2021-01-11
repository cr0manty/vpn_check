package com.cr0manty.vpn_check

import java.net.NetworkInterface
import java.util.*

class VPNChecker {
    companion object {
        fun isVpnActive(): Boolean {
            val vpnProtocolsKeysIdentifiers = arrayOf("tap", "tun", "ppp", "ipsec", "utun")
            try {
                for (networkInterface in Collections.list(NetworkInterface.getNetworkInterfaces())) {
                    for (protocolId in vpnProtocolsKeysIdentifiers) {
                        if (networkInterface.isUp && networkInterface.name.startsWith(protocolId)) return true
                    }
                }
            } catch (ex: Exception) {
                return false
            }
            return false
        }
    }
}