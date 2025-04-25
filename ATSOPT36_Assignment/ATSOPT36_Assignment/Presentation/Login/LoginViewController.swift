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
    
    private var nickname: String?
    
    private let loginLabel = UILabel().then {
        $0.font = .font(.pretendardMedium, ofSize: 23)
        $0.textColor = .gray84
        $0.text = "TVING ID 로그인"
    }
    
    private lazy var idTextField = TVTextField().then {
        $0.setPlaceholder("아이디", .gray2)
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        $0.addTarget(self, action: #selector(textFieldShouldReturn(sender:)), for: .editingDidEndOnExit)
    }
    private lazy var pwTextField = TVTextField(.password).then {
        $0.setPlaceholder("비밀번호", .gray2)
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        $0.addTarget(self, action: #selector(textFieldShouldReturn(sender:)), for: .editingDidEndOnExit)
    }
    
    private lazy var loginButton = TVButton("로그인하기").then {
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
    
    private lazy var setNicknameButton = UIButton().then {
        $0.setTitle("닉네임 만들러가기", for: .normal)
        $0.setTitleColor(.gray2, for: .normal)
        $0.titleLabel?.font = .font(.pretendardRegular, ofSize: 14)
        $0.addTarget(self, action: #selector(setNicknameButtonTapped), for: .touchUpInside)
        $0.setUnderline()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - UI Setting

extension LoginViewController {
    
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
    
    private func clearTextField() {
        idTextField.text = ""
        pwTextField.text = ""
    }
}

// MARK: - UI Action

extension LoginViewController {
    
    @objc private func loginButtonTapped() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.setLabelText(id: nickname ?? idTextField.text)
        welcomeViewController.delegate = self
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    @objc private func setNicknameButtonTapped() {
        view.endEditing(true)
        let nicknameSheetViewController = NicknameSheetViewController()
        if let sheet = nicknameSheetViewController.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in
                UIScreen.main.bounds.height / 2
            })]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        nicknameSheetViewController.delegate = self
        present(nicknameSheetViewController, animated: true, completion: nil)
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        guard let newIdText = idTextField.text,
              let newPasswordText = pwTextField.text else { return }
        
        // 유효성 검사 후 버튼 상태변경
        if newIdText.isValidEmail, newPasswordText.isValidPassword {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    @objc private func textFieldShouldReturn(sender: UITextField) {
        if sender == idTextField {
            pwTextField.becomeFirstResponder()
        } else {
            pwTextField.resignFirstResponder()
        }
    }
}

// MARK: - LoginDataDelegate

extension LoginViewController: LoginDataDelegate {
    func dataBind(id: String) {
        print("\(id) 로그아웃")
        clearTextField()
        loginButton.isEnabled = false
    }
}

// MARK: - NicknameDelegate

extension LoginViewController: NicknameDelegate {
    func dataBind(nickname: String?) {
        self.nickname = nickname
    }
}

#Preview{
    LoginViewController()
}
