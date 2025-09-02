//
//  UIDevice+Extension.swift
//  SwiftExtensionKit
//
//  Copyright (c) 2017-2024 RichAppz Limited (https://richappz.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public extension UIDevice {
    
    /**
     Checks the config, confirms if the build contains the `DEBUG` flag
     */
    static var isDevelopment: Bool {
#if DEBUG
        let isDevelopment = true
#else
        let isDevelopment = false
#endif
        
        return isDevelopment
    }
    
    /**
     The `DeviceType` of the device in use
     */
    static var deviceType: DeviceType {
        return DeviceType.current
    }
    
    /**
     Unique identifier for the device
     */
    static var uniqueIdentifier: String? {
        return current.identifierForVendor?.uuidString
    }
    
    /**
     System version number
     */
    static var osVersion: String {
        return current.systemVersion
    }
    
    /**
     Model string for the device, eg `iPhone4,1`
     */
    static var model: String {
        var utsnameInstance = utsname()
        uname(&utsnameInstance)
        let optionalString: String? = withUnsafePointer(to: &utsnameInstance.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in
                String.init(validatingUTF8: ptr)
            }
        }
        return optionalString ?? "N/A"
    }
    
    /**
     Check if a device is jailbroken or not
     */
    static var isJailbroken: Bool {
#if arch(i386) || arch(x86_64) || os(macOS)
        // Simulator or macOS build
        return false
#else
        // iOS 14+ Mac Catalyst check
        if #available(iOS 14.0, *) {
            if ProcessInfo.processInfo.isiOSAppOnMac {
                return false
            }
        }
        
        let fileManager = FileManager.default
        
        // Common jailbreak paths
        let jailbreakPaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/"
        ]
        for path in jailbreakPaths {
            if fileManager.fileExists(atPath: path) {
                return true
            }
        }
        
        // Check if app can open Cydia URL
        if let url = URL(string: "cydia://package/com.example.package"),
           UIApplication.shared.canOpenURL(url) {
            return true
        }
        
        // Try to write outside the sandbox
        let testPath = "/private/jailbreak_test.txt"
        do {
            try "test".write(toFile: testPath, atomically: true, encoding: .utf8)
            return true
        } catch {
            // Expected to fail on non-jailbroken devices
        }
        
        return false
#endif
    }
    
}
