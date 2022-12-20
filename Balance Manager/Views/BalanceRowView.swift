//
//  BalanceRowView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct BalanceRowView: View {
    
    var currentAddition: AdditionModel
    @State var isShowingDetail: Bool = false
    
    var body: some View {
        HStack{
            HStack{
                Text(currentAddition.subject)
                    .fontWeight(currentAddition.isLocked ? .bold : .regular)
                Image(systemName: "ellipsis.circle")
                    .font(.caption)
                    .foregroundColor(.blue)
            }

            Spacer()
            
            VStack(alignment: .trailing){
                
                Text("\(currentAddition.amount)")
                    .foregroundColor(currentAddition.amount < 0 ? .red : .green)
                    .bold()
                
                Text("CZK")
                    .font(.caption2)
                
            }
        }
        .sheet(isPresented: $isShowingDetail, content: {
            BalanceRowDetailView(currentAddition: currentAddition)
        })
        .onTapGesture {
            isShowingDetail.toggle()
        }
        .padding(5)
        
    }
}

struct BalanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceRowView(currentAddition: AdditionModel(subject: "Test", date: .now, amount: 500, isLocked: false))
    }
}
