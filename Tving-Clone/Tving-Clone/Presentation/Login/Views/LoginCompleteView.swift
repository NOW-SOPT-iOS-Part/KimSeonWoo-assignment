//
//  LoginCompleteView.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/16/24.
//

import UIKit
import SnapKit
import Then

class LoginCompleteView: UIView {
    
    var welcomeLabel = UILabel().then {
        $0.font = .pretendedMediumFont(ofSize: 23)
        $0.textColor = .gray84
        $0.text = "NowSopt님\n반가워요!"
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private let logoImage = UIImageView(image: .logo)
    
    lazy var nextButton = UIButton().then {
        $0.setButtonBorder(radius: 3, borderWidht: 1, borderColor: UIColor.gray2.cgColor)
        $0.setTitle("메인으로", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .pretendedRegularFont(ofSize: 14)
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
        logoImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.width.equalTo(335)
            $0.height.equalTo(53)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setHierarchy() {
        self.addSubViews([welcomeLabel, logoImage, nextButton])
    }
    
    private func setStyle() {}
    
}

