//
//  MainHeaderView.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit
import SnapKit
import Then

final class MainHeaderView: UICollectionReusableView {
    static let identifier: String = "MainHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.text = "티빙에서 꼭 봐야하는 컨텐츠"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .pretendedRegularFont(ofSize: 15)
    }
    
    lazy var arrowButton = UIButton().then {
        $0.setTitle("전체보기 >", for: .normal)
        $0.setTitleColor(.gray3, for: .normal)
        $0.titleLabel?.font = .pretendedRegularFont(ofSize: 11)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setHierarchy()
        setLayout()
    }
    
    private func setHierarchy() {
        self.addSubViews([titleLabel, arrowButton])
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        arrowButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    func bindData(data: MainData) {
        titleLabel.text = data.title
    }
}
