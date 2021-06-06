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
        
        switch toastData.orientation {
        case .bottomToTop:
            configureFromBottomToTop(customToastView: customToastView,
                                     toastHeight: toastData.toastHeight,
                                     defaultDistance: toastData.defaultDistance,
                                     timeDismissal: toastData.timeDismissal,
                                     verticalPosition: toastData.verticalPosition,
                                     shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .topToBottom:
            configureFromTopToBottom(customToastView: customToastView,
                                     toastHeight: toastData.toastHeight,
                                     defaultDistance: toastData.defaultDistance,
                                     timeDismissal: toastData.timeDismissal,
                                     verticalPosition: toastData.verticalPosition,
                                     shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .leftToRight:
            configureFromLeftToRight(customToastView: customToastView,
                                     toastHeight: toastData.toastHeight,
                                     defaultDistance: toastData.defaultDistance,
                                     timeDismissal: toastData.timeDismissal,
                                     verticalPosition: toastData.verticalPosition,
                                     shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .rightToLeft:
            configureFromRightToLeft(customToastView: customToastView,
                                     toastHeight: toastData.toastHeight,
                                     defaultDistance: toastData.defaultDistance,
                                     timeDismissal: toastData.timeDismissal,
                                     verticalPosition: toastData.verticalPosition,
                                     shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .fadeIn:
            configureFadeIn(customToastView: customToastView,
                            toastHeight: toastData.toastHeight,
                            defaultDistance: toastData.defaultDistance,
                            verticalPosition: toastData.verticalPosition)
        case .fadeOut:
            configureFadeOut(customToastView: customToastView,
                             toastHeight: toastData.toastHeight,
                             defaultDistance: toastData.defaultDistance,
                             verticalPosition: toastData.verticalPosition)
        }
    }
    
    // TODO: agregar el shouldDismissAfterPresenting al final
    fileprivate func configureFromBottomToTop(customToastView: CustomToastView,
                                              toastHeight: CGFloat,
                                              defaultDistance: CGFloat,
                                              timeDismissal: Double,
                                              verticalPosition: CGFloat,
                                              shouldDismissAfterPresenting: Bool) {
        let bottomConstraint = customToastView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                       constant: verticalPosition )
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDistance),
            bottomConstraint,
        ])
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        bottomConstraint.constant = -(verticalPosition + (tabBarController?.tabBar.frame.height ?? 0) - 20)
        UIView.animate(withDuration: 0.5) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                              execute: {
                                                bottomConstraint.constant = toastHeight
                                                
                                                UIView.animate(withDuration: timeDismissal) {
                                                    self.view.setNeedsLayout()
                                                    self.view.layoutIfNeeded()
                                                }
                                              })
            }
        }
    }
    
    fileprivate func configureFromTopToBottom(customToastView: CustomToastView,
                                              toastHeight: CGFloat,
                                              defaultDistance: CGFloat,
                                              timeDismissal: Double,
                                              verticalPosition: CGFloat,
                                              shouldDismissAfterPresenting: Bool) {
        
        let topConstraint = customToastView.topAnchor.constraint(equalTo: view.topAnchor,
                                                                 constant: -verticalPosition )
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDistance),
            topConstraint,
        ])
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        topConstraint.constant = verticalPosition
        UIView.animate(withDuration: 0.5) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                              execute: {
                                                topConstraint.constant = -toastHeight
                                                
                                                UIView.animate(withDuration: timeDismissal) {
                                                    self.view.setNeedsLayout()
                                                    self.view.layoutIfNeeded()
                                                }
                                              })
            }
        }
    }
    
    fileprivate func configureFromLeftToRight(customToastView: CustomToastView,
                                              toastHeight: CGFloat,
                                              defaultDistance: CGFloat,
                                              timeDismissal: Double,
                                              verticalPosition: CGFloat,
                                              shouldDismissAfterPresenting: Bool) {
        
        let leadingConstraint = customToastView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                         constant: -UIScreen.main.bounds.width)
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (defaultDistance*2)),
            customToastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalPosition),
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
                                                
                                                UIView.animate(withDuration: timeDismissal) {
                                                    self.view.setNeedsLayout()
                                                    self.view.layoutIfNeeded()
                                                }
                                              })
            }
        }
    }
    
    fileprivate func configureFromRightToLeft(customToastView: CustomToastView,
                                              toastHeight: CGFloat,
                                              defaultDistance: CGFloat,
                                              timeDismissal: Double,
                                              verticalPosition: CGFloat,
                                              shouldDismissAfterPresenting: Bool) {
        let trailingConstraint = customToastView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                           constant: UIScreen.main.bounds.width)
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (defaultDistance*2)),
            customToastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalPosition),
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
                                                
                                                UIView.animate(withDuration: timeDismissal) {
                                                    self.view.setNeedsLayout()
                                                    self.view.layoutIfNeeded()
                                                }
                                              })
            }
        }
    }
    
    fileprivate func configureFadeIn(customToastView: CustomToastView,
                                     toastHeight: CGFloat,
                                     defaultDistance: CGFloat,
                                     verticalPosition: CGFloat) {
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDistance),
            customToastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalPosition),
        ])
        
        UIView.animate(withDuration: 4.0,
                       delay: 0.1,
                       options: .curveEaseIn,
                       animations: {
            customToastView.alpha = 0.0
        }, completion: {(isCompleted) in
            customToastView.removeFromSuperview()
        })
    }
    
    fileprivate func configureFadeOut(customToastView: CustomToastView,
                                      toastHeight: CGFloat,
                                      defaultDistance: CGFloat,
                                      verticalPosition: CGFloat) {
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -defaultDistance),
            customToastView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalPosition),
        ])
        
        UIView.animate(withDuration: 3.0,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: {
            customToastView.alpha = 0.0
        }, completion: {(isCompleted) in
            customToastView.removeFromSuperview()
        })
    }
}
