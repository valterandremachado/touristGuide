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
    
    // MARK: Speech Recognition Setup
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    // MARK: - Properties
    var location = ""
    
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
        lbl.text = "Dummy text"
        return lbl
    }()
    
    lazy var startTourBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Record", for: .normal)
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
        view.backgroundColor = .white
        setupLocationManager()
        setupView()
        getDirectionsFunc(location: location)
        print("location: \(location)")
        startTourBtn.isEnabled = false
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        setupSpeechRecogn()
    }
    
    // MARK: - Handlers (functions/methods)
    @objc func cancelBtnPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func startTourBtnPressed(){
        print("123")
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            startTourBtn.isEnabled = false
            startTourBtn.setTitle("Stopping...", for: .disabled)
        } else {
            try! startRecording()
            startTourBtn.setTitle("Stop", for: [])
            startTourBtn.tintColor = .red
        }
        
    }
    
    func setupView(){
        [stackView].forEach({view.addSubview($0)})
        let cancelBtnItem = UIBarButtonItem(customView: cancelBtn)
        navigationItem.leftBarButtonItem =  cancelBtnItem
        navigationItem.title = "Voice Mapping"
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
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /*
             The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.startTourBtn.isEnabled = true
                    
                case .denied:
                    self.startTourBtn.isEnabled = false
                    self.startTourBtn.setTitle("User denied access to speech recognition", for: .disabled)
                    
                case .restricted:
                    self.startTourBtn.isEnabled = false
                    self.startTourBtn.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.startTourBtn.isEnabled = false
                    self.startTourBtn.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
    }
    
    private func startRecording() throws {

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
            var isFinal = false

            if let result = result {
                self.placeLbl.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
            }

            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.startTourBtn.isEnabled = true
                self.startTourBtn.setTitle("Record", for: [])
                self.startTourBtn.tintColor = .rgb(red: 101, green: 183, blue: 180)
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        try audioEngine.start()

        placeLbl.text = "(Go ahead, I'm listening)"
    }

    // MARK: SFSpeechRecognizerDelegate

    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            startTourBtn.isEnabled = true
            startTourBtn.setTitle("Record", for: [])
        } else {
            startTourBtn.isEnabled = false
            startTourBtn.setTitle("Recognition not available", for: .disabled)
        }
    }
    
    
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
