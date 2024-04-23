//
//  SignUpViewController.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/22/24.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var setPasswordTextField: UITextField!
    @IBOutlet weak var setPwLabel: UILabel!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var checkPwLabel: UILabel!
    @IBOutlet weak var makeAccountButton: UIButton!
    
    // 카카오로 시작 버튼 구현 여부는 추후 결정
    
    let defaults = UserDefaults.standard
    var valueCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        setPasswordTextField.delegate = self
        checkPasswordTextField.delegate = self
        
        configureUI()
    }
    
    
    func configureUI() {
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        emailTextField.layer.cornerRadius = 15
        emailTextField.placeholder = " 이메일 주소를 입력하세요"
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .next
        emailTextField.clearButtonMode = .always
        
        setPasswordTextField.layer.borderWidth = 1
        setPasswordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        setPasswordTextField.layer.cornerRadius = 15
        setPasswordTextField.placeholder = " 패스워드를 입력하세요"
        setPasswordTextField.keyboardType = .emailAddress
        setPasswordTextField.returnKeyType = .next
        setPasswordTextField.clearButtonMode = .always
        setPasswordTextField.isSecureTextEntry = true
        setPasswordTextField.textContentType = .oneTimeCode
        
        checkPasswordTextField.layer.borderWidth = 1
        checkPasswordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        checkPasswordTextField.layer.cornerRadius = 15
        checkPasswordTextField.placeholder = " 패스워드를 한 번 더 입력하세요"
        checkPasswordTextField.keyboardType = .emailAddress
        checkPasswordTextField.returnKeyType = .done
        checkPasswordTextField.clearButtonMode = .always
        checkPasswordTextField.isSecureTextEntry = true
        checkPasswordTextField.textContentType = .oneTimeCode
        
        makeAccountButton.layer.borderWidth = 1
        makeAccountButton.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        makeAccountButton.layer.cornerRadius = 15
        makeAccountButton.backgroundColor = UIColor(named: "MainColor")
        makeAccountButton.setTitle("회원가입하기", for: .normal)
        makeAccountButton.setTitleColor(.black, for: .normal)
        makeAccountButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
    
    
    @IBAction func makcAccountButtonTapped(_ sender: UIButton) {
        if valueCount == 3 {
            valueCount = 0
            // 데이터(이메일, 패스워드) 저장하기
            defaults.set(emailTextField.text, forKey: "id")
            defaults.set(setPasswordTextField.text, forKey: "password")
            
            // 로그인 화면으로 돌아가기
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension SignUpViewController: UITextFieldDelegate {
    
    //빈 화면 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // 엔터키 누르면 다음으로 넘어가다가 마지막에 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTextField {
            setPasswordTextField.becomeFirstResponder()
        } else if textField == setPasswordTextField {
            checkPasswordTextField.becomeFirstResponder()
        } else if textField == checkPasswordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    // 입력값 조건과 맞는지 확인하기
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == emailTextField {
            guard let tf = emailTextField.text else { return false }
            
            if checkEmail(str: tf) {
                emailLabel.text = "올바른 형식의 이메일입니다."
                valueCount += 1
            } else {
                emailLabel.text = "이메일 주소를 정확히 입력해 주세요."
            }
        } else if textField == setPasswordTextField {
            guard let tf = setPasswordTextField.text else { return false }
            
            if checkPassword(str: tf) {
                setPwLabel.text = "안전한 비밀번호입니다."
                valueCount += 1
            } else {
                setPwLabel.text = "비밀번호를 정확히 입력해 주세요."
            }
        } else if textField == checkPasswordTextField {
            guard let tf = setPasswordTextField.text else { return false }
            print(tf, checkPasswordTextField.text)
            print(string)
            print(textField.text)
            if checkPasswordTextField.text! + string == tf {
                checkPwLabel.text = "처음 입력한 비밀번호와 일치합니다."
                valueCount += 1
            } else {
                checkPwLabel.text = "처음 입력한 비밀번호와 다릅니다."
            }
        }
        return true
    }
    
   
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
    
    
    func checkPassword(str: String) -> Bool {
        let pwRegex = "[A-Z0-9a-z._%+-]{4,12}"
        return NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: str)
    }
    
}
