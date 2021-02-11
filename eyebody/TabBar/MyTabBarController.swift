//
//  MyNavigationController.swift
//  CustomTabShapeTest
//
//  Created by Philipp Weiß on 16.11.18.
//  Copyright © 2018 pmw. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController, UITabBarControllerDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupMiddleButton()
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    // TabBarButton – Setup Middle Button
    func setupMiddleButton() {
//        let BtnWrapperView = UIView(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))
//        BtnWrapperView.backgroundColor = UIColor.red
        
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))
//            middleBtn.setImage(UIImage(systemName: "sunrise", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium), for: .normal),
        
//        middleBtn.
        
        middleBtn.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 1))
        middleBtn.layer.cornerRadius = 25
        
        middleBtn.setImage(UIImage(systemName: "camera"), for: .normal)
//        middleBtn.setTitle("test", for: .normal)
        //STYLE THE BUTTON YOUR OWN WAY
//            middleBtn.setIcon(icon: .fontAwesomeSolid(.home), iconSize: 20.0, color: UIColor.white, backgroundColor: UIColor.white, forState: .normal)
//            middleBtn.applyGradient(colors: [colorBlueDark.cgColor,colorBlueLight.cgColor])
        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
//        self.tabBar.addSubview(<#T##view: UIView##UIView#>)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        self.view.layoutIfNeeded()
    }

    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        print("!!!!!!")
//        cameraSegue
        performSegue(withIdentifier: "cameraSegue", sender: sender)
//          self.selectedIndex = 1   //to select the middle tab. use "1" if you have only 3 tabs.
    }
    
    
}
