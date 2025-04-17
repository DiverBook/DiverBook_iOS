//
//  ProfileDetailsView.swift
//  DiverProfile
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct ProfileDetails:  View {
    var divison: String
    var phoneNumber: String
    var interests: String
    var places: String
    
    var body: some View{
        VStack(spacing: 32) {
            //희망분야
            HStack{
                Text("희망분야")
                    .fontWeight(.regular)
                    .foregroundStyle(DiveColor.gray3)
                
                Spacer()
                
                Text(divison)
                    .fontWeight(.semibold)
            }
            
            //연락처
            HStack{
                Text("연락처")
                    .fontWeight(.regular)
                    .foregroundStyle(DiveColor.gray3)
                
                Spacer()
                
                Text(phoneNumber)
                    .fontWeight(.semibold)

            }
            
            //관심사
            HStack{
                Text("관심사")
                    .fontWeight(.regular)
                    .foregroundStyle(DiveColor.gray3)
                
                Spacer()
                
                Text(interests)
                    .fontWeight(.semibold)
            }
            
            HStack{
                Text("자주 가는 장소")
                    .fontWeight(.regular)
                    .foregroundStyle(DiveColor.gray3)
             
                Spacer()
                
                Text(places)
                    .fontWeight(.semibold)
            }
        }
    }
}


