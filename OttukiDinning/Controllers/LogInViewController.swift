//
//  LogInViewController.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/22/24.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var kakaoLogInButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        idTextField.delegate = self
        passwordTextField.delegate = self
        
        configureUI()
        easyLogIn()
    }
    
    
    func configureUI() {
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        idTextField.layer.cornerRadius = 15
        idTextField.addLeftPadding()
        idTextField.placeholder = "이메일"
        idTextField.keyboardType = .emailAddress
        idTextField.returnKeyType = .next
        idTextField.clearButtonMode = .always
        idTextField.autocorrectionType = .no
        idTextField.spellCheckingType = .no
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.addLeftPadding()
        passwordTextField.placeholder = "패스워드"
        passwordTextField.keyboardType = .emailAddress
        passwordTextField.returnKeyType = .done
        passwordTextField.clearButtonMode = .always
        passwordTextField.autocorrectionType = .no
        passwordTextField.spellCheckingType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode
        
        logInButton.layer.borderWidth = 1
        logInButton.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        logInButton.layer.cornerRadius = 15
        logInButton.backgroundColor = UIColor(named: "MainColor")
        logInButton.setTitle("로그인하기", for: .normal)
        logInButton.setTitleColor(.black, for: .normal)
        
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        
        kakaoLogInButton.layer.cornerRadius = 12
        kakaoLogInButton.setImage(UIImage(named: "KakaoLogIn"), for: .normal)
        kakaoLogInButton.backgroundColor = UIColor(named: "ShadowColor")
    }
    
    
    func easyLogIn() {
        let id = readLoginInfo(forKey: "id")
        let pw = readLoginInfo(forKey: "password")
        
        if !id.isEmpty {
            idTextField.text = id
        }
        if !pw.isEmpty {
            passwordTextField.text = pw
        }
    }
    
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        // id, pw 맞는지 확인
        if idTextField.text == readLoginInfo(forKey: "id"), passwordTextField.text == readLoginInfo(forKey: "password") {
            //  맞으면 다음 화면으로 이동
            ButtonManager.homeButtonTapped(viewController: self)
        } else {
            // 틀리면 alert창 띄워 경고
            let alert = UIAlertController(title: "가입하신 이메일 또는 비밀번호가 아닙니다.", message: "다시 입력해 주세요.", preferredStyle: .alert)
            let back = UIAlertAction(title: "돌아가기", style: .cancel, handler: nil)
            
            alert.addAction(back)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        eraseLogInTF()
        // 회원가입 화면으로 이동
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as? SignUpViewController else { return }
        self.present(signUpVC, animated: true, completion: nil)
    }
    
    
    @IBAction func kakaoLoginButtonTapped(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    _ = oauthToken
                }
            }
        }
    }
    
    
    func readLoginInfo(forKey: String) -> String {
        if let value = defaults.string(forKey: forKey) {
            return value
        } else { return "" }
    }
    
    
    func eraseLogInTF() {
        if idTextField.text != nil {
            idTextField.text = ""
        }
        if passwordTextField.text != nil {
            passwordTextField.text = ""
        }
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



extension UITextField {
    
    // 텍스트필드 왼쪽에 padding 주기
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

