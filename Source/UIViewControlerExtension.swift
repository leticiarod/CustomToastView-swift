//
//  UIViewControlerExtension.swift
//  CustomToastView
//
//  Created by Leticia Rodriguez on 5/29/21.
//

import UIKit

extension UIViewController {
    public func showToast(with toastData: ToastData,
                          completion: @escaping () -> () = {}) {
        let bundle = Bundle(for: CustomToastView.self)
        
        guard let customToastView = bundle.loadNibNamed(CustomToastView.className, owner: self, options: nil)?.first as? CustomToastView else {
            // xib not loaded, or it's top view is of the wrong type
            return
        }
        
        customToastView.toastTappedNotification = {
            completion()
        }
        
        customToastView.configToast(data: toastData)
        
        customToastView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customToastView)
        
        let toastHeight: CGFloat = 54
        let defaultDistance: CGFloat = 16
        
        switch toastData.orientation {
        case .bottomToTop:
            configureFromBottomToTop(customToastView: customToastView,
                                     toastHeight: toastHeight,
                                     defaultDistance: defaultDistance)
        case .topToBottom:
            configureFromTopToBottom(customToastView: customToastView,
                                     toastHeight: toastHeight,
                                     defaultDistance: defaultDistance)
        case .leftToRight:
            configureFromLeftToRight(customToastView: customToastView,
                                     toastHeight: toastHeight,
                                     defaultDistance: defaultDistance)
        case .rightToLeft:
            configureFromRightToLeft(customToastView: customToastView,
                                     toastHeight: toastHeight,
                                     defaultDistance: defaultDistance)
        }
    }
    
    fileprivate func configureFromBottomToTop(customToastView: CustomToastView,
                                              toastHeight: CGFloat,
                                              defaultDistance: CGFloat) {
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
    
    fileprivate func configureFromTopToBottom(customToastView: CustomToastView,
                                              toastHeight: CGFloat,
                                              defaultDistance: CGFloat) {
        
        let topConstraint = customToastView.topAnchor.constraint(equalTo: view.topAnchor, constant: -toastHeight )
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDistance),
            topConstraint,
        ])
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        topConstraint.constant = toastHeight
        UIView.animate(withDuration: 0.5) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                              execute: {
                                                topConstraint.constant = -toastHeight
                                                
                                                UIView.animate(withDuration: 0.5) {
                                                    self.view.setNeedsLayout()
                                                    self.view.layoutIfNeeded()
                                                }
                                              })
            }
        }
    }
    
    fileprivate func configureFromLeftToRight(customToastView: CustomToastView,
                                              toastHeight: CGFloat,
                                              defaultDistance: CGFloat) {
        
        let leadingConstraint = customToastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -UIScreen.main.bounds.width)
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (defaultDistance*2)),
            customToastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -toastHeight),
            leadingConstraint
        ])
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        leadingConstraint.constant = defaultDistance
        UIView.animate(withDuration: 0.5) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                              execute: {
                                                leadingConstraint.constant = -UIScreen.main.bounds.width
                                                
                                                UIView.animate(withDuration: 0.5) {
                                                    self.view.setNeedsLayout()
                                                    self.view.layoutIfNeeded()
                                                }
                                              })
            }
        }
    }
    
    fileprivate func configureFromRightToLeft(customToastView: CustomToastView,
                                              toastHeight: CGFloat,
                                              defaultDistance: CGFloat) {
        let trailingConstraint = customToastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIScreen.main.bounds.width)
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (defaultDistance*2)),
            customToastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -toastHeight),
            trailingConstraint
        ])
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        trailingConstraint.constant = -defaultDistance
        UIView.animate(withDuration: 0.5) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                              execute: {
                                                trailingConstraint.constant = UIScreen.main.bounds.width
                                                
                                                UIView.animate(withDuration: 0.5) {
                                                    self.view.setNeedsLayout()
                                                    self.view.layoutIfNeeded()
                                                }
                                              })
            }
        }
        
    }
}
