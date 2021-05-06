//
//  MapViewController.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var lati:Double!
    var long:Double!
    
    @IBOutlet weak var theMapView:MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        addAnotation()
        // Do any additional setup after loading the view.
    }
    
    func addAnotation() {
        
        let lati:CLLocationDegrees = lati
        let long:CLLocationDegrees = long
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = "User Location"
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: lati, longitude: long)
        theMapView.addAnnotation(pointAnnotation)
        theMapView.setCenter(pointAnnotation.coordinate, animated: false)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
