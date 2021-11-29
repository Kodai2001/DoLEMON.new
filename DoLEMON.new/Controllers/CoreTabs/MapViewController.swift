//
//  MapViewController.swift
//  DoLEMON.new
//
//  Created by system on 2021/11/11.
//

import UIKit
import MapKit
import FirebaseFirestore

class MapViewController: UIViewController, UISearchResultsUpdating {
    
    let mapView = MKMapView()
    
    let searchVC = UISearchController(searchResultsController: ResultViewController())
    
    let commentVC = ShowCommentsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        view.backgroundColor = .systemBackground
        
        mapView.delegate = self
        
        // titleの設定
        navigationItem.title = "MAPS"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width,
            height: view.frame.size.height - view.safeAreaInsets.top)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultVC = searchController.searchResultsController as? ResultViewController else {
            return
        }
        
        resultVC.delegate = self
        
        GooglePlaceManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultVC.update(with: places)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MapViewController: ResultViewControllerDelegate {
    func didTapPlace(with coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        searchVC.searchBar.resignFirstResponder()
        searchVC.dismiss(animated: true, completion: nil) 
        // Add a map pin
        let pin = MKPointAnnotation()
        pin.title = title
        pin.subtitle = subtitle
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.5,
                                longitudeDelta: 0.5)),
                          animated: true)
    }
}


//　ピンをカスタムする
extension MapViewController: MKMapViewDelegate {
    
    //　ピンをカスタマイズする
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //アノテーションビューを作成する。
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        // currentUser判定をして、ピンの色を変える
        let firestoreManager = FirestoreManager()
        firestoreManager.fetchCurrentUser { user in
            if user.fullName == annotation.subtitle {
                //　自分のPinは赤
                pinView.pinTintColor = .systemRed
            } else {
                // 他の人のPinは青
                pinView.pinTintColor = .systemBlue
            }
        }
        
        //吹き出しに表示するスタックビューを生成する。
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.leading
        
        FirestoreManager.shared.getAllPins { pins in
            pins.forEach { pin in
                // 同じピンを繰り返し反映しないようにしたい
                //　全てピンが出終えてから処理
                if annotation.title == pin.placeName && annotation.subtitle == pin.fullName {
                    
                    if stackView.arrangedSubviews.count <= 1 {
                        //スタックビューにユーザーネームを追加する。
                        let text = "👤: \(pin.fullName)"
                        let userNameLabel:UILabel = UILabel()
                        userNameLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 0)
                        userNameLabel.sizeToFit()
                        userNameLabel.text = text
                        stackView.addArrangedSubview(userNameLabel)
                        
                        //スタックビューにフリーテキストを追加する。
                        let freeText = "📝: \(pin.commentText)"
                        let freeTextLabel:UILabel = UILabel()
                        freeTextLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 0)
                        freeTextLabel.numberOfLines = 0
                        freeTextLabel.sizeToFit()
                        freeTextLabel.text = freeText
                        stackView.addArrangedSubview(freeTextLabel)
                    }
                }
            }
        }
        //ピンの吹き出しにスタックビューを設定する。
        pinView.detailCalloutAccessoryView = stackView
        
        //吹き出しを表示可能にする。
        pinView.canShowCallout = true
        
        return pinView
    }
    
    //吹き出しアクササリー押下時の呼び出しメソッド
    //    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    //
    //        if(control == view.leftCalloutAccessoryView) {
    //            // commentVCに遷移
    //            commentVC.addressLabel.text = "DEBUG"
    //            present(commentVC, animated: true, completion: nil)
    //        } else {
    //            guard let pin = view.annotation else {return}
    //
    //            // ピンをマップ上から削除する
    //            mapView.removeAnnotation(pin)
    //
    //            // 指定されたドキュメントをFirestoreから取り出せるようにしたい
    //            COLLECTION_PINS
    //                // 仮の値でtestしている
    //                // 本当は特定のドキュメントのフィールドを取得したい
    //                .document("Ycmy1AgM77QYdVcs5sta")
    //                .delete() { err in
    //                    if let err = err {
    //                        print("Error removing document: \(err)")
    //                    } else {
    //                        print("Document successfully removed!")
    //                    }
    //                }
    //
    //        }
    //    }
    
    // マップのロード終了時に呼ばれる
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        let firestoreManger = FirestoreManager()
        let currentUid = FirebaseAuthManager.shared.userSession?.uid
        
        firestoreManger.getAllPins { pins in
            for pin in pins {
                firestoreManger.fetchFollowing { uids in
                    for uid in uids {
                        // followしてる人のピンが表示される
                        if pin.uid == uid {
                            firestoreManger.getAnnotations(pin: pin) { pins in
                                mapView.addAnnotations(pins)
                            }
                            // 自分のピンが表示される
                        } else if pin.uid == currentUid {
                            firestoreManger.getAnnotations(pin: pin) { pins in
                                mapView.addAnnotations(pins)
                            }
                        }
                    }
                }
            }
        }
    }
}
