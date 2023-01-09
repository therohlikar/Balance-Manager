//
//  SelectProfileView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 1/9/23.
//

import SwiftUI

struct SelectProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State var hasProfile: Bool
    
    var body: some View {
        VStack{
            if profileViewModel.getCurrentProfileList().count > 0 {
                ScrollView{
                    ForEach(profileViewModel.getCurrentProfileList()) { profile in
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
                        .onTapGesture {
                            //select new profile
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
        .navigationBarBackButtonHidden(!hasProfile)
    }
    
}

struct SelectProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SelectProfileView(hasProfile: false)
            .environmentObject(BalanceViewModel())
            .environmentObject(ProfileViewModel())
    }
}
