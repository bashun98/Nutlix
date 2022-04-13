//
//  SearchResultsViewController.swift
//  Nutlix
//
//  Created by Евгений Башун on 13.04.2022.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    let searchResultsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(MediaCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.collectionViewCellID)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var media: [Media] = [Media]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.searchResultsCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
}


extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return media.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellID, for: indexPath) as? MediaCollectionViewCell else {return UICollectionViewCell()}
        var posterPath = ""
        if media[indexPath.row].posterPath != nil {
            posterPath = media[indexPath.row].posterPath!
        } else {
            posterPath = ""
        }

        cell.configure(with: posterPath)
        //cell.backgroundColor = .red

        return cell
    }


}

extension SearchResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width / 3 - 10, height: 180)
    }
}
