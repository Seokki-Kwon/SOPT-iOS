//
//  MainViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/28/25.
//

import UIKit

import SnapKit

final class MainViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let mockData = MockData.items
    private let tableViewHeight: CGFloat = 100
    
    private var prevTopOffset: CGFloat = 0
    private var topConstraint: Constraint?
    
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.contentInset.top = tableViewHeight
        $0.showsVerticalScrollIndicator = false
        
        $0.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        $0.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        $0.register(TodayTvingList.self, forCellReuseIdentifier: TodayTvingList.reuseIdentifier)
        $0.register(PopularList.self, forCellReuseIdentifier: PopularList.reuseIdentifier)
        $0.register(PopularMovieList.self, forCellReuseIdentifier: PopularMovieList.reuseIdentifier)
        $0.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.reuseIdentifier)
        $0.register(SportChannelList.self, forCellReuseIdentifier: SportChannelList.reuseIdentifier)
        $0.register(KimGahyunBestList.self, forCellReuseIdentifier: KimGahyunBestList.reuseIdentifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        refreshControl.tintColor = .gray
        $0.refreshControl = refreshControl
        $0.tableFooterView = tableViewFooter
    }
    
    private lazy var tableViewFooter = UIView(
        frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 222)
    ).then {
        $0.backgroundColor = .black
        $0.addSubview(accountInfoView)
        $0.addSubview(termOfServiceLabel)
        $0.addSubview(privacyPolicyLabel)
        $0.addSubview(businessInfoLabel)
    }
    
    private let accountInfoView = UIStackView().then { stackView in
        stackView.backgroundColor = .gray5
        stackView.layer.cornerRadius = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fillProportionally
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.spacing = 8
        
        let notiLabel = UILabel()
        notiLabel.font = .font(.pretendardMedium, ofSize: 11)
        notiLabel.text = "공지"
        notiLabel.textColor = .gray2
        
        let accountLabel = UILabel()
        accountLabel.font = .font(.pretendardBold, ofSize: 11)
        accountLabel.text = "티빙 계정 공유 정책 추가 안내"
        accountLabel.textColor = .white
        
        let moveButton = UIButton()
        moveButton.setImage(UIImage(resource: .moveButton), for: .normal)
        [notiLabel, accountLabel, moveButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private let termOfServiceLabel = UILabel().then {
        $0.text = "고객문의 · 이용약관 · "
        $0.font = .font(.pretendardMedium, ofSize: 11)
        $0.textColor = .gray2
    }
    private let privacyPolicyLabel = UILabel().then {
        $0.text = "개인정보처리방침"
        $0.font = .font(.pretendardMedium, ofSize: 11)
        $0.textColor = .white
    }
    private let businessInfoLabel = UILabel().then {
        $0.text = "사업자정보 · 인재채용"
        $0.font = .font(.pretendardMedium, ofSize: 11)
        $0.textColor = .gray2
    }
    
    private let headerView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private lazy var searchButton = UIButton().then {
        let searchImage = UIImage(resource: .search)
        $0.setImage(searchImage, for: .normal)
        $0.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private lazy var characterButton = UIButton().then {
        let tvingCharacter = UIImage(resource: .tvingLogo2)
        $0.setImage(tvingCharacter, for: .normal)
        $0.addTarget(self, action: #selector(characterButtonTapped), for: .touchUpInside)
    }
    
    private lazy var headerTopView = UIView().then {
        let tvingLogo = UIImageView(image: UIImage(resource: .tvingLogo))
        
        tvingLogo.contentMode = .left
        
        let rightStackView = UIStackView()
        rightStackView.spacing = 10
        
        [searchButton, characterButton].forEach {
            rightStackView.addArrangedSubview($0)
        }
        
        $0.addSubview(tvingLogo)
        $0.addSubview(rightStackView)
        
        tvingLogo.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        rightStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    private let menuView = UIStackView().then { stackView in
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .black
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 11, bottom: 0, trailing: 11)
        
        ["홈", "드라마", "예능", "영화", "스포츠", "뉴스"].forEach {
            let button = UIButton()
            button.setTitleColor(.white, for: .normal)
            button.setTitle($0, for: .normal)
            button.titleLabel?.font = .font(.pretendardRegular, ofSize: 17)
            stackView.addArrangedSubview(button)
        }
    }
    
    private let topOverlay = UIView().then {
        $0.backgroundColor = .black
    }
    
    // MARK: - UI Setting
    override func setLayout() {
        headerTopView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        menuView.snp.makeConstraints {
            $0.top.equalTo(headerTopView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        topOverlay.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        headerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            self.topConstraint = $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).constraint
            $0.height.equalTo(tableViewHeight)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        accountInfoView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalToSuperview().offset(23)
        }
        
        termOfServiceLabel.snp.makeConstraints {
            $0.top.equalTo(accountInfoView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(20)
        }
        
        privacyPolicyLabel.snp.makeConstraints {
            $0.top.equalTo(accountInfoView.snp.bottom).offset(13)
            $0.leading.equalTo(termOfServiceLabel.snp.trailing)
        }
        
        businessInfoLabel.snp.makeConstraints {
            $0.top.equalTo(termOfServiceLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    override func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func addSubview() {
        [tableView, headerView, topOverlay].forEach { view.addSubview($0) }
        [headerTopView, menuView].forEach { headerView.addSubview($0) }
    }
}

// MARK: - LifeCycle

extension MainViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tableView.contentOffset.y = -100
    }
}


// MARK: - UI Action

extension MainViewController {
    @objc private func handleRefreshControl() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func searchButtonTapped() {
        let searchViewController = SearchViewController()
        
        navigationController?.pushViewController(searchViewController, animated: false)
    }
    
    @objc func characterButtonTapped() {
        
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return TodayTvingList.metric.itemSize.height + 60
        case 2:
            return PopularList.metric.itemSize.height + 60
        case 3:
            return PopularMovieList.metric.itemSize.height + 60
        case 4:
            return UITableView.automaticDimension
        case 5:
            return SportChannelList.metric.itemSize.height
        case 6:
            return KimGahyunBestList.metric.itemSize.height + 60
        default:
            return 0
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        prevTopOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentTopOffset = scrollView.contentOffset.y
        let deltaY = currentTopOffset - prevTopOffset
        
        if currentTopOffset > 0 {
            let oldConstraint = topConstraint?.layoutConstraints[0].constant ?? 0
            topConstraint?.update(offset: max(-56, min(0, oldConstraint - deltaY)))
            view.layoutIfNeeded()
        }
        
        prevTopOffset = currentTopOffset
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch mockData[indexPath.row] {
        case .thumbnail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            return cell
        case let .todayTving(items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayTvingList.reuseIdentifier, for: indexPath) as? TodayTvingList else { return UITableViewCell() }
            cell.prepare(items: items)
            return cell
        case let .popularLive(items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularList.reuseIdentifier, for: indexPath) as? PopularList else { return UITableViewCell() }
            cell.prepare(items: items)
            return cell
        case let .popularMovie(items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularMovieList.reuseIdentifier, for: indexPath) as? PopularMovieList else { return UITableViewCell() }
            cell.prepare(items: items)
            return cell
        case .banner:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.reuseIdentifier, for: indexPath) as? BannerTableViewCell else { return UITableViewCell() }
            return cell
        case let .sport(items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SportChannelList.reuseIdentifier, for: indexPath) as? SportChannelList else { return UITableViewCell() }
            cell.prepare(items: items)
            return cell
        case let .kimGahyunBest(items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: KimGahyunBestList.reuseIdentifier, for: indexPath) as? KimGahyunBestList else { return UITableViewCell() }
            cell.prepare(items: items)
            return cell
        }
    }
}

#Preview {
    MainViewController()
}
