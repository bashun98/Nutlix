//
//  UpcomingModel.swift
//  Nutlix
//
//  Created by Евгений Башун on 11.04.2022.
//

import Foundation

struct UpcomingModel {
    
    let title: String
    let imageURL: URL?
    
    init(with model: Media) {
        title = (model.originalName ?? model.originalTitle) ?? "Unknown"
        
        //MARK: - Исправить
        let posterPath = model.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath ?? "")")
        
        imageURL = url
    }
    
}
