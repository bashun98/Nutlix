//
//  JSONModel.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import Foundation

struct JSONModel: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let language: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case language = "original_language"
        case title = "original_title"
    }
}
