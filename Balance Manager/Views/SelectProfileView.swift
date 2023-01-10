//
//  SelectProfileView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 1/9/23.
//

import SwiftUI

struct SelectProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var hasProfile: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                if hasProfile {
                    ScrollView{
                        ForEach(profileViewModel.getCurrentProfileList()) { profile in
                            NavigationLink {
                                //open profile's balance
                                BalanceView(balanceViewModel: BalanceViewModel(profile: profile))
                            } label: {
                                HStack{
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.black)
                                        .cornerRadius(40)
                                        .background(
                                            RoundedRectangle(cornerRadius: 100)
                                                .foregroundColor(Color("AccentColor"))
                                                .frame(width: 30, height: 30)
                                        )
                                        .padding()
                                    
                                    Spacer()
                                    
                                    Text(profile.nickname.uppercased())
                                        .foregroundColor(Color("AccentColor"))
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                }
                                .font(.headline)
                                .padding(.horizontal, 30)
                                .opacity(0.85)
                            }
                        }
                        
                    }
                    .padding(.vertical, 40)
                }else{
                    Spacer()
                    VStack{
                        Text("There is no profile created yet. ")
                        Text("Click on the button below to create one.")
                    }
                    .padding(40)
                    .font(.headline)
                }
                
                Spacer()
                
                Button(action: {
                    // open sheet with creating profile view
                }, label: {
                    Text("Create new profile")
                })
                
            }
            .onAppear{
                hasProfile = profileViewModel.getCurrentProfileList().count > 0
            }
            
        }
        .navigationBarBackButtonHidden()
    }
    
}

struct SelectProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SelectProfileView()
            .environmentObject(ProfileViewModel())
            .preferredColorScheme(.dark)
    }
}
