//
//  CartItemTableViewCell.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 10/01/2021.
//

import UIKit

protocol CartItemTableViewCellDelegate: class {
    func didDelete(cartItemWithId id: Int)
}

class CartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var datasource: CartItem? {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: CartItemTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with cartItem: CartItem) {
        self.datasource = cartItem
    }
    
    private func updateUI() {
        guard let datasource = datasource else { return }

        self.titleLabel.text = datasource.menuItem.name
        self.priceLabel.text = "\(datasource.menuItem.price) usd"

        guard let imageUrl = URL(string: datasource.menuItem.imageUrl) else { return }
        self.itemImageView.af.setImage(withURL: imageUrl)
    }
    
    @IBAction func deleteCartItemAction(_ sender: UIButton) {
        guard let datasource = datasource else { return }
        self.delegate?.didDelete(cartItemWithId: datasource.menuItem.id)
    }

}
