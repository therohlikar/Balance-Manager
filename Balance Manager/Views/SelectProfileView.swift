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
    @State var isCreatingNewProfile: Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                if profileViewModel.profiles.count > 0 {
                    ScrollView{
                        ForEach(profileViewModel.profiles) { profile in
                            NavigationLink {
                                //open profile's balance
                                BalanceView(balanceViewModel: BalanceViewModel(profile: profile))
                            } label: {
                                HStack{
                                    Image(systemName: profile.icon)
                                        .foregroundColor(.black)
                                        .cornerRadius(40)
                                        .background(
                                            RoundedRectangle(cornerRadius: 100)
                                                .foregroundColor(Color("AccentColor"))
                                                .frame(width: 30, height: 30)
                                        )
                                        .padding()
                                        .frame(width: 50, height: 50)
                                    
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
                    isCreatingNewProfile.toggle()
                }, label: {
                    Text("Create new profile")
                })
            }
            
            
        }
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $isCreatingNewProfile, content: {
            ProfileFormView(currentProfile: ProfileModel(nickname: "", icon: "person.fill"))
        })
    }
}

struct SelectProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SelectProfileView()
            .environmentObject(ProfileViewModel())
            .preferredColorScheme(.dark)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
