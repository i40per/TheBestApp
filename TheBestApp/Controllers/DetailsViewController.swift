//
//  DetailsViewController.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 30.11.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var item: Items? = nil
    private var imageCache = NSCache<AnyObject, AnyObject>()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setItem()
        setupViews()
        setConstraints()
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.1646832824, green: 0.1647188365, blue: 0.1646810472, alpha: 1)
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    
        view.addSubview(userImageView)
    }
    
    func setItem() {
        guard
            let item = item,
            let imageUrl = item.media?.m
        else { return }
        
        self.title = item.title
        self.userImageView.downloadImageWith(imageCache: imageCache, urlString: imageUrl) {}
    }
}

//MARK: - SetConstraints

extension DetailsViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            userImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
}
