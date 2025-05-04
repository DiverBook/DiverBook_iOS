import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack {
            PrivacyPolicyTopBarView()
            
            //TODO: 개인정보 이용 약관 수정 필요, 현재 임시로 작성
            ScrollView(showsIndicators: false) {
                Text(
                    """
                    이 앱은 사용자 개인정보 보호를 최우선으로 생각합니다.

                    수집하는 항목:
                    - 이름, 전화번호, 관심사 등 사용자 직접 입력 정보
                    - 앱 사용 중 생성되는 로그 데이터

                    수집 목적:
                    - 앱 기능 제공 및 개선
                    - 사용자 맞춤형 서비스 제공

                    보관 기간:
                    - 회원 탈퇴 시 즉시 파기되며, 법령에 따른 예외는 별도로 저장될 수 있습니다.

                    제3자 제공:
                    - 사용자 동의 없이 외부에 제공되지 않습니다.
                    """
                )

                Spacer()
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    NavigationStack {
        PrivacyPolicyView()
    }
}
