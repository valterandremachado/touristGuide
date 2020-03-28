//
//  VoiceMappingVC.swift
//  GuideTech
//
//  Created by Valter A. Machado on 3/16/20.
//  Copyright © 2020 Valter A. Machado. All rights reserved.
//

import UIKit
import LBTATools
import FlyoverKit
import MapKit
import Speech
//import AVFoundation
//import AVKit

class VoiceMappingVC: UIViewController {
    var timer : Timer?

    // MARK: Speech Recognition Setup
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    // MARK: - Properties
    var locationDic: [String: Any] = ["Session road": "Session road", "Burnham Park": "Burnham Park", "Mines View Park": "Mines View Park"]
    var userInputLoc = ["Session road": "Session road"]
    var location = UILabel()
    
    lazy var mapView: MKMapView = {
        let mp = MKMapView()
        mp.showsUserLocation = true
        mp.delegate = self
        mp.userLocation.title = "Me"
        mp.mapType = .mutedStandard
        return mp
    }()
    
    var locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    lazy var placeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    lazy var startTourBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        if preferredLanguage == "ar" {
          btn.setTitle("Record".localized("ar"), for: .normal)
        } else {
            btn.setTitle("Record", for: .normal)
        }
        
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
        btn.addTarget(self, action: #selector(startTourBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.tintColor = .rgb(red: 101, green: 183, blue: 180)
        btn.addTarget(self, action: #selector(cancelBtnPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [mapView, startTourBtn, placeLbl])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 5
        //   sv.contentMode = .scaleToFill
        sv.alignment = .center
        sv.distribution = .equalSpacing
        //  sv.addBackground(color: .gray)
        return sv
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(red: 245, green: 245, blue: 245)
        
        setupLocationManager()
        setupView()
//        getDirectionsFunc(location: location)
        print("location: \(location)")
        startTourBtn.isEnabled = false
//        restartSpeechTimer()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        setupSpeechRecogn()
    }
    
    // MARK: - Handlers (functions/methods)
    @objc func cancelBtnPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func startTourBtnPressed(){
        
        DispatchQueue.main.async {
            
            if self.audioEngine.isRunning {
                self.audioEngine.stop()
                self.recognitionRequest?.endAudio()
                self.startTourBtn.isEnabled = false
                
                if preferredLanguage == "ar" {
                    self.startTourBtn.setTitle("Stopping...".localized("ar"), for: .disabled)
                } else {
                    self.startTourBtn.setTitle("Stopping...", for: .disabled)
                }
                
            } else {
                try! self.startRecording()
                
                if preferredLanguage == "ar" {
                    self.startTourBtn.setTitle("Stop".localized("ar"), for: [])
                } else {
                    self.startTourBtn.setTitle("Stop", for: [])
                }
                
                self.startTourBtn.tintColor = .red
            }
        }
    }
    
    func setupView(){
        [stackView].forEach({view.addSubview($0)})
        let cancelBtnItem = UIBarButtonItem(customView: cancelBtn)
        navigationItem.leftBarButtonItem =  cancelBtnItem
        
        if preferredLanguage == "ar" {
            navigationItem.title = "Voice Mapping".localized("ar")
            placeLbl.text = "Tap record to start".localized("ar")
        } else {
            navigationItem.title = "Voice Mapping"
            placeLbl.text = "Tap record to start"
        }
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        navigationController?.navigationBar.hideNavBarSeperator()
        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: view.frame.height/1.3))
    }
    
    
    
    fileprivate func setupLocationManager(){
        //        mapView.delegate = self
        //        mapView.showsUserLocation = true
        //MARK: Setting LocationManager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}
// MARK: - Speech Recognizer Extension
extension VoiceMappingVC: SFSpeechRecognizerDelegate {
    
    fileprivate func setupSpeechRecogn(){
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization {
            status in
            var buttonState = false
            switch status {
            case .authorized:
                buttonState = true
                print("Permission received")
            case .denied:
                buttonState = false
                print("User did not give permission to use speech recognition")
            case .notDetermined:
                buttonState = false
                print("Speech recognition not allowed by user")
            case .restricted:
                buttonState = false
                print("Speech recognition not supported on this device")
            @unknown default:
                fatalError("fatal error")
            }
            /// Disable the button if user did not grant permission
            DispatchQueue.main.async {
                self.startTourBtn.isEnabled = buttonState
            }
        }
        
         
    }
    
    private func startRecording() throws {
        self.placeLbl.frame.size.width = view.bounds.width - 64

        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//        (true, withFlags: .notifyOthersOnDeactivation)

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        let inputNode = audioEngine.inputNode
//        else { fatalError("Audio engine has no input node")}
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }

        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true

        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
//            var isLast = false

            
            if let result = result {
//                self.placeLbl.text = result.bestTranscription.formattedString
//                isLast = (result.isFinal)
//            }

//            if error != nil || isLast {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.startTourBtn.isEnabled = true
                
                if preferredLanguage == "ar" {
                    self.startTourBtn.setTitle("Record".localized("ar"), for: [])
                } else {
                    self.startTourBtn.setTitle("Record", for: [])
                }
                
                // added from different source code
                let bestString = result.bestTranscription.formattedString
                
                var lastString: String = ""
//
                for segment in result.bestTranscription.segments {
                    let indexTo = bestString.index(bestString.startIndex, offsetBy: segment.substringRange.location)
                    lastString = String(bestString[indexTo...])
                }
                
                // get last string and pass it to get direction function
                self.checkForSpotSaid(resultString: lastString)
                self.placeLbl.text = self.location.text
                self.getDirectionsFunc(location: self.location.text ?? "")

//                let inDict = self.locationDic.contains { $0.key == bestString}
//                if inDict {
//                    self.placeLbl.text = bestString
////                    self.userInputLoc = self.locationDic[bestStr!]! as! [String : String]
//                }
//                else {
//                    self.placeLbl.text = "can't find it in the dictionary"
////                    self.userInputLoc = FlyoverAwesomePlace.centralParkNY
//                }
                //**
                self.startTourBtn.tintColor = .rgb(red: 101, green: 183, blue: 180)
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
            
            if preferredLanguage == "ar" {
                placeLbl.text = "(Go ahead, I'm listening)".localized("ar")
            } else {
                placeLbl.text = "(Go ahead, I'm listening)"
            }
            
        } catch {
            print(error)
        }
        
    }

    func checkForSpotSaid(resultString: String){
        switch resultString {
        case "Session":
            location.text = "Session road"
        case "SM":
            location.text = "SM Baguio"
        default: break
        }
    }
    func restartSpeechTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
            // Do whatever needs to be done when the timer expires
            self.audioEngine.stop()
            self.recognitionRequest?.endAudio()
            self.startTourBtn.isEnabled = false
            
            if preferredLanguage == "ar" {
                self.startTourBtn.setTitle("Stopping...".localized("ar"), for: .disabled)
            } else {
                self.startTourBtn.setTitle("Stopping...", for: .disabled)
            }
            
        })
    }
    // MARK: SFSpeechRecognizerDelegate
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            startTourBtn.isEnabled = true
            
            if preferredLanguage == "ar" {
                self.startTourBtn.setTitle("Record".localized("ar"), for: [])
            } else {
                self.startTourBtn.setTitle("Record", for: [])
            }
        } else {
            startTourBtn.isEnabled = false
            startTourBtn.setTitle("Recognition not available", for: .disabled)
        }
    }
    
//    fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
//        return input.rawValue
//    }

    
}


extension VoiceMappingVC: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func getDirectionsFunc(location: String){
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location) { (placeMarkers, error) in
            guard let placeMarkers = placeMarkers, let location = placeMarkers.first?.location else {
                print("No location")
                return
            }
            //            print(location)
            self.mapThis(destinationCoord: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        guard let location = locations.last else {return}
        //        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        //        mapView.setRegion(region, animated: true)
        print(locations)
    }
    
    fileprivate func mapThis(destinationCoord: CLLocationCoordinate2D){
        let userLocation = (locationManager.location?.coordinate)!
        //
        //        let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        //        mapView.setRegion(region, animated: true)
        
        let startingLocation = MKPlacemark(coordinate: userLocation)
        let destination = MKPlacemark(coordinate: destinationCoord)
        
        let sourceItem = MKMapItem(placemark: startingLocation)
        let desItem = MKMapItem(placemark: destination)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = desItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("something is really wrong! \(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .rgb(red: 101, green: 183, blue: 180)
        
        return render
    }
    
}
