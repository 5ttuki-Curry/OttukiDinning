//
//  ButtonManager.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/26/24.
//

import UIKit

class ButtonManager {
    
    @objc static func homeButtonTapped(viewController: UIViewController) {
        print("홈화면 이동")
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        guard let homeVC = storyboard.instantiateViewController(identifier: "HomeView") as? HomeViewController else {
            return
        }
        
        LogInViewController.navigationController = UINavigationController(rootViewController: homeVC)
        LogInViewController.navigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        viewController.present(LogInViewController.navigationController, animated: true)
    }
    
    @objc static func searchButtonTapped(viewController: UIViewController) {
        print("검색화면 이동")
        let storyboard = UIStoryboard(name: "Sion", bundle: nil)
        
        guard let searchVC = storyboard.instantiateViewController(identifier: "SionViewController") as? SionViewController else {
            return
        }
        
        let navigationController = UINavigationController(rootViewController: searchVC)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        viewController.present(navigationController, animated: true)
    }
    
    @objc static func myInfoButtonTapped(viewController: UIViewController) {
        print("마이페이지 이동")
        let storyboard = UIStoryboard(name: "MyPageView", bundle: nil)
        
        guard let mypageVC = storyboard.instantiateViewController(withIdentifier: "MyPageView") as? MyPageViewController else {
            return
        }
        
        mypageVC.modalPresentationStyle = .fullScreen
        viewController.present(mypageVC, animated: true, completion: nil)
    }
}
