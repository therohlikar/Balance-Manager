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

    var body: some View {
        HStack(alignment: .center){

            VStack{
                Text("\(balanceViewModel.finalBalance)")
                    .bold()
                    .foregroundColor(balanceViewModel.finalBalance > 0 ? .green : .red)
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
            BalanceRowDetailView(currentAddition: AdditionModel(subject: "Unnamed Payment", date: .now, amount: 0, isLocked: false), new: true)
        })
    }
}

struct FinalizedBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinalizedBalanceView()
            .environmentObject(BalanceViewModel())
    }
}
