//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 23/02/2024.
//

import Foundation
import Combine

final class AboutSmilesViewModel {
    
    // MARK: - Properties
    private let storyUseCase: OffersUseCaseProtocol
    private let faqsViewModel: FAQUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private var stateSubject = PassthroughSubject<State, Never>()
    var statePublisher: AnyPublisher<State, Never> {
        stateSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Init
    init(faqsViewModel: FAQUseCaseProtocol, storyUseCase: OffersUseCaseProtocol) {
        self.faqsViewModel = faqsViewModel
        self.storyUseCase = storyUseCase
    }
    
    // MARK: - Functions
    func loadData() {
        stateSubject.send(.showLoader)
        Publishers.Zip(
            storyUseCase.fetchStories(),
            faqsViewModel.fetchFAQs())
        .sink { [weak self] offers, faqs in
            guard let self else {
                return
            }
            self.stateSubject.send(.hideLoader)
            self.handleResponse(offers: offers, faqs: faqs)
            
        }.store(in: &cancellables)
    }
    
    private func handleResponse(offers: OffersUseCase.State, faqs: FAQUseCase.State) {
        var sections: [AboutSmilesSections] = []
        if let offers = handleOffers(with: offers) {
            sections.append(.offers(offers: offers))
        }
        
        if let faqs = handleFaqs(with: faqs) {
            sections.append(.faqs(faqs: faqs))
        }
        stateSubject.send(.success(models: sections))
    }
    
    private func handleOffers(with state: OffersUseCase.State) -> [OfferUIModel]? {
        switch state {
        case .success(let offers):
            return offers
        case .showError(let message):
            stateSubject.send(.showError(message: message))
        }
        return nil
    }
    
    private func handleFaqs(with state: FAQUseCase.State) -> [QuestionCollectionViewCell.ViewModel]? {
        switch state {
        case .success(let faqs):
            return faqs
        case .showError(let message):
            stateSubject.send(.showError(message: message))
        }
        
        return nil
    }
}

extension AboutSmilesViewModel {
    enum State {
        case success(models: [AboutSmilesSections])
        case showLoader
        case hideLoader
        case showError(message: String)
    }
}
