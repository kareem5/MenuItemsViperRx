//
//  OffersView.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import UIKit

fileprivate let offersViewNibName = "OffersView"

class OffersView: UIView, NibLoadable {
    static var nibName: String = offersViewNibName
        
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var offersCollectionView: UICollectionView!
    @IBOutlet weak var bottomCurveView: UIView!

    
    private var offers: [Offer]? = nil {
        didSet {
            if let offers = offers, offers.count > 0,
               offersCollectionView.dataSource == nil {
                self.setupCollectionView()
                self.offersCollectionView.dataSource = self
                self.offersCollectionView.delegate = self
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    private func commonInit() {
        Bundle(for: type(of: self)).loadNibNamed(offersViewNibName, owner: self, options: nil)
        backgroundColor = .clear
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 5.0
        bottomCurveView.layer.masksToBounds = true
        bottomCurveView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        

    }
    
    
    private func setupCollectionView() {
        self.offersCollectionView.register(OfferCollectionViewCell.nib, forCellWithReuseIdentifier: OfferCollectionViewCell.identifier)
    }
    
    func configure(offers: [Offer]) {
        self.offers = offers
    }

}

extension OffersView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.offers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfferCollectionViewCell.identifier, for: indexPath) as? OfferCollectionViewCell else { return UICollectionViewCell() }
        if let offers = offers {
            cell.configure(offer: offers[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.bounds.width, height: 350)
    }
}
