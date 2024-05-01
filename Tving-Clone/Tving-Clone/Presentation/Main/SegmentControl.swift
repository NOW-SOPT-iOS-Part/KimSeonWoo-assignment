//
//  SegmentControl.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 4/30/24.
//

import UIKit
import SnapKit
import Then

final class UnderlineSegmentedControl: UISegmentedControl {
    private lazy var underlineView = UIView().then {
        $0.backgroundColor = .gray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.pretendedRegularFont(ofSize: 17),
            .foregroundColor: UIColor.white
        ]
        setTitleTextAttributes(attributes, for: .normal)
        setTitleTextAttributes(attributes, for: .selected)
        self.apportionsSegmentWidthsByContent = true
        
        self.addSubview(underlineView)
        removeBackgroundAndDivider()
    }

    private func removeBackgroundAndDivider() {
        let image = UIImage()
        setBackgroundImage(image, for: .normal, barMetrics: .default)
        setBackgroundImage(image, for: .selected, barMetrics: .default)
        setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUnderlinePosition()
    }
    
    var index:Int = 0
    var xOffset = 0.0
    
    private func updateUnderlinePosition() {
        guard numberOfSegments > 0, selectedSegmentIndex >= 0, selectedSegmentIndex < numberOfSegments else {
            return
        }
        
        if index > self.selectedSegmentIndex {
            xOffset -= calculateTextWidthForSegment(at: CGFloat(selectedSegmentIndex)) * 0.2 + 60.0
        } else {
            xOffset += calculateTextWidthForSegment(at: CGFloat(selectedSegmentIndex)) * 0.2 + 60.0
        }
        
        index = self.selectedSegmentIndex
        print(index)
        let selectedSegmentRect = self.calculateTextWidthForSegment(at: CGFloat(self.selectedSegmentIndex))

        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame = CGRect(
                x: self.calculateX(index: self.index),
                y: self.bounds.height - 2,
                width: self.calculateTextWidthForSegment(at: CGFloat(self.selectedSegmentIndex)),
                height: 2
            )
        }
    }
    
    private func calculateX(index: Int) -> CGFloat {
        switch index {
        case 0:
            return 10.0
        case 1:
            return 50.0
        case 2:
            return 130.0
        case 3:
            return 225.0
        case 4:
            return 280.0
        default:
            return 10.0
        }
    }

    private func calculateTextWidthForSegment(at index: CGFloat) -> CGFloat {
        guard let segmentTitle = self.titleForSegment(at: Int(index)) as NSString? else { return 0 }
        let attributes = [NSAttributedString.Key.font: UIFont.pretendedRegularFont(ofSize: 14)]
        let textWidth = segmentTitle.size(withAttributes: attributes).width
        return textWidth
    }
}
