//
//  SecurityCheck.swift
//  CryptoRank
//
//  Created by Damaris Muhia on 26/02/2025.
//

import UIKit

extension UIDevice {
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
            // This is a Simulator not an idevice
            return true
        #else
            return TARGET_OS_SIMULATOR != 0
        #endif
    }
    
    
    var isJailBroken: Bool {
        get {
            if UIDevice.current.isSimulator { return false }
            if JailBrokenHelper.hasCydiaInstalled() { return true }
            if JailBrokenHelper.isSuspiciousAppandFilesExists() { return true }
            if JailBrokenHelper.systemForkCall() { return true }
            return JailBrokenHelper.canEditSystemFiles()
        }
    }
}

private struct JailBrokenHelper {
    static func hasCydiaInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    static func isSuspiciousAppandFilesExists() -> Bool {
        for path in suspiciousAppsandFilesToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    static func canEditSystemFiles() -> Bool {
        let jailBreakText = "edit checks"
        let jbFilePath = "/private/jailBreakTestText.txt"
        do {
            try jailBreakText.write(toFile: jbFilePath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: jbFilePath)
            return true
        } catch {
            return false
        }
    }
   static func systemForkCall() -> Bool{
        let pid = getpgrp()
       return pid < 0 ? true : false
    }
    
    static var suspiciousAppsandFilesToCheck: [String] {
        return ["/Applications/Cydia.app",
                "/Applications/blackra1n.app",
                "/Applications/FakeCarrier.app",
                "/Applications/Icy.app",
                "/Applications/IntelliScreen.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/Applications/SBSettings.app",
                "/Applications/Snoop-itConfig.app",
                "/Applications/WinterBoard.app",
                "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/private/var/lib/apt",
                "/private/var/lib/apt/",
                "/private/var/lib/cydia",
                "/private/var/mobile/Library/SBSettings/Themes",
                "/private/var/stash",
                "/private/var/tmp/cydia.log",
                "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                "/usr/bin/sshd",
                "/usr/libexec/sftp-server",
                "/usr/sbin/sshd",
                "/etc/apt",
                "/bin/bash",
                "/Library/MobileSubstrate/MobileSubstrate.dylib",
                "/usr/libexec/cydia/",
                "/usr/sbin/frida-server",
                "/usr/bin/cycript",
                "/usr/local/bin/cycript",
                "/usr/lib/libcycript.dylib",
                "/bin/sh",
                "/usr/libexec/ssh-keysign",
                "/usr/bin/ssh",
                "/var/checkra1n.dmg",
        ]
    }
}
