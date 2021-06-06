//
//  UIViewControlerExtension.swift
//  CustomToastView
//
//  Created by Leticia Rodriguez on 5/29/21.
//

import UIKit

extension CustomToastView {
    
    public static func showToast(with toastData: ToastData,
                                 viewController: UIViewController,
                                 completion: @escaping (CustomToastView) -> () = {_ in},
                                 actionCompletion: @escaping () -> () = {}) {
        
        let bundle = Bundle(for: CustomToastView.self)
        
        guard let customToastView = bundle.loadNibNamed(CustomToastView.className, owner: self, options: nil)?.first as? CustomToastView else {
            // xib not loaded, or it's top view is of the wrong type
            return
        }
        
        customToastView.toastTappedNotification = {
            completion(customToastView)
        }
        
        customToastView.actionTappedNotification = {
            actionCompletion()
        }
        
        customToastView.configToast(data: toastData)
        
        customToastView.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.view.addSubview(customToastView)
        
        switch toastData.orientation {
        case .bottomToTop:
            configureFromBottomToTop(customToastView: customToastView, viewController: viewController,
                                     toastHeight: toastData.toastHeight,
                                     defaultDistance: toastData.defaultDistance,
                                     timeDismissal: toastData.timeDismissal,
                                     verticalPosition: toastData.verticalPosition,
                                     shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .topToBottom:
            configureFromTopToBottom(customToastView: customToastView, viewController: viewController,
                                     toastHeight: toastData.toastHeight,
                                     defaultDistance: toastData.defaultDistance,
                                     timeDismissal: toastData.timeDismissal,
                                     verticalPosition: toastData.verticalPosition,
                                     shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .leftToRight:
            configureFromLeftToRight(customToastView: customToastView, viewController: viewController,
                                     toastHeight: toastData.toastHeight,
                                     defaultDistance: toastData.defaultDistance,
                                     timeDismissal: toastData.timeDismissal,
                                     verticalPosition: toastData.verticalPosition,
                                     shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .rightToLeft:
            configureFromRightToLeft(customToastView: customToastView, viewController: viewController,
                                     toastHeight: toastData.toastHeight,
                                     defaultDistance: toastData.defaultDistance,
                                     timeDismissal: toastData.timeDismissal,
                                     verticalPosition: toastData.verticalPosition,
                                     shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .fadeIn:
            configureFadeIn(customToastView: customToastView, viewController: viewController,
                            toastHeight: toastData.toastHeight,
                            defaultDistance: toastData.defaultDistance,
                            timeDismissal: toastData.timeDismissal,
                            verticalPosition: toastData.verticalPosition,
                            shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        case .fadeOut:
            configureFadeOut(customToastView: customToastView, viewController: viewController,
                             toastHeight: toastData.toastHeight,
                             defaultDistance: toastData.defaultDistance,
                             timeDismissal: toastData.timeDismissal,
                             verticalPosition: toastData.verticalPosition,
                             shouldDismissAfterPresenting: toastData.shouldDismissAfterPresenting)
        }
    }
    
    fileprivate static func configureFromBottomToTop(customToastView: CustomToastView,
                                                     viewController: UIViewController,
                                                     toastHeight: CGFloat,
                                                     defaultDistance: CGFloat,
                                                     timeDismissal: Double,
                                                     verticalPosition: CGFloat,
                                                     shouldDismissAfterPresenting: Bool) {
        let bottomConstraint = customToastView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor,
                                                                       constant: verticalPosition )
        
        customToastView.set(constraint: bottomConstraint,
                            viewController: viewController)
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -defaultDistance),
            bottomConstraint,
        ])
        
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        
        bottomConstraint.constant = -(verticalPosition + (viewController.tabBarController?.tabBar.frame.height ?? 0) - 20)
        UIView.animate(withDuration: 0.5) {
            viewController.view.setNeedsLayout()
            viewController.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                if shouldDismissAfterPresenting {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                                  execute: {
                                                    bottomConstraint.constant = toastHeight
                                                    
                                                    UIView.animate(withDuration: timeDismissal) {
                                                        viewController.view.setNeedsLayout()
                                                        viewController.view.layoutIfNeeded()
                                                    }
                                                  })
                }
            }
        }
    }
    
    fileprivate static func configureFromTopToBottom(customToastView: CustomToastView,
                                                     viewController: UIViewController,
                                                     toastHeight: CGFloat,
                                                     defaultDistance: CGFloat,
                                                     timeDismissal: Double,
                                                     verticalPosition: CGFloat,
                                                     shouldDismissAfterPresenting: Bool) {
        
        let topConstraint = customToastView.topAnchor.constraint(equalTo: viewController.view.topAnchor,
                                                                 constant: -verticalPosition )
        
        customToastView.set(constraint: topConstraint,
                            viewController: viewController)
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -defaultDistance),
            topConstraint,
        ])
        
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        
        topConstraint.constant = verticalPosition
        UIView.animate(withDuration: 0.5) {
            viewController.view.setNeedsLayout()
            viewController.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                if shouldDismissAfterPresenting {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                                  execute: {
                                                    topConstraint.constant = -toastHeight
                                                    
                                                    UIView.animate(withDuration: timeDismissal) {
                                                        viewController.view.setNeedsLayout()
                                                        viewController.view.layoutIfNeeded()
                                                    }
                                                  })
                }
            }
        }
    }
    
    fileprivate static func configureFromLeftToRight(customToastView: CustomToastView,
                                                     viewController: UIViewController,
                                                     toastHeight: CGFloat,
                                                     defaultDistance: CGFloat,
                                                     timeDismissal: Double,
                                                     verticalPosition: CGFloat,
                                                     shouldDismissAfterPresenting: Bool) {
        
        let leadingConstraint = customToastView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor,
                                                                         constant: -UIScreen.main.bounds.width)
        
        customToastView.set(constraint: leadingConstraint,
                            viewController: viewController)
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (defaultDistance*2)),
            customToastView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -verticalPosition),
            leadingConstraint
        ])
        
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        
        leadingConstraint.constant = defaultDistance
        UIView.animate(withDuration: 0.5) {
            viewController.view.setNeedsLayout()
            viewController.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                if shouldDismissAfterPresenting {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                                  execute: {
                                                    leadingConstraint.constant = -UIScreen.main.bounds.width
                                                    
                                                    UIView.animate(withDuration: timeDismissal) {
                                                        viewController.view.setNeedsLayout()
                                                        viewController.view.layoutIfNeeded()
                                                    }
                                                  })
                }
            }
        }
    }
    
    fileprivate static func configureFromRightToLeft(customToastView: CustomToastView,
                                                     viewController: UIViewController,
                                                     toastHeight: CGFloat,
                                                     defaultDistance: CGFloat,
                                                     timeDismissal: Double,
                                                     verticalPosition: CGFloat,
                                                     shouldDismissAfterPresenting: Bool) {
        let trailingConstraint = customToastView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor,
                                                                           constant: UIScreen.main.bounds.width)
        
        
        customToastView.set(constraint: trailingConstraint,
                            viewController: viewController)
        
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (defaultDistance*2)),
            customToastView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -verticalPosition),
            trailingConstraint
        ])
        
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        
        trailingConstraint.constant = -defaultDistance
        UIView.animate(withDuration: 0.5) {
            viewController.view.setNeedsLayout()
            viewController.view.layoutIfNeeded()
        } completion: { completed in
            if completed {
                if shouldDismissAfterPresenting {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2,
                                                  execute: {
                                                    trailingConstraint.constant = UIScreen.main.bounds.width
                                                    
                                                    UIView.animate(withDuration: timeDismissal) {
                                                        viewController.view.setNeedsLayout()
                                                        viewController.view.layoutIfNeeded()
                                                    }
                                                  })
                    
                }
            }
        }
    }
    
    fileprivate static func configureFadeIn(customToastView: CustomToastView,
                                            viewController: UIViewController,
                                            toastHeight: CGFloat,
                                            defaultDistance: CGFloat,
                                            timeDismissal: Double,
                                            verticalPosition: CGFloat,
                                            shouldDismissAfterPresenting: Bool) {
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -defaultDistance),
            customToastView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -verticalPosition),
        ])
        
        customToastView.alpha = 0.0
        // Fade in
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseIn, animations: {
            customToastView.alpha = 1.0
        }) { isFinished in
            if isFinished {
                if shouldDismissAfterPresenting {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeDismissal,
                                                  execute: {
                                                    UIView.animate(withDuration: 3.0,
                                                                   delay: 0.1,
                                                                   options: [.curveEaseOut],
                                                                   animations: {
                                                                    customToastView.alpha = 0.0
                                                                   }, completion: {(isCompleted) in
                                                                    customToastView.removeFromSuperview()
                                                                   })
                                                    
                                                  })
                    
                }
            }
        }
    }
    
    fileprivate static func configureFadeOut(customToastView: CustomToastView,
                                             viewController: UIViewController,
                                             toastHeight: CGFloat,
                                             defaultDistance: CGFloat,
                                             timeDismissal: Double,
                                             verticalPosition: CGFloat,
                                             shouldDismissAfterPresenting: Bool) {
        NSLayoutConstraint.activate([
            customToastView.heightAnchor.constraint(equalToConstant: toastHeight),
            customToastView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: defaultDistance),
            customToastView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -defaultDistance),
            customToastView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -verticalPosition),
        ])
        if shouldDismissAfterPresenting {
            UIView.animate(withDuration: 3.0,
                           delay: 0.1,
                           options: .curveEaseOut,
                           animations: {
                            customToastView.alpha = 0.0
                           }, completion: {(isCompleted) in
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeDismissal,
                                                          execute: {
                                                            customToastView.removeFromSuperview()
                                                          })
                            
                            
                           })
        }
    }
}
