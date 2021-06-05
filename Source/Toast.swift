//
//  Toast.swift
//  CustomToastView-swift
//
//  Created by Leticia Rodriguez on 5/31/21.
//

public enum ToastOrientation {
    case bottomToTop
    case topToBottom
    case leftToRight
    case rightToLeft
}

public class Toast {
    
    var data: ToastData = ToastData()
    
    private init(data: ToastData) {
        self.data = data
    }
    
    public func show(viewController: UIViewController,
                   completion: @escaping () -> () = {}) {
        viewController.showToast(with: data) {
            completion()
        }
    }
    
    public class Builder {
        
        public init() {
            
        }
        
        private var data: ToastData = ToastData()
        
        /// Toast message type
        /// simple -> only text
        /// action -> shows an action at the right
        /// Simple by default
        public func type(_ type: CustomToastType) -> Builder {
            data.type = type
            return self
        }
        
        public func showRightAction() -> Builder {
            data.showRightAction = true
            return self
        }
        
        public func showLeftIcon() -> Builder {
            data.showLeftIcon = true
            return self
        }
        
//        let toastHeight: CGFloat = 54
//        let defaultDistance: CGFloat = 16
        // CORNER RADIUS
        
        // FADE IN
        
        // FADE OUT
        
        // TIME DISMISSAL
        
        // Do not dismiss
        
        // animation type bottom to top, top to bottom, left to right etc 
        
        public func orientation(_ orientation: ToastOrientation) -> Builder {
            data.orientation = orientation
            return self
        }
        
        /// Font of the message string of the toast
        public func font(_ font: UIFont) -> Builder {
            data.font = font
            return self
        }
        
        /// Color of the message string of the toast
        public func textColor(_ textColor: UIColor) -> Builder {
            data.textColor = textColor
            return self
        }
        
        /// BackgroundColor of the toast
        public func backgroundColor(_ backgroundColor: UIColor) -> Builder {
            data.backgroundColor = backgroundColor
            return self
        }
        
        /// Title message of the Toast -> By default is "Hello! I'm a toast message!"
        public func title(_ title: String) -> Builder {
            data.title = title
            return self
        }
        
        /// Color of the action string  of the toast
        public func actionTextColor(_ actionTextColor: UIColor) -> Builder {
            data.actionTextColor = actionTextColor
            return self
        }
        
        /// Text of the action  of the toast
        public func actionText(_ actionText: String) -> Builder {
            data.actionText = actionText
            return self
        }
        
        /// Font of the action  of the toast
        public func actionFont(_ actionFont: UIFont) -> Builder {
            data.actionFont = actionFont
            return self
        }
        
        public func build() -> Toast {
            return Toast(data: data)
        }
    }
}
