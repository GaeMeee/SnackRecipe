//
//  CustomTabBarController.swift
//  RecipeLit
//
//  Created by JeonSangHyeok on 12/26/23.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var controllers: [UIViewController]
    
    init(controllers: [UIViewController]) {
        self.controllers = controllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarControllers()
        addBorder()
    }
}

private extension CustomTabBarController {
    func addBorder() {
        let border = CALayer()
        border.backgroundColor = UIColor.systemGray2.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.tabBar.frame.size.width, height: 0.5)
        tabBar.layer.addSublayer(border)
    }
    
    func configureTabBarControllers() {
        let mainTabBarItem = templateTabBarItem(index: 0, unSelectedImage: "house", selectedImage: "house.fill", tag: 0)
        let searchTabBarItem = templateTabBarItem(index: 1, unSelectedImage: "magnifyingglass", selectedImage: "magnifyingglass", tag: 1)
        let myPageTabBarItem = templateTabBarItem(index: 2, unSelectedImage: "person", selectedImage: "person.fill", tag: 2)
        
        controllers[0].tabBarItem = mainTabBarItem
        controllers[1].tabBarItem = searchTabBarItem
        controllers[2].tabBarItem = myPageTabBarItem
        
        self.viewControllers = controllers
    }
    
    func templateTabBarItem(index: Int, unSelectedImage: String, selectedImage: String, tag: Int) -> UITabBarItem {
        controllers[index].tabBarItem.tag = tag
        controllers[index].tabBarItem.image = UIImage(systemName: unSelectedImage)
        controllers[index].tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        
        return controllers[index].tabBarItem
    }
}
