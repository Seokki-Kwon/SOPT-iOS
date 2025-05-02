//
//  KimGahyunBestListCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

final class KimGahyunBestListCell: UITableViewCell {
    
    enum Metric {
        static let itemSize: CGSize = CGSize(width: 160, height: 90)
        static let itemMinimumSpacing: CGFloat = 7
        static let itemMinimumInterSpacing: CGFloat = 0
        static let sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    // MARK: - Properties
    private var items: [ContentModel] = []
    
    static let identifier = "KimGahyunBestListCell"
    
    private let collectionViewHeader = TvingCollectionHeaderView().then {
        $0.configure(title: "김가현PD의 인생작 TOP 5")
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
        $0.register(KimGahyunBestCell.self, forCellWithReuseIdentifier: KimGahyunBestCell.identifier)
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

extension KimGahyunBestListCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KimGahyunBestCell.identifier, for: indexPath) as? KimGahyunBestCell else { return UICollectionViewCell() }
        cell.dataBind(item: items[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension KimGahyunBestListCell: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !scrollView.isDragging {
            let scrollOffset = scrollView.contentOffset.x
            let rawIndex = scrollOffset / Metric.itemSize.width
            let index: CGFloat
            index = rawIndex - floor(rawIndex) > 0.7 ? CGFloat(Int(rawIndex + 1)) : CGFloat(Int(rawIndex))
            let offset = (index * Metric.itemSize.width) + (index * Metric.itemMinimumSpacing)
            targetContentOffset.pointee = CGPoint(x: offset, y: scrollView.contentInset.top)
        }
    }
}
