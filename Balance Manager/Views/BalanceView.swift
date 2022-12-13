//
//  BalanceView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct BalanceView: View {
    
    private var additions: [AdditionModel] = [
        AdditionModel(subject: "asdfdghsfhghjkghjk", date: .now, amount: 100, isLocked: false),
        AdditionModel(subject: "Sex work", date: .now, amount: -600, isLocked: false),
        AdditionModel(subject: "Me", date: .now, amount: -500, isLocked: false),
        AdditionModel(subject: "Jacob", date: .now, amount: -400, isLocked: false),
        AdditionModel(subject: "Me", date: .now, amount: 300, isLocked: false),
        AdditionModel(subject: "Jacob", date: .now, amount: -200, isLocked: false),
    ]
    
    var body: some View {
        VStack{
            List{
                ForEach(additions){ addition in
                    BalanceRowView(currentAddition: addition)
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
    }
}
