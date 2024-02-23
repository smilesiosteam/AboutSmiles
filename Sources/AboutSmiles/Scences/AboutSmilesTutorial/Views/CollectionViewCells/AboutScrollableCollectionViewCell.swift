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
    
    // MARK: - Outltes
    @IBOutlet private weak var backgroundColorView: UIView!
    @IBOutlet private weak var foregroundImageView: UIView!
    @IBOutlet private weak var roundedView: UIView!
    @IBOutlet  weak var pageController: JXPageControlJump!
    @IBOutlet private weak var pageControlHeight: NSLayoutConstraint!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var descriptionLable: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var goToExplorerButton: UIButton!
    
    public var showPageControl = false {
        didSet {
            if !showPageControl {
                pageController.isHidden = true
                pageControlHeight.constant = 0
                layoutIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pageController.currentIndex = 0
        pageController.activeColor = .appRevampPurpleMainColor
        self.roundTopCorners(of:roundedView , by: 20)
        // Initialization code
        if AppCommonMethods.languageIsArabic() {
            pageController.transform = CGAffineTransform(rotationAngle: .pi)
        }
        pageController.contentAlignment = JXPageControlAlignment(.left,.center)
    }
    
   private func roundTopCorners(of view: UIView, by radius: CGFloat) {
       
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = radius
    }
    
}
