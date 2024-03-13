//
//  File.swift
//  
//
//  Created by Muhammad Shayan Zahid on 21/06/2023.
//

import UIKit
import SmilesFontsManager
import SmilesUtilities

final class AboutTextSlideCollectionViewCell: UICollectionViewCell {
    
    // MARK: -- Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewUI()
    }
    
    func setupViewUI() {
        
        title.fontTextStyle =  .smilesHeadline2
        subTitle.fontTextStyle =  .smilesBody2
        
        title.textColor = .appRevampFilterTextColor
        
        subTitle.textColor = .appRevampClosingTextGrayColor
    }
    
    func configureCell(with story: StoriesUIModel) {
        title.text = story.title
        subTitle.text = story.description
    }
}
