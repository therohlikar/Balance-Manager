//
//  Balance_ManagerApp.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

@main
struct Balance_ManagerApp: App {
    @StateObject var profileViewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            SelectProfileView()
                .environmentObject(profileViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
