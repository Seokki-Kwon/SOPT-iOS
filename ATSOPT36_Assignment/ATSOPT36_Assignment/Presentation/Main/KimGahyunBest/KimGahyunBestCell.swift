//
//  KimGahyunBestCcell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

import SnapKit

final class KimGahyunBestCell: UICollectionViewCell {
    
    static let identifier = "KimGahyunBestCell"
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.image = UIImage(resource: .poupluar1)
        $0.backgroundColor = .yellow
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
        [imageView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {
       
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

