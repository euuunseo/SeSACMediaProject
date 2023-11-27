//
//  FindNearCinemaViewController.swift
//  SeSACMediaProject
//
//  Created by 고은서 on 2023/11/26.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

enum cinemaType {
    case All
    case megaBox
    case cgv
    case lotteCinema
}

class FindNearCinemaViewController: UIViewController {

    let locationManager  = CLLocationManager()
    let mapView = MKMapView()
    let filterButton = {
        let view = UIButton()
        
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
        
        view.addSubview(filterButton)
        filterButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(view).offset(-10)
            make.topMargin.equalTo(view).offset(20)
            make.size.equalTo(35)
        }
        filterButton.addTarget(self, action: #selector(filterButtonCliked), for: .touchUpInside)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        checkDeiviceLocationAuthorization()
        
        let center = CLLocationCoordinate2D(latitude: 35.179290, longitude: 126.907649)
        setRegionAndAnnotation(center: center)
        
        setAnnotation(type: .All)
        
    }
    
    @objc func filterButtonCliked() {
        
        let alert = UIAlertController(title: "영화관 필터", message: nil, preferredStyle: .actionSheet)
        
        let megaBox = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.setAnnotation(type: .megaBox)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            self.setAnnotation(type: .cgv)
        }
        let lotteCinema = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.setAnnotation(type: .lotteCinema)
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.setAnnotation(type: .All)
        }
        
        alert.addAction(megaBox)
        alert.addAction(cgv)
        alert.addAction(lotteCinema)
        alert.addAction(all)
        
        present(alert, animated: true)
        
        
    }
    
    func showAlert () {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 허용해주세요.", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func setAnnotation(type: cinemaType) {
        
        let megaAnnotation = MKPointAnnotation()
        megaAnnotation.title = "메가박스"
        megaAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.529050, longitude: 126.876048)
        
        let cgvAnnotation = MKPointAnnotation()
        cgvAnnotation.title = "cgv"
        cgvAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.517135, longitude: 126.903685)
        
        let lotteAnnotation = MKPointAnnotation()
        lotteAnnotation.title = "롯데시네마"
        lotteAnnotation.coordinate = CLLocationCoordinate2D(latitude: 37.508830, longitude: 126.889464)
        
        mapView.addAnnotations([megaAnnotation, cgvAnnotation, lotteAnnotation])
        
        if type == .All {
            mapView.addAnnotations([megaAnnotation, cgvAnnotation, lotteAnnotation])
        } else if type == .megaBox {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([megaAnnotation])
        } else if type == .cgv {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([cgvAnnotation])
        } else if type == .lotteCinema {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations([lotteAnnotation])
        }
        
    }

    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
 
    }
    
    
    func checkDeiviceLocationAuthorization() {
        
        DispatchQueue.global().async {
            
            if CLLocationManager.locationServicesEnabled() {
                
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                print("위치 권한을 사용할 수 없습니다")
            }
        }
    }

    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {

        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest //위치정확도
            locationManager.requestWhenInUseAuthorization() //얼럿
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            showAlert()
            
            let center = CLLocationCoordinate2D(latitude: 35.179290, longitude: 126.907649)
            setRegionAndAnnotation(center: center)
            
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("====authorizedWhenInUse")
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            fatalError()
        }
    }
    
}


extension FindNearCinemaViewController: CLLocationManagerDelegate {
    
    //사용자 위치 권한 가지고 오기 성공
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            //원래 얘가 맞음
            //setRegionAndAnnotation(center: coordinate)
            // 청년취업사관학교 37.517742, 126.886463
            let center = CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463)
            setRegionAndAnnotation(center: center)
            
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    //실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 가져오기 실패")
    }
    
    //권한 상태 바뀔 때 (iOS 14 이상)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        checkDeiviceLocationAuthorization()
    }
    
    //iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkDeiviceLocationAuthorization()
    }
    
}
