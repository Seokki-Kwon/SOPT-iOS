//
//  ImageTableViewCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/1/25.
//

import UIKit

import SnapKit

final class ImageTableViewCell: UITableViewCell {        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        let imageView = UIImageView(image: UIImage(resource: .main))
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
