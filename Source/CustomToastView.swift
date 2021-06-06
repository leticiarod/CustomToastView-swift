//
//  CustomToastView.swift
//  Outfitted
//
//  Created by Leticia Rodriguez on 3/10/21.
//

import UIKit

public class CustomToastView: UIView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var toastMessageLabel: UILabel!
    @IBOutlet private weak var actionLabel: UILabel!
    @IBOutlet private weak var leftIconImageView: UIImageView!
    
    var toastTappedNotification: () -> () = {}
    
    private var toastData: ToastData?
    public var constraint: NSLayoutConstraint?
    public var viewController: UIViewController?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    private func setUI() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toastTapped))
        containerView.addGestureRecognizer(gesture)
    }
    
    func set(constraint: NSLayoutConstraint,
             viewController: UIViewController) {
        self.constraint = constraint
        self.viewController = viewController
    }
    
    func configToast(data: ToastData) {
        if let cornerRadius = data.cornerRadius {
            containerView.layer.cornerRadius = cornerRadius
        } else {
            containerView.layer.cornerRadius = data.toastHeight/2
        }
        
        containerView.backgroundColor = data.backgroundColor
        
        toastMessageLabel.textColor = data.textColor
        toastMessageLabel.text = data.title
        toastMessageLabel.font = data.font
        toastMessageLabel.textAlignment = data.textAlignment
        
        actionLabel.textColor = data.actionTextColor
        actionLabel.text = data.actionText
        actionLabel.font = data.actionFont
        
        if let leftIconImage = data.leftIconImage {
            leftIconImageView.image = leftIconImage
        }
        leftIconImageView.isHidden = data.leftIconImage == nil
        
        leftIconImageView.contentMode = data.leftIconImageContentMode
        
        if let rightActionLabel = data.rightActionLabel {
            actionLabel.text = rightActionLabel
            toastMessageLabel.textAlignment = .left
        }
        actionLabel.isHidden = data.rightActionLabel == nil
        
        toastData = data
    }
    
    @objc private func toastTapped() {
        toastTappedNotification()
    }
    
    public func hide() {
        guard let toastData = self.toastData else { return }
        self.hideByOrientation()
        UIView.animate(withDuration: toastData.timeDismissal) {
            self.viewController?.view.setNeedsLayout()
            self.viewController?.view.layoutIfNeeded()
        }
    }
    
    private func hideByOrientation() {
        guard let toastData = self.toastData else { return }
        switch toastData.orientation {
        case .bottomToTop:
            self.constraint?.constant = toastData.toastHeight
        case .topToBottom:
            self.constraint?.constant = -toastData.toastHeight
        case .leftToRight:
            self.constraint?.constant = -UIScreen.main.bounds.width
        case .rightToLeft:
            self.constraint?.constant = UIScreen.main.bounds.width
        case .fadeIn: dismissFadeIn()
        case .fadeOut: dismissFadeOut()
        }
    }
    
    private func dismissFadeIn() {
        UIView.animate(withDuration: 3.0,
                       delay: 0.1,
                       options: [.curveEaseOut],
                       animations: {
                        self.alpha = 0.0
                       }, completion: {(isCompleted) in
                        self.removeFromSuperview()
                       })
    }
    
    private func dismissFadeOut() {
        UIView.animate(withDuration: 3.0,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: {
                        self.alpha = 0.0
                       }, completion: {(isCompleted) in
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + (self.toastData?.timeDismissal ?? 0.0),
                                                      execute: {
                                                        self.removeFromSuperview()
                                                      })
                        
                        
                       })
    }
}
