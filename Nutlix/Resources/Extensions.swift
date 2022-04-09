//
//  Extensions.swift
//  Nutlix
//
//  Created by Евгений Башун on 09.04.2022.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
