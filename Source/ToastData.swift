//
//  ToastData.swift
//  CustomToastView-swift
//
//  Created by Leticia Rodriguez on 5/31/21.
//

public struct ToastData {
    var type: CustomToastType = .simple
    var font: UIFont = UIFont.systemFont(ofSize: 14, weight: .light)
    var textColor: UIColor = .white
    var backgroundColor: UIColor = .magenta
    var title: String = "Hello! I'm a toast message!"
    var actionTextColor: UIColor = .black
    var actionText: String? = nil
    var actionFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    var orientation: ToastOrientation = .bottomToTop
    var showRightAction: Bool = false
    var showLeftIcon: Bool = false
    
    public init() {
        
    }
}
