//
//  BaseViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/7/25.
//

import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {
    
    // MARK: - Initilizing
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        addSubview()
        setLayout()
        setDelegate()
    }
    
    // addSubview
    func addSubview() {}
    // set Constraints
    func setLayout() {}
    // set Delegate
    func setDelegate() {}
}

