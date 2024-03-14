//
//  FAQViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Ahmed Naguib on 21/02/2024.
//

import UIKit
import Combine
import SmilesLoader
import SmilesUtilities

public final class AboutSmilesOffersViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var backButtonOutlet: UIButton! {
        didSet {
            let icon = AppCommonMethods.languageIsArabic() ? "BackArrow_black_Ar" : "BackArrow_black"
            backButtonOutlet.setImage(UIImage(named: icon), for: .normal)
        }
    }
    
    // MARK: - Properties
    private let layout = AboutSmilesLayout()
    private let viewModel: AboutSmilesViewModel
    private var cancellables = Set<AnyCancellable>()
    private var sections:  [AboutSmilesSections] = []
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
        viewModel.loadData()
    }
    
    // MARK: - Init
    init(viewModel: AboutSmilesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: AboutSmilesOffersViewController.className, bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    private func bindViewModel() {
        viewModel.statePublisher.sink { [weak self] state in
            guard let self else {
                return
            }
            
            switch state {
            case .success(let models):
                self.sections = models
                self.collectionView.collectionViewLayout = self.layout.create(sections: models)
                self.collectionView.reloadData()
            case .showLoader:
                SmilesLoader.show(isClearBackground: false)
            case .hideLoader:
                SmilesLoader.dismiss()
            case .showError(let message):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showAlertWithOkayOnly(message: message)
                }
            }
        }.store(in: &cancellables)
    }
    
    // MARK: - Button Actions
    @IBAction private func popTapped(_ sender: Any) {
        navigationController?.popViewController()
    }
}

// MARK: - UICollectionViewDataSource
extension AboutSmilesOffersViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let type = sections[safe: section] else {
            return 0
        }
        
        switch type {
        case .offers(offers: let offers):
            return offers.count
        case .faqs(faqs: let faqs):
            return faqs.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let type = sections[safe: indexPath.section] else {
            return .init()
        }
        switch type {
        case .offers(offers: let offers):
            let cell = collectionView.dequeueReusableCell(withClass: OfferCollectionViewCell.self, for: indexPath)
            cell.configCell(viewModel: offers[safe: indexPath.row])
            return cell
        case .faqs(faqs: let faqs):
            let cell = collectionView.dequeueReusableCell(withClass: QuestionCollectionViewCell.self, for: indexPath)
            cell.configCell(viewModel: faqs[safe: indexPath.row])
            cell.didSelect = { [weak self] in
                faqs[safe: indexPath.row]?.isOpen.toggle()
                self?.collectionView.reloadItems(at: [indexPath])
            }
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: Constants.aboutSmilesHeader.rawValue,
                                                                           withReuseIdentifier: AboutSmilesHeaderCollectionViewCell.className,
                                                                           for: indexPath) as? AboutSmilesHeaderCollectionViewCell
        else { return .init() }
        let title = sections[safe: indexPath.section]?.title
        header.configCell(with: title)
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension AboutSmilesOffersViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedSection = sections[safe: indexPath.section],
              case .offers(offers: let offers) = selectedSection,
              let selectedOffer = offers[safe: indexPath.row]
        else {
            return
        }
        
        let detailsView = AboutSmilesConfigurator.getAboutSmilesTutorialView(offers: selectedOffer.stories)
        detailsView.modalPresentationStyle = .fullScreen
        present(detailsView, animated: true)
    }
}
