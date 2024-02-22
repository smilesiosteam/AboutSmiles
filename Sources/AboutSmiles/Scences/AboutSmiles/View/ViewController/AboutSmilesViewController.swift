//
//  FAQViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Ahmed Naguib on 21/02/2024.
//

import UIKit

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
    
    // MARK: - Functions
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout.create()
        
        collectionView.register(UINib(nibName: "OfferCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "OfferCollectionViewCell")
        collectionView.register(UINib(nibName: "QuestionCollectionViewCell", bundle: .module), forCellWithReuseIdentifier: "QuestionCollectionViewCell")
        
        collectionView.register(
            UINib(nibName: "AboutSmilesCollectionViewCell", bundle: .module),
            forSupplementaryViewOfKind: "header",
            withReuseIdentifier: "SectionHeader")
//        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "SectionHeader")
    }
}

extension AboutSmilesViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCollectionViewCell", for: indexPath) as! OfferCollectionViewCell
            //            cell.contentView.backgroundColor = .red
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCollectionViewCell", for: indexPath) as! QuestionCollectionViewCell
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "SectionHeader", for: indexPath) as! AboutSmilesCollectionViewCell
//        header.item = "Section Header"
        return header
    }
}


extension UICollectionView {
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(String(describing: name))")
        }
        return cell
    }
}

// MARK: - Create
extension AboutSmilesViewController {
    static public func create() -> AboutSmilesViewController {
        let viewController = AboutSmilesViewController(nibName: String(describing: AboutSmilesViewController.self), bundle: .module)
        return viewController
    }
}
