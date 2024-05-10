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
    
    private var mainData: [MainDataModel] = [] {
        didSet {
            rootView.mainCollectionView.reloadData()
        }
    }
    
    private var detailData: DetailDataModel = DetailDataModel(title: "", openDt: "", directors: "", actors: "", audits: "", companys: "")
    
    
    weak var delegate: MainContentViewControllerDelegate?
    
    private let rootView = MainContentView()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        requestMovieInfo()
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
    
    @objc private func handleCellTap(code: String) {
        requestDetailInfo(code: code)
        let detailViewController = DetailViewController()
        detailViewController.detailView.configure(with: detailData)
        if let presentationController = detailViewController.presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
        }
        detailViewController.modalPresentationStyle = .formSheet
        self.present(detailViewController, animated: true)
    }
}

extension MainContentViewController: UICollectionViewDelegate {}

extension MainContentViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mainData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch MainSectionType.allCases[section] {
        case .MainCarousel:
            return 1
        default:
            return mainData[section].data.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = rootView.mainCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainHeaderView.identifier, for: indexPath) as? MainHeaderView else {return UICollectionReusableView()}
            switch MainSectionType.allCases[indexPath.section] {
            case .RecommendedContent:
                header.titleLabel.text = "티빙에서 꼭 봐야하는 콘텐츠"
            case .Live:
                header.titleLabel.text = "인기 LIVE 채널"
            case .Paramount:
                header.titleLabel.text = "1화 무료! 파라마운트+ 인기 시리즈"
            case .MovieDictionary:
                header.titleLabel.text = "마술보다 더 신비로운 영화(신비로운 영화사전님)"
            default:
                break
            }
            
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch MainSectionType.allCases[indexPath.section] {
        case .MainCarousel:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: MainCarouselCell.identifier, for: indexPath) as? MainCarouselCell else { return UICollectionViewCell()}
            
            let cellData = mainData[indexPath.section]
            cell.bindData(data: cellData)
            return cell
        case .Live:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: LiveCell.identifier, for: indexPath) as? LiveCell else { return UICollectionViewCell()}
            
            let cellData = (mainData[indexPath.section].data[indexPath.row])
            cell.bindData(data: cellData, rank: indexPath.row + 1)
            return cell
            
        case .Advertise:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: AdvertiseCell.identifier, for: indexPath) as? AdvertiseCell else { return UICollectionViewCell()}
            
            return cell
            
        case .RecommendedContent, .Paramount, .MovieDictionary:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.identifier, for: indexPath) as? MoviePosterCell else { return UICollectionViewCell()}
            
            let cellData = mainData[indexPath.section].data[indexPath.row]
            cell.bindData(data: cellData)
            cell.delegate = self
            return cell
        }
    }
    
    private func requestMovieInfo() {
        MovieService.shared.getMovieInfo { [weak self] response in
            switch response {
            case .success(let data):
                if let data = data as? [MainDataModel] {
                    self?.mainData = data
                }
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
    
    private func requestDetailInfo(code: String) {
        MovieService.shared.getDetailInfo(code: code) { [weak self] response in
            switch response {
            case .success(let data):
                if let data = data as? DetailDataModel {
                    self?.detailData = data
                }
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
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

extension MainContentViewController: MainContentCellDelegate {
    func cellDidTap(code: String) {
        handleCellTap(code: code)
    }
}
