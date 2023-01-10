//
//  ProfileFormView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 1/10/23.
//

import SwiftUI

struct ProfileFormView: View {
    @State var tfNickname: String = ""
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @Environment(\.dismiss) var dismiss
    
    let iconSet: [String] = ["person.fill", "dollarsign", "network", "centsign", "house.fill", "car.fill", "airplane.circle", "trash", "graduationcap", "laptopcomputer"]
    
    @State var selectedIcon: String = "person.fill"

    var body: some View {
        ZStack{
            VStack(alignment: .center){
                Text("Nickname")
                TextField("blah", text: $tfNickname)
                    .frame(width: 200)
                    .padding(10)
                    .padding(.horizontal, 10)
                    .background(.blue.opacity(0.7))
                    .cornerRadius(25)
                    .padding(.bottom, 25)
                
                Text("Select icon")
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 80))
                ], spacing: 20){
                    ForEach(iconSet, id: \.self) { value in
                        Image(systemName: "\(value)")
                            .foregroundColor(.black)
                            .cornerRadius(40)
                            .background(
                                RoundedRectangle(cornerRadius: 100)
                                    .foregroundColor(selectedIcon == value ? .blue : Color("AccentColor"))
                                    .frame(width: 40, height: 40)
                            )
                            .padding()
                            .onTapGesture {
                                selectedIcon = value
                            }
                    }
                }
                .padding(.bottom, 80)
                
                
                HStack{
                    Button {
                        profileViewModel.createNewProfile(profile: ProfileModel(nickname: tfNickname, icon: selectedIcon))
                        dismiss()
                    } label: {
                        Text("Save profile")
                            .font(.headline)
                            .padding()
                            .padding(.horizontal, 20)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(25)
                    }
                    
                    Button {
                        tfNickname = ""
                        selectedIcon = "person.fill"
                        
                        dismiss()
                    } label: {
                        Image(systemName: "trash")
                            .font(.headline)
                            .padding()
                            .padding(.horizontal, 5)
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(25)
                    }
                }
            }
            .font(.headline)
        }
    }
}

struct ProfileFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFormView()
            .preferredColorScheme(.dark)
    }
}
