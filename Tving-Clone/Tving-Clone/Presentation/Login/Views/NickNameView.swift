//
//  NickNameVIew.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/17/24.
//

import UIKit
import SnapKit
import Then

class NickNameView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.font = .pretendedRegularFont(ofSize: 24)
        $0.textColor = .black
        $0.text = "닉네임을 입력해주세요."
    }
    
    lazy var saveButton = UIButton().then {
        $0.setButtonBorder(radius: 5, borderWidht: 1, borderColor: UIColor.gray2.cgColor)
        $0.setTitle("저장하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .pretendedRegularFont(ofSize: 14)
        $0.backgroundColor = .red
    }
    
    var nickNameTextField = UITextField().then {
        $0.setPlaceholder(placeholder: "아요짱", fontColor: .black, font: .pretendedRegularFont(ofSize: 14))
        $0.backgroundColor = .gray2
        $0.layer.cornerRadius = 3
        $0.setLeftPaddingPoints(15)
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
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(40)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
            $0.height.equalTo(53)
        }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(335)
            $0.height.equalTo(53)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setHierarchy() {
        self.addSubViews([titleLabel, saveButton, nickNameTextField])
    }
    
    private func setStyle() {
        self.backgroundColor = .white
    }
}


