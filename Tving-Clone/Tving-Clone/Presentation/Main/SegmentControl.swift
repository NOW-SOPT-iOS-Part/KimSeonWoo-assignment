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
    
    private func updateUnderlinePosition() {
        guard numberOfSegments > 0, selectedSegmentIndex >= 0, selectedSegmentIndex < numberOfSegments else {
            return
        }

        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        let selectedSegmentWidth = calculateTextWidthForSegment(at: CGFloat(selectedSegmentIndex))
        let xOffset = (segmentWidth - selectedSegmentWidth) / 2

        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame = CGRect(
                x: xOffset + CGFloat(self.selectedSegmentIndex) * segmentWidth,
                y: self.bounds.height - 2,
                width: selectedSegmentWidth,
                height: 2
            )
        }
    }

    private func calculateTextWidthForSegment(at index: CGFloat) -> CGFloat {
        guard let segmentTitle = self.titleForSegment(at: Int(index)) as NSString? else { return 0 }
        let attributes = [NSAttributedString.Key.font: UIFont.pretendedRegularFont(ofSize: 14)]
        let textWidth = segmentTitle.size(withAttributes: attributes).width
        return textWidth
    }
}
