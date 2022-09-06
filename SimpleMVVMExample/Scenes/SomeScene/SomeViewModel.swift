//
//  SomeViewModel.swift
//  SimpleMVVMExample
//
//  Created by Yuriy Kudrovskiy on 05.09.2022.
//

import Foundation

// MARK: - Implementation

final class SomeViewModel {
    
    // MARK: - Outputs
    
    var onModelUpdate: ((String) -> Void)?
    
    // MARK: - Dependencies
    
    private let someService: SomeService
    
    // MARK: - Private properties
    
    private var model: SomeModel? {
        willSet {
            guard let value = self.model?.value else { return }
            onModelUpdate?(value)
        }
    }
    
    // MARK: - Lifecycle
    
    init(someService: SomeService) {
        self.someService = someService
    }
    
}

// MARK: - Public (Inputs)

extension SomeViewModel {
    
    func didTapButton() {
        updateModel()
    }
    
}

// MARK: - State managment

private extension SomeViewModel {
    
    func updateModel() {
        SomeService.shared.fetchSomeData {
            model = $0
        }
    }
    
}
