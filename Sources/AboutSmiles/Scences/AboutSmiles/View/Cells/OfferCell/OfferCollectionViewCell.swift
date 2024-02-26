//
//  OfferCollectionViewCell.swift
//  CompositionalLayoutDemo
//
//  Created by Ahmed Naguib on 21/02/2024.
//

import UIKit
import SmilesFontsManager

final class OfferCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageOffer: UIImageView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        imageOffer.layer.cornerRadius = 12
    }
    
    // MARK: - Functions
    func configCell(viewModel: ViewModel) {
        titleLabel.text = "Get the best \n of Smiles "
        titleLabel.fontTextStyle = .smilesTitle2
    }
}

extension OfferCollectionViewCell {
    struct ViewModel {
        var title: String?
        var image: String?
    }
}



