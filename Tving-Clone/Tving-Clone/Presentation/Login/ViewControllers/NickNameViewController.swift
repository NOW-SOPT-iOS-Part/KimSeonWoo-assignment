//
//  NickNameViewController.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/17/24.
//

import UIKit
import SnapKit
import Then

protocol makeNickNameDelegate {
    func makeNickName(nickName: String)
}

class NickNameViewController: UIViewController {
    
    var delegate: makeNickNameDelegate?
    private let nickNameView = NickNameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        configTarget()
    }
    
    private func setHierarchy() {
        self.view.addSubview(nickNameView)
        view.roundCorners(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    private func setLayout() {
        nickNameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configTarget() {
        nickNameView.saveButton.addTarget(self,
                                              action: #selector(saveButtonTapped),
                                              for: .touchUpInside)
    }
}

extension NickNameViewController {
    @objc private func saveButtonTapped() {
        self.view.backgroundColor = .clear
        if let nickName = self.nickNameView.nickNameTextField.text {
            self.delegate?.makeNickName(nickName: nickName)
        }
        self.dismiss(animated: true)
    }
}

