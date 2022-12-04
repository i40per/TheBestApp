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
    
    private var tagsArray: [String] = []
    
    private var viewModel: MainViewModel?
    private var counter: Int = 0
    private var isPaging = true
    
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
        
        let networkManager = NetworkManager()
        self.viewModel = MainViewModel(networkManager: networkManager)
        
        view.backgroundColor = #colorLiteral(red: 0.09410236031, green: 0.09412645549, blue: 0.09410081059, alpha: 1)
        view.addSubview(collectionView)
        
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: idCollectionView)
    }
    
    //MARK: - SetDelegates
    
    private func setDelegates() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func removeAllAndReload() {
        
        self.counter = 0
        if let viewModel = viewModel {
            viewModel.items.removeAll()
            viewModel.sortedItems.removeAll()
            DispatchQueue.main.async { [weak self] in
                self?.searchController.searchBar.text = ""
                self?.collectionView.reloadData()
                self?.view.endEditing(true)
            }
        }
    }
    
    private func loadMoreData() {
        
        if let viewModel = viewModel {
            viewModel.loadImageWhenTextChanges(tagsArray[counter]) {
                DispatchQueue.main.async { [weak self] in
                    self?.collectionView.reloadData()
                    self?.counter += 1
                    self?.isPaging = true
                }
            } failureCompletion: { error in
                DispatchQueue.main.async {
                    print(error.rawValue)
                }
            }
        }
    }
    
    //MARK: - SetupNavigationBar
    
    private func setupNavigationBar() {
        
        let titleLabel = UILabel(text: "TheBestApp",
                                 font: UIFont.boldSystemFont(ofSize: 22),
                                 color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                 line: 0)
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
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
    
    private func createSortMethod(_ completion: @escaping (Items, Items) -> Bool) -> UIAction {
        
        return UIAction() { [weak self] action in
            if let viewModel = self?.viewModel {
                viewModel.sortedItems = viewModel.sortedItems.sorted(by: {
                    completion($0, $1)
                })
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }

    @objc private func sortBarButtonTapped(sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "", message: "Choose the sorting method:", preferredStyle: .actionSheet)
        let sortName = UIAlertAction(title: "Name", style: .default) { (action) in
            _ = self.createSortMethod({ lhs, rhs in
                lhs.title! < rhs.title!
            })
            self.collectionView.reloadData()
        }
        
        let sortDate = UIAlertAction(title: "Date", style: .default) { (action) in
            _ = self.createSortMethod({ lhs, rhs in
                lhs.published! < rhs.published!
            })
            self.collectionView.reloadData()
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
        if let viewModel = viewModel {
            return viewModel.sortedItems.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let viewModel = viewModel {
            return viewModel.sortedItems.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCollectionView, for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        
        if let viewModel = viewModel {
            cell.configure(viewModel.sortedItems[indexPath.row])
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > self.collectionView.contentSize.height - 200 - scrollView.frame.size.height {

            if isPaging {
                isPaging = false
                if counter == tagsArray.count {
                    return
                }
                loadMoreData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let viewModel = viewModel {
            let item = viewModel.items[indexPath.row]
    
            let detailsViewController = DetailsViewController()
            detailsViewController.item = item
            
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
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
        if searchBar.isFirstResponder {
            guard let text = searchBar.text else { return }
            self.tagsArray = text.components(separatedBy: " ")
        }
        
        if searchText.isEmpty {
            removeAllAndReload()
            self.view.endEditing(true)
            return
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeAllAndReload()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        true
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            return
        }
        removeAllAndReload()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        loadMoreData()
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
