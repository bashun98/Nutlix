//
//  SearchViewController.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import UIKit

class SearchViewController: UIViewController {

    private let sectionsTitles = [
        "Trending Movies",
        "Trending TV",
        "Popular Movies",
        "Popular TV",
        "Upcoming Movies",
        "Top Rated"
    ]

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setupNavBar()
        navigationItem.searchController = searchController
        tableView.delegate = self
        tableView.dataSource = self

        searchController.searchResultsUpdater = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func setupNavBar() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsTitles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sectionsTitles[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsContoller = searchController.searchResultsController as? SearchResultsViewController else {return}

        NetworkManager.shared.getSomething(query) { result in
            
            switch result {
            case .success(let media):
                DispatchQueue.main.async {
                    resultsContoller.media = media
                   // resultsContoller.searchResultsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error) 
            }
            
        }
    }
}
