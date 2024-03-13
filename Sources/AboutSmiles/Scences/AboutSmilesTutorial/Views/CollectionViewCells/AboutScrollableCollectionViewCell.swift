//
//  AboutScrollableCollectionViewCell.swift
//
//
//  Created by Ghullam  Abbas on 22/02/2024.
//

import UIKit
import SmilesPageController
import SmilesUtilities


final class AboutScrollableCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var foregroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configData(model: StoriesUIModel) {
        
        foregroundImageView.setImageWithUrlString(model.imageUrl.asStringOrEmpty(), backgroundColor: .white) { [weak self] image in
            if let image = image {
                self?.foregroundImageView.image = image
            }
        }
    }
}

