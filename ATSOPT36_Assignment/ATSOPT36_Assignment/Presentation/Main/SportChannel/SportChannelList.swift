//
//  SportListCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

final class SportChannelList: UITableViewCell {
    
    static var metric = Metric(itemSize: CGSize(width: 90, height: 45),
                               itemMinimumSpacing: 7,
                               itemMinimumInterSpacing: 0,
                               sectionInset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    
    
    // MARK: - Properties
    
    private var items: [ContentModel] = []        
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = SportChannelList.metric.itemMinimumSpacing
        $0.minimumInteritemSpacing = SportChannelList.metric.itemMinimumInterSpacing
        $0.itemSize = SportChannelList.metric.itemSize
        $0.sectionInset = SportChannelList.metric.sectionInset
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(SportChannelCell.self, forCellWithReuseIdentifier: SportChannelCell.reuseIdentifier)
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
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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

extension SportChannelList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportChannelCell.reuseIdentifier, for: indexPath) as? SportChannelCell else { return UICollectionViewCell() }
        cell.dataBind(item: items[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SportChannelList: ScrollEffectBehavior {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollToNearestItem(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
