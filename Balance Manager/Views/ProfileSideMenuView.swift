//
//  ProfileSideMenuView.swift
//  Balance Manager
//
//  Created by Radek Jeník on 1/6/23.
//

import SwiftUI

struct ProfileSideMenuView: View {
    @Binding var profileBtn: Bool
    @State var currentDragOffSetX: CGFloat = 0
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        ZStack{
            HStack{
                VStack(alignment: .center){
                    
                    NavigationLink(destination:{
                        SelectProfileView(hasProfile: true)
                    },label: {
                        VStack{
                            Image(systemName: "person.fill")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                                .cornerRadius(40)
                                .background(
                                    RoundedRectangle(cornerRadius: 100)
                                        .foregroundColor(Color("AccentColor"))
                                        .frame(width: 60, height: 60)
                                )
                                .padding()

                            Text("Michael's Profile")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title)
                        }
                        .opacity(0.85)
                        .padding(.bottom, 25)
                        
                        
                    })
                    
                    Spacer()
                    
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
                                if value.translation.width < -180 {
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
    }
}
