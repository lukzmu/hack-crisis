//
//  MapView.swift
//  CrisisHelp
//
//  Created by Lukasz Zmudzinski on 17/03/2020.
//  Copyright © 2020 Lukasz Zmudzinski. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var locationModel = LocationViewModel()
    var model : HelpMapViewModel?
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: UIScreen.main.bounds)
        map.mapType = .mutedStandard
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        map.delegate = context.coordinator
        
        return map
    }
    
    func updateUIView(_ view: MKMapView, context: Context){
        guard let requests = model?.helpRequests else { return }
        for request in requests {
            let coords = CLLocationCoordinate2D(latitude: request.latitude, longitude: request.longitude)
            let annotation = MapAnnotation(coordinate: coords, helpRequest: request)
            view.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if !(annotation is MapAnnotation) {
                return nil
            }
            let typedAnnotation = annotation as! MapAnnotation
            
            let identifier = "covid19"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = false
                annotationView?.image = typedAnnotation.iconAsset
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if !(view.annotation is MapAnnotation) {
                return
            }
            let typedAnnotation = view.annotation as! MapAnnotation
            
            parent.model?.selectedRequest = typedAnnotation.helpRequest
            parent.model?.showSelectedRequest = true
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
