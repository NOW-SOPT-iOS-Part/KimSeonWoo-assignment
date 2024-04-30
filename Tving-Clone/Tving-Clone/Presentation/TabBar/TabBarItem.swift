//
//  TabBarItem.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/29/24.
//

import UIKit

enum TabBarItem: CaseIterable {
    case home, soon, search, timeline
}

extension TabBarItem {
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .soon:
            return "공계예정"
        case .search:
            return "검색"
        case .timeline:
            return "기록"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .soon:
            return UIImage(systemName: "video")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .timeline:
            return UIImage(systemName: "book")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")
        case .soon:
            return UIImage(systemName: "video.fill")
        case .search:
            return UIImage(systemName: "magnifyingglass.fill")
        case .timeline:
            return UIImage(systemName: "book.fill")
        }
    }
    
    var changedViewController: UIViewController? {
        switch self {
        case .home:
            MainViewController()
        case .soon:
            LoginViewController()
        case .search:
            LoginViewController()
        case .timeline:
            LoginViewController()
        }
    }
}

import UIKit

class ViewController: UIViewController {
  private let segmentedControl: UISegmentedControl = {
    let segmentedControl = UnderlineSegmentedControl(items: ["전체", "웹툰", "베스트도전"])
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()
  private let childView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private let vc1: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .red
    return vc
  }()
  private let vc2: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .green
    return vc
  }()
  private let vc3: UIViewController = {
    let vc = UIViewController()
    vc.view.backgroundColor = .blue
    return vc
  }()
  private lazy var pageViewController: UIPageViewController = {
    let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    vc.setViewControllers([self.dataViewControllers[0]], direction: .forward, animated: true)
    vc.delegate = self
    vc.dataSource = self
    vc.view.translatesAutoresizingMaskIntoConstraints = false
    return vc
  }()
  
  var dataViewControllers: [UIViewController] {
    [self.vc1, self.vc2, self.vc3]
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.segmentedControl)
    self.view.addSubview(self.pageViewController.view)
    
    NSLayoutConstraint.activate([
      self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.segmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
      self.segmentedControl.heightAnchor.constraint(equalToConstant: 50),
    ])
    NSLayoutConstraint.activate([
      self.pageViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 4),
      self.pageViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -4),
      self.pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -4),
      self.pageViewController.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 5),
    ])
    
    self.segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
    self.segmentedControl.setTitleTextAttributes(
      [
        NSAttributedString.Key.foregroundColor: UIColor.green,
        .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
      ],
      for: .selected
    )

  }
  
  @objc private func changeValue(control: UISegmentedControl) {
    self.currentPage = control.selectedSegmentIndex
  }
}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
