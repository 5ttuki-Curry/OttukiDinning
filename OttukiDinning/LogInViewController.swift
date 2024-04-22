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
    
    // 카카오로 시작 버튼은 스토리보드에 만들어만 둠, 추가 구현할 지 추후 결정
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    
    func configureUI() {
        emailTextField.layer.cornerRadius = 20
        emailTextField.placeholder = "이메일"
        emailTextField.borderStyle = .roundedRect
        
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.placeholder = "패스워드"
        
        logInButton.backgroundColor = 
        logInButton.layer.cornerRadius = 20
        
        
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        // tap bar 첫번째 화면으로 이동
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // 회원가입 화면으로 이동
    }
}
