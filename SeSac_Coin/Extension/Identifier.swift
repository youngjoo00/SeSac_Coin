//
//  Identifier.swift
//  SeSac_Media
//
//  Created by youngjoo on 1/31/24.
//

import UIKit

extension UIView {
    static var identifier: String {
        get {
            return String(describing: self)
        }
    }

}
