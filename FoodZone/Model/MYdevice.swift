//
//  MYdevice.swift
//  BirthdayEditor
//
//  Created by Devkrushna Infotech on 18/03/21.
//  Copyright © 2021 iMac. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration


let screenSize = UIScreen.main.bounds.size

enum MYdevice
{
    static var rootView = UIApplication.shared.windows.first?.rootViewController
    
    static let appID = "1626466938"
 
    static let appName = "Video Maker"
    
    static let isPad = UIDevice.current.userInterfaceIdiom == .pad
    
    static let topAnchor = rootView?.view.safeAreaInsets.top ?? 0
    
    static let bottomAnchor = rootView?.view.safeAreaInsets.bottom ?? 0
    
    static let screenWidth = UIScreen.main.bounds.width
    
    static let screenHeight = UIScreen.main.bounds.height
    
    
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
}
