//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 22/02/2024.
//

import Foundation
import UIKit
import NetworkingLayer

public struct AboutSmilesConfigurator {
    
    public enum ConfiguratorType {
        case aboutSmilesTutorial(stories: [StoriesUIModel]?)
        case aboutSmiles
    }
    
    private static var delegate: AboutSmilesNavigationDelegate? = nil
    
    public static func create(type: ConfiguratorType, delegate: AboutSmilesNavigationDelegate? = nil) -> UIViewController {
        self.delegate = delegate
        switch type {
        case .aboutSmilesTutorial(let offers):
            return getAboutSmilesTutorialView(offers: offers)
        case .aboutSmiles:
            return getAboutSmitesView()
        }
    }
    
    private static func getAboutSmitesView() -> UIViewController {
        let offersUseCase = OffersUseCase(repository: repository)
        let faqsUseCase = FAQUseCase(repository: repository)
        let viewModel = AboutSmilesViewModel(faqsUseCase: faqsUseCase, storyUseCase: offersUseCase)
        let view = AboutSmilesOffersViewController(viewModel: viewModel)
        return view
    }
    
   static func getAboutSmilesTutorialView(offers: [StoriesUIModel]?) -> UIViewController {
        return AboutSmilesTutorialViewController(collectionsData: offers, delegate: delegate)
    }
    
    private static var network: Requestable {
        NetworkingLayerRequestable(requestTimeOut: 60)
    }
    
    private static var repository: AboutSmilesRepositoryProtocol{
        AboutSmilesRepository(networkRequest: network)
    }
}
