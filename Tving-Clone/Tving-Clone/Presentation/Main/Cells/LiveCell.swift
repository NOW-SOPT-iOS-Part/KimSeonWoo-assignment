//
//  LiveCell.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit
import SnapKit
import Then

final class LiveCell: UICollectionViewCell {
    static let identifier: String = "LiveCell"
    
    private let liveImageView = UIImageView().then {
        $0.image = .tivingTitle
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let rankLabel = UILabel().then {
        $0.font = .pretendedRegularFont(ofSize: 20)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    private let makerLabel = UILabel().then {
        $0.font = .pretendedRegularFont(ofSize: 10)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = .pretendedRegularFont(ofSize: 10)
        $0.textColor = .gray2
        $0.textAlignment = .left
    }
    
    private let ratioLabel = UILabel().then {
        $0.font = .pretendedRegularFont(ofSize: 10)
        $0.textColor = .gray2
        $0.textAlignment = .left
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setHierachy()
        setLayout()
    }
    
    private func setHierachy() {
        self.addSubViews([liveImageView, rankLabel, stackView])
        stackView.addArrangedSubviews(makerLabel, subTitleLabel, ratioLabel)
    }
    
    private func setLayout() {
        liveImageView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(58)
        }

        rankLabel.snp.makeConstraints {
            $0.top.equalTo(liveImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(8)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(liveImageView.snp.bottom).offset(10)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
    
    func bindData(data: ContentData, rank: Int) {
        liveImageView.image = UIImage(named: data.image)
        rankLabel.text = "\(rank)"
        makerLabel.text = data.maker
        subTitleLabel.text = data.subTitle
        ratioLabel.text = data.ratio
    }
}
