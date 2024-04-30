//
//  MainContentView.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit
import SnapKit
import Then


final class MainContentView: UIView {
    
    var navigationBar = NavigationBarVIew().then {
        $0.isHidden = false
    }
    
    lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.getLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .black
    }
    
    private func setRegister() {
        mainCollectionView.register(MainCarouselCell.self,
                                    forCellWithReuseIdentifier: MainCarouselCell.identifier)
        mainCollectionView.register(LiveCell.self,
                                    forCellWithReuseIdentifier: LiveCell.identifier)
        mainCollectionView.register(MoviePosterCell.self,
                                    forCellWithReuseIdentifier: MoviePosterCell.identifier)
        mainCollectionView.register(AdvertiseCell.self,
                                    forCellWithReuseIdentifier: AdvertiseCell.identifier)
        mainCollectionView.register(MainHeaderView.self,
                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                    withReuseIdentifier: MainHeaderView.identifier)
    }
    
    static func getLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch MainSectionType.allCases[section] {
            case .MainCarousel:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(480)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
                return section
                
            case .Live:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(160),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(168 * 6),
                    heightDimension: .absolute(160)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(8)
                let section = NSCollectionLayoutSection(group: group)
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
                return section
                
            case .Advertise:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(58)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
                return section
                
                
            case .RecommendedContent, .Paramount, .MovieDictionary:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(98),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(106 * 6),
                    heightDimension: .absolute(160)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(8)
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [sectionHeader]
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
                return section
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setRegister()
    }
    
    private func setHierarchy() {
        self.addSubViews([mainCollectionView,navigationBar])
    }
    
    private func setLayout() {
        mainCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(ScreenUtils.getWidth(94))
        }
    }
}
