//
//  AboutSmilesTutorialViewController.swift
//  
//
//  Created by Ghullam  Abbas on 22/02/2024.
//

import UIKit
import SmilesUtilities
import SmilesPageController

class AboutSmilesTutorialViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var collectionsData: [Any]? {
        didSet {
            collectionView?.reloadData()
        }
    }
    public static let module = Bundle.module
   // public var callBack: ((GetTopOffersResponseModel.TopOfferAdsDO) -> ())?
   // public var topAdsCallBack: ((GetTopAdsResponseModel.TopAdsDto.TopAd) -> ())?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCollectionView()
        // Do any additional setup after loading the view.
    }
    
    init() {
       
        super.init(nibName: "AboutSmilesTutorialViewController", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionViewLayout() ->  UICollectionViewCompositionalLayout {
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
        [AboutScrollableCollectionViewCell.self
        ].forEach({
            collectionView.register(
                UINib(nibName: String(describing: $0.self), bundle: .module),
                forCellWithReuseIdentifier: String(describing: $0.self))
        })
        
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AboutSmilesTutorialViewController: UICollectionViewDelegate, UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutScrollableCollectionViewCell", for: indexPath) as? AboutScrollableCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let data = collectionsData?[safe: indexPath.row] as? GetTopOffersResponseModel.TopOfferAdsDO {
//            callBack?(data)
//        } else if let data = collectionsData?[safe: indexPath.row] as? GetTopAdsResponseModel.TopAdsDto.TopAd {
//            topAdsCallBack?(data)
//        }
    }
}
