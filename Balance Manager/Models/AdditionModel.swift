//
//  AdditionModel.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import Foundation

struct AdditionModel: Identifiable{
    let id: String = UUID().uuidString
    
    let subject: String
    let date: Date
    let amount: Int
    let isLocked: Bool
    
}
