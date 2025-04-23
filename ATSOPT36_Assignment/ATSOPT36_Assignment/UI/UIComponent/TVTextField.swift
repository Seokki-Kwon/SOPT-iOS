//
//  TVTextField.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/23/25.
//

import UIKit
import SnapKit

enum TextFieldType {
    case `default`
    case password
}

final class TVTextField: UITextField {
    
    private let textFieldType: TextFieldType
    
    private lazy var rightStackView = UIStackView().then {
        $0.spacing = 16
        $0.axis = .horizontal
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        let dummyView = UILabel()
        $0.addArrangedSubview(dummyView)
    }
    
    private lazy var togglePasswordButton = UIButton().then {
        $0.setImage(UIImage(resource: .eyeSlashIcon), for: .normal)
        $0.addTarget(self, action: #selector(togglePasswordButtonTapped), for: .touchUpInside)
    }
    
    private lazy var deleteButton = UIButton().then {
        $0.setImage(UIImage(resource: .deleteButton), for: .normal)
        $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        $0.isHidden = true
    }
    
    init(_ type: TextFieldType = .default) {
        self.textFieldType = type
        super.init(frame: .zero)
        setUI()
        setTextFieldStyle()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        font = .font(.pretendardSemiBold, ofSize: 15)
        backgroundColor = .gray4
        textColor = .white
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 0))
        leftViewMode = .always
        layer.cornerRadius = 3
        layer.borderColor = UIColor.gray2.cgColor
        keyboardType = .asciiCapable
        backgroundColor = .gray4
    }
    
    private func setTextFieldStyle() {
        switch textFieldType {
        case .default:
            rightStackView.addArrangedSubview(deleteButton)
        case .password:
            rightStackView.addArrangedSubview(deleteButton)
            rightStackView.addArrangedSubview(togglePasswordButton)
            isSecureTextEntry = true
        }
        rightViewMode = .always
        rightView = rightStackView
    }
    
    private func addTarget() {
        self.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(textDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(textDidEnd), for: .editingDidEnd)
    }
    
    @objc func deleteButtonTapped() {
        text = ""
        deleteButton.isHidden = true
    }
    
    @objc private func togglePasswordButtonTapped() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            togglePasswordButton.setImage(.eyeSlashIcon, for: .normal)
        } else {
            togglePasswordButton.setImage(.eyeIcon, for: .normal)
        }
    }
    
    @objc private func textDidChange() {
        deleteButton.isHidden = !hasText
        togglePasswordButton.isHidden = !hasText
    }
    
    @objc private func textDidBegin() {
        layer.borderWidth = 1
        deleteButton.isHidden = !hasText
    }
    
    @objc private func textDidEnd() {
        layer.borderWidth = 0
        deleteButton.isHidden = true
    }
}
