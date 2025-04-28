//
//  WelcomeViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/19/25.
//

import UIKit
import SnapKit
import Then

final class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: WelcomeViewControllerDelegate?
    
    private var id: String?
    
    private let tvingImage = UIImageView().then {
        $0.image = UIImage(resource: .tving)
    }
    
    private let welcomeLabel = UILabel().then {
        $0.font = .font(.pretendardBold, ofSize: 23)
        $0.textColor = .gray84
        $0.numberOfLines = 0
        $0.text = "안녕하세요 \n 반가워요!"
        $0.textAlignment = .center
    }
    
    private lazy var goToMainButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.setTitle("메인으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .font(.pretendardSemiBold, ofSize: 14)
        $0.layer.cornerRadius = 3
        $0.backgroundColor = .main
        $0.addTarget(self, action: #selector(goToMainButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        addSubViews()
        setLayout()
        bindID()
    }
}

// MARK: - UI Setting

extension WelcomeViewController {
    
    private func setUI() {
        view.backgroundColor = .black
        // backButton 설정
        let backButton = UIButton()
        backButton.setImage(UIImage(resource: .backButtonIcon), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func addSubViews() {
        view.addSubview(tvingImage)
        view.addSubview(welcomeLabel)
        view.addSubview(goToMainButton)
    }
    
    private func setLayout() {
        tvingImage.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tvingImage.snp.bottom).offset(67)
        }
        
        goToMainButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-11)
            $0.height.equalTo(52)
        }
    }
}

// MARK: - UI Binding

extension WelcomeViewController {
    
    private func bindID() {
        welcomeLabel.text = "\(id ?? "") 님\n반가워요!"
    }
    
    func setLabelText(id: String?) {
        self.id = id
    }
}

// MARK: - UI Action

extension WelcomeViewController {
    @objc private func goToMainButtonTapped() {
        delegate?.welcomeFlowDidComplete()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
