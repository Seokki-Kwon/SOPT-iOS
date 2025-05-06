//
//  SportCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

import SnapKit

final class SportChannelCell: UICollectionViewCell {
    
    static let identifier = "SportChannelCell"
    
    private let imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.image = UIImage(resource: .sport2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setLayout()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.backgroundColor = .gray5
        contentView.layer.cornerRadius = 4
    }
    
    private func addSubView() {
        contentView.addSubview(imageView)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension SportChannelCell {
    func dataBind(item: ContentModel) {
        imageView.image = item.thumbnail        
    }
}
