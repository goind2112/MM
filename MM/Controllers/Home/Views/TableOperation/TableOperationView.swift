//
//  TableIncAneExpView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 27.11.2022.
//

import UIKit
import CoreData

final class TableOperationView: MMBaseContainerView {
    weak var delegate: TransferringPositionViaTheSavButton?
    let tableOperation = UITableView()
    var fetchedResultsController = HomeViewController.fetchedResultsControllerTable
}

extension TableOperationView {
    override func setupViews() {
        super.setupViews()
        setupView(tableOperation)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            tableOperation.topAnchor.constraint(equalTo: topAnchor),
            tableOperation.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableOperation.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableOperation.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        tableOperation.register(RowIncAneExp.self, forCellReuseIdentifier: R.ID.reuseIDOperation)
        tableOperation.backgroundColor = .white
        tableOperation.rowHeight = 50
        tableOperation.allowsSelection = false
        tableOperation.dataSource = self
        tableOperation.delegate = self
        tableOperation.reloadData()
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Sistem: \"\(error.localizedDescription)\"")
        }
    }
}

extension TableOperationView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let item = fetchedResultsController.object(at: indexPath) as? Operation else { return }
            guard let tagId = item.relationshipWithTag?.relationshipWithAuxiliaryEntitie?.tagId else { return }
            let value = item.operationValue 
            CoreDataService.shared.updateTagValue(with: value, id: tagId, isDelete: true)
            CoreDataService.shared.context.delete(item)
            CoreDataService.shared.saveContext()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        delegate?.updateFRC(scrollView.contentOffset.y, contentSize: scrollView.contentSize.height)
    }
}

extension TableOperationView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        print(sections.count)
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchedResultsController.sections else { return nil }
        
        let sectionName = sections[section].name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        
        guard let date = dateFormatter.date(from: sectionName) else { return "Error" }
        
        let dateFormatterForDate = DateFormatter()
        dateFormatterForDate.dateFormat = "dd-MM-yyyy"
        
        let name = dateFormatterForDate.string(from: date)
    
        return name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: R.ID.reuseIDOperation, for: indexPath)
        guard let row = row as? RowIncAneExp else { return row }
        guard let item = fetchedResultsController.object(at: indexPath) as? Operation else { return row }
        guard let name = item.relationshipWithTag?.name else { return row }
        guard let emoji = item.relationshipWithTag?.emoji else { return row }
        
        row.tagLabel.text = name
        row.emojiLabel.text = emoji
        
        let value = item.operationValue
        let strValue = String(format: "%.02f", value)
        row.valueLabel.text = "\(item.relationshipWithTag?.isIncomeTag == true ? "" : "-")\(strValue) ₽"
        
        row.nameLabel.text = item.operationName
        row.viewLine.backgroundColor = item.relationshipWithTag?.isIncomeTag == true ? R.Colors.titleGreen : R.Colors.titleRed
        
        row.backgroundColor = .white
        return row
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = R.Colors.titleGray
        header.textLabel?.font = R.Fonts.helveticaRegular(with: 16)
    }
}
