//
//  FinalizedBalanceView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct FinalizedBalanceView: View {
    @State var isCreatingNew: Bool = false
    @ObservedObject var balanceViewModel: BalanceViewModel

    var body: some View {
        HStack(alignment: .center){

            VStack{
                Text("\(balanceViewModel.finalBalance)")
                    .bold()
                    .foregroundColor(balanceViewModel.finalBalance < 0 ? .red : balanceViewModel.finalBalance > 0 ? .green : .white )
                Text("CZK")
                    .font(.caption2)
            }
            .onTapGesture {
                isCreatingNew.toggle()
            }
            .padding(.horizontal, 20)
        }
        .font(.title)
        .fullScreenCover(isPresented: $isCreatingNew, content: {
            BalanceRowDetailView(balanceViewModel: balanceViewModel, currentAddition: AdditionModel(subject: "Unnamed Payment", date: .now, amount: 0, isLocked: false), new: true)
        })
    }
}

struct FinalizedBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinalizedBalanceView(balanceViewModel: BalanceViewModel(profile: ProfileModel(nickname: "NONAME", icon: "person.fill")))
    }
}
