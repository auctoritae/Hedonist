//
//  PlaceRouter.swift
//  Hedonist
//
//  Created by a.lobanov on 12/28/22.
//

import UIKit
import CallKit
import SafariServices

protocol PlaceRouterProtocol: AnyObject {
    func openCall(from: Landmark)
    func presentFavAlert()
    func close()
}

final class PlaceRouter: PlaceRouterProtocol {
    // MARK: - Variable
    weak var viewController: PlaceVC?
    
    
    // MARK: - Implementation
    func openCall(from: Landmark) {
        if let number = from.phone?.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "") {
            if let url = NSURL(string: ("tel:" + "+" + number)) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        } else {
            viewController?.presentAlert(message: Errors.phoneError)
        }
    }
    
    
    func presentFavAlert() {
        viewController?.presentAlert(message: Alerts.addedToFavorites)
    }
    
    
    func close() {
        viewController?.dismiss(animated: true)
    }
}
