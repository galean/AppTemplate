//
//  Drawable.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}
