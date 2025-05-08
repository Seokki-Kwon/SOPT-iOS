//
//  SearchResultCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/8/25.
//

import UIKit

import SnapKit

final class SearchResultCell: UITableViewCell {
    
    private let searchLabel = UILabel().then {
        $0.text = "검색결과"
        $0.textColor = .white
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubview(searchLabel)
        
        searchLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
    }
    
}
