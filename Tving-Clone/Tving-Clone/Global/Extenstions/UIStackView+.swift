//
//  UIStackView+.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/30/24.
//

import UIKit

extension UIStackView {
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
