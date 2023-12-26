//
//  MainToolBarViewController.swift
//  ToDoApp
//
//  Created by Димаш Алтынбек on 25.11.2023.
//

import Foundation
import UIKit

class MainToolBarViewController: UITabBarController {
    //MARK: -LifeCYcle-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = TimerViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Timer", image: UIImage(systemName: "timer"), tag: 0)
        
        let secoundViewController = ListViewController()
        secoundViewController.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.clipboard"), tag: 1)
        
        let thirdViewController = AddNewTaskViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Add Task", image: UIImage(systemName: "plus"), tag: 2)
        
        let myViews = [firstViewController, secoundViewController, thirdViewController]
        
        viewControllers = myViews.map({ UINavigationController(rootViewController: $0)})
    }
}
