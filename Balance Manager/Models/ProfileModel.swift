//
//  ProfileModel.swift
//  Balance Manager
//
//  Created by Radek Jeník on 1/7/23.
//

import Foundation
struct ProfileModel: Identifiable, Codable{
    let id: String
    let nickname: String
    let icon: String
    
    init(id: String = UUID().uuidString, nickname: String, icon:String){
        self.id = id
        self.nickname = nickname
        self.icon = icon
    }
    
    func update(newProfile: ProfileModel) -> ProfileModel {
        return ProfileModel(nickname: newProfile.nickname, icon: newProfile.icon)
    }
}
