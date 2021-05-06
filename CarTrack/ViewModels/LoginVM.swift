//
//  LoginVM.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation
import UIKit

class LoginVM {
    
    var countries: [String] = []

    // Fetach countried from locale and save in an array
    func fetchCountries(){
        countries.append("Select Country")
        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
    }
    
    //validate textfield and return result with validation error message
    func validate(request: LoginRequest) throws {
        if request.userName.count == 0 {
            throw TextFieldValidationError.userNameEmpty
            //return ValidationResult(success: false, errorMessage: "Username is empty!")
        }
        else if request.password.count == 0 {
            throw TextFieldValidationError.pwdNameEmpty
            //return ValidationResult(success: false, errorMessage: "Password is empty!")
        }
    }
    
    // On success full validation, do user authentication from local database
    func userAuthentication(requestFields:LoginRequest,completionHandler: @escaping(Result<Bool, AuthenticationError>)  ->Void) {
        let dbHandler = DBHandler()
        dbHandler.offlineLoginValidation(username: requestFields.userName, password: requestFields.password) { result in
            completionHandler(result)
        }
    }
}
