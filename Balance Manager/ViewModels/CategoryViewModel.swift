//
//  CategoryViewModel.swift
//  Balance Manager
//
//  Created by Radek Jeník on 1/15/23.
//

import Foundation

class CategoryViewModel:ObservableObject{
    init(){
    }
    
    public let categories: [CategoryModel] = [
        CategoryModel(name: "groceries", icon: "basket.fill", color: "cat_groceries", paymentName: nil),
        CategoryModel(name: "fastfood", icon: "takeoutbag.and.cup.and.straw.fill", color: "cat_fastfood", paymentName: nil),
        CategoryModel(name: "streaming", icon: "play.tv", color: "cat_streaming", paymentName: "Netflix, Apple Music, ..."),
        CategoryModel(name: "rent", icon: "house.fill", color: "cat_rent", paymentName: nil),
        CategoryModel(name: "loan", icon: "dollarsign.arrow.circlepath", color: "cat_loan", paymentName: "Loan, insurance..."),
        CategoryModel(name: "paycheck", icon: "newspaper.fill", color: "cat_paycheck", paymentName: nil),
        CategoryModel(name: "cinema", icon: "theatermasks.fill", color: "cat_cinema", paymentName: "Cinema or theatre"),
        CategoryModel(name: "electronics", icon: "macbook.and.iphone", color: "cat_electronics", paymentName: nil),
        CategoryModel(name: "gift", icon: "gift.fill", color: "cat_gift", paymentName: nil),
        CategoryModel(name: "gym", icon: "dumbbell.fill", color: "cat_gym", paymentName: "Sport activity (gym, ...)")
    ]
    
    
    public func getCategoryByName(name:String) -> CategoryModel {
        return self.categories.first { category in
            category.name == name.lowercased()
        } ?? CategoryModel(name: "Unknown", icon: "basket.fill", color: "cat_groceries", paymentName: nil)
    }
    
    public func getCategories() -> [CategoryModel]{
        return categories
    }
}
