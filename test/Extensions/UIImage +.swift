//
//  UIImage +.swift
//  test
//
//  Created by Anna Ruslanovna on 10.07.2024.
//

import Foundation
import UIKit.UIImage

extension UIImage {
    func resize(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
