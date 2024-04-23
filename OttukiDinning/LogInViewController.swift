//
//  LogInViewController.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/22/24.
//

import UIKit

class LogInViewController: UIViewController {

    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    // 카카오로 시작 버튼은 스토리보드에 만들어만 둠, 추가 구현할 지 추후 결정
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idTextField.delegate = self
        passwordTextField.delegate = self
        
        configureUI()
        
    }
    
    
    func configureUI() {
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        idTextField.layer.cornerRadius = 15
        idTextField.placeholder = "이메일"
        idTextField.keyboardType = .emailAddress
        idTextField.returnKeyType = .next
        idTextField.clearButtonMode = .always
        idTextField.text = readLoginInfo(forKey: "id")
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.placeholder = "패스워드"
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.returnKeyType = .done
        passwordTextField.clearButtonMode = .always
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text = readLoginInfo(forKey: "password")
        
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        logInButton.layer.cornerRadius = 15
        logInButton.backgroundColor = UIColor(named: "MainColor")
        logInButton.setTitle("로그인하기", for: .normal)
        logInButton.setTitleColor(.black, for: .normal)
        
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        
    }
    
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        // id, pw 맞는지 확인
        if idTextField.text == readLoginInfo(forKey: "id"), passwordTextField.text == readLoginInfo(forKey: "password") {
            //  맞으면 다음 화면으로 이동
            print("다음화면 이동")
        } else {
            // 틀리면 alert창 띄워 경고
            let alert = UIAlertController(title: "가입하신 이메일 또는 비밀번호가 아닙니다.", message: "올바르게 입력해 주세요.", preferredStyle: .alert)
            let back = UIAlertAction(title: "돌아가기", style: .cancel, handler: nil)
            alert.addAction(back)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // 회원가입 화면으로 이동
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as? SignUpViewController else { return }
        self.present(signUpVC, animated: true, completion: nil)
        
    }
    
    
    func readLoginInfo(forKey: String) -> String {
        if let value = defaults.string(forKey: forKey) {
            return value
        } else { return "" }
    }
    
    
   

}


extension LogInViewController: UITextFieldDelegate {
    
    //빈 화면 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // 엔터 누르면 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

