//
//  ProfileSideMenuView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 1/6/23.
//

import SwiftUI

struct ProfileSideMenuView: View {
    @ObservedObject var balanceViewModel: BalanceViewModel
    @Binding var profileBtn: Bool
    @State var currentDragOffSetX: CGFloat = 0
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    @State private var showingClearAlert:Bool = false
    @State private var showingDeleteAlert:Bool = false
    @State private var deleteActive:Bool = false
    
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment: .center){
                    NavigationLink(destination:{
                        SelectProfileView()
                    },label: {
                        VStack{
                            Image(systemName: profileViewModel.getCurrentProfile().icon)
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .cornerRadius(40)
                                .background(
                                    RoundedRectangle(cornerRadius: 100)
                                        .foregroundColor(Color("AccentColor"))
                                        .frame(width: 60, height: 60)
                                )
                                .padding()

                            Text("\(profileViewModel.getCurrentProfile().nickname)'s Profile")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title)
                            Text("(Click to change profile)")
                                .font(.caption)
                        }
                        .opacity(0.85)
                        .padding(.bottom, 25)
                    })
                    
                    Button {
                        showingClearAlert.toggle()
                    } label: {
                        Text("Clear current balance")
                            .font(.headline)
                    }
                    .alert(isPresented:$showingClearAlert) {
                        Alert(
                            title: Text("Are you sure you want to clear your balance?"),
                            message: Text("You cannot undo this action."),
                            primaryButton: .destructive(Text("Clear")) {
                                balanceViewModel.clearAdditions()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: SelectProfileView(), isActive: $deleteActive) {
                        EmptyView()
                    }
                    Button(action:{
                        showingDeleteAlert.toggle()
                    },label: {
                        Text("Delete current profile")
                            .font(.headline)
                            .foregroundColor(.red)
                    })
                    .alert(isPresented: $showingDeleteAlert) {
                        Alert(
                            title: Text("Are you sure you want to delete your profile?"),
                            message: Text("You cannot undo this action."),
                            primaryButton: .destructive(Text("Delete")) {
                                deleteActive = true
                                profileViewModel.deleteCurrentProfile()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .padding(36)
                .padding(.horizontal, 20)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .bottom)
                .transition(.move(edge: .leading))
                .animation(.spring(), value: profileBtn)
                .offset(x: currentDragOffSetX)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()){
                                if value.translation.width > 10 {
                                    return
                                }
                                
                                currentDragOffSetX = value.translation.width
                            }
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                                if value.translation.width < -50 {
                                    profileBtn.toggle()
                                }
                                
                                currentDragOffSetX = 0
                            }
                        }
                )
                
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 5, height: 60)
                    .foregroundColor(Color("AccentColor"))
                    .transition(.move(edge: .leading))
                    .animation(.spring(), value: profileBtn)
                    .offset(x: -25)
                    .offset(x: currentDragOffSetX)
                    .opacity(0.75)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
