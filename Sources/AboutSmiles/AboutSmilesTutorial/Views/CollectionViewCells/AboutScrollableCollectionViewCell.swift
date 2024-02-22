//
//  AboutScrollableCollectionViewCell.swift
//  
//
//  Created by Ghullam  Abbas on 22/02/2024.
//

import UIKit
import SmilesPageController

class AboutScrollableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var foregroundImageView: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var pageController: JXPageControlJump!
    @IBOutlet weak var pageControlHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var goToExplorerButton: UIButton!
    
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
    }
    func roundTopCorners(of view: UIView, by radius: CGFloat) {
            let path = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: radius, height: radius))

            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            view.layer.mask = maskLayer
    }
}
