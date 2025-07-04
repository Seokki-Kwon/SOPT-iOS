//
//  SearchViewController.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 5/8/25.
//

import UIKit
import Combine

import SnapKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private var result: [Movie] = []
    private var bag = Set<AnyCancellable>()
    
    private let textSubject = CurrentValueSubject<String?, Never>("")
    
    private let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
    }
    
    private let cancelButton = UIButton().then {
        let image = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate)
        $0.setImage(image, for: .normal)
        $0.tintColor = .white
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        $0.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private lazy var searchTextField = UITextField().then {
        $0.backgroundColor = .gray4
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.layer.cornerRadius = 20
        $0.setPlaceholder("제목, 인물명을 입력해보세요.", .gray2)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        $0.leftViewMode = .always
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private lazy var searchBar = UIStackView().then { stackView in
        stackView.distribution = .fill
        stackView.spacing = 7
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 16)
        [cancelButton, searchTextField].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: - UI Setting
    
    override func addSubview() {
        [searchBar, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setLayout() {
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
        }
    }
    
    override func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Binding

extension SearchViewController {
    private func bind() {
        textSubject
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .replaceNil(with: "")
            .filter { !$0.isEmpty }
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                performSarch($0)
            })
            .store(in: &bag)
    }
}

// MARK: - UI Action

extension SearchViewController {
    @objc private func textFieldDidChange(_ textField: UITextField) {
        textSubject.send(textField.text)
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}

// MARK: - Netowrk Request

extension SearchViewController {
    private func performSarch(_ term: String) {
        guard !term.isEmpty else { return }
        Task {
            do {
                let response: MovieListResponse = try await NetworkService.shared.request(MovieListAPI.fetchMovieList(term: term))
                result = response.movieListResult.movieList
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell else { return UITableViewCell() }
        cell.prepare(text: result[indexPath.row].movieNm)
        return cell
    }
}

#Preview {
    SearchViewController()
}
