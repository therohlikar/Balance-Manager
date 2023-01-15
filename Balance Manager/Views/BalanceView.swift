//
//  BalanceView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 12/13/22.
//

import SwiftUI

struct BalanceView: View {
    @StateObject var balanceViewModel: BalanceViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @State var profileBtn: Bool = false

    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Button {
                        profileBtn.toggle()
                    } label: {
                        Image(systemName: "person.fill")
                            .font(.title)
                    }
                    Spacer()
                    
//                    Button {
//
//                    } label: {
//                            Image(systemName: "ellipsis.circle")
//                            .font(.title)
//                    }
                }
                .tint(Color("AccentColor"))
                .padding(.horizontal, 20)
                
                
                Picker("Test", selection: $balanceViewModel.currentSorting) {
                    Image(systemName: "calendar")
                        .tag(BalanceViewModel.SortAndFilter.dateFrom)
                    
                    Image(systemName: "arrow.up")
                        .tag(BalanceViewModel.SortAndFilter.fromLowest)
                    
                    Image(systemName: "arrow.down")
                        .tag(BalanceViewModel.SortAndFilter.fromHighest)
                    
                    Image(systemName: "plus")
                        .tag(BalanceViewModel.SortAndFilter.onlyPositive)
                    
                    Image(systemName: "minus")
                        .tag(BalanceViewModel.SortAndFilter.onlyNegative)
                }
                .padding(.top)
                .padding(.horizontal)
                .pickerStyle(.segmented)
                
                
                List{
                    ForEach(balanceViewModel.formFilteredArray()){ addition in
                        BalanceRowView(balanceViewModel: balanceViewModel, currentAddition: addition)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    balanceViewModel.deleteAddition(addition: addition)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    balanceViewModel.updateAddition(addition: addition, newAddition: AdditionModel(subject: addition.subject, category: addition.category, date: addition.date, amount: addition.amount, isLocked: !addition.isLocked))
                                } label: {
                                    Image(systemName: (addition.isLocked ? "lock.open" : "lock"))
                                }
                                .tint(.yellow)
                            }
                    }

                }
                .listStyle(.plain)

                FinalizedBalanceView(balanceViewModel: balanceViewModel)
            }
            .disabled(profileBtn)
            
            GeometryReader{ _ in
                HStack{
                    ProfileSideMenuView(balanceViewModel: balanceViewModel, profileBtn: $profileBtn)
                        .offset(x: profileBtn ? 0 : -UIScreen.main.bounds.width)
                        
                    
                    Spacer()
                }
            }
        }
        .onAppear{
            profileViewModel.updateCurrentProfile(profile: balanceViewModel.profileConnected)
        }
        .navigationBarBackButtonHidden()
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView(balanceViewModel: BalanceViewModel(profile: ProfileModel(nickname: "NONAME", icon: "person.fill")))
            .environmentObject(ProfileViewModel())
            .preferredColorScheme(.dark)
    }
}
