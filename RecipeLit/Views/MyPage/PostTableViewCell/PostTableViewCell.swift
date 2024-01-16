//
//  PostTableViewCell.swift
//  RecipeLit
//
//  Created by JeonSangHyeok on 1/4/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let identifier: String = "PostTableCell"
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private var postTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "김치찌개 만들기"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    override func layoutSubviews() {
        postImageView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - AutoLayouts
private extension PostTableViewCell {
    func configureUI() {
        configureImageView()
        configurePostTitleLabel()
    }
    
    func configureImageView() {
        contentView.addSubview(postImageView)
        
        postImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
            $0.width.height.equalTo(100)
        }
    }
    
    func configurePostTitleLabel() {
        contentView.addSubview(postTitleLabel)
        
        postTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(postImageView.snp.trailing).offset(10)
        }
    }
}
