//
//  ViewController.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 29.11.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var sortBarButtonItem: UIBarButtonItem = {
       
        return UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
                                style: .plain,
                                target: self,
                                action: #selector(sortBarButtonTapped))
    }()
    
    private let searchController = UISearchController()
    
    private let idCollectionView = "idCollectionView"
    
    //MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setupNavigationBar()
        setConstraints()
    }
    
    //MARK: - SetupViews
    
    private func setupViews() {
        
        view.backgroundColor = #colorLiteral(red: 0.09410236031, green: 0.09412645549, blue: 0.09410081059, alpha: 1)
        
        view.addSubview(collectionView)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: idCollectionView)
    }
    
    //MARK: - SetDelegates
    
    private func setDelegates() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //MARK: - SetupNavigationBar
    
    private func setupNavigationBar() {
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = sortBarButtonItem
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.backButtonTitle = ""
        navigationItem.hidesSearchBarWhenScrolling = false

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance.backgroundColor = #colorLiteral(red: 0.1599434614, green: 0.165407896, blue: 0.1891466677, alpha: 1)
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = #colorLiteral(red: 0.1599434614, green: 0.165407896, blue: 0.1891466677, alpha: 1)
    }

    @objc private func sortBarButtonTapped(sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "", message: "Choose the sorting method:", preferredStyle: .actionSheet)
        let sortName = UIAlertAction(title: "Name", style: .default) { (action) in
        }
        let sortDate = UIAlertAction(title: "Date", style: .default) { (action) in
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(sortName)
        alertController.addAction(sortDate)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}

//MARK: - UICollectionViewDataSourse

extension MainViewController: UICollectionViewDataSource {
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCollectionView, for: indexPath) as?
                MainCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsViewController = DetailsViewController()
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.width / 2.02,
               height: collectionView.frame.width / 2.02)
    }
}

//MARK: - SetConstraints

extension MainViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
