//
//  DBHandler.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation
import CoreData

class DBHandler {
    
    let entityName = "UserLoginInfo"
    let context = PersistentStorage.shared.context
    
    func offlineLoginValidation(username:String, password:String, completionHandler: @escaping (Result<Bool, AuthenticationError>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            if result.count == 0 {
                
                completionHandler(.failure(AuthenticationError.noRecordExist))
            }
            
            for data in result as! [NSManagedObject] {
                
                let dbUserName = data.value(forKey: "username") as! String
                let dbPassword = data.value(forKey: "password") as! String
                
                if dbUserName == username && dbPassword == password {
                    completionHandler(.success(true))
                    return
                }
            }
            completionHandler(.failure(AuthenticationError.credentialNotMatch))
        } catch {
            completionHandler(.failure(AuthenticationError.featchingDataFailed))
        }
    }
    
    func saveData(username:String, password:String) {
            do {
                let data = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
                
                data.setValue(username, forKeyPath: "username")
                data.setValue(password, forKeyPath: "password")

                try context.save()
            } catch {
                fatalError()
            }
    }
}
