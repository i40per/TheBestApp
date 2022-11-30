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
        imageView.image = UIImage(named: "Bear")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        
        title = "Bear"
        view.backgroundColor = #colorLiteral(red: 0.1646832824, green: 0.1647188365, blue: 0.1646810472, alpha: 1)
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    
        view.addSubview(userImageView)
    }
}

//MARK: - SetConstraints

extension DetailsViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            userImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
        ])
    }
}
