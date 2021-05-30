//
//  UIViewExtension.swift
//  CustomToastView
//
//  Created by Leticia Rodriguez on 5/29/21.
//

import UIKit

extension UIView {
    class func loadViewFromNib<T: UIView>() -> T? {
        guard let subView = Bundle.main.loadNibNamed(self.className, owner: self, options: nil)?.first as? T else {
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        return subView
    }
}
