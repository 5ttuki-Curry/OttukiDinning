//
//  SignUpViewController.swift
//  OttukiDinning
//
//  Created by 박준영 on 4/22/24.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var setPasswordTextField: UITextField!
    @IBOutlet weak var setPwLabel: UILabel!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var checkPwLabel: UILabel!
    @IBOutlet weak var makeAccountButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.delegate = self
        emailTextField.delegate = self
        setPasswordTextField.delegate = self
        checkPasswordTextField.delegate = self
        
        configureUI()
        
        // 텍스트입력할 때마다 감지
        self.nicknameTextField.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        self.setPasswordTextField.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
        self.checkPasswordTextField.addTarget(self, action: #selector(self.TFdidChanged(_:)), for: .editingChanged)
    }
     
    
    func configureUI() {
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        nicknameTextField.layer.cornerRadius = 15
        nicknameTextField.addLeftPadding()
        nicknameTextField.placeholder = "닉네임을 입력하세요"
        nicknameTextField.keyboardType = .emailAddress
        nicknameTextField.returnKeyType = .next
        nicknameTextField.clearButtonMode = .always
        nicknameTextField.autocorrectionType = .no
        nicknameTextField.spellCheckingType = .no
        
        nicknameLabel.text = "숫자, 대소문자 4~14자 이내로 작성 가능"
        
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        emailTextField.layer.cornerRadius = 15
        emailTextField.addLeftPadding()
        emailTextField.placeholder = "이메일 주소를 입력하세요"
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .next
        emailTextField.clearButtonMode = .always
        emailTextField.autocorrectionType = .no
        emailTextField.spellCheckingType = .no
        
        setPasswordTextField.layer.borderWidth = 1
        setPasswordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        setPasswordTextField.layer.cornerRadius = 15
        setPasswordTextField.addLeftPadding()
        setPasswordTextField.placeholder = "패스워드를 입력하세요"
        setPasswordTextField.keyboardType = .emailAddress
        setPasswordTextField.returnKeyType = .next
        setPasswordTextField.clearButtonMode = .always
        setPasswordTextField.autocorrectionType = .no
        setPasswordTextField.spellCheckingType = .no
        setPasswordTextField.isSecureTextEntry = true
        setPasswordTextField.textContentType = .oneTimeCode
        
        setPwLabel.text = "숫자, 대소문자, _, %, +, -, 6~12자 이내로 작성 가능"
        
        checkPasswordTextField.layer.borderWidth = 1
        checkPasswordTextField.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        checkPasswordTextField.layer.cornerRadius = 15
        checkPasswordTextField.addLeftPadding()
        checkPasswordTextField.placeholder = "패스워드를 한 번 더 입력하세요"
        checkPasswordTextField.keyboardType = .emailAddress
        checkPasswordTextField.returnKeyType = .done
        checkPasswordTextField.clearButtonMode = .always
        checkPasswordTextField.autocorrectionType = .no
        checkPasswordTextField.spellCheckingType = .no
        checkPasswordTextField.isSecureTextEntry = true
        checkPasswordTextField.textContentType = .oneTimeCode
        
        makeAccountButton.layer.borderWidth = 1
        makeAccountButton.layer.borderColor = UIColor(named: "ShadowColor")?.cgColor
        makeAccountButton.layer.cornerRadius = 15
        makeAccountButton.backgroundColor = UIColor(named: "MainColor")
        makeAccountButton.setTitle("회원가입하기", for: .normal)
        makeAccountButton.setTitleColor(.black, for: .normal)
        makeAccountButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        makeAccountButton.isEnabled = false
    }
    
    
    @IBAction func makcAccountButtonTapped(_ sender: UIButton) {
        // 데이터(이메일, 패스워드) 저장하기
        defaults.set(nicknameTextField.text, forKey: "nickname")
        defaults.set(emailTextField.text, forKey: "id")
        defaults.set(setPasswordTextField.text, forKey: "password")
        
        // 로그인 화면으로 돌아가기
        self.dismiss(animated: true, completion: nil)
        view.snapshotView(afterScreenUpdates: true)
    }
    
    // 닉네임 형식 확인
    func checkNickname(str: String) -> Bool {
        let nicknameRegex = "[A-Z0-9a-z]{4,14}"
        return  NSPredicate(format: "SELF MATCHES %@", nicknameRegex).evaluate(with: str)
    }
    
    // 이메일 형식 확인
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
    
    // 비밀번호 형식 확인
    func checkPassword(str: String) -> Bool {
        let pwRegex = "[A-Z0-9a-z._%+-]{6,12}"
        return NSPredicate(format: "SELF MATCHES %@", pwRegex).evaluate(with: str)
    }
    
    //두 텍스트필드 문자가 같은 지 확인
    func isSameBothTextField(_ first: UITextField,_ second: UITextField) -> Bool {
        if first.text == second.text {
            return true
        } else {
            return false
        }
    }
    
    //텍스트 필드 입력값 변하면 유효성 검사
    @objc func TFdidChanged(_ sender: UITextField) {
        
        switch sender {
        case nicknameTextField:
            guard let tf = nicknameTextField.text else { return }
            
            if checkNickname(str: tf) {
                nicknameLabel.text = "사용 가능한 닉네임입니다."
            } else {
                nicknameLabel.text = "닉네임을 정확히 입력해 주세요."
            }
        case emailTextField:
            guard let tf = emailTextField.text else { return }
            
            if checkEmail(str: tf) {
                emailLabel.text = "올바른 형식의 이메일입니다."
            } else {
                emailLabel.text = "이메일 주소를 정확히 입력해 주세요."
            }
        case setPasswordTextField:
            guard let tf = setPasswordTextField.text else { return }
            
            if checkPassword(str: tf) {
                setPwLabel.text = "안전한 비밀번호입니다."
            } else {
                setPwLabel.text = "비밀번호를 정확히 입력해 주세요."
            }
        case checkPasswordTextField:
            if isSameBothTextField(setPasswordTextField, checkPasswordTextField) {
                checkPwLabel.text = "처음 입력한 비밀번호와 일치합니다."
            } else {
                checkPwLabel.text = "처음 입력한 비밀번호와 다릅니다."
            }
        default:
            break
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
        
        if textField === nicknameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField === emailTextField {
            setPasswordTextField.becomeFirstResponder()
        } else if textField === setPasswordTextField {
            checkPasswordTextField.becomeFirstResponder()
        } else if textField === checkPasswordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // 텍스트필드 입력값 유효하면 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nicknameLabel.text == "사용 가능한 닉네임입니다.",
            emailLabel.text == "올바른 형식의 이메일입니다.",
           setPwLabel.text == "안전한 비밀번호입니다.",
           checkPwLabel.text == "처음 입력한 비밀번호와 일치합니다." {
            makeAccountButton.isEnabled = true
        }
    }
    
}

    

