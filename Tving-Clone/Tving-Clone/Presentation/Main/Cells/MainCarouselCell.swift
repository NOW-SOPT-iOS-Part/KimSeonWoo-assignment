//
//  MainCarouselCell.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit

import SnapKit
import Then

final class MainCarouselCell: UICollectionViewCell {
    static let identifier: String = "MainCarouselCell"
    
    private var timer: Timer?
    private var currentPage: Int = 0
    private var totalPage: Int = 0
    private var pageViews: [UIImageView] = []
    
    let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let pageControl = UIPageControl().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.currentPage = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setDelegate()
        startAutoScroll()
    }
    
    deinit {
        stopAutoScroll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegate() {
        scrollView.delegate = self
    }
    
    private func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        self.addSubViews([scrollView, pageControl])
        for pageView in pageViews {
            scrollView.addSubview(pageView)
        }
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().offset(-60)
            $0.height.equalTo(498)
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        for (index, pageView) in pageViews.enumerated() {
            pageView.snp.makeConstraints {
                $0.top.equalTo(scrollView.snp.top)
                $0.size.equalTo(scrollView)
                $0.leading.equalTo(scrollView.snp.leading).offset(UIScreen.main.bounds.width * CGFloat(index))
            }
        }
    }
    
    func bindData(data: MainDataModel) {
        pageViews.removeAll()
        totalPage = data.data.count
        pageControl.numberOfPages = totalPage
        scrollView.contentSize = CGSize(width: (375 * totalPage), height: 498)
        for i in 0..<totalPage {
            let pageView = UIImageView().then {
                $0.image = data.data[i].image
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 3
            }
            pageViews.append(pageView)
        }
        setHierarchy()
        setConstraints()
    }

    private func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func nextPage() {
        currentPage = (currentPage + 1) % totalPage
        scrollView.setContentOffset(CGPoint(x: (UIScreen.main.bounds.width * CGFloat(currentPage)), y: 0), animated: true)
        pageControl.currentPage = currentPage
    }
}

extension MainCarouselCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        pageControl.currentPage = currentPage
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAutoScroll()
    }
}
