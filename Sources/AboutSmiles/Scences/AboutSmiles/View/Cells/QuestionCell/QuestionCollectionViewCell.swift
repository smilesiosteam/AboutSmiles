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
    
    func configCell(viewModel: ViewModel?) {
        answerLabel.text = viewModel?.answer
        questionLabel.text = viewModel?.question
        answerLabel.isHidden = !(viewModel?.isOpen ?? false)
        arrowImage.transform = (viewModel?.isOpen ?? false) ? CGAffineTransformMakeRotation(.pi) : CGAffineTransform.identity
    }
    
    @IBAction private func showAnswetTapped(_ sender: Any) {
        didSelect?()
    }
}

extension QuestionCollectionViewCell {
    final class ViewModel: Equatable {
        var question: String?
        var answer: String?
        var id: Int?
        var isOpen: Bool = false
        
        init(question: String? = nil, answer: String? = nil, id: Int? = nil) {
            self.question = question
            self.answer = answer
            self.id = id
        }
        
        static func == (lhs: QuestionCollectionViewCell.ViewModel, 
                        rhs: QuestionCollectionViewCell.ViewModel) -> Bool {
            return (lhs.question == rhs.question &&
                    lhs.answer == rhs.answer &&
                    lhs.id == rhs.id &&
                    lhs.isOpen == rhs.isOpen
            )
        }
    }
}
