//
//  FAQViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Ahmed Naguib on 21/02/2024.
//

import UIKit
import SmilesUtilities


public final class AboutSmilesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var items = QuestionCollectionViewCell.ViewModel.load()
    private let layout = AboutSmilesLayout()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    public init() {
        super.init(nibName: AboutSmilesViewController.className, bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout.create()
        
        collectionView.register(UINib(nibName: OfferCollectionViewCell.className, bundle: .module),
                                forCellWithReuseIdentifier: OfferCollectionViewCell.className)
        collectionView.register(UINib(nibName: QuestionCollectionViewCell.className, bundle: .module),
                                forCellWithReuseIdentifier: QuestionCollectionViewCell.className)
        
        collectionView.register(
            UINib(nibName: AboutSmilesHeaderCollectionViewCell.className, bundle: .module),
            forSupplementaryViewOfKind: Constants.aboutSmilesHeader.rawValue,
            withReuseIdentifier: AboutSmilesHeaderCollectionViewCell.className)
    }
}

extension AboutSmilesViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        AboutSmilesLayout.Section.allCases.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = AboutSmilesLayout.Section(rawValue: indexPath.section) ?? .faqs
        switch type {
        case .offers:
            let cell = collectionView.dequeueReusableCell(withClass: OfferCollectionViewCell.self, for: indexPath)
            cell.configCell(viewModel: .init())
            return cell
        case .faqs:
            let cell = collectionView.dequeueReusableCell(withClass: QuestionCollectionViewCell.self, for: indexPath)
            cell.configCell(viewModel: items[indexPath.row])
            cell.didSelect = { [weak self] in
                self?.items[indexPath.row].isOpen = !((self?.items[indexPath.row].isOpen) ?? false)
                self?.collectionView.reloadItems(at: [indexPath])
            }
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: Constants.aboutSmilesHeader.rawValue, withReuseIdentifier: AboutSmilesHeaderCollectionViewCell.className, for: indexPath) as! AboutSmilesHeaderCollectionViewCell
        header.configCell(with: "Discover offers")
        return header
    }
}
