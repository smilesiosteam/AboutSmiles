//
//  QuestionCollectionViewCell.swift
//  CellHeight
//
//  Created by Ahmed Naguib on 21/02/2024.
//  Copyright © 2024 Loopwerk. All rights reserved.
//

import UIKit
import SmilesFontsManager

final class QuestionCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var arrowImage: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var answerLabel: UILabel!
   
    // MARK: - Properties
    var didSelect: (() -> Void)?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        answerLabel.isHidden = true
        arrowImage.image = UIImage(named: "dropdownBlack")
        questionLabel.fontTextStyle = .smilesTitle1
        answerLabel.fontTextStyle = .smilesBody3
    }
    
    func configCell(viewModel: ViewModel) {
        answerLabel.text = viewModel.answer
        questionLabel.text = viewModel.question
        answerLabel.isHidden = !viewModel.isOpen
        arrowImage.transform = viewModel.isOpen ? CGAffineTransformMakeRotation(.pi) : CGAffineTransform.identity
    }
    
    @IBAction private func showAnswetTapped(_ sender: Any) {
        didSelect?()
    }
}

extension QuestionCollectionViewCell {
    struct ViewModel {
        var question: String?
        var answer: String?
        var isOpen: Bool = false
        
        static func load() -> [ViewModel] {
            [
                .init(question: "Where’s my points?", answer: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatu"),
                .init(question: "How to check history of what have I earned & spent?", 
                      
                      answer: "I've been digging through the  compositional layout api introduced in iOS 13, hoping to find a solution to the contrived approach of embedding a UITableView inside a UICollectionViewCell. I have used this headache-inducing solution in the past in order to provide horizontal page scrolling with vertical table scrolling at the same time. It is a very cumbersome way of doing things and ever since CompositionalLayout was announced I have been dying to give a shot at refactoring it."),
                
                .init(question: "Unable to redeem at partner outlet. What should I do?", 
                      answer: "his produces a vertical scroll of two items and a horizontal scroll which shows the remaining items in the subsequent pages, but only two per page. My goal is to have the  divided by days of the year and each one should have X number of items which a"),
                
                    .init(question: "Why am I not getting Smiles points for my payment/recharge?", answer: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatu"),
                
                .init(question: "What does Maximum limit reached mean?", answer: "I don't understand the diagram. It's just a static screen shot; I'm not getting a sense for what it's supposed to do. It sounds to me like this should be a horizontally scrolling collection view of days where each gr")
            ]
        }
    }
}
