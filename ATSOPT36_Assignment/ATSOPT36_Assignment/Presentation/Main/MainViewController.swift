//
//  MainViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/28/25.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var prevTopOffset: CGFloat = 0
    private var topConstraint: Constraint?
    private let tableViewHeight: CGFloat = 100
    
    // TableView
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.contentInset.top = tableViewHeight
        $0.showsVerticalScrollIndicator = false
        $0.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        $0.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        $0.register(TodayTvingCell.self, forCellReuseIdentifier: TodayTvingCell.identifier)
        $0.register(PopularListCell.self, forCellReuseIdentifier: PopularListCell.identifier)
        $0.register(PopularMovieListCell.self, forCellReuseIdentifier: PopularMovieListCell.identifier)
        $0.register(BannerTableViewCell.self, forCellReuseIdentifier: BannerTableViewCell.identifier)
        $0.register(SportListCell.self, forCellReuseIdentifier: SportListCell.identifier)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        refreshControl.tintColor = .gray
        $0.refreshControl = refreshControl
    }
    
    // Tableheader
    private let headerView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let headerTopView = UIView().then {
        let tvingLogo = UIImageView(image: UIImage(resource: .tvingLogo))
        let tvingCharacter = UIImageView(image: UIImage(resource: .tvingLogo2))
        let searchImage = UIImageView(image: UIImage(resource: .search))
        
        tvingLogo.contentMode = .left
        tvingCharacter.contentMode = .center
        searchImage.contentMode = .center
        
        // 헤더 오른쪽에 들어갈 이미지
        let rightStackView = UIStackView()
        rightStackView.spacing = 10
        rightStackView.addArrangedSubview(searchImage)
        rightStackView.addArrangedSubview(tvingCharacter)
        
        $0.addSubview(tvingLogo)
        $0.addSubview(rightStackView)
        
        tvingLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(11)
        }
        rightStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(11)
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
    
    // MARK: - LifeCylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setLayout()
        setDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tableView.contentOffset.y = -100
    }
    
}

// MARK: - UI Setting

extension MainViewController {
    
    private func addSubview() {
        [tableView, headerView, topOverlay].forEach {
            view.addSubview($0)
        }
        [headerTopView, menuView].forEach {
            headerView.addSubview($0)
        }
    }
    
    private func setLayout() {
        
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
    }
    
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UI Action

extension MainViewController {
    @objc private func handleRefreshControl() {
        // Update your content…
        
        // Dismiss the refresh control.
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return TodayTvingCell.Metric.itemSize.height + 50
        case 2:
            return PopularListCell.Metric.itemSize.height + 50
        case 3:
            return PopularMovieListCell.Metric.itemSize.height + 50
        case 4:
            return UITableView.automaticDimension
        case 5:
            return SportListCell.Metric.itemSize.height
        default:
            return 100
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 상단에 여백값 음수로 값이 들어가는 문제 방지
        //        if scrollView.contentOffset.y < 0 {
        //            scrollView.contentOffset.y = 0
        //        }
        prevTopOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤뷰와 컨텐츠 사이의 거리
        let currentTopOffset = scrollView.contentOffset.y
        // 현재위치에 이전 위치를빼서 이동거리를 구한다
        let deltaY = currentTopOffset - prevTopOffset
        
        if currentTopOffset > 0 {
            // topConstraint값 가져오기
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
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayTvingCell.identifier, for: indexPath) as? TodayTvingCell else { return UITableViewCell() }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularListCell.identifier, for: indexPath) as? PopularListCell else { return UITableViewCell() }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularMovieListCell.identifier, for: indexPath) as? PopularMovieListCell else { return UITableViewCell() }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as? BannerTableViewCell else { return UITableViewCell() }
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SportListCell.identifier, for: indexPath) as? SportListCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
}

#Preview {
    MainViewController()
}
