//
//  LoginView.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/8/24.
//

import UIKit
import SnapKit
import Then

class LoginView: UIView {
    private let titleLabel = UILabel().then {
        $0.font = .pretendedMediumFont(ofSize: 23)
        $0.textColor = .gray84
        $0.text = "TVING ID 로그인"
    }
    
    lazy var idTextField = UITextField().then {
        $0.setPlaceholder(placeholder: "아이디", fontColor: .gray2, font: .pretendedRegularFont(ofSize: 14))
        $0.backgroundColor = .gray4
        $0.layer.cornerRadius = 3
        $0.setLeftPaddingPoints(15)
        $0.layer.borderWidth = 1
        $0.clearButtonMode = .always
    }
    
    lazy var passwordTextField = UITextField().then {
        $0.setPlaceholder(placeholder: "비밀번호", fontColor: .gray2, font: .pretendedRegularFont(ofSize: 14))
        $0.backgroundColor = .gray4
        $0.layer.cornerRadius = 3
        $0.setLeftPaddingPoints(15)
        $0.isSecureTextEntry = true
        $0.layer.borderWidth = 1
    }
    
    lazy var loginButton = UIButton().then {
        $0.setButtonBorder(radius: 3, borderWidht: 1, borderColor: UIColor.gray2.cgColor)
        $0.setTitle("로그인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .pretendedRegularFont(ofSize: 14)
    }
    
    private lazy var findIDButton = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .pretendedRegularFont(ofSize: 14)
    }
    
    private lazy var findPassWordButton = UIButton().then {
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .pretendedRegularFont(ofSize: 14)
    }
    
    lazy var showPasswordButton = UIButton().then {
        $0.setImage(.eyeSlash, for: .normal)
    }
    
    lazy var removePassWordButton = UIButton().then {
        $0.setImage(.xCircle, for: .normal)
    }
    
    private let divideView = UIView().then {
        $0.backgroundColor = .gray4
    }
    
    private let accountSuggestionLabel = UILabel().then {
        $0.font = .pretendedMediumFont(ofSize: 14)
        $0.textColor = .gray3
        $0.text = "아직 계정이 없으신가요?"
    }
    
    lazy var makeNickNameButton = UIButton().then {
        $0.setTitle("닉네임 만들러가기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .pretendedRegularFont(ofSize: 14)
        $0.setUnderline()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        
        idTextField.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(52)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(52)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(idTextField.snp.bottom).offset(15)
        }
        
        loginButton.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(52)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextField.snp.bottom).offset(15)
        }
        
        divideView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(14)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
        }
        
        findIDButton.snp.makeConstraints {
            $0.centerY.equalTo(divideView)
            $0.trailing.equalTo(divideView.snp.leading).inset(-25)
        }
        
        findPassWordButton.snp.makeConstraints {
            $0.centerY.equalTo(divideView)
            $0.leading.equalTo(divideView.snp.trailing).inset(-25)
        }
        
        accountSuggestionLabel.snp.makeConstraints {
            $0.centerX.equalTo(findIDButton)
            $0.top.equalTo(divideView.snp.bottom).offset(15)
        }
        
        makeNickNameButton.snp.makeConstraints {
            $0.leading.equalTo(accountSuggestionLabel.snp.trailing).offset(15)
            $0.centerY.equalTo(accountSuggestionLabel)
        }
        
        removePassWordButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        showPasswordButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
            $0.trailing.equalTo(removePassWordButton.snp.leading).inset(-10)
        }
    }
    
    private func setHierarchy() {
        self.addSubViews([titleLabel, idTextField, passwordTextField, loginButton, findIDButton, findPassWordButton, divideView, accountSuggestionLabel, makeNickNameButton])
        
        passwordTextField.addSubViews([showPasswordButton, removePassWordButton])
    }
    
    private func setStyle() {}
}

