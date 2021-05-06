//
//  WSHandler.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation

class WSHandler: Service  {
    
    // hanlde get users api request and reponse here
    func getUsersAPI(completionHandler: @escaping (UserDetail?, NetworkError?) -> Void) {
       
        let usersRequestUrl = "https://jsonplaceholder.typicode.com/users"
        
        fetchDataUsingGet(requestUrl: usersRequestUrl) { data, error in
            
            guard URL(string: usersRequestUrl) != nil else {
                completionHandler(nil, .badURL)
                return
            }
            
            guard error == nil else {
                print("101 - ErrorCode: \(error.debugDescription)")
                completionHandler(nil, .unknown)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, .requestFailed)
                return
            }
            do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let usersArray = try decoder.decode(UserDetail.self, from: data) as UserDetail
                    completionHandler(usersArray,nil)
            } catch {
                    completionHandler(nil, .unknown)
                    print(error)
            }
        }
    }
}
