//
//  CollectionTagView.swift
//  MoneyMatters
//
//  Created by Даниил Мухсинятов on 24.11.2022.
//

import UIKit

final class CollectionTagIncView: MMBaseContainerView {
    
    weak var delegate: TransferringIdViaTheTableView? 
    private let cellTag = CellTag()
    var arrayTag = HomeViewController.arrayTagInc
    var collectionTag: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset.left = 10
        return view
    }()
    
}

extension CollectionTagIncView {
    
    override func setupViews() {
        super.setupViews()
        setupView(collectionTag)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            collectionTag.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            collectionTag.bottomAnchor.constraint(equalTo: collectionTag.topAnchor, constant: 60),
            collectionTag.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionTag.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        collectionTag.backgroundColor = .white
        collectionTag.register(CellTag.self, forCellWithReuseIdentifier: R.ID.reuseIDIncomeTeg)
        collectionTag.showsHorizontalScrollIndicator = false
        collectionTag.showsVerticalScrollIndicator = false
        collectionTag.delegate = self
        collectionTag.dataSource = self
        collectionTag.reloadData()
    }
}

extension CollectionTagIncView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.ID.reuseIDIncomeTeg,
                                                      for: indexPath)
        
        guard let cell = cell as? CellTag else {return cell}

        let item = arrayTag[indexPath.row]
        cell.tagEmojiLabel.text = item.emoji
        cell.tagLabel.text = item.name
        guard let value = item.relationshipWithAuxiliaryEntitie?.tagValue else { return cell }
        let strValue = String(format: "%.02f", value)
        cell.tagValueLabel.text = "\(strValue) ₽"
        cell.backgroundColor = R.Colors.titleGreen
        cell.layer.cornerRadius = 20
        return cell
    }
    
}

extension CollectionTagIncView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 230, height: 50)
    }
}

extension CollectionTagIncView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = arrayTag[indexPath.row]
        guard let id = item.relationshipWithAuxiliaryEntitie?.tagId else { return }
        delegate?.searchByTags(id)
    }
}

