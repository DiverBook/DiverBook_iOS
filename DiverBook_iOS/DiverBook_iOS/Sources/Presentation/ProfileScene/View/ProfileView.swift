//
//  ProfileView.swift
//  DiverBook_iOS
//
//  Created by bear on 4/17/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var todaytalk: String = ""
    
    private var divison = "디자인"
    private var phoneNumber = "010-0000-0000"
    private var interests = "사진, 아마스빈"
    private var places = "C5"
    
    @State private var history = ""
    
    var body: some View {
        ScrollView {
            //MARK: Module 1: 프로필 이미지, 이름, 발견일자, 오늘의 한마디
            VStack(spacing: 26) {
                //MARK: 프로필 이미지, 이름, 발결일자
                HStack(spacing: 11){
                    // 미모지 샘플 사용으로 이미지만 '베리'의 내용입니다.
                    PrimaryProfile(image: Image("exMemoji"), style: .basic)
                    
                    VStack(alignment: .leading, spacing: 6){
                        Text("Chloe")
                            .fontWeight(.semibold)
                        
                        Text("발견일자: 25.03.24")
                            .fontWeight(.regular)
                            .foregroundStyle(.blue)
                    }
                    Spacer()
                }
                
                //MARK: 오늘의 한마디
                Rectangle()
                    .frame(height: 55)
                
                
                Spacer(minLength: 26)
                
                //MARK: Module 2: 희망분야, 연락서, 관심사, 자주 가는 장소
                ProfileDetails(divison: divison, phoneNumber: phoneNumber, interests: interests, places: places)
                
                Spacer().frame(height: 50)
                
                //MARK: Module 3: 다이버 기록
                VStack(spacing: 14){
                    HStack{
                        Text("다이버에 대한 기록을 남겨주세요!")
                            .foregroundStyle(DiveColor.color2)
                        Spacer()
                    }
                    
                    CustomTextEditor(text: $history, placeholder: "기록 입력", backgroundColor: UIColor(named: "textbox") ?? UIColor.systemGray6)
                        .frame(height: 140)
                        .shadow(color: Color.black.opacity(0.15), radius: 7, x: 0, y: 2)
                }
                
                Spacer().frame(height: 17)
                
                //MARK: Module 4 : 저장버튼
                RoundedRectangle(cornerRadius: 10)
                    .fill(DiveColor.color4)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Text("저장")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    )
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    ProfileView()
}
