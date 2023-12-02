//
//  ProductsView.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//


import UIKit

class ProductsView: UIView {
    
    private var productsTableView: UITableView = {
        let obj = UITableView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private var groupedProducts: [Category: [Product]] = [:]
    private var categories: [Category] = []
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        //properties
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        productsTableView.register(EmptyCell.self, forCellReuseIdentifier: "EmptyCell")
        
        //subviews
        self.addSubview(productsTableView)
        
        //constraints
        NSLayoutConstraint.activate([
            productsTableView.topAnchor.constraint(equalTo: topAnchor),
            productsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func load(productsData: [Category: [Product]], categories: [Category]) {
        self.groupedProducts = productsData
        self.categories = categories
        productsTableView.reloadData()
    }
    
    func scrollTo(category: Category) {
        let section = categories.firstIndex {
            $0 == category
        }
        guard let section = section else {
            return
        }
        let indexPath = IndexPath(row: 0, section: section)
        productsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension ProductsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        categories[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]
        let products = groupedProducts[category] ?? []
        return products.count > 0 ? products.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let category = categories[indexPath.section]
        let categoryProducts = groupedProducts[category]
        if let products = categoryProducts, products.count > 0, products.indices.contains(indexPath.row) {
            let product = products[indexPath.row]
            cell.set(product: product)
        } else {
            let cell = productsTableView.dequeueReusableCell(withIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
            return cell
        }
        return cell
    }
}

class EmptyCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.text = "No items here"
        obj.textAlignment = .center
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
