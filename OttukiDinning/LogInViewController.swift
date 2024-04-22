//
//  LogInViewController.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/22/24.
//

import UIKit

class LogInViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    // 카카오로 시작 버튼은 스토리보드에 만들어만 둠, 추가 구현 의논시 결정
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    
    func configureUI() {
        
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        
    }
}
