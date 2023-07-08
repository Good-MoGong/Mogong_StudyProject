//
//  LonginSY.swift
//  Mogong_StudyWork
//
//  Created by 박서연 on 2023/06/21.
//

import SwiftUI

// 키보드 enter 누르면 id -> password로 이동하게 만들기
private enum FocusText {
    case id
    case passward
}

// alert 텍스트 enum 수정해보기

struct LoginSY: View {
    
    // 로그인 데이터 생성
    var loginData = LoginData()
    
    @State var id: String = ""
    @State var password: String = ""
    @State var isToggle: Bool = false
    
    @FocusState var firstResponder: Bool // 키보드 첫번째로 포커스 맞추려고 생성한 변수
    @FocusState private var focusField: FocusText? // 엔터키 조절 변수
    @State private var isEditing: Bool = true // 텍스트 필드외의 뷰 터치를 감지하기 위한 변수
    @State var showAlert: Bool = false // 얼럿 상태체크

    // 로그인 체크 함수
    private func loginCheck(id: String, pwd: String) -> Bool {
        for user in loginData.users {
            if user.email == id && user.password == pwd {
                return true // 로그인 성공
            }
        }
        return false
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Log in")
                    .font(.system(size: 70))
                    .fontWeight(.medium)
                    .frame(width: 350, alignment: .leading)
                    .padding(.bottom, 10)
                Spacer()
                
                // 중간 문장
                Text("Introduce your credentials")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // ID 텍스트 필드
                HStack {
                    Image(systemName: "person").frame(width: 20)
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                    TextField("E-mail", text: $id)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .keyboardType(.emailAddress) //email 형식으로 입력 받도록
                        .autocapitalization(.none) // 대문자 설정 지우기
                        .disableAutocorrection(false) // 자동 수정 설정 해제
                        .focused($firstResponder)
                        .focused($focusField, equals: .id)
                        .submitLabel(.next)
                        .onSubmit { focusField = .passward }
                        .onTapGesture { isEditing = true }
                    
                }
                .padding()
                .overlay( RemoveId(id: $id))
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
    
                // Password 텍스트 필드
                HStack {
                    Image(systemName: "key").frame(width: 20)
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                    SecureField("Password", text: $password)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .focused($focusField, equals: .passward)
                        .submitLabel(.continue)
                        .onTapGesture { isEditing = true } // 다른 뷰 눌렀을 때 키보드 내려가도록
                        .onSubmit {
                            focusField = nil
                        }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black, lineWidth: 2))
                .overlay( RemovePassword(password: $password))
                // 토글
                Toggle("Agree to ierms and conditions", isOn: $isToggle)
                    
                Spacer()
                            
                Button {
                    showAlert = true
                } label: {
                    if loginCheck(id: id, pwd: password) && isToggle == true {
                        NavigationLink { LoginSecondView() } label: { SignInButton() }
                    } else if loginCheck(id: id, pwd: password) && isToggle == false {
                        SignInButton()
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("동의 약관을 확인해주세요"), message: Text("이용 약관 확인하기"), dismissButton: .default(Text("확인"))) }
                    } else {
                        SignInButton()
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("로그인 실패"), message: Text("아이디/비밀번호를 확인 해주세요"), dismissButton: .default(Text("확인"))) }
                    }
                    
                }
                
            }
            .padding(20)
            .onTapGesture {
                if isEditing {
                    dismissKeyboard()
                    isEditing = false
                }
            }
            .onAppear {
                firstResponder = true
            }
        }
    }
    
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// 근데 이렇게 view extension 해서 onTapGesture { self.endTextEditing() } 해도 동일함
extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LonginSY_Previews: PreviewProvider {
    static var previews: some View {
        LoginSY()
    }
}
