//
//  FAQLayout.swift
//  CompositionalLayoutDemo
//
//  Created by Ahmed Naguib on 22/02/2024.
//

import UIKit

final class AboutSmilesLayout {
    
    func create(sections: [AboutSmilesSections]) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            let section = sections[sectionIndex]
            switch section {
            case .offers:
                return self?.offersLayout(layoutEnvironment)
            case .faqs:
                return self?.faqsLayout()
            }
        }
        // Layout
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 0
        layout.configuration = configuration
        
        return layout
    }
    
    private func faqsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 30, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 24
        section.boundarySupplementaryItems = [createHeaderItem()]
        return section
    }
    
    private func offersLayout(_ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // First item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(layoutEnvironment.container.contentSize.width / 3), heightDimension: .absolute(210))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 16, leading: 0, bottom: 20, trailing: 0)
        section.boundarySupplementaryItems = [createHeaderItem()]
        return section
    }
    
    private func createHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(28))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: Constants.aboutSmilesHeader.rawValue, alignment: .top)
        return header
    }
}
