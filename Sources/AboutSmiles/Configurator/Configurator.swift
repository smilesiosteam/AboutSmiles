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
    
    public static func create(type: ConfiguratorType) -> UIViewController {
        switch type {
        case .aboutSmilesTutorial(let offers):
            let vc = AboutSmilesTutorialViewController()
                vc.collectionsData = offers
            return vc
        case .aboutSmiles:
            return getAboutSmitesView()
        }
    }
    
    private static func getAboutSmitesView() -> UIViewController {
        let offersUseCase = OffersUseCase(repository: repository)
        let faqsUseCase = FAQUseCase(repository: repository)
        let viewModel = AboutSmilesViewModel(faqsViewModel: faqsUseCase, storyUseCase: offersUseCase)
        let view = AboutSmilesViewController(viewModel: viewModel)
        return view
    }
    
    static var network: Requestable {
        NetworkingLayerRequestable(requestTimeOut: 60)
    }
    
    static var repository: AboutSmilesRepositoryProtocol{
        AboutSmilesRepository(networkRequest: network)
    }
}
