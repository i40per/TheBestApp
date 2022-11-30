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
        imageView.image = UIImage(named: "Iron man")
        imageView.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = .white
        label.contentMode = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "NameLabellabel.contentMode = .center"
        label.textColor = .white
        label.contentMode = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameListTagsLabel: UILabel = {
        let label = UILabel()
        label.text = "NameListTagsLabel"
        label.textColor = .white
        label.contentMode = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
}
    
//MARK: - SetConstraints

extension MainCollectionViewCell {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
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
