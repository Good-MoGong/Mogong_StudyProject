//
//  LoginData.swift
//  Mogong_StudyWork
//
//  Created by 박서연 on 2023/07/06.
//

import Foundation

class LoginData {
    struct User {
        var email: String
        var password: String
    }
    
    var users: [User] = [
        User(email: "aaa@naver.com", password: "aaaaa11111"),
        User(email: "bbb@gmail.com", password: "bbbbb22222")
    ]
    
    // 아이디 형식 검사 -> @ 앞에 알파벳, 숫자, 특수문자가 포함될 수 있고 @ 뒤에는 알파벳, 숫자, 그리고 . 뒤에는 알파벳 2자리 이상
    func isValidEmail(id: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: id)
    }
    
    // 비밀번호 형식 검사 -> 소문자, 대문자, 숫자 8자리 이상
    func isValidPassword(pwd: String) -> Bool {
        let passwordRegEx = "^[a-zA-Z0-9]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: pwd)
    }
} // end of UserModel
