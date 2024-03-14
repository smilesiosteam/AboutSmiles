//
//  AboutSmilesTutorialViewController.swift
//  
//
//  Created by Ghullam  Abbas on 22/02/2024.
//

import UIKit
import SmilesUtilities
import SmilesPageController
import SmilesTutorials

final class AboutSmilesTutorialViewController: UIViewController {
    
    @IBOutlet private weak var backgroundColorView: UIView!
    @IBOutlet private weak var roundedView: UIView!
    @IBOutlet  weak var pageController: JXPageControlJump!
    @IBOutlet private weak var pageControlHeight: NSLayoutConstraint!
    @IBOutlet  weak var nextButton: UIButton!
    @IBOutlet private weak var goToExplorerButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    private let collectionsData: [StoriesUIModel]
    private weak var delegate: AboutSmilesNavigationDelegate?
    private var currentPageIndex: Int = 0
    
    private var autoScroller: AboutTutorialCollectionViewAutoScroller!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        pageController.currentIndex = 0
        pageController.activeColor = .appRevampPurpleMainColor
        roundTopCorners(of: roundedView, by: 20)
        // Initialization code
        
        setupCollectionView()
        initialSetup()
    }
   
    init(collectionsData: [StoriesUIModel]?, delegate: AboutSmilesNavigationDelegate?) {
        
        self.collectionsData = collectionsData ?? [StoriesUIModel]()
        self.delegate = delegate
        super.init(nibName: AboutSmilesTutorialViewController.className, bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidDisappear(_ animated: Bool) {
        autoScroller.stopTimer()
    }
    // MARK: - Functions
    private func configData(model: StoriesUIModel) {
       
        nextButton.setTitle(model.buttonSecondText, for: .normal)
        goToExplorerButton.setTitle(model.buttonOneText, for: .normal)
        titleLabel.text = model.title
        subTitleLabel.text = model.description
        backgroundColorView.backgroundColor = UIColor(hexString: model.backgroundColor ?? "#DCDFEF")
        
        
        if let isActive = model.isActive, isActive {
            goToExplorerButton.isUserInteractionEnabled = true
            goToExplorerButton.backgroundColor = .appRevampPurpleMainColor
            goToExplorerButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            goToExplorerButton.isUserInteractionEnabled = false
            goToExplorerButton.backgroundColor = UIColor(red: 220/255, green: 223/255, blue: 239/255, alpha: 1)
            goToExplorerButton.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .normal)
        }
        pageController.currentPage = currentPageIndex
    }
    
   private func roundTopCorners(of view: UIView, by radius: CGFloat) {
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = radius
    }
    
    private func setupAppearance() {
        titleLabel.fontTextStyle =  .smilesHeadline2
        subTitleLabel.fontTextStyle =  .smilesBody2
        nextButton.fontTextStyle =  .smilesHeadline4
        goToExplorerButton.fontTextStyle =  .smilesHeadline4
    }
    private func initialSetup() {
        if AppCommonMethods.languageIsArabic() {
            titleLabel.textAlignment = .right
            subTitleLabel.textAlignment = .right
            collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            pageController.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        collectionView.reloadData()
        autoScroller.resetAutoScroller()
        pageController.currentIndex = 0
        autoScroller.itemsCount = collectionsData.count
        autoScroller.startTimer(interval: getTimeInterval())
        autoScroller.scrollDidFire = { [weak self] currentIndex in
            guard let self = self else { return }
            self.setImage(at: currentIndex)
        }
        pageController.contentAlignment = JXPageControlAlignment(.left, .center)
        
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: String(describing: AboutScrollableCollectionViewCell.self), bundle: Bundle.module), forCellWithReuseIdentifier: String(describing: AboutScrollableCollectionViewCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        autoScroller = AboutTutorialCollectionViewAutoScroller(collectionView: collectionView, itemsCount: 0, currentIndex: 0)
    }
    
    func setupCollectionViewLayout() ->  UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            
            section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
                guard let self = self else { return }
                let page = round(offset.x / self.collectionView.bounds.width)
                self.pageController.currentPage = Int(page)
                self.autoScroller.currentIndex = Int(page)
                self.setImage(at: Int(page))
            }
            return section
        }
        
        return layout
    }
    // MARK: - IBActions
    @IBAction func didTabCrossButton(_ sender: UIButton) {
        dismiss()
    }
    @IBAction func didTabGoButton(index: Int) {
        let item = self.collectionsData[index]
        if let urlString = item.buttonOneUrl {
            delegate?.handleDeepLinkRedirection(redirectionUrl: urlString)
        }
    }
    @IBAction func didTabNextButton(_ sender: UIButton) {
        let currentIndex = currentPageIndex
        let numberOfItems = collectionsData.count
        var nextIndex = currentIndex + 1
        if (nextIndex >= numberOfItems) {
            nextIndex = 0
            currentPageIndex = 0
        }
        let nextIndexPath = IndexPath(item: nextIndex, section: 0)
        self.setImage(at: currentPageIndex)
        collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: -- Helper functions

extension AboutSmilesTutorialViewController {
    private func getTimeInterval() -> Double {
        let interval: Double = 5.0
        return interval
    }
    
    private func setImage(at index: Int) {
        currentPageIndex = index
        configData(model: collectionsData[index])
    }
}

// MARK: -- UICollectionView functions

extension AboutSmilesTutorialViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = collectionsData.count
        
        pageController.numberOfPages = count
        pageController.isHidden = !(count > 1)
        nextButton.isHidden = !(count > 1)
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutScrollableCollectionViewCell", for: indexPath) as? AboutScrollableCollectionViewCell {
       
            cell.configData(model: collectionsData[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
}
