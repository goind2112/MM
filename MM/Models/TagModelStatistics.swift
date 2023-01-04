//
//  TagModelStatistics.swift
//  MM
//
//  Created by Даниил Мухсинятов on 01.01.2023.
//

import Foundation


final class TagModelStatistics {
    
    struct TagStatistics {
        var value: Double
        var condition: TypeOfOperation
        var tagName: String
    }
    
    static let shared = TagModelStatistics()
    private init() {}
    
    var arrayTagStatistics = [TagStatistics]()
    
    private let arrayNameForTag: [Int16 : String] = [
    1  : "З/П",
    2  : "Ава",
    3  : "Проц",
    4  : "Сдел" ,
    5  : "Вып",
    6  : "ИнД",


    7  : "Дом",
    8  : "Сдел",
    9  : "Еда",
    10 : "Семья",
    11 : "Комм",
    12 : "Здор",
    13 : "Одеж",
    14 : "Налог",
    15 : "Связь",
    16 : "Подп",
    17 : "Обр",
    18 : "Транс",
    19 : "Пут",
    20 : "Эллек",
    21 : "Алк",
    22 : "Сиг",
    23 : "ИнР",
    24 : "Маш",
    ]
    
    func arrayFilling() {
        CoreDataService.shared.getAnArrayOfTags(with: .theTypeIsMissing)
        let array = CoreDataService.shared.arrayTag
        var arrayTagStatistics = [TagStatistics]()
        var iterationStep = 0
        for item in array {
            if iterationStep < 10 {
                if item.relationshipWithAuxiliaryEntitie?.tagValue != 0 {
                    guard let theMostExpensiveItem = array.first?.relationshipWithAuxiliaryEntitie?.tagValue else { return }
                    guard let valueTag = item.relationshipWithAuxiliaryEntitie?.tagValue else { return }
                    let value = valueTag / theMostExpensiveItem
                    
                    var condition: TypeOfOperation
                    if item.isIncomeTag {
                        condition = .income
                    } else {
                        condition = .expenses
                    }
                    
                    guard let tagId = item.relationshipWithAuxiliaryEntitie?.tagId else { return }
                    guard let name = arrayNameForTag[tagId] else { return }
                    
                    arrayTagStatistics.append(TagStatistics(value: value, condition: condition, tagName: name))
                    iterationStep += 1
                }
            }
        }
        self.arrayTagStatistics = arrayTagStatistics
    }
}
