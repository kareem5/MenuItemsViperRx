//
//  MenuItemTableViewCell.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

import UIKit

protocol MenuItemTableViewCellDelegate: class {
    func addToCart(item: Item)
}

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weightSizeLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    weak var delegate: MenuItemTableViewCellDelegate?
    
    private var datasource: Item? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    }
    
    func configure(with menuItem: Item) {
        self.datasource = menuItem
    }
    
    private func updateUI() {
        
        guard let datasource = datasource else { return }
        self.titleLabel.text = datasource.name
        self.descriptionLabel.text = datasource.description
        self.weightSizeLabel.text = "\(datasource.weight) gram, \(datasource.size)"
        self.priceButton.setTitle("\(datasource.price) usd", for: .normal)
        
        guard let imageUrl = URL(string: datasource.imageUrl) else { return }
        self.itemImageView.af.setImage(withURL: imageUrl)

    }
    
    func addToCartAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.priceButton.setTitle("added + 1", for: .normal)
            self.priceButton.backgroundColor = .systemGreen
        } completion: { _ in
            self.priceButton.backgroundColor = .black
            self.priceButton.setTitle("\(self.datasource!.price) usd", for: .normal)
        }
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        self.delegate?.addToCart(item: datasource!)
        self.addToCartAnimation()
    }
}
