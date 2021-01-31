//
//  AddFavouriteViewController.swift
//  WeatherMQ
//
//  Created by Damodar, Namala (623-Extern) on 31/01/21.
//

import UIKit
import MapKit

class FavouriteViewController: UIViewController {
    @IBOutlet weak var bookmarksMapView: MKMapView?
    var listOfLocations = [FavouriteLocations]()

    lazy var favouriteViewModel: FavouriteViewModel = {
        let viewModel = FavouriteViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let longGesture = UILongPressGestureRecognizer(target: self,
                                                       action: #selector(addFavouriteLocation(longGesture:)))
        bookmarksMapView?.addGestureRecognizer(longGesture)

        // Do any additional setup after loading the view.
    }
    

    @objc func addFavouriteLocation(longGesture: UIGestureRecognizer) {
        // Do not generate pins many times during long press.
        if longGesture.state != .began {
            return
        }
        
        let location = longGesture.location(in: self.bookmarksMapView)
        let coordinates: CLLocationCoordinate2D = (bookmarksMapView?.convert(location,
                                                                             toCoordinateFrom: bookmarksMapView))!
        
        self.favouriteViewModel.getPlacemark(for: coordinates) { favLocation in
            guard let location = favLocation else { return }
            let pinView: MKPointAnnotation = MKPointAnnotation()
            pinView.coordinate = coordinates
            
            let name = location.name ?? ""
            let locatily = location.locality ?? ""
            let subLocatily = location.sublocality ?? ""
            let administrative = location.administrativeArea ?? ""
            
            pinView.title = name + ", " + locatily
            pinView.subtitle = subLocatily + ", " + administrative
            self.listOfLocations.append(location)
            DispatchQueue.main.async {
                self.bookmarksMapView?.addAnnotation(pinView)
            }
        }
    }
    
    @IBAction func dimissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FavouriteViewController: MKMapViewDelegate {
    // Delegate method called when addAnnotation is done.
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinView = PinAnnotationView(annotation: annotation,
                                        reuseIdentifier: PinAnnotationView.identifier)
        pinView.animatesDrop = true
        pinView.canShowCallout = true
        pinView.annotation = annotation
        pinView.pinTintColor = .blue
        
        print("latitude: \(annotation.coordinate.latitude), longitude: \(annotation.coordinate.longitude)")
        return pinView
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let annotation: MKAnnotation = view.annotation  else { return }
        DispatchQueue.main.async {
            mapView.removeAnnotation(annotation)
        }
    }
}
