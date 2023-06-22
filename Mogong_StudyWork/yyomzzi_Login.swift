//
//  yyomzzi_Login.swift
//  Mogong_StudyWork
//
//  Created by 안지영 on 2023/06/22.
//

import SwiftUI

struct yyomzzi_Login: View {
    
    @State var id: String = ""
    @State var password: String = ""
    
    // 암호화된 패스워드 보여주는 눈깔토글에 쓰이는 Bool 타입 변수
    @State var showPassword: Bool = false
    
    // 이용약관 동의하냐는 토글에 쓰이는 Bool 타입 변수
    @State var agreeToTerms: Bool = true
    
    // 로그인이 되었는지 실패했는지 보여주는 텍스트에 담을 String 변수
    @State var loginResult = ""
    
    //요기까지 변수끝. @State 를 통해 변화하는 값을 받아서 다시 뷰를 그려주기
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                // 로그인 화면 제목
                Text("Log in")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                    .padding(.bottom, 40)
                Spacer()
            }
            
            HStack {
                // 아이디랑 비밀번호 입력하라는 표시
                Text("Introduce your credentials")
                    .font(.system(size: 22))
                Spacer()
            }
            
            Group {
                // 이메일로 로그인하는 입력 텍스트필드. id 값을 받아서 넣습니당.
                TextField("  Enter your E-mail", text: $id)
                    .frame(height: 60)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .padding(.bottom, 20)
                //자동완성 해제
                
                
                /*
                 비밀번호 처럼 암호화해서 입력하고 싶을때는 SecureField
                 만약 showPassword 토글 버튼이 true 면 그냥 텍필로 비밀번호 보여주고
                 false 면 secureField로 암호화해서 보여달라는~
                 */
                HStack {
                    if showPassword {
                        
                        TextField("  Enter your password", text: $password)
                            .frame(height: 60)
                            .background(Color.clear)
                            .autocapitalization(.none)
                        
                    } else {
                        SecureField("  Enter your password", text: $password)
                            .frame(height: 60)
                            .background(Color.clear)
                            .autocapitalization(.none)
                    }
                    
                    
                    //하.. 얘를 구현하면 좋은데.. 텍필 안에다가 넣고싶은데.. 우케해야하지..?
                    // ==> Stack의 테두리를 추가하면 됨!! .overlay 사용하면가능!
                    
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: "eye")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
            }
            
            // 이용약관에 체크하는 토글
            Toggle("Agree to terms and conditions", isOn: $agreeToTerms)
                .font(.system(size: 20))
                .padding(.top,20)
            
            Spacer()
            
            // 로그인이 잘되었는지 우쨌는지 보여주는 텍스트. 밑에 함수에 따라서 달라짐
            Text(loginResult)
                .foregroundColor(.red)
            
            // 로그인하는 버튼. 버튼을 누르면 loginCheck() 함수가 실행되고, 그에 따라서 위의 텍스트가 달라짐
            Button {
                loginCheck()
            } label: {
                Text("Sign in")
                    .font(.system(size: 25))
                    .frame(width: 300, height: 35)
            }
            .buttonStyle(.borderedProminent)
            
            /*
             대박..
             buttonStyle을 적용하면 frame 이 안먹음
             그래서 frame 조절을 하려면 버튼 내부에다가 구현을 해서
             프레임 조절한 버튼의 스타일을 그 후에 지정해줘야함 ㅜ 대박발견 ㅜ
             */
            
            
            Spacer()
            
            
        }
        
        .padding()
    }
    
    // login 체크하는 함수. 아이디랑 패스워드를 조건절로 확인해서 성공했는지 우쨌는지 알랴줌
    func loginCheck() {
        if id == "yyomzzi@gmail.com" && password == "1234" {
            loginResult = "성공적으로 로그인이 되었습니다."
        } else if id == "" && password == "" {
            loginResult = "아이디와 비밀번호를 입력해주세요."
        } else if id != "yyomzzi@gmail.com" || password != "1234"{
            loginResult = "아이디 혹은 비밀번호가 일치하지 않습니다."
        }
    }
}

struct yyomzzi_Login_Previews: PreviewProvider {
    static var previews: some View {
        yyomzzi_Login()
    }
}
