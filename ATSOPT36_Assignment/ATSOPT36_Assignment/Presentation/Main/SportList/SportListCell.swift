//
//  SportListCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

final class SportListCell: UITableViewCell {
    
    enum Metric {
        static let itemSize: CGSize = CGSize(width: 90, height: 45)
        static let itemMinimumSpacing: CGFloat = 7
        static let itemMinimumInterSpacing: CGFloat = 0
        static let sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    // MARK: - Properties
    
    static let identifier = "SportListCell"
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = Metric.itemMinimumSpacing
        $0.minimumInteritemSpacing = Metric.itemMinimumInterSpacing
        $0.itemSize = Metric.itemSize
        $0.sectionInset = Metric.sectionInset
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(SportCell.self, forCellWithReuseIdentifier: SportCell.identifier)
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setting
    
    private func setUI() {
        [collectionView].forEach {
            contentView.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension SportListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportCell.identifier, for: indexPath) as? SportCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SportListCell: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !scrollView.isDragging {
            let scrollOffset = scrollView.contentOffset.x
            let rawIndex = scrollOffset / Metric.itemSize.width
            let indexRemain = Int(scrollOffset) % Int(Metric.itemSize.width)
            let index = indexRemain == 0 ? CGFloat(Int(rawIndex - 1)) : CGFloat(Int(rawIndex))
            let offsetX = (index * Metric.itemSize.width) + (index * Metric.itemMinimumSpacing)
            targetContentOffset.pointee = CGPoint(x: offsetX , y: scrollView.contentInset.top)
        }
    }
}
