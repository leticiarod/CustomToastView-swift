//
//  UIViewControlerExtension.swift
//  CustomToastView
//
//  Created by Leticia Rodriguez on 5/29/21.
//

import UIKit

public extension UIViewController {
    func showToast(with type: CustomToastType,
                   completion: @escaping () -> () = {}) {
        let bundle = Bundle(for: CustomToastView.self)
        
        guard let customToastView = bundle.loadNibNamed(CustomToastView.className, owner: self, options: nil)?.first as? CustomToastView else {
            // xib not loaded, or it's top view is of the wrong type
            return
        }
        
        customToastView.toastTappedNotification = {
            completion()
        }
        
        customToastView.configToast(textColor: .white)
        
        customToastView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customToastView)
        
        let toastHeight: CGFloat = 54
        let defaultDistance: CGFloat = 16
        
        let bottomConstraint = customToastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: toastHeight )
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDistance),
            bottomConstraint,
        ])
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        bottomConstraint.constant = -(toastHeight + (tabBarController?.tabBar.frame.height ?? 0) - 20)
        UIView.animate(withDuration: 0.5) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                              execute: {
                                                bottomConstraint.constant = toastHeight
                                                
                                                UIView.animate(withDuration: 0.5) {
                                                    self.view.setNeedsLayout()
                                                    self.view.layoutIfNeeded()
                                                }
                                              })
            }
        }
    }
}
