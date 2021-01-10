//
//  OfferCollectionViewCell.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import UIKit
import AlamofireImage

class OfferCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(offer: Offer) {
        self.titleLabel.text = offer.title
        self.descriptionLabel.text = offer.description
        
        guard let imageUrl = URL(string: offer.imageUrl) else { return }
        self.offerImageView.af.setImage(withURL: imageUrl)
    }
}
