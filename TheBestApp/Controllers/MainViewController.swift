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
    
    private var searchResults: [FlickrSearchResults] = []
    private let flickrModel = Flickr()
    
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
        
        searchController.searchBar.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func photo(for indexPath: IndexPath) -> FlickrModel {
        return searchResults[indexPath.section].searchResults[indexPath.row]
    }
    
    //MARK: - SetupNavigationBar
    
    private func setupNavigationBar() {
        let titleLabel = UILabel(text: "TheBestApp",
                                 font: UIFont.boldSystemFont(ofSize: 22),
                                 color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                 line: 0)
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = sortBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return searchResults.count
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults[section].searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCollectionView, for: indexPath) as?
                MainCollectionViewCell else {return UICollectionViewCell()}
        let flickrPhoto = photo(for: indexPath)
        cell.cellConfigure(model: flickrPhoto)
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let photo = photo(for: indexPath)
        let detailsViewController = DetailsViewController()
        
        detailsViewController.userImageView.image = photo.thumbnail
        detailsViewController.title = photo.title
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.frame.width / 2.02,
               height: collectionView.frame.width / 1.8)
    }
}

//MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        flickrModel.searchFlickr(for: searchText) { searchResults in
            DispatchQueue.main.async {
                
                switch searchResults {
                case .failure(let error):
                    print("Error searching: \(error)")
                case .success(let results):
                    print("""
                    Found \(results.searchResults.count) \
                    matching \(results.searchTerm)
                    """)
                    self.searchResults.insert(results, at: 0)
                    self.collectionView.reloadData()
                }
            }
        }
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
