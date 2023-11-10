//
//  Array.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        self = filter { $0 != element }
    }
    
    func except(_ element: Element) -> Self {
        return filter { $0 != element }
    }
    
    func except(_ elements: [Element]) -> Self {
        return filter { !elements.contains($0) }
    }
}
