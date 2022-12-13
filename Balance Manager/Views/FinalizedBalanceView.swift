//
//  FinalizedBalanceView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct FinalizedBalanceView: View {
    var body: some View {
        HStack(alignment: .center){
            Button {
                
            } label: {
                Image(systemName: "minus.circle")
                    .tint(.red)
            }
            
            
            VStack{
                Text("5 123")
                    .bold()
                Text("CZK")
                    .font(.caption2)
            }
            .padding(.horizontal, 20)
            
            
            Button {
                
            } label: {
                Image(systemName: "plus.circle")
                    .tint(.green)
            }
        }
        .font(.title)
    }
}

struct FinalizedBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        FinalizedBalanceView()
    }
}
