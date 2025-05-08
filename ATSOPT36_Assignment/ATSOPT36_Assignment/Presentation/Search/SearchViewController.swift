//
//  SearchViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/8/25.
//

import UIKit

import SnapKit

final class SearchViewController: BaseViewController {
    
    private let tableView = UITableView()
    
    private let cancelButton = UIButton().then {
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        $0.setImage(image, for: .normal)
        $0.tintColor = .white
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
    }
    
    private let searchTextField = UITextField().then {
        $0.backgroundColor = .gray4
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.layer.cornerRadius = 20
        $0.setPlaceholder("제목, 인물명을 입력해보세요.", .gray2)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        $0.leftViewMode = .always
    }
    
    private lazy var searchBar = UIStackView().then { stackView in
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        [cancelButton, searchTextField].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addSubview() {
        [searchBar, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom)
        }
    }
}

#Preview {
    SearchViewController()
}
