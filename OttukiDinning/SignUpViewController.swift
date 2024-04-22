//
//  SignUpViewController.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/22/24.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var setPasswordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var makeAccountButton: UIButton!
    
    // 카카오로 시작 버튼 구현 여부는 추후 결정
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
    }
    
    func configureUI() {
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        emailTextField.layer.cornerRadius = 15
        emailTextField.placeholder = "이메일 주소를 입력하세요"
        emailTextField.keyboardType = .emailAddress
        emailTextField.clearButtonMode = .always
        
        setPasswordTextField.layer.borderWidth = 1
        setPasswordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        setPasswordTextField.layer.cornerRadius = 15
        setPasswordTextField.placeholder = "패스워드를 입력하세요"
        
        checkPasswordTextField.layer.borderWidth = 1
        checkPasswordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        checkPasswordTextField.layer.cornerRadius = 15
        checkPasswordTextField.placeholder = "패스워드를 한 번 더 입력하세요"
        
        makeAccountButton.layer.borderWidth = 1
        makeAccountButton.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        makeAccountButton.layer.cornerRadius = 15
        makeAccountButton.backgroundColor = UIColor(named: "MainColor")
        makeAccountButton.setTitle("회원가입하기", for: .normal)
        makeAccountButton.setTitleColor(.black, for: .normal)
        makeAccountButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
    

}
