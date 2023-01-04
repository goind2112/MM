//
//  ValuteModel.swift
//  MM
//
//  Created by Даниил Мухсинятов on 31.12.2022.
//

import Foundation

struct ValuteModel: Codable {
    var Valute: [String : Valute]
}

struct Valute: Codable {
    var Value: Double
}
