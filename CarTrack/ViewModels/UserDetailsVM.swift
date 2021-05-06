//
//  UserDetailsVM.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation

import UIKit
import MapKit
import CoreLocation

class UserDetailsVM {
    
    var userArray:UserDetail?
    
    // This method will return users array which is getting from API call
    func getUser(completionHandler: @escaping(Bool)->Void) {
        if Utils.shared.isReachable {
            
            let wsHandler = WSHandler()
            wsHandler.getUsersAPI { userDetail, nwError in
                
                if userDetail?.count ?? 0 > 0 {
                    self.userArray = userDetail
                    completionHandler(true)
                }
                else {
                    completionHandler(false)
                }
            }
        }
        else {
            completionHandler(false)
        }
    }
    
    func generateCell(index:Int, cell: UITableViewCell) -> UITableViewCell {

        let companyLbl:UILabel  = cell.viewWithTag(1) as! UILabel
        let nameLbl:UILabel     = cell.viewWithTag(2) as! UILabel
        let addressLbl:UILabel  = cell.viewWithTag(3) as! UILabel
        let mapBtn:CustomButton = cell.viewWithTag(4) as! CustomButton
        
        let userElement = userArray?[index]

        // display company name
        companyLbl.text = userElement?.company?.name
        companyLbl.addBottomLine()
        
        // display person name
        nameLbl.text = userElement?.name
        nameLbl.addBottomLine()
        
        // display complete address
        addressLbl.text = "\(userElement?.address?.street ?? "") \(userElement?.address?.suite ?? "") \(userElement?.address?.city ?? "") \(userElement?.address?.zipcode ?? "")"
        addressLbl.addBottomLine()
        
        // add array index
        mapBtn.index = index
        
        return cell
    }

    func openMap(index:Int, currentRef:UIViewController) {
        let userElement = userArray?[index]
        
        let latiStr = userElement?.address?.geo?.lat
        let latitude = Double(latiStr!)!

        let longStr = userElement?.address?.geo?.lng
        let longitude = Double(longStr!)!
        
        let mapView = MapViewController()
        mapView.lati = latitude
        mapView.long = longitude
        currentRef.present(mapView, animated: true)
    }
    
}

class CustomButton: UIButton {
    var index:Int!
    var currentRef:UIViewController!
}
