//
//  ViewController.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 05.11.2022.
//
import UIKit
import CoreData

public protocol TransferringIdViaTheTableView: AnyObject {
    func searchByTags(_ id: Int16)
}

public protocol TransferringDataViaTheSavButton: AnyObject {
    func saveData(_ name: String, value: Double, tag: Tag)
}

public protocol TransferringPositionViaTheSavButton: AnyObject {
    func updateFRC(_ contentOfset: Double, contentSize: Double)
}

final class HomeViewController: MMBaseController, TransferringDataViaTheSavButton, TransferringIdViaTheTableView, TransferringPositionViaTheSavButton {
    
    private enum Constants {
        static let entiti = "Operation"
        static let sortNameDate = "dateOfOperation"
        static let sortNameValue = "operationValue"
        static let sortNameEmoji = "relationshipWithTag.emoji"
    }
    var isUpdateingFRCFetchLimit = false
    static var arrayTagInc = CoreDataService.shared.arrayTagInc
    static var arrayTagExp = CoreDataService.shared.arrayTagExp
    
    static var fetchedResultsControllerTable: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entiti)
        
        let sortDescriptorDate = NSSortDescriptor(key: Constants.sortNameDate, ascending: false)
        let sortDescriptorValue = NSSortDescriptor(key: Constants.sortNameValue, ascending: false)
        let sortDescriptorTag = NSSortDescriptor(key: Constants.sortNameEmoji, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptorDate, sortDescriptorValue, sortDescriptorTag]
        fetchRequest.fetchLimit = 100
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: CoreDataService.shared.context,
                                                                  sectionNameKeyPath: Constants.sortNameDate,
                                                                  cacheName: nil)
        
        return fetchedResultsController
    }()
    
    private let coreDataService = CoreDataService.shared
    
    private let collectionTagIncomeView = CollectionTagIncView(with: R.Strings.Home.CollTagInc,
                                                       font: 23,
                                                       position: .collection)
    
    private let collectionTagExpenditureView = CollectionTagExpView(with: R.Strings.Home.CollTagExp,
                                                            font: 23,
                                                            position: .collection)
    private let tableOperationView = TableOperationView()
    private let createRowController = CreateRowController()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillProportionally
        return stack
    }()
    
    @objc private func presentationCreateRowController() {
        navigationController?.pushViewController(createRowController, animated: true)
    }
    
    @objc private func deleteChangesToFRC() {
        searchByTags(100)
        let leftNavBarButton = addNavBarButton(at: .left, with: "Отмена", image: nil)
        leftNavBarButton.isHidden = true
    }
    
    private func updateFRCFetchLimit() {
        DispatchQueue.main.async {
            guard !self.isUpdateingFRCFetchLimit && !self.tableOperationView.tableOperation.isHidden else { return }
            self.tableOperationView.fetchedResultsController.fetchRequest.fetchLimit += 50
            
            do {
                try self.tableOperationView.fetchedResultsController.performFetch()
            } catch {
                print("Sistem: \"\(error.localizedDescription)\"")
            }
            
            self.tableOperationView.tableOperation.reloadData()
            self.isUpdateingFRCFetchLimit = false
        }
    }
    
    //MARC: - delegation functions
    func saveData(_ name: String, value: Double, tag: Tag) {
            let operation = Operation(context: coreDataService.context)
            operation.operationName = name
            operation.operationValue = value
            operation.relationshipWithTag = tag
            
            let someDate = Date()
            var components = Calendar.current.dateComponents([.year,.month,.day], from: someDate)
            
            let date = Calendar.current.date(from: components)
            operation.dateOfOperation = date
            
            if name != "", value != 0 {
                coreDataService.saveContext()
                guard let id = tag.relationshipWithAuxiliaryEntitie?.tagId else { return }
                coreDataService.updateTagValue(with: value, id: id, isDelete: false)
            }
            
            HomeViewController.arrayTagInc = coreDataService.arrayTagInc
            HomeViewController.arrayTagExp = coreDataService.arrayTagExp
            collectionTagIncomeView.arrayTag = HomeViewController.arrayTagInc
            collectionTagExpenditureView.arrayTag = HomeViewController.arrayTagExp
            collectionTagIncomeView.collectionTag.reloadData()
            collectionTagExpenditureView.collectionTag.reloadData()
    }
    
    func searchByTags(_ id: Int16) {
        var predicate = NSPredicate()
        
        if id == 100 {
            predicate = NSPredicate(format: "relationshipWithTag.relationshipWithAuxiliaryEntitie.tagId < \(id)")
        } else {
            predicate = NSPredicate(format: "relationshipWithTag.relationshipWithAuxiliaryEntitie.tagId = \(id)")
        }
        
        tableOperationView.fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            try tableOperationView.fetchedResultsController.performFetch()
        } catch {
            print("Sistem: \"\(error.localizedDescription)\"")
        }
        
        tableOperationView.tableOperation.reloadData()
        
        let leftNavBarButton = addNavBarButton(at: .left, with: "Отмена", image: nil)
        leftNavBarButton.addTarget(self, action: #selector(deleteChangesToFRC), for: .touchUpInside)
    }
    
    func updateFRC(_ contentOfset: Double, contentSize: Double) {
        guard let operation = try? CoreDataService.shared.context.count(for: NSFetchRequest<NSFetchRequestResult>(entityName: "Operation")) else { return }
       
        let fetchLimit = tableOperationView.fetchedResultsController.fetchRequest.fetchLimit
        let contentUpdate = contentSize / 1.1
        
        guard contentOfset >= contentUpdate && operation > fetchLimit else { return }
        updateFRCFetchLimit()
    }
}

extension HomeViewController {
    
    override func setupViews() {
        super.setupViews()
        stackView.addArrangedSubview(collectionTagIncomeView)
        stackView.addArrangedSubview(collectionTagExpenditureView)
        tableOperationView.addSubview(stackView)
        view.setupView(stackView)
        view.setupView(tableOperationView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: collectionTagIncomeView.topAnchor,
                                              constant: 190),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tableOperationView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            tableOperationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableOperationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableOperationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        title = R.Strings.Home.house
        navigationController?.tabBarItem.title = R.Strings.TabBar.title(for: .house)
        
        let rightNavBarButton = addNavBarButton(at: .right, with: nil, image: R.Images.plus)
        rightNavBarButton.addTarget(self, action: #selector(presentationCreateRowController), for: .touchUpInside)
        
        collectionTagExpenditureView.delegate = self
        collectionTagIncomeView.delegate = self
        createRowController.delegate = self
        tableOperationView.delegate = self
        HomeViewController.fetchedResultsControllerTable.delegate = self
    }
}

extension HomeViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableOperationView.tableOperation.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
        let isoDate = sectionName
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        guard let date = dateFormatter.date(from:isoDate) else { return "Error"}
        
        let dateFormatterForDate = DateFormatter()
        dateFormatterForDate.dateFormat = "dd-MM-yyyy"
        let name = dateFormatterForDate.string(from: date)
        print("Sistem: \"Date of operation: \(name)\"")
        return name
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableOperationView.tableOperation.insertSections(IndexSet(integer: sectionIndex),
                                                             with: .fade)
        case .delete:
            tableOperationView.tableOperation.deleteSections(IndexSet(integer: sectionIndex),
                                                             with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableOperationView.tableOperation.insertRows(at: [indexPath], with:
                        .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableOperationView.tableOperation.deleteRows(at: [indexPath], with:
                        .automatic)
                //MARC: - update arrayTag
                HomeViewController.arrayTagInc = coreDataService.arrayTagInc
                HomeViewController.arrayTagExp = coreDataService.arrayTagExp
                collectionTagIncomeView.arrayTag = HomeViewController.arrayTagInc
                collectionTagExpenditureView.arrayTag = HomeViewController.arrayTagExp
                collectionTagIncomeView.collectionTag.reloadData()
                collectionTagExpenditureView.collectionTag.reloadData()
            }
        case .move:
            break
        case .update:
            if let indexPath = indexPath {
                tableOperationView.tableOperation.reloadRows(at: [indexPath], with:
                        .fade)
            }
        @unknown default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableOperationView.tableOperation.endUpdates()
    }
}

