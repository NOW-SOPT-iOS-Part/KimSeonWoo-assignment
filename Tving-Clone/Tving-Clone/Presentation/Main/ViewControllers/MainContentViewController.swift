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
    
    private var viewModel: MainContentViewModel!
    
    weak var delegate: MainContentViewControllerDelegate?
    
    private let rootView = MainContentView()
    
    
    init(viewModel: MainContentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        viewModel.fetchContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setTarget()
        bindViewModel()
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
    
    private func bindViewModel() {
        viewModel.content.bind { [weak self] _ in
            self?.rootView.mainCollectionView.reloadData()
        }
        viewModel.contentDetail.bind { [weak self] detailData in
            guard let detailData = detailData else { return }
            let detailView = DetailView()
            detailView.configure(with: detailData)
            let detailViewController = DetailViewController(detailView: detailView)
            if let presentationController = detailViewController.presentationController as? UISheetPresentationController {
                presentationController.detents = [.medium()]
            }
            detailViewController.modalPresentationStyle = .formSheet
            self?.present(detailViewController, animated: true)
        }
    }
    
    @objc private func handleCellTap(code: String) {
        viewModel.fetchContentDetail(code: code)
    }
}

extension MainContentViewController: UICollectionViewDelegate {}

extension MainContentViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.content.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch MainSectionType.allCases[section] {
        case .MainCarousel:
            return 1
        default:
            return viewModel.content.value[section].data.count
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
            
            let cellData = viewModel.content.value[indexPath.section]
            cell.bindData(data: cellData)
            return cell
        case .Live:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: LiveCell.identifier, for: indexPath) as? LiveCell else { return UICollectionViewCell()}
            
            let cellData = (viewModel.content.value[indexPath.section].data[indexPath.row])
            cell.bindData(data: cellData, rank: indexPath.row + 1)
            return cell
            
        case .Advertise:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: AdvertiseCell.identifier, for: indexPath) as? AdvertiseCell else { return UICollectionViewCell()}
            
            return cell
            
        case .RecommendedContent, .Paramount, .MovieDictionary:
            guard let cell = rootView.mainCollectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.identifier, for: indexPath) as? MoviePosterCell else { return UICollectionViewCell()}
            
            let cellData = viewModel.content.value[indexPath.section].data[indexPath.row]
            cell.bindData(data: cellData)
            cell.delegate = self
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

extension MainContentViewController: MainContentCellDelegate {
    func cellDidTap(code: String) {
        handleCellTap(code: code)
    }
}
