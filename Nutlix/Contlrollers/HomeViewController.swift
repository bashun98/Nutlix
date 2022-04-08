//
//  HomeViewController.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let sectionsTitles = [
        "Tranding movies",
        "Popular",
        "Tranding TV",
        "Upcoming Movies",
        "Top Rated"
    ]
    
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellID)
        //tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.headerViewID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        configureNavBar()
        if #available(iOS 15.0, *) {
            homeTableView.sectionHeaderTopPadding = 0
        }
        homeTableView.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        let headerView = HeaderView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: view.bounds.width,
                                                  height: 400))
        homeTableView.tableHeaderView = headerView
        homeTableView.sectionFooterHeight = 0
        NetworkManager.shared.getTrendingMovies { _ in "" }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
    
    private func configureNavBar() {
        var nutflixImage = UIImage(named: "netflixLogo")
        nutflixImage = nutflixImage?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: nutflixImage,
                                                           style: .done,
                                                           target: self,
                                                           action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"),
                            style: .done,
                            target: self,
                            action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"),
                            style: .done,
                            target: self,
                            action: nil)
        ]
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellID, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0,
                                                              y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textAlignment = .left
        header.textLabel?.textColor = .white
        //header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    
}
