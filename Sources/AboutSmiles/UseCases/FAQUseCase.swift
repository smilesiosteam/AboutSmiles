//
//  File.swift
//
//
//  Created by Ahmed Naguib on 26/02/2024.
//

import Foundation
import Combine

protocol FAQUseCaseProtocol {
    func fetchFAQs() -> AnyPublisher<FAQUseCase.State, Never>
}

final class FAQUseCase {
    
    // MARK: - Properties
    private let repository: AboutSmilesRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(repository: AboutSmilesRepositoryProtocol) {
        self.repository = repository
    }
}

extension FAQUseCase: FAQUseCaseProtocol {
    
    func fetchFAQs() -> AnyPublisher<State, Never> {
        return Future<State, Never> {  [weak self] promise in
            guard let self else {
                return
            }
            self.repository.fetchFaqs().sink { completion in
                if case .failure(let error) = completion {
                    promise(.success(.showError(message: error.localizedDescription)))
                }
            } receiveValue: { response in
                let faqs = response.faqsDetails ?? []
                let faqsUIModels = faqs.map({ self.map($0) })
                promise(.success(.success(faqs: faqsUIModels)))
            }.store(in: &cancellables)
        }
        .eraseToAnyPublisher()
    }
    
    private func map(_ item: FaqsResponseDetail) ->  QuestionCollectionViewCell.ViewModel {
        let model = QuestionCollectionViewCell.ViewModel()
        model.answer = item.faqContent
        model.question = item.faqTitle
        model.id = item.id
        return model
    }
}

extension FAQUseCase {
    enum State {
        case success(faqs: [QuestionCollectionViewCell.ViewModel])
        case showError(message: String)
    }
}
