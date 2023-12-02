//
//  CategoryView.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//

import UIKit

protocol CategoryViewDelegate: AnyObject {
    func categoryViewDidSelectItem(_ view: CategoryView, category: Category)
}

class CategoryView: UIView {
    
    private var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let obj = UICollectionView(frame: .zero, collectionViewLayout: layout)
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private var categories: [Category] = []
    private var selectedCategory: Category?
    weak var delegate: CategoryViewDelegate?
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        //properties
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        //subviews
        self.addSubview(categoriesCollectionView)
        
        //constraints
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func load(categories: [Category]) {
        self.categories = categories
        self.selectedCategory = categories.first
        categoriesCollectionView.reloadData()
    }
}

extension CategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let thisCategory = self.categories[indexPath.row]
        cell.set(category: thisCategory)
        cell.titleLabel.textColor = thisCategory == self.selectedCategory ? .yellow : .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let thisCategory = self.categories[indexPath.row]
        guard thisCategory != self.selectedCategory else {
            return
        }
        self.selectedCategory = thisCategory
        collectionView.reloadData()
        delegate?.categoryViewDidSelectItem(self, category: thisCategory)
    }
}

