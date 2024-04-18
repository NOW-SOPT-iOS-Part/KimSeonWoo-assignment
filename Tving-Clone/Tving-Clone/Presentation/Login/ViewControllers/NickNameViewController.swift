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
        setDelegate()
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
    
    private func setDelegate() {
        nickNameView.nickNameTextField.delegate = self
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

extension NickNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let koreanRegex =  "^[가-힣ㄱ-ㅎㅏ-ㅣ]$"
        let range = NSRange(location: 0, length: string.utf16.count)
        let regex = try! NSRegularExpression(pattern: koreanRegex)
        if regex.firstMatch(in: string, options: [], range: range) != nil {
            print("문자열이 한글만 포함됩니다.")
            return true
        } else {
            print("문자열에 한글 이외의 문자가 포함되어 있습니다.")
            return false
        }
    }
}







