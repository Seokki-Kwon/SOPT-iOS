//
//  LoginViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/18/25.
//

import UIKit
import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginLabel = UILabel().then {
        $0.font = .font(.pretendardMedium, ofSize: 23)
        $0.textColor = .gray84
        $0.text = "TVING ID 로그인"
    }
    
    private let idTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.gray2, NSAttributedString.Key.font: UIFont.font(.pretendardSemiBold, ofSize: 15)])
        $0.backgroundColor = .gray4
        $0.textColor = .white
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 3
    }
    
    private lazy var passwordInputView = UIStackView().then {
        $0.spacing = 16
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        $0.addArrangedSubview(deletePasswordButton)
        $0.addArrangedSubview(togglePasswordButton)
    }
    
    private lazy var pwTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.gray2, NSAttributedString.Key.font: UIFont.font(.pretendardSemiBold, ofSize: 15)])
        $0.backgroundColor = .gray4
        $0.textColor = .white
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 0))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 3
        $0.rightView = passwordInputView
        $0.rightViewMode = .whileEditing
    }
    
    private let deletePasswordButton = UIButton().then {
        $0.setImage(UIImage(resource: .deleteButton), for: .normal)
    }
    
    private let togglePasswordButton = UIButton().then {
        $0.setImage(UIImage(resource: .eyeIcon), for: .normal)
    }
    
    private let loginButton = UIButton().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.gray4.cgColor
        $0.layer.borderWidth = 1
        $0.setTitle("로그인하기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .font(.pretendardSemiBold, ofSize: 14)
        $0.layer.cornerRadius = 3
    }
    
    private let findIdButton = UIButton().then {
        $0.setTitleColor(.gray2, for: .normal)
        $0.setTitle("아이디 찾기", for: .normal)
        $0.titleLabel?.font = .font(.pretendardSemiBold, ofSize: 14)
    }
    
    private let findPasswordButton = UIButton().then {
        $0.setTitleColor(.gray2, for: .normal)
        $0.setTitle("비밀번호 찾기", for: .normal)
        $0.titleLabel?.font = .font(.pretendardSemiBold, ofSize: 14)
    }
    
    private lazy var idPasswordView = UIStackView().then {
        $0.spacing = 33
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        lineView.backgroundColor = .gray4
        $0.addArrangedSubview(findIdButton)
        $0.addArrangedSubview(lineView)
        $0.addArrangedSubview(findPasswordButton)
    }
    
    private let setNicknameButton = UIButton().then {
        $0.setTitle("닉네임 만들러가기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .font(.pretendardRegular, ofSize: 14)
    }
    
    private lazy var nicknameView = UIStackView().then {
        $0.spacing = 33
        let noAccountLabel = UILabel()
        noAccountLabel.text = "아직도 계정이 없으신가요?"
        noAccountLabel.font = .font(.pretendardSemiBold, ofSize: 14)
        noAccountLabel.textColor = .gray3
        $0.addArrangedSubview(noAccountLabel)
        $0.addArrangedSubview(setNicknameButton)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubViews()
        setLayout()
    }
    
    // MARK: - UI Setting
    
    private func addSubViews() {
        view.addSubview(loginLabel)
        view.addSubview(idTextField)
        view.addSubview(pwTextField)
        view.addSubview(loginButton)
        view.addSubview(idPasswordView)
        view.addSubview(nicknameView)
    }
    
    private func setLayout() {
        
        loginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
        }
        
        idTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(loginLabel.snp.bottom).offset(31)
            $0.height.equalTo(52)
        }
        
        pwTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.top.equalTo(idTextField.snp.bottom).offset(7)
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.top.equalTo(pwTextField.snp.bottom).offset(21)
        }
        
        idPasswordView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
        }
        
        nicknameView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(idPasswordView.snp.bottom).offset(28)
        }
    }
    
}

#Preview{
    LoginViewController()
}
