//
//  AccessPhotoManager.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/19.
//

import UIKit
import Photos

class AccessPhotoManager {
    // アルバム(Photo liblary)の閲覧権限の確認をするメソッド
    func checkPermission(){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("auth")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    print("success")
                }
            })
            print("not Determined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .limited:
            print("limited")
        @unknown default:
            break
        }
    }
}
