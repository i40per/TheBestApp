//
//  MainCollectionViewCell.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 30.11.2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.contentMode = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.contentMode = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameListTagsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.contentMode = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageCache = NSCache<AnyObject, AnyObject>()
    
    override func prepareForReuse() {
        userImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        
        backgroundColor = #colorLiteral(red: 0.1605761051, green: 0.1642630696, blue: 0.1891490221, alpha: 1)
        addSubview(userImageView)
        addSubview(dateLabel)
        addSubview(nameLabel)
        addSubview(nameListTagsLabel)
    }
    
    func configure(_ item: Items) {
        
        guard
            let title = item.title,
            let date = item.published,
            let tags = item.tags,
            let imageUrl = item.media?.m
        else { return }
        
        self.nameLabel.text = "Title: \(title)"
        self.dateLabel.text = "Date: \(date.returnHumanReadableDate())"
        self.nameListTagsLabel.text = "Tags: \(tags)"
        self.userImageView.downloadImageWith(imageCache: imageCache, urlString: imageUrl) {
        }
    }
}
    
//MARK: - SetConstraints

extension MainCollectionViewCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            userImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            userImageView.heightAnchor.constraint(equalToConstant: frame.width - 50),
            
            dateLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 5),
            dateLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            nameListTagsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameListTagsLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            nameListTagsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
