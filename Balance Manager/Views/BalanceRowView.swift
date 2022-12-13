//
//  BalanceRowView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct BalanceRowView: View {
    
    var currentAddition: AdditionModel
    
    var body: some View {
        HStack{
            HStack{
                Text(currentAddition.subject)
                Image(systemName: "ellipsis.circle")
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            .onTapGesture {
                print(currentAddition.amount)
            }

            Spacer()
            
            VStack(alignment: .trailing){
                
                Text("\(currentAddition.amount)")
                    .foregroundColor(currentAddition.amount > 0 ? .green : .red)
                    .bold()
                
                Text("CZK")
                    .font(.caption2)
                
            }
        }
        .padding(5)
    }
}

struct BalanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceRowView(currentAddition: AdditionModel(subject: "Test", date: .now, amount: 500, isLocked: false))
    }
}
