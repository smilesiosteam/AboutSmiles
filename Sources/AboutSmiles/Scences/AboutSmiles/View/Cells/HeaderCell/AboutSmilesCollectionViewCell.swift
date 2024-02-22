//
//  AboutSmilesCollectionViewCell.swift
//  
//
//  Created by Ahmed Naguib on 22/02/2024.
//

import UIKit
import SmilesFontsManager

final class AboutSmilesCollectionViewCell: UICollectionReusableView {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Functions
    func configCell(with title: String) {
        titleLabel.text = title
//        titleLabel
    }
}
