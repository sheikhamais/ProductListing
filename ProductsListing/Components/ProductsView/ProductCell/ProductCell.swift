//
//  ProductCell.swift
//  ProductsListing
//
//  Created by Pro on 27/10/2023.
//

import UIKit

class ProductCell: UITableViewCell {
    
    var containerView: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .lightGray
        obj.layer.cornerRadius = 8
        obj.clipsToBounds = true
        return obj
    }()
    
    var avatarImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFill
        obj.layer.cornerRadius = 25
        obj.clipsToBounds = true
        return obj
    }()
    
    var allInfoStackView: UIStackView = {
        let obj = UIStackView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.axis = .vertical
        obj.spacing = 12
        return obj
    }()
    
    var titleLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    var descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.numberOfLines = 0
        return obj
    }()
    
    var priceCategoryStackView: UIStackView = {
        let obj = UIStackView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.axis = .horizontal
        obj.spacing = 8
        return obj
    }()
    
    var priceLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    var categoryLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.textAlignment = .right
        return obj
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        contentView.addSubview(containerView)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(allInfoStackView)
        allInfoStackView.addArrangedSubview(titleLabel)
        allInfoStackView.addArrangedSubview(descriptionLabel)
        allInfoStackView.addArrangedSubview(priceCategoryStackView)
        priceCategoryStackView.addArrangedSubview(priceLabel)
        priceCategoryStackView.addArrangedSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            
            allInfoStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            allInfoStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            allInfoStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            allInfoStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
    }
    
    func set(product: Product) {
        if let url = URL(string: product.images?.first ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price ?? 0)"
        categoryLabel.text = product.category?.name
    }
    
    override func prepareForReuse() {
        self.avatarImageView.image = nil
    }
}
