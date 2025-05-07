//
//  KimGahyunBestListCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

final class KimGahyunBestList: UITableViewCell {
    
    static var metric = Metric(itemSize: CGSize(width: 160, height: 90),
                               itemMinimumSpacing: 7,
                               itemMinimumInterSpacing: 0,
                               sectionInset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    
    // MARK: - Properties
    private var items: [ContentModel] = []
    
    static let identifier = "KimGahyunBestList"
    
    private let collectionViewHeader = TvingCollectionHeaderView().then {
        $0.configure(title: "김가현PD의 인생작 TOP 5")
        $0.backgroundColor = .black
    }
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = KimGahyunBestList.metric.itemMinimumSpacing
        $0.minimumInteritemSpacing = KimGahyunBestList.metric.itemMinimumInterSpacing
        $0.itemSize = KimGahyunBestList.metric.itemSize
        $0.sectionInset = KimGahyunBestList.metric.sectionInset
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(KimGahyunBestListCell.self, forCellWithReuseIdentifier: KimGahyunBestListCell.identifier)
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

extension KimGahyunBestList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KimGahyunBestListCell.identifier, for: indexPath) as? KimGahyunBestListCell else { return UICollectionViewCell() }
        cell.dataBind(item: items[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension KimGahyunBestList: ScrollEffectBehavior {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollToNearestItem(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
