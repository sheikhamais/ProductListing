//
//  ProductsListingHomeViewController.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//

import UIKit

class ProductsListingHomeViewController: UIViewController {
    
    let viewModel = ProductsListingHomeViewModel()
    
    lazy var categoryView: CategoryView = {
        let obj = CategoryView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.delegate = self
        return obj
    }()
    
    var productsView: ProductsView = {
        let obj = ProductsView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getAllData()
    }
    
    private func configureUI() {
        
        view.addSubview(categoryView)
        view.addSubview(productsView)
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            productsView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 20),
            productsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            productsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func getAllData() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        viewModel.getAllCategories { result in
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        viewModel.getAllProducts { result in
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.categoryView.load(categories: self.viewModel.categories)
            self.productsView.load(productsData: self.viewModel.groupedProducts, categories: self.viewModel.categories)
        }
    }
}

extension ProductsListingHomeViewController: CategoryViewDelegate {
    func categoryViewDidSelectItem(_ view: CategoryView, category: Category) {
        productsView.scrollTo(category: category)
    }
}
