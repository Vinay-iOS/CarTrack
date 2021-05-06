//
//  UserWebServiceTest.swift
//  CarTrackTests
//
//  Created by SCTT CDMS on 6/5/21.
//

import XCTest
@testable import CarTrack
class UserWebServiceTest: XCTestCase {

    
    func test_invalid_URL(){
        
        //Arrangement
        let wshandler = WSHandler()
        let urlStr = "https://jsonplaceholder.typicode.com/users_1234"
        
        //ACT
        wshandler.getUsersAPI(requestURLStr: urlStr) { userDetail, error in
            
            XCTAssertEqual(error, NetworkError.badURL)
            XCTAssertNil(userDetail)
        }
    }
    
    func test_valid_URL_with_successfull_reponse(){
        
        //Arrangement
        let wshandler = WSHandler()
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        
        //ACT
        wshandler.getUsersAPI(requestURLStr: urlStr) { userDetail, error in
            
            XCTAssertNotNil(userDetail)
            XCTAssertNotNil(error)
        }
    }
    


}
