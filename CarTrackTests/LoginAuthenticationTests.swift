//
//  LoginAuthenticationTests.swift
//  CarTrackTests
//
//  Created by SCTT CDMS on 6/5/21.
//

import XCTest
@testable import CarTrack

class LoginAuthenticationTests: XCTestCase {

    func test_Get_Country_Response(){
        
        //Arrangement
        let loginVM = LoginVM()
        
        //Act return northing or nil
        loginVM.fetchCountries()
        XCTAssertNotNil(loginVM.countries)
    }
    
    func test_Login_validation_with_validRequest(){
        
        //Arrangement
        let loginReuest = LoginRequest(userName: "car", password: "1234")
        let loginVM = LoginVM()
        
        // Act testing not nil value
        do {
            try loginVM.validate(request: loginReuest)
            XCTAssertNotNil(loginReuest)
        }
        catch{
            
        }
    }
    
    func test_Login_validation_with_InValidRequest(){
        
        //Arrangement
        let loginReuest = LoginRequest(userName: "", password: "1234")
        let loginVM = LoginVM()
        
        // Act testing nil value
        do {
            try loginVM.validate(request: loginReuest)
            XCTAssertNil(loginReuest)
        }
        catch{
            
        }
    }
    
    func test_Login_authentication_with_validRequest_Returns_Success(){
        
        //Arrangement
        let loginReuest = LoginRequest(userName: "car", password: "1234")
        let loginVM = LoginVM()
        
        //ACT authentication success
        loginVM.userAuthentication(requestFields: loginReuest) { result in
            
            switch result {
                case .success(let trueValue):
                    XCTAssert(trueValue)
                case .failure(let error):
                    XCTAssertNil(error)
            }
        }
    }
    
    func test_Login_authentication_with_validRequest_Returns_Failure(){
        
        //Arrangement
        let loginReuest = LoginRequest(userName: "Track", password: "1234")
        let loginVM = LoginVM()
        
        //ACT authentication failure
        loginVM.userAuthentication(requestFields: loginReuest) { result in
            
            switch result {
                case .success(let trueValue):
                    XCTAssertNil(trueValue)
                case .failure(let error):
                    XCTAssertNotNil(error)
            }
        }
    }
    
}
