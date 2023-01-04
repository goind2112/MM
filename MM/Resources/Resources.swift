//
//  Resources.swift
//  MM
//
//  Created by Даниил Мухсинятов on 31.12.2022.
//

import Foundation
import UIKit

enum R {
    enum Colors {
        static let active = UIColor(hexString: "#437BFE")
        static let inactive = UIColor(hexString: "#929DA5")
        
        static let background = UIColor(hexString: "#F8F9F9")
        static let separator = UIColor(hexString: "#E8ECEF")
        static let secondary = UIColor(hexString: "#F0F3FF")
        
        static let titleGray = UIColor(hexString: "#545C77")
        
        static let titleGreen = UIColor(hexString: "#ACDF87")
        static let titleRed = UIColor(hexString: "#ff4122")
    }
    
    enum Images {
        static func icon(for tab: Tabs) -> UIImage? {
            switch tab {
            case .house: return UIImage(systemName: "house")
            case .statistics: return UIImage(systemName: "plus.forwardslash.minus")
            case .target: return UIImage(systemName: "target")
            }
        }
        static let plus = UIImage(systemName: "plus.circle")
    }
    
    enum Strings {
        enum TabBar {
            static func title(for tab: Tabs) -> String {
                switch tab {
                case .house: return "ДОМ"
                case .statistics: return "АНАЛИЗ"
                case .target: return "ЦЕЛЬ"
                }
            }
        }
        enum Home {
            static let house = "Расходы & Доходы"
            static let CollTagInc = "Доходы"
            static let CollTagExp = "Расходы"
            static let nameLabel = "Наименование"
            static let sumLabel = "Сумма"
            static let expLabel = "Расход"
            static let incLabel = "Доход"
            static let sav = "Cохранить"
            static let hideKeyboard = "Скрыть"
            
        }
        
        enum Statistics {
            static let statistics = "Статистика"
            static let earningsIndex = "Индекс доходов"
            static let incomeView = "Доход"
            static let expenditureView = "Затраты"
            static let remainingFundsView = "Осталось средств"
            static let incomeСhartView = "График доходов & расхдов"
        }
        
        enum Target {
            static let target = "Цель"
            static let pathToTheGoal = "Путь к Цели"
            static let collectedMoney = "Есть"
            static let leftToRaiseMoney = "Осталось"
            static let thereIsAPurposeTitle = "Удалить цель"
            static let thereIsNoPurposeTitle = "Создать цель"
            static let sav = "Сохранить"
            static let close = "Закрыть"
            static let createAGoal = "Cоздание цели"
            static let descriptionLabel = "Введите нужную вам сумму:"
        }
    }
    enum Fonts {
        static func helveticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
    }
    enum ID {
        static let reuseIDIncomeTeg = "CellIncome"
        static let reuseIDOperation = "RowOperation"
    }
}
