//
//  LoginViewController.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/8/24.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private var isEnabled = false
    private var nickName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        setDelegate()
        configAddTarget()
    }
    
    private func setHierarchy() {
        self.view.addSubview(loginView)
    }
    
    private func setLayout() {
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setStyle() {
        self.navigationController?.navigationBar.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setDelegate() {
        loginView.idTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    private func configAddTarget() {
        loginView.loginButton.addTarget(self,
                                        action: #selector(loginButtonTapped),
                                        for: .touchUpInside)
        
        loginView.makeNickNameButton.addTarget(self,
                                               action: #selector(nickNameButtonTapped),
                                               for: .touchUpInside)
        
        loginView.idTextField.addTarget(self,
                                        action: #selector(textFieldChanged),
                                        for: .editingChanged)
        
        loginView.passwordTextField.addTarget(self,
                                              action: #selector(textFieldChanged),
                                              for: .editingChanged)
        
        loginView.showPasswordButton.addTarget(self,
                                               action: #selector(showPassword),
                                               for: .touchUpInside)
        
        loginView.removePassWordButton.addTarget(self,
                                                 action: #selector(removePassWord),
                                                 for: .touchUpInside)
    }
}

extension LoginViewController {
    @objc private func loginButtonTapped() {
        let completeViewController = LoginCompleteViewController()
        if nickName == "" {
            completeViewController.bindData(nickName: loginView.idTextField.text ?? "")
        } else {
            completeViewController.bindData(nickName: nickName)
        }
        
        navigationController?.pushViewController(completeViewController, animated: true)
    }
    
    @objc private func nickNameButtonTapped() {
        let nickNameViewController = NickNameViewController()
        nickNameViewController.delegate = self
        if let presentationController = nickNameViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        nickNameViewController.modalPresentationStyle = .formSheet
        self.present(nickNameViewController, animated: true)
    }
        
    @objc private func textFieldChanged() {
        if let idText = loginView.idTextField.text,
           let passwordText = loginView.passwordTextField.text {
            if idText.isValidID() && passwordText.isValidPassword() {
                toggleButtonStatus(isValid: true)
            } else {
                toggleButtonStatus(isValid: false)
            }
        }
    }
    
    @objc private func showPassword() {
        loginView.passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc private func removePassWord() {
        loginView.passwordTextField.text = ""
    }
    
    private func toggleButtonStatus(isValid: Bool) {
        if isValid {
            loginView.loginButton.isEnabled = true
            loginView.loginButton.backgroundColor = .red
            loginView.loginButton.layer.borderWidth = 0
        } else {
            loginView.loginButton.isEnabled = false
            loginView.loginButton.backgroundColor = .clear
            loginView.loginButton.setButtonBorder(radius: 3, borderWidht: 1, borderColor: UIColor.gray2.cgColor)
        }
    }
}

extension LoginViewController: makeNickNameDelegate{
    func makeNickName(nickName: String) {
        self.nickName = nickName
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginView.idTextField {
            loginView.idTextField.layer.borderColor = UIColor.gray2.cgColor
        } else if textField == loginView.passwordTextField {
            loginView.passwordTextField.layer.borderColor = UIColor.gray2.cgColor
            loginView.showPasswordButton.isHidden = false
            loginView.removePassWordButton.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == loginView.idTextField {
            loginView.idTextField.layer.borderColor = UIColor.black.cgColor
        } else if textField == loginView.passwordTextField {
            loginView.passwordTextField.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.idTextField {
            loginView.passwordTextField.becomeFirstResponder()
        } else {
            loginView.passwordTextField.resignFirstResponder()
        }
        return true
    }
}

