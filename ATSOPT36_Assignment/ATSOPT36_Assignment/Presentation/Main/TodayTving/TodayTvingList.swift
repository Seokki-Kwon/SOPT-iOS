//
//  TodayTvingCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/1/25.
//

import UIKit

import SnapKit

final class TodayTvingList: UITableViewCell {
    
    // MARK: - Properties
    
    private var items: [ContentModel] = []
    
    static var metric = Metric(itemSize: CGSize(width: 150, height: 146),
                               itemMinimumSpacing: 11.0,
                               itemMinimumInterSpacing: 11.0,
                               sectionInset: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))        
    
    private let collectionViewHeader = TvingCollectionHeaderView().then {
        $0.configure(title: "오늘의 티빙 TOP 20")
        $0.backgroundColor = .black
    }
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = TodayTvingList.metric.itemMinimumSpacing
        $0.minimumInteritemSpacing = TodayTvingList.metric.itemMinimumInterSpacing
        $0.itemSize = TodayTvingList.metric.itemSize
        $0.sectionInset = TodayTvingList.metric.sectionInset
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(TodayTvingCell.self, forCellWithReuseIdentifier: TodayTvingCell.reuseIdentifier)
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
    
    func prepare(items: [ContentModel]) {
        self.items = items
    }
}

// MARK: - UICollectionViewDataSource

extension TodayTvingList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayTvingCell.reuseIdentifier, for: indexPath) as? TodayTvingCell else { return UICollectionViewCell() }
        cell.dataBind(index: indexPath.row, items[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout & ScrollEffectBehavior

extension TodayTvingList: ScrollEffectBehavior {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollToNearestItem(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}

