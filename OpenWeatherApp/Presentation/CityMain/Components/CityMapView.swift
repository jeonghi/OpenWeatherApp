//
//  MapView.swift
//  OpenWeatherApp
//
//  Created by 쩡화니 on 10/1/24.
//

import SwiftUI
import MapKit

final class CityAnnotation: NSObject, MKAnnotation {
  
  let city: City
  
  var coordinate: CLLocationCoordinate2D {
    .init(latitude: city.coordinate.latitude, longitude: city.coordinate.longitude)
  }
  
  var title: String? {
    return city.name
  }
  
  init(city: City) {
    self.city = city
  }
  
  static let dummyData = CityAnnotation(
    city: .dummyData
  )
}

// SwiftUI MapView 사용을 위한 뷰
struct CityMapView: BaseViewType {
  let annotation: CityAnnotation
  
  init(annotation: CityAnnotation = .dummyData) {
    self.annotation = annotation
  }
  init(city: City) {
    self.annotation = .init(city: city)
  }
  
  var body: some View {
    CityMapViewRepresentable(annotation: annotation)
  }
}

private struct CityMapViewRepresentable: UIViewRepresentable {
  var annotation: CityAnnotation
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
    mapView.delegate = context.coordinator
    mapView.mapType = .standard
    mapView.isZoomEnabled = false
    mapView.isScrollEnabled = false
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    
    uiView.removeAnnotations(uiView.annotations)
    uiView.addAnnotation(annotation)
    
    // 지도 중심을 어노테이션의 위치로 설정
    let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    uiView.setRegion(region, animated: false)
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator()
  }
  
  class Coordinator: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
      
      let identifier = "CityAnnotationView"
      
      guard annotation is CityAnnotation else { return nil }
      
      var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      
      if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
      } else {
        annotationView?.annotation = annotation
      }
      
      return annotationView
    }
  }
}

#if(DEBUG)
#Preview {
  CityMapView()
}
#endif
