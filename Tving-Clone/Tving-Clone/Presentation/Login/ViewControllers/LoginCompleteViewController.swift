//
//  LoginCompleteViewController.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/16/24.
//

import UIKit
import SnapKit
import Then

class LoginCompleteViewController: UIViewController {
    private let loginCompleteView = LoginCompleteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        configTarget()
    }
    
    private func setHierarchy() {
        self.view.addSubview(loginCompleteView)
    }
    
    private func setLayout() {
        self.navigationController?.navigationBar.isHidden = true
        
        loginCompleteView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configTarget() {
        loginCompleteView.nextButton.addTarget(self,
                                              action: #selector(nextButtonTapped),
                                              for: .touchUpInside)
    }
    
    func bindData(nickName: String) {
        loginCompleteView.welcomeLabel.text = "\(nickName)님 안녕하세요!"
    }
}

extension LoginCompleteViewController {
    @objc private func nextButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
