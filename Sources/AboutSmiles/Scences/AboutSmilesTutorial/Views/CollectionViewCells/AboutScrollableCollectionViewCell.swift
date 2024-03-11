//
//  AboutScrollableCollectionViewCell.swift
//  
//
//  Created by Ghullam  Abbas on 22/02/2024.
//

import UIKit
import SmilesPageController
import SmilesUtilities

protocol AboutScrollableCollectionCellDelegate: AnyObject {
    func didTabCrossButton()
    func didTabNextButton(cell: AboutScrollableCollectionViewCell)
    func didTabGoButton(index: Int)
}

final class AboutScrollableCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var backgroundColorView: UIView!
    @IBOutlet private weak var foregroundImageView: UIImageView!
    @IBOutlet private weak var roundedView: UIView!
    @IBOutlet  weak var pageController: JXPageControlJump!
    @IBOutlet private weak var pageControlHeight: NSLayoutConstraint!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var descriptionLable: UILabel!
    @IBOutlet  weak var nextButton: UIButton!
    @IBOutlet private weak var goToExplorerButton: UIButton!
    
    weak var delegate: AboutScrollableCollectionCellDelegate?
    
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
        setupAppearance()
        pageController.currentIndex = 0
        pageController.activeColor = .appRevampPurpleMainColor
        roundTopCorners(of: roundedView, by: 20)
        // Initialization code
        if AppCommonMethods.languageIsArabic() {
            pageController.transform = CGAffineTransform(rotationAngle: .pi)
        }
        pageController.contentAlignment = JXPageControlAlignment(.left,.center)
    }
    // MARK: - Functions
    func configCell(model: StoriesUIModel) {
       
        titleLable.text = model.title
        descriptionLable.text = model.description
        nextButton.setTitle(model.buttonSecondText, for: .normal)
        goToExplorerButton.setTitle(model.buttonOneText, for: .normal)
        backgroundColorView.backgroundColor = UIColor(hexString: model.backgroundColor ?? "")
        foregroundImageView.setImageWithUrlString(model.imageUrl.asStringOrEmpty(), backgroundColor: .white) { [weak self] image in
            if let image = image {
                self?.foregroundImageView.image = image
            }
        }
        if let isActive = model.isActive, isActive {
            goToExplorerButton.isUserInteractionEnabled = true
            goToExplorerButton.backgroundColor = .appRevampPurpleMainColor
        } else {
            goToExplorerButton.isUserInteractionEnabled = false
            goToExplorerButton.backgroundColor = UIColor(red: 220/255, green: 223/255, blue: 239/255, alpha: 1)
        }
    }
    
   private func roundTopCorners(of view: UIView, by radius: CGFloat) {
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = radius
    }
    
    private func setupAppearance() {
        titleLable.fontTextStyle =  .smilesHeadline2
        descriptionLable.fontTextStyle =  .smilesBody2
        nextButton.fontTextStyle =  .smilesHeadline4
        goToExplorerButton.fontTextStyle =  .smilesHeadline4
    }
    
    // MARK: - IBActions
    @IBAction private func didTabCrossButton(_ sender: UIButton) {
            delegate?.didTabCrossButton()
    }
    
    @IBAction private func didTabNextButton(_ sender: UIButton) {
            delegate?.didTabNextButton(cell: self)
    }
    
    @IBAction private func didTabGoButton(_ sender: UIButton) {
        delegate?.didTabGoButton(index: sender.tag)
    }
}

