//
//  BalanceViewModel.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import Foundation

class BalanceViewModel:ObservableObject{
    var profileConnected: ProfileModel
    var balanceKey:String
    
    init(profile: ProfileModel){
        balanceKey = "additions_list_\(profile.nickname.lowercased())"
        profileConnected = profile
        
        getAdditions()
        //getAdditions_Test()
    }
    
    enum SortAndFilter{
        case dateFrom
        case fromLowest
        case fromHighest
        case onlyNegative
        case onlyPositive
    }
    
    @Published var additions: [AdditionModel] = [] {
        didSet{
            saveAdditions()
            recalculateAdditions()
        }
    }
    
    
    @Published var finalBalance : Int = 0
    @Published var currentSorting: SortAndFilter = .dateFrom {
        didSet {
            sortAdditions(by: currentSorting)
        }
    }

    func getAdditions_Test(){
        let testAdditions: [AdditionModel] = [
            AdditionModel(subject: "One", date: .now, amount: 500, isLocked: false),
            AdditionModel(subject: "Two", date: .now, amount: -785, isLocked: true),
            AdditionModel(subject: "Three", date: .now, amount: 223, isLocked: true),
            AdditionModel(subject: "Four", date: Date.now.addingTimeInterval(86400), amount: 566, isLocked: false),
            AdditionModel(subject: "Five", date: .now, amount: -212, isLocked: false),
            AdditionModel(subject: "Six", date: .now, amount: 221, isLocked: false),
        ]
        
        self.additions = testAdditions
        sortAdditions(by: currentSorting)
        recalculateAdditions()
    }
    
    func getAdditions(){
        guard
            let data = UserDefaults.standard.data(forKey: balanceKey),
            let savedAdditions = try? JSONDecoder().decode([AdditionModel].self, from: data)
        else { return }
        
        self.additions = savedAdditions
        sortAdditions(by: .dateFrom)
        recalculateAdditions()
    }
    
    func deleteAddition(addition: AdditionModel){
        if let index = additions.firstIndex(where: {$0.id == addition.id}){
            additions.remove(at: index)
            
            sortAdditions(by: currentSorting)
        }
    }
    
    func updateAddition(addition: AdditionModel, newAddition: AdditionModel){
        if let index = additions.firstIndex(where: {$0.id == addition.id}){
            additions[index] = addition.update(newAddition: newAddition)
        }else {
            self.addAddition(addition: newAddition)
        }
        
        sortAdditions(by: currentSorting)
    }
    
    func addAddition(addition: AdditionModel){
        additions.append(addition)
        
        sortAdditions(by: currentSorting)
    }
    
    func saveAdditions(){
        if let encodedData = try? JSONEncoder().encode(additions){
            UserDefaults.standard.setValue(encodedData, forKey: balanceKey)
        }
    }
    
    func sortAdditions(by: SortAndFilter){
        switch(by){
        case .dateFrom:
            self.additions.sort{
                $0.date > $1.date
            }
        case .fromLowest:
            self.additions.sort{
                $0.amount < $1.amount
            }
        case .fromHighest:
            self.additions.sort{
                $0.amount > $1.amount
            }
        default:
            self.additions.sort{
                $0.date > $1.date
            }
        }
    }
    
    func getCurrentAdditions() -> [AdditionModel]{
        var tempAdditions: [AdditionModel] = self.additions
        
        if self.currentSorting == .onlyNegative {
            tempAdditions = tempAdditions.filter{
                $0.amount <= 0
            }
        }else if self.currentSorting == .onlyPositive {
            tempAdditions = tempAdditions.filter{
                $0.amount > 0
            }
        }
        
        return tempAdditions
    }

    func recalculateAdditions(){
        var newBalance:Int = 0
        for addition in additions {
            newBalance += addition.amount
        }
        
        self.finalBalance = newBalance
    }
    
    func clearAdditions(){
        self.finalBalance = 0
        self.additions = []
        
        saveAdditions()
        recalculateAdditions()
    }
}
