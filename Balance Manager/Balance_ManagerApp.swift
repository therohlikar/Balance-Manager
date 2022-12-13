//
//  Balance_ManagerApp.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

@main
struct Balance_ManagerApp: App {
    
    @StateObject var balanceViewModel: BalanceViewModel = BalanceViewModel()
    
    var body: some Scene {
        WindowGroup {
            BalanceView()
                .environmentObject(balanceViewModel)
        }
    }
}
