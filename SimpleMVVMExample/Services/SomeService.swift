//
//  SomeService.swift
//  SimpleMVVMExample
//
//  Created by Yuriy Kudrovskiy on 04.09.2022.
//

import Foundation

final class SomeService {
    
    static let shared = SomeService()
    
    func fetchSomeData(success: (SomeModel)->()) {
        success(SomeModel(value: Int.random(in: 1...100).description))
    }
    
}
