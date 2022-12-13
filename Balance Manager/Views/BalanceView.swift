//
//  BalanceView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct BalanceView: View {
    
    @EnvironmentObject var balanceViewModel: BalanceViewModel
    var body: some View {
        VStack{
            List{
                ForEach(balanceViewModel.additions){ addition in
                    BalanceRowView(currentAddition: addition)
                    .swipeActions(edge: .trailing) {
                        Button {
                            balanceViewModel.deleteAddition(addition: addition)
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
                    
                    .swipeActions(edge: .leading) {
                        Button {
                            balanceViewModel.updateAddition(addition: addition, newAddition: AdditionModel(subject: addition.subject, date: addition.date, amount: addition.amount, isLocked: !addition.isLocked, isNegative: addition.isNegative))
                        } label: {
                            Image(systemName: (addition.isLocked ? "lock.open" : "lock"))
                        }
                        .tint(.yellow)
                    }
                }
                
            }
            .listStyle(.plain)
            
            
            FinalizedBalanceView()
        }
    }
    
    
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
            .environmentObject(BalanceViewModel())
    }
}
