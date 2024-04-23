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
    
    let defaults = UserDefaults.standard
    
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
        emailTextField.returnKeyType = .next
        emailTextField.clearButtonMode = .always
        
        setPasswordTextField.layer.borderWidth = 1
        setPasswordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        setPasswordTextField.layer.cornerRadius = 15
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .next
        setPasswordTextField.placeholder = "패스워드를 입력하세요"
        
        checkPasswordTextField.layer.borderWidth = 1
        checkPasswordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        checkPasswordTextField.layer.cornerRadius = 15
        checkPasswordTextField.keyboardType = .emailAddress
        checkPasswordTextField.returnKeyType = .done
        checkPasswordTextField.placeholder = "패스워드를 한 번 더 입력하세요"
        
        makeAccountButton.layer.borderWidth = 1
        makeAccountButton.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        makeAccountButton.layer.cornerRadius = 15
        makeAccountButton.backgroundColor = UIColor(named: "MainColor")
        makeAccountButton.setTitle("회원가입하기", for: .normal)
        makeAccountButton.setTitleColor(.black, for: .normal)
        makeAccountButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
    
    
    @IBAction func makcAccountButtonTapped(_ sender: UIButton) {
        // 데이터(이메일, 패스워드) 저장하기
        defaults.set(emailTextField.text, forKey: "id")
        defaults.set(setPasswordTextField.text, forKey: "password")
        
        // 로그인 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
    
}
