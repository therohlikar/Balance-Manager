//
//  BalanceViewModel.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import Foundation

class BalanceViewModel:ObservableObject{
    @Published var additions: [AdditionModel] = [] {
        didSet{
            saveAdditions()
            recalculateAdditions()
        }
    }
    @Published var finalBalance : Int = 0
    
    let balanceKey:String = "additions_list"
    
    init(){
        getAdditions()
    }
    
    func getAdditions(){
        guard
            let data = UserDefaults.standard.data(forKey: balanceKey),
            let savedAdditions = try? JSONDecoder().decode([AdditionModel].self, from: data)
        else { return }
        
        self.additions = savedAdditions
        
        recalculateAdditions()
    }
    
    func deleteAddition(addition: AdditionModel){
        if let index = additions.firstIndex(where: {$0.id == addition.id}){
            additions.remove(at: index)
        }
    }
    
    func updateAddition(addition: AdditionModel, newAddition: AdditionModel){
        if let index = additions.firstIndex(where: {$0.id == addition.id}){
            additions[index] = addition.update(newAddition: newAddition)
        }else {
            self.addAddition(addition: newAddition)
        }
    }
    
    func addAddition(addition: AdditionModel){
        additions.append(addition)
    }
    
    func saveAdditions(){
        if let encodedData = try? JSONEncoder().encode(additions){
            UserDefaults.standard.setValue(encodedData, forKey: balanceKey)
        }
    }
    
    func recalculateAdditions(){
        var newBalance:Int = 0
        for addition in additions {
            if addition.isNegative {
                newBalance -= addition.amount
            }else{
                newBalance += addition.amount
            }
        }
        
        self.finalBalance = newBalance
    }
}
