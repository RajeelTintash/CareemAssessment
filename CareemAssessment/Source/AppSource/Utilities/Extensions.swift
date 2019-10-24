//  
//  Extensions.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 21/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import UIKit

//MARK:- UIDevice entension to support model name for device
extension UIDevice {
    /// Returns the device model name 
    static let modelName: String = {
        var systemInfo      = utsname()
        uname(&systemInfo)
        let machineMirror   = Mirror(reflecting: systemInfo.machine)
        let identifier      = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        func mapToDevice(identifier: String) -> String {
            #if os(iOS)
            switch identifier {
                // Ipods
                case "iPod5,1":                                 return "iPod Touch 5"
                case "iPod7,1":                                 return "iPod Touch 6"
                case "iPod9,1":                                 return "iPod Touch 7"
                
                // Iphones
                case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
                case "iPhone4,1":                               return "iPhone 4s"
                case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
                case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
                case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
                case "iPhone7,2":                               return "iPhone 6"
                case "iPhone7,1":                               return "iPhone 6 Plus"
                case "iPhone8,1":                               return "iPhone 6s"
                case "iPhone8,2":                               return "iPhone 6s Plus"
                case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
                case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
                case "iPhone8,4":                               return "iPhone SE"
                case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
                case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
                case "iPhone10,3", "iPhone10,6":                return "iPhone X"
                case "iPhone11,2":                              return "iPhone XS"
                case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
                case "iPhone11,8":                              return "iPhone XR"
                case "iPhone12,1":                              return "iPhone 11"
                case "iPhone12,3":                              return "iPhone 11 Pro"
                case "iPhone12,5":                              return "iPhone 11 Pro Max"
                    
                // Simulator
                case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
                default:                                        return identifier
                }
            #endif
        }
        return mapToDevice(identifier: identifier)
    }()
}

extension Data {
    mutating func append(string: String) {
        let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true)
        if let _data = data {
            append(_data)
        }
    }
}

extension Formatter {
    static let movieDbApiDateFormatter: DateFormatter = {
        let formatter           = DateFormatter()
        formatter.dateFormat    = "yyyy-MM-dd"
        return formatter
    }()
    
    static let  movieDisplayDateFormatter: DateFormatter = {
        let formatter           = DateFormatter()
        formatter.dateFormat    = "dd MMMM yyyy"
        return formatter
    }()
}

extension UILabel {
  func set(image: UIImage, with text: String) {
    let attachment      = NSTextAttachment()
    attachment.image    = image
    attachment.bounds   = CGRect(x: 0, y: 0, width: 10, height: 10)
    let attachmentStr   = NSAttributedString(attachment: attachment)

    let mutableAttributedString = NSMutableAttributedString()
    mutableAttributedString.append(attachmentStr)
    mutableAttributedString.append(NSAttributedString(string: " "))

    let textString = NSAttributedString(string: text, attributes: [.font: self.font ?? UIFont.systemFont(ofSize: 17)])
    mutableAttributedString.append(textString)

    self.attributedText = mutableAttributedString
  }
}
