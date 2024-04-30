//
//  NavigationBarVIew.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit
import SnapKit
import Then

final class NavigationBarVIew: UIView {
    
    private let logoImageView = UIImageView().then {
        $0.image = .tivingTitle
        $0.tintColor = .white
    }
    
    private let profileImageView = UIImageView().then {
        $0.image = .profile
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
    }
    
    private func setHierarchy() {
        self.addSubViews([logoImageView, profileImageView])
    }
    
    private func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(11)
            $0.width.equalTo(100)
            $0.height.equalTo(25)
        }
        
        profileImageView.snp.makeConstraints {
             $0.centerY.equalTo(self.logoImageView)
             $0.trailing.equalToSuperview().inset(9)
             $0.width.height.equalTo(33)
         }
    }
}
