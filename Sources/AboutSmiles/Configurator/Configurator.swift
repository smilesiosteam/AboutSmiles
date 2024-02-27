//
//  File.swift
//  
//
//  Created by Ghullam  Abbas on 22/02/2024.
//

import Foundation
import UIKit

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
            return AboutSmilesViewController()
        }
    }
}
