//
//  ViewController.swift
//  PGD
//
//  Created by Pedro Oliveira on 22/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit
import MapKit
import AudioToolbox
import AVFoundation

class MapViewController: PGDViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var stalkButton: UIButton!
    var manager:CLLocationManager!
    var lastRequestDate: Date?
    var currentLocation: CLLocation?
    var updateTimer: Timer?
    var annotations: [InterestPointAnnotation]!
    
    var stalk: Bool?
    internal var username: String?
    internal var password: String?
    
    let interactor = Interactor()
    
    required init?(coder aDecoder: NSCoder) {
        self.annotations = [InterestPointAnnotation]()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        let imageView = UIImageView.init(image: UIImage(named:"maptitle")!.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = UIColor(hex: 0xEEEEEE)
        navigationItem.titleView = imageView
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        manager.delegate = self
        //manager.allowsBackgroundLocationUpdates = true
        mapView!.showsUserLocation = true
        mapView!.delegate = self
        mapView!.userLocation.title = retrieveUsername()
        stalk = false
        UIApplication.shared.isIdleTimerDisabled = true
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addAnnotationsToMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func menuButtonTouched(_ sender: UIButton) {
        self.performSegue(withIdentifier:"presentMenuViewControllerSegue", sender:sender)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "presentMenuViewControllerSegue" {
            if let destinationViewController = segue.destination as? MenuViewController {
                destinationViewController.transitioningDelegate = self
                destinationViewController.interactor = interactor
            }
        }
        
    }
    
    @IBAction func centerMapButtonTouched(_ sender: UIButton) {
        centerMap()
    }
    
    
    @IBAction func stalkmeTouched(_ sender: UIButton) {
        switchStalkMode()
    }
    
    func switchStalkMode() {
        stalk = !stalk!
        if (stalk == true) {
            stalkButton?.setImage(UIImage(named:"disable-tracking"), for: .normal)
            mapView!.setUserTrackingMode(.followWithHeading, animated: true)
        } else {
            stalkButton?.setImage(UIImage(named:"enable-tracking"), for: .normal)
            mapView!.setUserTrackingMode(.none, animated: true)
        }
    }
    
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "presentMenuViewControllerSegue", sender: nil)
        }
    }
    
    
    
    func centerMap() {
        if currentLocation != nil {
            let center = CLLocationCoordinate2D(latitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006))
            self.mapView!.setRegion(region, animated: true)
        }
    }
    
    func clearMap() {
        let annotationsToRemove = mapView!.annotations.filter { $0 !== mapView!.userLocation }
        mapView!.removeAnnotations( annotationsToRemove )
    }
    
    func loadData() {
        lastRequestDate = Date()
        loadDataFromServer(currentLocation!)
    }
    
    func updateData(){
        var secondsFromLastRequest  = 0 as TimeInterval
        if lastRequestDate != nil {
            secondsFromLastRequest = Date().timeIntervalSince(lastRequestDate!)
        }
        
        if lastRequestDate == nil || secondsFromLastRequest > 59 {
            loadData()
        }
    }
    
    func loadDataFromServer(_ location: CLLocation) {
        let controller = WSController()
        let imageView = UIImageView.init(image: UIImage(named:"maptitle")!.withRenderingMode(.alwaysTemplate))
        self.navigationItem.titleView = imageView
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: [.repeat, .autoreverse, .beginFromCurrentState], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.75) {
                    imageView.tintColor = UIColor(hex: 0xFF752E)
                    imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    imageView.transform = CGAffineTransform(rotationAngle: -0.174533)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.75) {
                    imageView.tintColor = UIColor(hex: 0xEEEEEE)
                    imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    imageView.transform = CGAffineTransform(rotationAngle: 0.0)
                }
                }, completion: nil)
            
        }
        controller.getInterestPoints(username: self.username!, password: self.password!, coordinate: location) { (data) in
            var color = UIColor(hex: 0xDA0A1F)
            if data != nil {
                
                self.annotations = [PokemonAnnotation]()
                for p in (data?.pokemons)! {
                    self.addPokemonAnnotation(p)
                }
                for p in (data?.gyms)! {
                    self.addGymAnnotation(p)
                }
                for p in (data?.pokestops)! {
                    self.addPokestopAnnotation(p)
                }
                color = UIColor(hex: 0xEEEEEE)
            }
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                imageView.layer.removeAllAnimations()
                UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.beginFromCurrentState ], animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0) {
                        imageView.tintColor = color
                        imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        imageView.transform = CGAffineTransform(rotationAngle: 0.0)
                    }
                    }, completion: nil)
                self.addAnnotationsToMap()
            })
        }
    }
    
    func addAnnotationsToMap() {
        self.clearMap()
        for a in self.annotations {
            let add = (a is PokemonAnnotation && retrieveShowPokemons()) ||
                      (a is GymAnnotation && retrieveShowGyms()) ||
                      (a is PokestopAnnotation && retrieveShowStops()) ||
                      (a is PokestopAnnotation && a.imageName == "lured.png" && retrieveShowLures())
            if add {
                self.mapView.addAnnotation(a)
            }
            
        }
    }
    
    func addPokemonAnnotation(_ pokemon: Pokemon) {
        let annotation = PokemonAnnotation()
        let id = String(format:"%03d", pokemon.id!)
        let distance = pokemon.coordinate.distance(from: currentLocation!)
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.none
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateString = formatter.string(from: pokemon.expirationDate)
        
        annotation.coordinate = pokemon.coordinate.coordinate
        annotation.title = "\(pokemon.name!) @ \(Int(distance))m"
        annotation.subtitle = "Goes away at \(dateString)"
        annotation.imageName = "\(id).png"
        
        annotations.append(annotation)
    }
    
    
    
    func addPokestopAnnotation(_ pokestop: Pokestop) {
        let annotation = PokestopAnnotation()
        let distance = pokestop.coordinate.distance(from: currentLocation!)
        
        annotation.coordinate = pokestop.coordinate.coordinate
        annotation.title = "Pokestop @ \(Int(distance))m"
        
        annotation.imageName = "stop.png"
        
        if pokestop.expirationDate != nil && Int((pokestop.expirationDate?.timeIntervalSinceNow)!) > 0{
            let formatter = DateFormatter()
            formatter.dateStyle = DateFormatter.Style.none
            formatter.timeStyle = .short
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            let dateString = formatter.string(from: pokestop.expirationDate!)
            annotation.subtitle = "Current Pokémon until \(dateString)"
            annotation.imageName = "lured.png"
        }
        
        annotations.append(annotation)
    }
    
    func addGymAnnotation(_ gym: Gym) {
        let annotation = GymAnnotation()
        let distance = gym.coordinate.distance(from: currentLocation!)
        
        annotation.coordinate = gym.coordinate.coordinate
        annotation.title = "\(gym.name!)'s gym @ \(Int(distance))m"
        
        annotation.imageName = "\(gym.name!).png"
        
        annotation.subtitle = "\(gym.prestige!) prestige"
        
        annotations.append(annotation)
    }
}

// MARK: - View Controller Transition delegate

extension MapViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

// MARK: - Map View delegate

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "PokemonPin"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        else {
            annotationView!.annotation = annotation
        }
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView?.image = UIImage(named:"avatar")
            annotationView?.canShowCallout = true
        }
        if  annotation.isKind(of: InterestPointAnnotation.self)  {
            let interestPointAnnotation = annotation as! InterestPointAnnotation
            annotationView!.canShowCallout = true
            let image = UIImage(named:interestPointAnnotation.imageName!)
            annotationView!.image = image
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let view = mapView.subviews.first
        for r in (view?.gestureRecognizers)! {
            if r.state == .began || r.state == .ended {
                if stalk == true {
                    switchStalkMode()
                }
            }
        }
    }
}

// MARK: - Location Manager delegate

extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let isFirstLocation = currentLocation == nil
        currentLocation = locations.last! as CLLocation
        if(isFirstLocation){
            centerMap()
        }
        
        if updateTimer == nil  {
            updateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MapViewController.updateData), userInfo: nil, repeats: true)
        }
    }
}
