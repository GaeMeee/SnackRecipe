//
//  MyPageViewController.swift
//  RecipeLit
//
//  Created by JeonSangHyeok on 12/26/23.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    
    // MARK: - UIProperties
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private var nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "전상혁"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .blue
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private var postView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private var bookMarkView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private var postTextLabel: UILabel = {
        let label = UILabel()
        label.text = "게시글"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var bookMarkTextLabel: UILabel = {
        let label = UILabel()
        label.text = "북마크"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var postCountLabel: UILabel = {
        let label = UILabel()
        label.text = "2223"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private var bookMarkCountLabel: UILabel = {
        let label = UILabel()
        label.text = "32"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.insertSegment(withTitle: "게시글", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "북마크", at: 1, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .clear
        segmentControl.tintColor = .black
        segmentControl.selectedSegmentTintColor = .systemBlue
        return segmentControl
    }()
    
    private lazy var postTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

// MARK: - AutoLayout
private extension MyPageViewController {
    func configureUI() {
        view.backgroundColor = .white
        
        configureProfileImageView()
        configureNickNameLabel()
        configureStackView()
        configureSegmentControl()
        configurePostTableView()
    }
    
    func configureProfileImageView() {
        view.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(100)
        }
    }
    
    func configureNickNameLabel() {
        view.addSubview(nickNameLabel)
        
        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.top).offset(20)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(15)
        }
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        stackView.addArrangedSubview(postView)
        stackView.addArrangedSubview(bookMarkView)
        
        configurePostTextLabel()
        configurePostCountLabel()
        configureBookMarkTextLabel()
        configureBookMarkCountLabel()
    }
    
    func configurePostTextLabel() {
        postView.addSubview(postTextLabel)
        
        postTextLabel.snp.makeConstraints {
            $0.top.leading.trailing.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    func configurePostCountLabel() {
        postView.addSubview(postCountLabel)
        
        postCountLabel.snp.makeConstraints {
            $0.top.equalTo(postTextLabel.snp.bottom)
            $0.centerX.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureBookMarkTextLabel() {
        bookMarkView.addSubview(bookMarkTextLabel)
        
        bookMarkTextLabel.snp.makeConstraints {
            $0.centerX.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    func configureBookMarkCountLabel() {
        bookMarkView.addSubview(bookMarkCountLabel)
        
        bookMarkCountLabel.snp.makeConstraints {
            $0.top.equalTo(bookMarkTextLabel.snp.bottom)
            $0.centerX.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureSegmentControl() {
        view.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    func configurePostTableView() {
        view.addSubview(postTableView)
        
        postTableView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: - UITableViewDataSource
extension MyPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentControl.numberOfSegments == 0 {
            let cell = postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            return cell
        } else {
            let cell = postTableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
