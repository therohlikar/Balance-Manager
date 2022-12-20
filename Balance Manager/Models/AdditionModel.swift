//
//  AdditionModel.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import Foundation

struct AdditionModel: Identifiable, Codable{
    let id: String
    let subject: String
    let date: Date
    let amount: Int
    let isLocked: Bool
    
    init(id: String = UUID().uuidString, subject: String, date:Date, amount: Int, isLocked: Bool){
        self.id = id
        self.subject = subject
        self.date = date
        self.amount = amount
        self.isLocked = isLocked
    }
    
    func update(newAddition: AdditionModel) -> AdditionModel {
        return AdditionModel(subject: newAddition.subject, date: newAddition.date, amount: newAddition.amount, isLocked: newAddition.isLocked)
    }
}
