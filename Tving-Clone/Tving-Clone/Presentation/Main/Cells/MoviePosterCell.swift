//
//  MoviePosterCell.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit
import SnapKit
import Then

protocol MainContentCellDelegate: AnyObject {
    func cellDidTap(code: String)
}

final class MoviePosterCell: UICollectionViewCell {
    static let identifier: String = "MoviePosterCell"
    
    weak var delegate: MainContentCellDelegate?
    private var codeNumber: String = ""
    
    private lazy var movieImage = UIImageView().then {
        $0.image = .poster1
    }
    private let movieTitle = UILabel().then {
        $0.text = "시그널"
        $0.font = .pretendedRegularFont(ofSize: 10)
        $0.textColor = .gray2
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setHierarchy()
        setLayout()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func setHierarchy() {
        self.addSubViews([movieImage, movieTitle])
    }
    
    private func setLayout() {
        movieImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(146)
        }
        
        movieTitle.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
    }
    
    func bindData(data: MainData) {
        movieImage.image = data.image
        movieTitle.text = data.title
        codeNumber = data.ratio
    }
    
    @objc private func handleTap() {
        delegate?.cellDidTap(code: codeNumber)
    }
}
