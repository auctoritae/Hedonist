//
//  Extensions.swift
//  Hedonist
//
//  Created by a.lobanov on 1/21/23.
//

import UIKit

extension UITableView {
    func removeExcessCells () {
        tableFooterView = UIView(frame: .zero)
    }
}
