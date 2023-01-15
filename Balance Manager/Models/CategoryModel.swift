//
//  CategoryModel.swift
//  Balance Manager
//
//  Created by Radek Jeník on 1/15/23.
//

import Foundation

struct CategoryModel: Identifiable, Codable{
    let id: String
    let name: String
    let icon: String
    let color: String
    let paymentName: String
    
    init(id: String = UUID().uuidString, name: String, icon:String, color: String, paymentName: String?){
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
        self.paymentName = paymentName ?? name
    }
}
