//
//  MainViewController.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/30/24.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let mainvc = MainContentViewController()
    private let onAirVC = OnAirViewController()
    private let tvProgramVC = TVProgramViewController()
    private let movieVC = MovieViewController()
    private let paramountVC = ParamountViewController()
    
    private let segmentedControl = UnderlineSegmentedControl(items: ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"]).then {
        $0.backgroundColor = .clear
    }
    
    private let backgrounView = UIView().then {
        $0.backgroundColor = .clear
    }

    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                               navigationOrientation: .horizontal,
                                                               options: nil).then {
        $0.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
        $0.delegate = self
        $0.dataSource = self
    }

    var dataViewControllers: [UIViewController] {
        [mainvc, onAirVC, tvProgramVC, movieVC, paramountVC]
    }

    var currentPage: Int = 0 {
        didSet {
            let direction: UIPageViewController.NavigationDirection = oldValue <= self.currentPage ? .forward : .reverse
            self.pageViewController.setViewControllers(
                [dataViewControllers[self.currentPage]],
                direction: direction,
                animated: true,
                completion: nil
            )
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = true
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        mainvc.delegate = self
        setHierarchy()
        setLayout()
        setTarget()
        configureSegment()
    }

    private func setHierarchy() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.didMove(toParent: self)
        
        view.addSubview(segmentedControl)
        view.addSubview(backgrounView)
        
        view.bringSubviewToFront(backgrounView)
        view.bringSubviewToFront(segmentedControl)
    }
    
    private func setTarget() {
        segmentedControl.addTarget(self, action: #selector(changeValue(control:)), for: .valueChanged)
    }

    private func setLayout() {
        backgrounView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.snp.top)
            $0.height.equalTo(100)
        }
        
        segmentedControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.snp.top).offset(100)
            $0.height.equalTo(50)
        }

        pageViewController.view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.snp.top)
            $0.bottom.equalToSuperview()
        }
    }

    private func configureSegment() {
        segmentedControl.selectedSegmentIndex = 0
        changeValue(control: segmentedControl)
    }

    @objc private func changeValue(control: UISegmentedControl) {
      self.currentPage = control.selectedSegmentIndex
    }
}

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard
            let index = self.dataViewControllers.firstIndex(of: viewController),
            index - 1 >= 0
        else { return nil }
        return self.dataViewControllers[index - 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard
            let index = self.dataViewControllers.firstIndex(of: viewController),
            index + 1 < self.dataViewControllers.count
        else { return nil }
        return self.dataViewControllers[index + 1]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard
            let viewController = pageViewController.viewControllers?[0],
            let index = self.dataViewControllers.firstIndex(of: viewController)
        else { return }
        self.currentPage = index
        self.segmentedControl.selectedSegmentIndex = index
    }
}

extension MainViewController: MainContentViewControllerDelegate {
    func updateSegmentedControlBackgroundColor(_ isHidden: Bool) {
        segmentedControl.backgroundColor = isHidden ? .black : .clear
        backgrounView.backgroundColor = isHidden ? .black : .clear
        segmentedControl.snp.updateConstraints {
            $0.top.equalTo(self.view.snp.top).offset(isHidden ? 50 : 100)
        }
    }
}
