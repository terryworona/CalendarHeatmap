//
//  CalendarHeatmapCell.swift
//  fill-it-up
//
//  Created by Dongjie Zhang on 1/31/20.
//  Copyright © 2020 Zachary. All rights reserved.
//

import UIKit

open class CalendarHeatmapCell: UICollectionViewCell {
    
    var shadowColor: UIColor?
    var shadowOpacity: Float?
    var shadowRadius: CGFloat?
    var shadowOffset: CGSize?
    var setShadow: Bool = false
    
    open var config: CalendarHeatmapConfig! {
        didSet {
            backgroundColor = config.backgroundColor
        }
    }
    
    open var itemColor: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    open override var isSelected: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    open override func draw(_ rect: CGRect) {
        let cornerRadius = config.itemCornerRadius
        let maxCornerRadius = min(bounds.width, bounds.height) * 0.5
        let path = UIBezierPath(roundedRect: rect, cornerRadius: min(cornerRadius, maxCornerRadius))
        itemColor.setFill()
        path.fill()
        
        self.updateShadowViews()
        
        guard isSelected, config.allowItemSelection else {
            return
        }
        config.selectedItemBorderColor.setStroke()
        path.lineWidth = config.selectedItemBorderLineWidth
        path.stroke()
    }
    
    func updateShadowViews() {
        if self.setShadow == true {
            return
        }
    
        if self.shadowColor != nil, self.shadowOpacity != nil, self.shadowRadius != nil, self.shadowOffset != nil {
            self.clipsToBounds = false
            self.layer.shadowColor = self.shadowColor!.cgColor
            self.layer.shadowOpacity = self.shadowOpacity!
            self.layer.shadowRadius = self.shadowRadius!
            self.layer.shadowOffset = self.shadowOffset!
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: min(config.itemCornerRadius, min(bounds.width, bounds.height) * 0.5)).cgPath
            self.setShadow = true
        }
    }
    
    // MARK: Traits
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setShadow = false
    }
}
