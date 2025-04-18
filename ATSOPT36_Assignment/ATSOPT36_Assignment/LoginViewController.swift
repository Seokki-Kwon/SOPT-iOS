//
//  LoginViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/18/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .font(.pretendardMedium, ofSize: 23)
        label.textColor = .gray84
        label.text = "TVING ID 로그인"
        return label
    }()
    
    private let idTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.gray2, NSAttributedString.Key.font: UIFont.font(.pretendardSemiBold, ofSize: 15)])
        tf.backgroundColor = .gray4
        tf.textColor = .white
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 0))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 3
        return tf
    }()
    
    private lazy var pwTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.gray2, NSAttributedString.Key.font: UIFont.font(.pretendardSemiBold, ofSize: 15)])
        tf.backgroundColor = .gray4
        tf.textColor = .white
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 0))
        tf.leftViewMode = .always
        tf.layer.cornerRadius = 3
        // deleteButton 추가
        let stackView = UIStackView()
        let paddingView = UIView()
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        paddingView.widthAnchor.constraint(equalToConstant: 4).isActive = true
        stackView.spacing = 16
        [deletePasswordButton, togglePasswordButton, paddingView].forEach {
            stackView.addArrangedSubview($0)
        }
        tf.rightView = stackView
        tf.rightViewMode = .whileEditing
        return tf
    }()
    
    private let deletePasswordButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(resource: .deleteButton), for: .normal)
        return bt
    }()
    
    private let togglePasswordButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(resource: .eyeIcon), for: .normal)
        return bt
    }()
    
    private let loginButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.layer.borderColor = UIColor.gray4.cgColor
        bt.layer.borderWidth = 1
        bt.setTitle("로그인하기", for: .normal)
        bt.setTitleColor(.gray2, for: .normal)
        bt.titleLabel?.font = .font(.pretendardSemiBold, ofSize: 14)
        bt.layer.cornerRadius = 3
        return bt
    }()
    
    private let idPasswordView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 33
        let findIdLabel = UILabel()
        let findPwLabel = UILabel()
        findIdLabel.font = .font(.pretendardSemiBold, ofSize: 14)
        findIdLabel.textColor = .gray2
        findIdLabel.text = "아이디 찾기"
        findPwLabel.font = .font(.pretendardSemiBold, ofSize: 14)
        findPwLabel.textColor = .gray2
        findPwLabel.text = "비밀번호 찾기"
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        lineView.backgroundColor = .gray4
        [findIdLabel, lineView, findPwLabel].forEach {
            sv.addArrangedSubview($0)
        }
        return sv
    }()
    
    private let nicknameView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 33
        let noAccountLabel = UILabel()
        noAccountLabel.text = "아직도 계정이 없으신가요?"
        noAccountLabel.font = .font(.pretendardSemiBold, ofSize: 14)
        noAccountLabel.textColor = .gray3
        let setNicknameButton = UIButton()
        setNicknameButton.setTitle("닉네임 만들러가기", for: .normal)
        setNicknameButton.setTitleColor(.gray2, for: .normal)
        setNicknameButton.titleLabel?.font = .font(.pretendardRegular, ofSize: 14)
        [noAccountLabel, setNicknameButton].forEach {
            sv.addArrangedSubview($0)
        }
        return sv
    }()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
    }
    
    // MARK: - UI Setting
    
    func setUI() {
        view.addSubview(loginLabel)
        view.addSubview(idTextField)
        view.addSubview(pwTextField)
        view.addSubview(loginButton)
        view.addSubview(idPasswordView)
        view.addSubview(nicknameView)
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            idTextField.heightAnchor.constraint(equalToConstant: 52),
            idTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 31),
        ])
        
        NSLayoutConstraint.activate([
            pwTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pwTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pwTextField.heightAnchor.constraint(equalToConstant: 52),
            pwTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 7),
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            loginButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 21)
        ])
        
        NSLayoutConstraint.activate([
            idPasswordView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idPasswordView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 31)
        ])
        
        NSLayoutConstraint.activate([
            nicknameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nicknameView.topAnchor.constraint(equalTo: idPasswordView.bottomAnchor, constant: 28)
        ])
    }
 
}
