//
//  MainViewController.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit
import SnapKit

protocol MainContentViewControllerDelegate: AnyObject {
    func updateSegmentedControlBackgroundColor(_ isHidden: Bool)
}

final class MainContentViewController: UIViewController {
    
    weak var delegate: MainContentViewControllerDelegate?
    
    private let rootView = MainContentView()
    private let data = MainDataModel.dummy()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setTarget()
    }
    
    private func setHierarchy() {
        view.addSubViews([rootView])
    }
    
    private func setTarget() {
        rootView.mainCollectionView.delegate = self
        rootView.mainCollectionView.dataSource = self
    }
    
    private func setLayout() {
        rootView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MainContentViewController: UICollectionViewDelegate {}

extension MainContentViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch MainSectionType.allCases[section] {
        case .MainCarousel:
            return 1
        default:
            return data[section].data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = rootView.mainCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainHeaderView.identifier, for: indexPath) as? MainHeaderView else {return UICollectionReusableView()}
            
            return header

        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MainSectionType.allCases[indexPath.section] {
        case .MainCarousel:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: MainCarouselCell.identifier, for: indexPath) as? MainCarouselCell else { return UICollectionViewCell()}
            
            let cellData = data[indexPath.section]
            cell.bindData(data: cellData)
            return cell
        case .Live:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: LiveCell.identifier, for: indexPath) as? LiveCell else { return UICollectionViewCell()}
            
            let cellData = data[indexPath.section].data[indexPath.row]
            cell.bindData(data: cellData, rank: indexPath.row)
            return cell
            
        case .Advertise:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: AdvertiseCell.identifier, for: indexPath) as? AdvertiseCell else { return UICollectionViewCell()}
            
            return cell
            
        case .RecommendedContent, .Paramount, .MovieDictionary:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.identifier, for: indexPath) as? MoviePosterCell else { return UICollectionViewCell()}
            
            let cellData = data[indexPath.section].data[indexPath.row]
            cell.bindData(data: cellData)
            return cell
        }
    }
}

extension MainContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navigationBarHidden = scrollView.contentOffset.y > 0
        rootView.navigationBar.isHidden = navigationBarHidden
        delegate?.updateSegmentedControlBackgroundColor(navigationBarHidden)
    }
}
