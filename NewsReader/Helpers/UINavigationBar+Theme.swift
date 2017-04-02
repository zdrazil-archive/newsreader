//
//  UINavigationBar+Theme.swift
//  NewsReader
//
//  Created by Vladimír Zdražil on 02/04/2017.
//  Copyright © 2017 Vladimír Zdražil. All rights reserved.
//

import UIKit

extension UINavigationBar {

    // Set background color of status bar
    func setStatusBarColor() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let statusBarView = UIView.init(frame: CGRect(x: 0, y: -statusBarHeight, width: UIScreen.main.bounds.size.width, height: statusBarHeight))
        statusBarView.backgroundColor = UIColor.black
        self.addSubview(statusBarView)
    }

    // Set transparent navigation bar
    func setTransparentNavigationBar() {
       self.setBackgroundImage(UIImage(), for: .default)
       self.shadowImage = UIImage()
       self.isTranslucent = true
    }
}
