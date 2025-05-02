//
//  PopularCollectionViewCell.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/2/25.
//

import UIKit

import SnapKit

final class PopularCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.image = UIImage(resource: .poupluar1)
        $0.backgroundColor = .yellow
    }
    
    private let rankLabel = UIImageView().then {
        $0.image = UIImage(resource: .number1)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "JTBC"
        $0.font = .font(.pretendardMedium, ofSize: 10)
        $0.textColor = .white
    }
    
    private let detailInfoLabel = UILabel().then {
        $0.text = "이혼숙려캠프 34화"
        $0.font = .font(.pretendardMedium, ofSize: 10)
        $0.textColor = .gray
    }
    
    private let latingLabel = UILabel().then {
        $0.text = "27.2%"
        $0.font = .font(.pretendardMedium, ofSize: 10)
        $0.textColor = .gray
    }
    
    private lazy var infoDetailView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(titleLabel)
        $0.addArrangedSubview(detailInfoLabel)
        $0.addArrangedSubview(latingLabel)
    }
    
    private let infoView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        [rankLabel, infoDetailView].forEach {
            infoView.addSubview($0)
        }
        [imageView, infoView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setLayout() {        
        rankLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(9)
            $0.width.equalTo(12)
            $0.height.equalTo(18)
        }
        infoDetailView.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
            $0.top.equalToSuperview()
            $0.trailing.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        infoView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }
}

extension PopularCollectionViewCell {
    func dataBind(item: ContentModel) {
        imageView.image = item.thumbnail
        titleLabel.text = item.title
        detailInfoLabel.text = item.description
        latingLabel.text = "\(item.rating)%"
    }
}
