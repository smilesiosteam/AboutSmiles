//
//  FAQViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Ahmed Naguib on 21/02/2024.
//

import UIKit
import Combine

public final class AboutSmilesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let layout = AboutSmilesLayout()
    private let viewModel = AboutSmilesViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var sections:  [AboutSmilesSections] = []
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
       
        
        viewModel.state.sink { state in
            switch state {
            case .success(let models):
                self.sections = models
                self.collectionView.collectionViewLayout = self.layout.create(sections: models)
                self.collectionView.reloadData()
            }
            
        }
        .store(in: &cancellables)
        viewModel.loadData()
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
        collectionView.collectionViewLayout = layout.create(sections: sections)
        
        collectionView.register(UINib(nibName: OfferCollectionViewCell.className, bundle: .module),
                                forCellWithReuseIdentifier: OfferCollectionViewCell.className)
        collectionView.register(UINib(nibName: QuestionCollectionViewCell.className, bundle: .module),
                                forCellWithReuseIdentifier: QuestionCollectionViewCell.className)
        
        collectionView.register(
            UINib(nibName: AboutSmilesHeaderCollectionViewCell.className, bundle: .module),
            forSupplementaryViewOfKind: Constants.aboutSmilesHeader.rawValue,
            withReuseIdentifier: AboutSmilesHeaderCollectionViewCell.className)
    }
    
    @IBAction private func popTapped(_ sender: Any) {
        navigationController?.popViewController()
    }
    
}

extension AboutSmilesViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
            
        case .offers(offers: let offers):
            return offers.count
        case .faqs(faqs: let faqs):
            return faqs.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]        
        switch type {
        case .offers(offers: let offers):
            let cell = collectionView.dequeueReusableCell(withClass: OfferCollectionViewCell.self, for: indexPath)
            cell.configCell(viewModel: offers[indexPath.row])
            return cell
        case .faqs(faqs: let faqs):
            let cell = collectionView.dequeueReusableCell(withClass: QuestionCollectionViewCell.self, for: indexPath)
            cell.configCell(viewModel: faqs[indexPath.row])
            cell.didSelect = { [weak self] in
                faqs[indexPath.row].isOpen = !(( faqs[indexPath.row].isOpen) )
                
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
