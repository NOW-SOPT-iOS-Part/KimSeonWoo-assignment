//
//  AdvertiseCell.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit
import SnapKit
import Then

final class AdvertiseCell: UICollectionViewCell {
    static let identifier: String = "AdvertiseCell"
    
    private lazy var carouselImageView = UIImageView().then {
        $0.image = .advertise
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addSubview(carouselImageView)
        setLayout()
    }
    
    private func setLayout() {
        carouselImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
