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
        case aboutSmilesTutorial
        case aboutSmiles
    }
    
    public static func create(type: ConfiguratorType) -> UIViewController {
        switch type {
        case .aboutSmilesTutorial:
            return AboutSmilesTutorialViewController()
        case .aboutSmiles:
            return AboutSmilesViewController()
        }
    }
}
