//
//  TodosController.swift
//  SubViews
//
//  Created by Kevin Bjornberg on 1/17/25.
//

import Foundation
import SwiftUI

class TodosController: ObservableObject {
    @Published var sections: [TodoSection]
    
    init() {
        self.sections = TodoSection.dummySections
    }
}
