//
//  WebServices.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation

class Service {
    
    // call web service to get data or error from server and callback to the targeted method in WSHandler
    func fetchDataUsingGet(requestUrl:String, completionHandler: @escaping (Data?, Error?) -> Void){
        if let url = URL(string: requestUrl){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                completionHandler(data,error)
            }).resume()
        }
    }
}

