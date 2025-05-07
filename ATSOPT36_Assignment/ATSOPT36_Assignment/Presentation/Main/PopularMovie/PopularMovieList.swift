//
//  PopularMovieListCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

final class PopularMovieList: UITableViewCell {
    
    static var metric = Metric(itemSize:  CGSize(width: 98, height: 146),
                               itemMinimumSpacing: 8,
                               itemMinimumInterSpacing: 0,
                               sectionInset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    
    // MARK: - Properties
    private var items: [ContentModel] = []
    
    static let identifier = "PopularMovieList"
    
    private let collectionViewHeader = TvingCollectionHeaderView().then {
        $0.configure(title: "실시간 인기 영화")
        $0.backgroundColor = .black
    }
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = PopularMovieList.metric.itemMinimumSpacing
        $0.minimumInteritemSpacing = PopularMovieList.metric.itemMinimumInterSpacing
        $0.itemSize = PopularMovieList.metric.itemSize
        $0.sectionInset = PopularMovieList.metric.sectionInset
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(PopularMovieCell.self, forCellWithReuseIdentifier: PopularMovieCell.identifier)
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

extension PopularMovieList: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCell.identifier, for: indexPath) as? PopularMovieCell else { return UICollectionViewCell() }
        cell.dataBind(item: items[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PopularMovieList: ScrollEffectBehavior {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollToNearestItem(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
