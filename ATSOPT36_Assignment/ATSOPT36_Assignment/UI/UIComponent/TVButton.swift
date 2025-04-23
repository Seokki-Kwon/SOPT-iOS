//
//  TVButton.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/23/25.
//

import UIKit

final class TVButton: UIButton {
    
    private let title: String
    
    override var isEnabled: Bool {
        didSet {
            isEnabled ? enableLoginButton() : disabledLoginButton()
        }
    }
    
    init(_ title: String) {
        self.title = title
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        layer.borderColor = UIColor.gray4.cgColor
        layer.borderWidth = 1
        setTitle(title, for: .normal)
        setTitleColor(.gray2, for: .normal)
        titleLabel?.font = .font(.pretendardSemiBold, ofSize: 14)
        layer.cornerRadius = 3
        isEnabled = false
    }
    
    private func enableLoginButton() {
        backgroundColor = .main
        setTitleColor(.white, for: .normal)
    }
    
    private func disabledLoginButton() {
        backgroundColor = .none
        setTitleColor(.gray2, for: .normal)
    }
}
