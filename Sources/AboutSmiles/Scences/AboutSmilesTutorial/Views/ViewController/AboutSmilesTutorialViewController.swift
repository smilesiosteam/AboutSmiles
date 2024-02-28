//
//  AboutSmilesTutorialViewController.swift
//  
//
//  Created by Ghullam  Abbas on 22/02/2024.
//

import UIKit
import SmilesUtilities
import SmilesPageController

final class AboutSmilesTutorialViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
     var collectionsData: [StoriesUIModel]?
     static let module = Bundle.module
    
     var delegate: AboutSmilesDelegate!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }
    
    init() {
        super.init(nibName: AboutSmilesTutorialViewController.className, bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(self.view.frame.size.height)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            
            return section
        }
        return layout
    }
    
    // MARK: - Functions
    private func configCollectionView() {
        collectionView.register(UINib(nibName: AboutScrollableCollectionViewCell.className, bundle: .module),
            forCellWithReuseIdentifier: AboutScrollableCollectionViewCell.className)
        
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
    }
}

extension AboutSmilesTutorialViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, AboutScrollableCollectionCellDelegate {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return collectionsData?.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withClass: AboutScrollableCollectionViewCell.self, for: indexPath)
         cell.pageController.isHidden = collectionsData?.count == 1
         cell.pageController.numberOfPages = collectionsData?.count ?? 0
         cell.pageController.currentPage = indexPath.row
         cell.delegate = self
         if let item = self.collectionsData?[indexPath.row] {
             cell.configCell(model: item)
         }
         
        return cell
    }
    func didTabCrossButton() {
        dismiss()
    }
    func didTabGoButton(index: Int) {
        let item = self.collectionsData?[index]
        if let urlString = item?.buttonOneUrl {
            delegate.handleDeepLinkRedirection(redirectionUrl: urlString)
        }
        
        
    }
    func didTabNextButton() {
        // Assuming collectionView is your UICollectionView instance
        let currentIndex = collectionView.indexPathsForVisibleItems.first?.item ?? 0
        let numberOfItems = collectionView.numberOfItems(inSection: 0)

        var nextIndex = currentIndex + 1

        // Check if the next index exceeds the maximum value
        if nextIndex >= numberOfItems {
            // Reset to 0 when reached the maximum value
            nextIndex = 0
        }

        let nextIndexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)

    }
}
