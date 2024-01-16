//
//  DetailViewController.swift
//  RecipeLit
//
//  Created by JeonSangHyeok on 1/10/24.
//

import UIKit

class DetailViewController: UIViewController {
    var images: [UIImage] = [UIImage(systemName: "bolt")!, UIImage(systemName: "bolt")!, UIImage(systemName: "bolt")!, UIImage(systemName: "bolt")!]
    
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 400)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 4
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.backgroundStyle = .prominent
        return pageControl
    }()
    
    private var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private var nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "JeonSangHyeok"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}

private extension DetailViewController {
    func configureUI() {
        view.backgroundColor = .white
        configureImageCollectionView()
        configurePageControl()
        configureProfileView()
    }
    
    func configureImageCollectionView() {
        view.addSubview(imageCollectionView)
        
        imageCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
    
    func configurePageControl() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageCollectionView.snp.top).offset(360)
        }
    }
    
    func configureProfileView() {
        view.addSubview(profileView)
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        configureProfileImageView()
        configureNickNameLabel()
    }
    
    func configureProfileImageView() {
        profileView.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(40)
        }
        
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
    }
    
    func configureNickNameLabel() {
        profileView.addSubview(nickNameLabel)
        
        nickNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}

//extension DetailViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//}
