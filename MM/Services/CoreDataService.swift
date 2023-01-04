//
//  CoreDataService.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 14.12.2022.
//

import Foundation
import CoreData

final class CoreDataService {
    static let shared = CoreDataService()

    private init() {}
    
    var arrayTag = [Tag]()
    var arrayTagInc = [Tag]()
    var arrayTagExp = [Tag]()
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func entitieForName(with entitieName: String) -> NSEntityDescription {
        guard let entitie = NSEntityDescription.entity(forEntityName: entitieName, in: context) else { return NSEntityDescription() }
        return entitie
    }
    
    func updatingTags() {
        let tagModel = TagModel()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tag")
        
        if let tags = try? context.fetch(fetchRequest) as? [Tag], tags.count == tagModel.tagArray.count {
            arrayTag = tags
        } else {
            guard let tags = try? context.fetch(fetchRequest) as? [Tag] else { return }
            var arrayId = [Int16]()
            for tag in tags {
                guard let id = tag.relationshipWithAuxiliaryEntitie?.tagId else { return }
                arrayId.append(id)
            }
                for foundTag in tagModel.tagArray {
                    if !arrayId.contains(foundTag.id) {
                        let auxiliaryEntitieTag = AuxiliaryEntitieTag(context: context)
                        auxiliaryEntitieTag.tagId = foundTag.id
                        let tag = Tag(context: context)
                        tag.name = foundTag.tagName
                        tag.emoji = foundTag.tagEmoji
                        tag.isIncomeTag = foundTag.isIncomeTag
                        tag.relationshipWithAuxiliaryEntitie = auxiliaryEntitieTag
                        arrayTag.append(tag)
                        do {
                            try context.save()
                        } catch let error {
                            print("Sistem: \"\(error.localizedDescription)\"")
                        }
                    }
                }
            }
        print("Sistem: \"tags updated\"")
        print("Sistem: \"The arrayTag contains \(arrayTag.count) tags\"")
    }
    
    func getAnArrayOfTags(with typeOfOperation: TypeOfOperation) {
        var arrayTag = [Tag]()
        let fethRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tag")
        let sortDescriptor = NSSortDescriptor(key: "relationshipWithAuxiliaryEntitie.tagValue", ascending: false)
        fethRequest.sortDescriptors = [sortDescriptor]

        switch typeOfOperation {
        case .income:
            fethRequest.predicate = NSPredicate(format: "isIncomeTag = true")
        case .expenses:
            fethRequest.predicate = NSPredicate(format: "isIncomeTag = false")
        case .theTypeIsMissing:
            break
        }

        do {
            let results = try CoreDataService.shared.context.fetch(fethRequest)
            for result in results as! [Tag] {
                arrayTag.append(result)
            }

        } catch {
            print("Sistem: \"\(error.localizedDescription)\"")
        }
        
        switch typeOfOperation {
        case .income:
            self.arrayTagInc = arrayTag
        case .expenses:
            self.arrayTagExp = arrayTag
        case .theTypeIsMissing:
            self.arrayTag = arrayTag
        }
        print("Sistem: \"Geted an array of tags\"")
        print("Sistem: \"The arrayTag contains \(arrayTag.count) tags by type of operation \(typeOfOperation)\"")
    }
    
    func updateTagValue(with value: Double, id: Int16, isDelete: Bool) {
        let fethRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tag")
        fethRequest.predicate = NSPredicate(format: "relationshipWithAuxiliaryEntitie.tagId = \(id)")
        
        if let tags = try? context.fetch(fethRequest) as? [Tag] {
            guard let tag = tags.first else { return }
            
            switch isDelete {
            case true:
                tag.relationshipWithAuxiliaryEntitie?.tagValue -= value
                
                do {
                    try context.save()
                } catch let error {
                    print("Sistem: \"\(error.localizedDescription)\"")
                }
                getAnArrayOfTags(with: .theTypeIsMissing)
                getAnArrayOfTags(with: .income)
                getAnArrayOfTags(with: .expenses)
            case false:
                tag.relationshipWithAuxiliaryEntitie?.tagValue += value
                
                do {
                    try context.save()
                } catch let error {
                    print("Sistem: \"\(error.localizedDescription)\"")
                }
                getAnArrayOfTags(with: .theTypeIsMissing)
                getAnArrayOfTags(with: .income)
                getAnArrayOfTags(with: .expenses)
            }
        }
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MMCoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - CRUD
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataService {
    struct TagModel {
        struct Tag {
            var tagName: String
            var tagEmoji: String
            var isIncomeTag: Bool
            var id: Int16
        }
        var tagArray = [
            Tag(tagName: "З/П", tagEmoji: "💰", isIncomeTag: true, id: 1),
        Tag(tagName: "Аванс", tagEmoji: "💵", isIncomeTag: true, id: 2),
        Tag(tagName: "Проценты", tagEmoji: "%", isIncomeTag: true, id: 3),
        Tag(tagName: "Сделки", tagEmoji: "🤝", isIncomeTag: true, id: 4),
        Tag(tagName: "Выплаты", tagEmoji: "🤧", isIncomeTag: true, id: 5),
        Tag(tagName: "Иные доходы", tagEmoji: "🤷🏻‍♂️", isIncomeTag: true, id: 6),
        
        
        Tag(tagName: "Дом", tagEmoji: "🏠", isIncomeTag: false, id: 7),
        Tag(tagName: "Сделки", tagEmoji: "🤝", isIncomeTag: false, id: 8),
        Tag(tagName: "Еда", tagEmoji: "🍩", isIncomeTag: false, id: 9),
        Tag(tagName: "Семья", tagEmoji: "👨‍👩‍👧‍👦", isIncomeTag: false, id: 10),
        Tag(tagName: "Коммуналка", tagEmoji: "🛁", isIncomeTag: false, id: 11),
        Tag(tagName: "Здоровье", tagEmoji: "🏥", isIncomeTag: false, id: 12),
        Tag(tagName: "Одежда", tagEmoji: "👕", isIncomeTag: false, id: 13),
        Tag(tagName: "Налоги", tagEmoji: "🧾", isIncomeTag: false, id: 14),
        Tag(tagName: "Связь", tagEmoji: "☎️", isIncomeTag: false, id: 15),
        Tag(tagName: "Подписки", tagEmoji: "🎫", isIncomeTag: false, id: 16),
        Tag(tagName: "Образование", tagEmoji: "👨🏽‍🏫", isIncomeTag: false, id: 17),
        Tag(tagName: "Транспорт", tagEmoji: "🚊", isIncomeTag: false, id: 18),
        Tag(tagName: "Путешествия", tagEmoji: "⛵", isIncomeTag: false, id: 19),
        Tag(tagName: "Эллектронника", tagEmoji: "💻", isIncomeTag: false, id: 20),
        Tag(tagName: "Алкоголь", tagEmoji: "🍹", isIncomeTag: false, id: 21),
        Tag(tagName: "Сигареты", tagEmoji: "🚬", isIncomeTag: false, id: 22),
        Tag(tagName: "Иные расходы", tagEmoji: "🤷🏻‍♂️", isIncomeTag: false, id: 23),
        Tag(tagName: "Машина", tagEmoji: "🚘", isIncomeTag: false, id: 24),
        ]
    }
}
