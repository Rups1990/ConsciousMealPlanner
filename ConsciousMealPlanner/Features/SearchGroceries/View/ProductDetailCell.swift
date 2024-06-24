//
//  ProductDetailCell.swift
//  ConsciousMealPlanner
//
//  Created by Rubha on 24/06/24.
//

import UIKit

final class ProductDetailCell: UITableViewCell {
      
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with product: Product) {
        self.textLabel?.text = product.title ?? "Lemon Tea"
        self.textLabel?.textColor = UIColor.white
        self.textLabel?.numberOfLines = 0
        self.backgroundColor = UIColor.clear
    }

}
