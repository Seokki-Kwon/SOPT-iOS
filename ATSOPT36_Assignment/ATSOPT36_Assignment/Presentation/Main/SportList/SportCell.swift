//
//  SportCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

import SnapKit

final class SportCell: UICollectionViewCell {
    
    static let identifier = "SportCell"
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.image = UIImage(resource: .sport2)
        $0.backgroundColor = .gray4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        contentView.addSubview(imageView)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

