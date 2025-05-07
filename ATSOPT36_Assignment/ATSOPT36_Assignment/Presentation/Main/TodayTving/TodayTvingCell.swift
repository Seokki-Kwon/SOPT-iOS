//
//  TodayTvingCollectionCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/1/25.
//

import UIKit

import SnapKit

final class TodayTvingCell: UICollectionViewCell {        
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.image = UIImage(resource: .movie1)
    }
    
    private let rankingLabel = UIImageView().then {
        $0.image = UIImage(resource: .number1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {      
        [rankingLabel, imageView].forEach {
            contentView.addSubview($0)
        }
        
        rankingLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.leading.equalTo(rankingLabel.snp.trailing).offset(10)
            $0.top.trailing.bottom.equalToSuperview()
        }
        
    }
}

extension TodayTvingCell {
    func dataBind(index: Int, _ item: ContentModel) {
        imageView.image = item.thumbnail        
        rankingLabel.image = UIImage(named: "number\(index + 1)")
    }
}
