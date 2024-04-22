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
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        emailTextField.layer.cornerRadius = 15
        emailTextField.placeholder = "이메일"
        emailTextField.keyboardType = .emailAddress
        emailTextField.clearButtonMode = .always
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.placeholder = "패스워드"
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.clearButtonMode = .always
        
        logInButton.layer.borderWidth = 1
        logInButton.backgroundColor = UIColor(named: "MainColor")
        logInButton.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        logInButton.layer.cornerRadius = 15
        logInButton.setTitle("로그인하기", for: .normal)
        logInButton.setTitleColor(.black, for: .normal)
        
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        
    }
    
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        // tap bar 첫번째 화면으로 이동
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // 회원가입 화면으로 이동
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as? SignUpViewController else { return }
        self.present(signUpVC, animated: true, completion: nil)
        
    }
    
}


extension LogInViewController: UITextFieldDelegate {
     
}
