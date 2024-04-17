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
        setStyle()
        configTarget()
    }
    
    private func setHierarchy() {
        view.addSubview(nickNameView)
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
    
    private func setStyle() {
        view.roundCorners(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
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

