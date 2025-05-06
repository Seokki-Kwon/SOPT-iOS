//
//  TvingCollectionHeaderView.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

import SnapKit

final class TvingCollectionHeaderView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.text = "이번주 인기"
        $0.font = .font(.pretendardBold, ofSize: 15)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(titleLabel)
        backgroundColor = .black
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
