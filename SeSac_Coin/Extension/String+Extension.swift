//
//  String+Extension.swift
//  SeSac_MVVM
//
//  Created by youngjoo on 2/24/24.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        // 여기서의 self 는 현재 사용중인 String의 인스턴스를 참조하는 역할
        return emailTest.evaluate(with: self)
    }
}
