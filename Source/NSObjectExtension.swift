//
//  NSObjectExtension.swift
//  CustomToastView
//
//  Created by Leticia Rodriguez on 5/29/21.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
