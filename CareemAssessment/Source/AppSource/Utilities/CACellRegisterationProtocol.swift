//
//  CACellRegisterationProtocol.swift
//  CareemAssesment
//
//  Created by Rajeel Amjad on 23/10/2019.
//  Copyright © 2019 Rajeel Amjad. All rights reserved.
//

import Foundation
import UIKit

/// Conform to this protocol to register xibs to tableview
protocol CACellRegisterationProtocol {
    func registerCellsForTableView(tableView: UITableView?)
}

extension CACellRegisterationProtocol {
    /// Registers the xibs to tableview
    /// - Parameter tableView: tableview
    /// - Parameter identifiers: cell identifiers strings, expects cell xib name and reuse identifier to be same string
    func registerCellsTo(tableView: UITableView?, identifiers: [String]){
        identifiers.forEach {
            tableView?.register(UINib(nibName: $0, bundle: Bundle.main), forCellReuseIdentifier: $0)
        }
    }
}
