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
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    private func setUI() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toastTapped))
        containerView.addGestureRecognizer(gesture)
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
    }
    
    @objc private func toastTapped() {
        toastTappedNotification()
    }
}
