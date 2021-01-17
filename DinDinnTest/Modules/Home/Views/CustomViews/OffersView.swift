//
//  OffersView.swift
//  DinDinnTest
//
//  Created by Kareem Ahmed on 09/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let offersViewNibName = "OffersView"

class OffersView: UIView, NibLoadable {
    static var nibName: String = offersViewNibName
        
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var offersCollectionView: UICollectionView!
    @IBOutlet weak var bottomCurveView: RoundTopView!

    
    private let disposeBag = DisposeBag()
    
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
        contentView.frame = self.bounds
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 5.0
//        bottomCurveView.layer.masksToBounds = true
//        bottomCurveView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        bottomCurveView.addRoundCorners(corners: [.topLeft, .topRight], radius: 20)
        
        bottomCurveView.backgroundColor = .white
        bottomCurveView.roundCorners(corners: [.topLeft, .topRight], radius: 20)

        setupCollectionView()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        bottomCurveView.layer.cornerRadius = CGFloat(20)
//        bottomCurveView.clipsToBounds = true
//        bottomCurveView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        bottomCurveView.maskByRoundingCorners([.topLeft, .topRight])
    }
    
    
    private func setupCollectionView() {
        self.offersCollectionView.register(OfferCollectionViewCell.nib, forCellWithReuseIdentifier: OfferCollectionViewCell.identifier)
        self.offersCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func configure(dataSource: PublishSubject<[Offer]>) {
        
        dataSource.bind(to: offersCollectionView.rx.items(cellIdentifier: OfferCollectionViewCell.identifier, cellType: OfferCollectionViewCell.self)) { [] index, offer, cell in
            cell.configure(offer: offer)
        }.disposed(by: disposeBag)
        
//        let resu =  offersCollectionView.rx
//            .itemSelected.map { [weak self] ind in
//                print(ind.)
//            }
    }

}

extension OffersView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.bounds.width, height: collectionView.bounds.height)
    }
}
