//
//  ScrollEffectBehavior.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/7/25.
//

import UIKit

struct Metric {
    var itemSize: CGSize
    var itemMinimumSpacing: CGFloat
    var itemMinimumInterSpacing: CGFloat
    var sectionInset: UIEdgeInsets
}

protocol ScrollEffectBehavior: UICollectionViewDelegateFlowLayout {
    static var metric: Metric { get set }    
    
    func scrollToNearestItem(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
}

extension ScrollEffectBehavior {
    func scrollToNearestItem(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !scrollView.isDragging {
            let scrollOffset = scrollView.contentOffset.x            
            let rawIndex = scrollOffset / Self.metric.itemSize.width
            let index: CGFloat
            index = rawIndex - floor(rawIndex) > 0.7 ? CGFloat(Int(rawIndex + 1)) : CGFloat(Int(rawIndex))
            let offset = (index * Self.metric.itemSize.width) + (index * Self.metric.itemMinimumSpacing)
            targetContentOffset.pointee = CGPoint(x: offset, y: scrollView.contentInset.top)
        }
    }
}


