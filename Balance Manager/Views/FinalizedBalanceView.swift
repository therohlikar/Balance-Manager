//
//  FinalizedBalanceView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct FinalizedBalanceView: View {
    @EnvironmentObject var balanceViewModel: BalanceViewModel
    @State var isCreatingNew: Bool = false

    @State var isNegative:Bool = false
    
    var body: some View {
        HStack(alignment: .center){
            Button {
                isNegative = true
                isCreatingNew.toggle()
            } label: {
                Image(systemName: "minus.circle")
                    .tint(.red)
            }
            
            
            VStack{
                Text("\(balanceViewModel.finalBalance)")
                    .bold()
                Text("CZK")
                    .font(.caption2)
            }
            .padding(.horizontal, 20)
            
            
            Button {
                isNegative = false
                isCreatingNew.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .tint(.green)
            }
        }
        .font(.title)
        .sheet(isPresented: $isCreatingNew, content: {
            BalanceRowDetailView(currentAddition: AdditionModel(subject: "", date: .now, amount: 0, isLocked: false, isNegative: isNegative))
        })
    }
}

struct FinalizedBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinalizedBalanceView()
    }
}
