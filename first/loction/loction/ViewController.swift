//
//  ViewController.swift
//  loction
//
//  Created by syh-hw on 16/11/4.
//  Copyright © 2016年 syh_wzn. All rights reserved.
//

import UIKit

class ViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate {
    var mapView = MAMapView()
    let search = AMapSearchAPI()
    
    //定位
    var currentLocation:CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mapView = MAMapView.init(frame: self.view.bounds)
        self.view.addSubview(mapView)
        mapView.mapType = MAMapType.Standard
        mapView.delegate = self
        mapView.showTraffic = true
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .Follow
        let compassX = mapView.compassOrigin.x
        
        let scaleX = mapView.scaleOrigin.x
        
        //设置指南针和比例尺的位置
        mapView.compassOrigin = CGPointMake(compassX, 21)
        
        mapView.scaleOrigin = CGPointMake(scaleX, 21)
        
        mapView.showsCompass = true
        mapView.showsScale = true

        search.delegate = self
        
    

        
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    // 逆地理编码
    func reverseGeocoding(){
        
        let coordinate = currentLocation?.coordinate
        
        // 构造 AMapReGeocodeSearchRequest 对象，配置查询参数（中心点坐标）
        let regeo: AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
        
        regeo.location = AMapGeoPoint.locationWithLatitude(CGFloat(coordinate!.latitude), longitude: CGFloat(coordinate!.longitude))
        
        
        
        // 进行逆地理编码查询
        self.search!.AMapReGoecodeSearch(regeo)
        
    }
    
    
    
    
    // 定位回调
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            currentLocation = userLocation.location
        }
    }
    
    // 点击Annoation回调
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        // 若点击的是定位标注，则执行逆地理编码
        if view.annotation.isKindOfClass(MAUserLocation){
            reverseGeocoding()
        }
    }
    
    // 逆地理编码回调
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        
        if (response.regeocode != nil) {
            
            var title = response.regeocode.addressComponent.city
            
            title = response.regeocode.addressComponent.province
            
            //给定位标注的title和subtitle赋值，在气泡中显示定位点的地址信息
            mapView.userLocation.title = title
            mapView.userLocation.subtitle = response.regeocode.formattedAddress
            
        }
        
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

