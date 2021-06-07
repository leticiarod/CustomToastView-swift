//
//  ToastData.swift
//  CustomToastView-swift
//
//  Created by Leticia Rodriguez on 5/31/21.
//

public struct ToastData {
    //var type: CustomToastType = .simple
    var font = UIFont.systemFont(ofSize: 14,
                                 weight: .light)
    var textColor: UIColor = .white
    var backgroundColor: UIColor = .magenta
    var title = "Hello! I'm a toast message!"
    var actionTextColor: UIColor = .black
    var actionText: String? = nil
    var actionFont = UIFont.systemFont(ofSize: 14,
                                       weight: .regular)
    var orientation: AnimationType = .bottomToTop
    var leftIconImage: UIImage? = nil
    var toastHeight: CGFloat = 54
    var defaultDistance: CGFloat = 16
    var cornerRadius: CGFloat? = nil
    var timeDismissal = 0.5
    var verticalPosition: CGFloat = 54
    var shouldDismissAfterPresenting = true
    var textAlignment: NSTextAlignment = .center
    var leftIconImageContentMode: UIViewContentMode = .scaleAspectFit
    
    public init() {
        
    }
}
