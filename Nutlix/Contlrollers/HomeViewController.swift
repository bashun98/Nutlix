//
//  HomeViewController.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import UIKit

enum Sections: Int {
    case trendingMovies = 0, popularMovies, popularTVs, trendingTV, upcomingMovies, topRated
}

enum Medias {
    case movie, tv
}

enum Classification {
    case trending, popular, upcoming, top_rated
}

class HomeViewController: UIViewController {
    
    private let sectionsTitles = [
        "Trending movies",
        "Trending TV",
        "Popular movies",
        "Popular TV",
        "Upcoming movies",
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
        var neededString = ""
        
        switch indexPath.section {
        case Sections.trendingMovies.rawValue:
            neededString = "\(Classification.trending)/\(Medias.movie)/day"
        case Sections.trendingTV.rawValue:
            neededString = "\(Classification.trending)/\(Medias.tv)/day"
        case Sections.popularMovies.rawValue:
            neededString = "\(Medias.movie)/\(Classification.popular)"
        case Sections.popularTVs.rawValue:
            neededString = "\(Medias.tv)/\(Classification.popular)"
        case Sections.upcomingMovies.rawValue:
            neededString = "\(Medias.movie)/\(Classification.upcoming)"
        case Sections.topRated.rawValue:
            neededString = "\(Medias.movie)/\(Classification.top_rated)"
        default:
            
        }
     
        NetworkManager.shared.getMedia(neededString) { result in
            switch result {
            case .success(let data):
                cell.configure(with: data)
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
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
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
}
