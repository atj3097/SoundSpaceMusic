//
//  UIUtilities.swift
//  SoundSpaceMusic
//
//  Created by God on 3/8/20.
//  Copyright © 2020 Adam Jackson. All rights reserved.
//

import UIKit

struct UIUtilities {
  
  static func setViewBackgroundColor(_ view: UIView) {
    view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }
    static func addSubViews(_ views: [UIView], parentController: UIViewController) {
        views.forEach({parentController.view.addSubview($0)})
    }
  
    static func setUILabel(_ label: UILabel, labelTitle: String, size: CGFloat, alignment: NSTextAlignment) {
        label.text = labelTitle
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Medium", size: size)
        label.textAlignment = alignment
    }
    
    static func setupTextView(_ textView: UITextField, placeholder: String, alignment: NSTextAlignment) {
        textView.placeholder = placeholder
        textView.textAlignment = alignment
    }
    
    static func setUpButton(_ button: UIButton, title: String, backgroundColor: UIColor, target: Any?, action: Selector ) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.isUserInteractionEnabled = true
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    static func setUpImageView(_ imageView: UIImageView, image: UIImage, contentMode: UIView.ContentMode) {
        imageView.image = image
        imageView.contentMode = contentMode
    }
    
    static func setUpNavigationBar(title: String, viewController: UIViewController, leftBarButton: UIBarButtonItem) {
        let attrs = [
                   NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
                   NSAttributedString.Key.font: UIFont(name: "SnellRoundhand-Bold", size: 30)]
        viewController.navigationController?.navigationBar.titleTextAttributes = attrs as [NSAttributedString.Key : Any]
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
        viewController.navigationController?.navigationBar.isTranslucent = true
        viewController.navigationController?.view.backgroundColor = .clear
        viewController.navigationController?.navigationBar.topItem?.title = "\(title)"
        viewController.navigationItem.leftBarButtonItem = leftBarButton
    }
}

