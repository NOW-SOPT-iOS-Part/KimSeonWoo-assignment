//
//  DetailViewController.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 5/10/24.
//

import UIKit
import SnapKit
import Then


final class DetailViewController: UIViewController {

    let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
    }
    
    private func setHierarchy() {
        view.addSubview(detailView)
    }
    
    private func setLayout() {
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setStyle() {
        view.roundCorners(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
}

