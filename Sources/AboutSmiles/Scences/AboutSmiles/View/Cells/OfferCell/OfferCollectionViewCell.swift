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
    func configCell(viewModel: OfferUIModel) {
        titleLabel.text = viewModel.title
        titleLabel.fontTextStyle = .smilesTitle2
    }
}
