//
//  Extensions.swift
//  Hedonist
//
//  Created by a.lobanov on 1/21/23.
//

import UIKit

// MARK: - UITableView extensions
extension UITableView {
    func removeExcessCells () {
        tableFooterView = UIView(frame: .zero)
    }
}


// MARK: - UIViewController extensions
extension UIViewController {
     func presentAlert(title: String, message: String) {
          DispatchQueue.main.async {
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               alert.modalPresentationStyle = .overFullScreen
               alert.modalTransitionStyle = .crossDissolve
               self.present(alert, animated: true)
          }
     }
}
