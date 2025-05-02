//
//  TodayTvingCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/1/25.
//

import UIKit

import SnapKit

final class TodayTvingCell: UITableViewCell {
    
    enum Metric {
        static let itemSize: CGSize = CGSize(width: 150, height: 146)
        static let itemMinimumSpacing: CGFloat = 11.0
        static let itemMinimumInterSpacing: CGFloat = 11.0
        static let sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    // MARK: - Properties
    
    static let identifier = "TodayTvingCell"
    
    private let collectionViewHeader = TvingCollectionHeaderView().then {
        $0.configure(title: "오늘의 티빙 TOP 20")
        $0.backgroundColor = .black
    }
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = Metric.itemMinimumSpacing
        $0.minimumInteritemSpacing = Metric.itemMinimumInterSpacing
        $0.itemSize = Metric.itemSize
        $0.sectionInset = Metric.sectionInset
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(TodayTvingCollectionCell.self, forCellWithReuseIdentifier: TodayTvingCollectionCell.identifier)
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
        [collectionViewHeader, collectionView].forEach {
            contentView.addSubview($0)
        }
        
        collectionViewHeader.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(collectionViewHeader.snp.bottom)
        }
    }
    
    private func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension TodayTvingCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayTvingCollectionCell.identifier, for: indexPath) as? TodayTvingCollectionCell else { return UICollectionViewCell() }
        return cell
    }
}

extension TodayTvingCell: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !scrollView.isDragging {
            let scrollOffset = scrollView.contentOffset.x
            let rawIndex = scrollOffset / Metric.itemSize.width
            let indexRemain = Int(scrollOffset) % Int(Metric.itemSize.width)
            let index = indexRemain == 0 ? CGFloat(Int(rawIndex - 1)) : CGFloat(Int(rawIndex))
            targetContentOffset.pointee = CGPoint(x: (index * Metric.itemSize.width) + (index * Metric.itemMinimumSpacing) , y: scrollView.contentInset.top)
        }
    }
}
