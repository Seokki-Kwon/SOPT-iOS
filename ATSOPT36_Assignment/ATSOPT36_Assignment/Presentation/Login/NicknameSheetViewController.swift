//
//  NicknameSheetViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/21/25.
//

import UIKit
import SnapKit
import Then

final class NicknameSheetViewController: UIViewController {
    
    weak var delegate: NicknameDelegate?
    
    private var bottomConstraint: Constraint?
    
    private let nicknameInfoLabel = UILabel().then {
        $0.text = "닉네임을 입력해주세요"
        $0.font = .font(.pretendardMedium, ofSize: 23)
    }
    
    private lazy var nicknameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.gray2, NSAttributedString.Key.font: UIFont.font(.pretendardSemiBold, ofSize: 15)])
        $0.backgroundColor = .gray2
        $0.textColor = .gray4
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 3
        $0.rightViewMode = .whileEditing
    }
    
    private lazy var saveButton = TVButton("저장하기").then {
        $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setLayout()
        setDelegate()
        addNotification()
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setDelegate() {
        nicknameTextField.delegate = self
    }
    
    private func addSubViews() {
        view.addSubview(nicknameInfoLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(saveButton)
    }
    
    private func setLayout() {
        nicknameInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(20)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(nicknameInfoLabel.snp.bottom).offset(21)
            $0.height.equalTo(52)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            // 레이아웃 설정과 동시에 할당
            self.bottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-11).constraint
            $0.height.equalTo(52)
        }
    }
    
    @objc private func saveButtonTapped() {
        delegate?.dataBind(nickname: nicknameTextField.text)
        dismiss(animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight: CGFloat
            keyboardHeight = keyboardSize.height
            bottomConstraint?.update(offset: -keyboardHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bottomConstraint?.update(offset: -11)
        self.view.layoutIfNeeded()
    }
}

extension NicknameSheetViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let nicknameText = nicknameTextField.text else { return }
        let filterdText = nicknameText.filter { String($0).isHangul }
        textField.text = filterdText
        saveButton.isEnabled = !filterdText.isEmpty
    }
}
