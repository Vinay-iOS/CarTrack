//
//  Utils.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation
import Network
import UIKit
import NVActivityIndicatorView

class Utils: NSObject {
    
    static var shared = Utils()
    
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true
    
    func startInternetMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
                    self?.status = path.status
                    self?.isReachableOnCellular = path.isExpensive

                    if path.status == .satisfied {
                        // post connected notification
                    } else {
                        print("No connection.")
                        // post disconnected notification
                    }
                    //print(path.isExpensive)
                }

                let queue = DispatchQueue(label: "NetworkMonitor")
                monitor.start(queue: queue)
    }
    
    func stopInternetMonitoring() {
        monitor.cancel()
    }
    
    func showIndicator(controller:UIViewController){
        let _width:CGFloat  = 45
        let _height:CGFloat = 45
        let xAxis = controller.view.center.x - (_width/2)
        let yAxis = controller.view.center.y - (_height/2)
        let indicatorSize = CGRect(x: xAxis, y: yAxis, width: _width, height: _height)

        let activityIndicatorView = NVActivityIndicatorView(frame: indicatorSize, type: NVActivityIndicatorView.DEFAULT_TYPE, color: UIColor.gray , padding: 0)
       controller.view.addSubview(activityIndicatorView)
       activityIndicatorView.startAnimating()
   }

   func hideIndicator(controller:UIViewController) {
    for view in controller.view.subviews {

        if view.isKind(of: NVActivityIndicatorView.classForCoder()){
            let activityIndicatorView = view as? NVActivityIndicatorView
            activityIndicatorView?.stopAnimating()
            activityIndicatorView?.removeFromSuperview()
        }
    }
   }
}
