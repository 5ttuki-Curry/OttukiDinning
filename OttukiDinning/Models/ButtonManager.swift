//
//  ButtonManager.swift
//  OttukiDinning
//
//  Created by t2023-m0056 on 4/26/24.
//

import UIKit

class ButtonManager {
    
    static var navigationController = UINavigationController()
    
    @objc static func homeButtonTapped(viewController: UIViewController) {
        print("홈화면 이동")
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        
        guard let homeVC = storyboard.instantiateViewController(identifier: "HomeView") as? HomeViewController else {
            return
        }
        
        ButtonManager.navigationController = UINavigationController(rootViewController: homeVC)
        ButtonManager.navigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        viewController.present(ButtonManager.navigationController, animated: true)
    }
    
    @objc static func searchButtonTapped(viewController: UIViewController) {
        print("검색화면 이동")
        let storyboard = UIStoryboard(name: "Sion", bundle: nil)
        
        guard let searchVC = storyboard.instantiateViewController(identifier: "SionViewController") as? SionViewController else {
            return
        }
        
        ButtonManager.navigationController = UINavigationController(rootViewController: searchVC)
        ButtonManager.navigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        viewController.present(ButtonManager.navigationController, animated: true)
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
