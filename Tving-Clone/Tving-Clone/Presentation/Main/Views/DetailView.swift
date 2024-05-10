//
//  DetailView.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 5/10/24.
//

import UIKit
import SnapKit
import Then

final class DetailView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.font = .pretendedRegularFont(ofSize: 24)
        $0.textColor = .black
        $0.text = "상세 정보"
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    private func setHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(stackView)
    }
    
    private func setStyle() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(40)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    
    func configure(with detailData: DetailDataModel) {
        let detailDataList = [
            detailData.title,
            detailData.openDt,
            detailData.directors,
            detailData.actors,
            detailData.audits,
            detailData.companys
        ]
        
        for item in detailDataList {
            let label = UILabel().then {
                $0.font = .pretendedRegularFont(ofSize: 14)
                $0.textColor = .black
                $0.text = item
            }
            stackView.addArrangedSubview(label)
        }
    }
}

