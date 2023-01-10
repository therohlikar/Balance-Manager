//
//  BalanceRowView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct BalanceRowView: View {
    @StateObject var balanceViewModel: BalanceViewModel
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
            BalanceRowDetailView(balanceViewModel: balanceViewModel, currentAddition: currentAddition)
        })
        .onTapGesture {
            isShowingDetail.toggle()
        }
        .padding(5)
        
    }
}

struct BalanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceRowView(balanceViewModel: BalanceViewModel(profile: ProfileModel(nickname: "NONAME", icon: "person.fill")), currentAddition: AdditionModel(subject: "Test", date: .now, amount: 500, isLocked: false))
    }
}
