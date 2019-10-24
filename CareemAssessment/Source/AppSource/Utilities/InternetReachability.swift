//  
//  InternetReachability.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Network

/// Checks for internet connectivity.
/// Simply check for isconnected throughtout the app where required.
class InternetReachability {
    static let shared                   = InternetReachability()
    private(set) var isConnected :Bool  = true
    
    private init() {
        startCheckingforInternet()
    }
}


extension InternetReachability {
    
    
    /// Private fucntion starts monitoring internet connectivity and updates is connected.
    fileprivate func startCheckingforInternet () {
        let networkMoniter                  = NWPathMonitor()
        let queue                           = DispatchQueue.global(qos: .background)
        
        networkMoniter.start(queue: queue)
        networkMoniter.pathUpdateHandler    = {  path in
            self.isConnected = path.status == .satisfied ? true : false
        }
    }
}
