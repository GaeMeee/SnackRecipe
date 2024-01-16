//
//  PostCollectionViewCell.swift
//  RecipeLit
//
//  Created by JeonSangHyeok on 12/26/23.
//

import UIKit
import SnapKit

class PostCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "FeedCell"
    
    private var postTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "된장찌개"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private var nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "JeonSangHyeok"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private var feedInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(systemName: "heart", withConfiguration: imageConfig)
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(systemName: "bookmark", withConfiguration: imageConfig)
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var writeTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(Date())"
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .systemGray2
        return label
    }()
    
    private var likeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

private extension PostCollectionViewCell {
    @objc func buttonTapped(_ sender: UIButton) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        
        sender.isSelected.toggle()
        
        if sender == likeButton {
            if sender.isSelected {
                let selectedImage = UIImage(systemName: "heart.fill", withConfiguration: imageConfig)
                sender.setImage(selectedImage, for: .normal)
                sender.tintColor = .red
            } else {
                let normalImage = UIImage(systemName: "heart", withConfiguration: imageConfig)
                sender.setImage(normalImage, for: .normal)
                sender.tintColor = .white
            }
        } else {
            if sender.isSelected {
                let selectedImage = UIImage(systemName: "bookmark.fill", withConfiguration: imageConfig)
                sender.setImage(selectedImage, for: .normal)
                sender.tintColor = .yellow
            } else {
                let normalImage = UIImage(systemName: "bookmark", withConfiguration: imageConfig)
                sender.setImage(normalImage, for: .normal)
                sender.tintColor = .white
            }
        }
    }
}

// MARK: - AutoLayout
private extension PostCollectionViewCell {
    func configureUI() {
        configurePostTitleLabel()
        configureFeedImageView()
        configureProfileView()
        configureFeedInfoView()
    }
    
    func configurePostTitleLabel() {
        contentView.addSubview(postTitleLabel)
        
        postTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(40)
        }
    }
    
    func configureFeedImageView() {
        contentView.addSubview(feedImageView)
        
        feedImageView.snp.makeConstraints {
            $0.top.equalTo(postTitleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
    
    func configureProfileView() {
        contentView.addSubview(profileView)
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(feedImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(40)
        }
        
        configureProfileImageView()
        configureNickNameLabel()
    }
    
    func configureProfileImageView() {
        profileView.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(34)
        }
        
        profileImageView.layer.cornerRadius = 17
        profileImageView.clipsToBounds = true
    }
    
    func configureNickNameLabel() {
        profileView.addSubview(nickNameLabel)
        
        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(5)
        }
    }
    
    
    
    func configureFeedInfoView() {
        contentView.addSubview(feedInfoView)
        
        feedInfoView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview()
        }
        
        configureLikeButton()
        configureBookmarkButton()
        configureWriteTimeLabel()
        configureLikeCountLabel()
    }
    
    func configureLikeButton() {
        feedInfoView.addSubview(likeButton)
        
        likeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(25)
        }
    }
    
    func configureBookmarkButton() {
        feedInfoView.addSubview(bookmarkButton)
        
        bookmarkButton.snp.makeConstraints {
            $0.centerY.equalTo(likeButton)
            $0.leading.equalTo(likeButton.snp.trailing).offset(10)
            $0.width.equalTo(30)
            $0.height.equalTo(25)
        }
    }
    
    func configureWriteTimeLabel() {
        feedInfoView.addSubview(writeTimeLabel)
        
        writeTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(likeButton)
            $0.trailing.equalToSuperview()
        }
    }
    
    func configureLikeCountLabel() {
        feedInfoView.addSubview(likeCountLabel)
        
        likeCountLabel.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
        }
    }
}
