//
//  FeedViewController.swift
//  Pinterest
//
//  Created by Daval Cato on 11/13/21.
//

import UIKit
import AVFoundation
import MessageKit
import CoreLocation

class FeedViewController: UIViewController, UISearchResultsUpdating, UITextFieldDelegate, UISearchBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Core location instance
    let locationServices = CLLocationManager()
    
    //Capture Session
    var session: AVCaptureSession?
    
    // Photo Output
    let output = AVCapturePhotoOutput()
    
    // Video Preview
    var previewLayer = AVCapturePhotoOutput()
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            
            return
        }
        print(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.enablesReturnKeyAutomatically = false
    }
    
    
//    let searchBar = UISearchBar()
    
    // setup the collectionView - lazy var to access self delegate
    lazy var collectionView: UICollectionView = {
        let layout = PinterestLayout()
        layout.delegate = self
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PinterestCell.self, forCellWithReuseIdentifier: "cellId")
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.contentInset.top = 5
        
        return cv
    }()
    
    // adding search
    let searchTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search"
        tf.backgroundColor = #colorLiteral(red: 0.9588784575, green: 0.9528519511, blue: 0.9350754619, alpha: 1)
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 10
        
        // containerView for search field
        let rightView = UIView(frame: CGRect(
            x: 6,
            y: 4,
            width: 38,
            height: -10))
        
//    func ButtonCreate () {
        // add button as a subview
//        let rightBtn = UIButton(type: .custom)
//        rightBtn.setImage(UIImage(named: "camera-icon"), for: .normal)
//        rightBtn.isEnabled = true
//        rightBtn.isUserInteractionEnabled = true
//        rightBtn.addTarget(self, action: #selector(rightBtnAction), for: .touchUpInside)
//
//        rightView.addSubview(rightBtn)
//
//        // set frame
//        rightBtn.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: 25,
//            height: 25)
//
//        // anchor right button
//        rightBtn.constraint(
//            top: nil,
//            left: nil,
//            bottom: nil,
//            right: rightView.rightAnchor,
//            topConstant: 0,
//            leftConstant: 8,
//            bottomConstant: 5,
//            rightConstant: 8,
//            widthConstant: 25,
//            heightConstant: 25)
//
//        rightView.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
//
//        // set the rightView property on the text to make it appear
//        tf.rightView = rightView
//        tf.rightViewMode = .always
        
        
        // containerView
        let leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 38,
            height: 25))
        
        // button
        let leftBtn = UIButton(type: .custom)
        leftBtn.setImage(UIImage(named: "search-icon"), for: .normal)
        // set frame
        leftBtn.frame = CGRect(
            x: 0,
            y: 0,
            width: -25,
            height: -25)
        
        leftView.addSubview(leftBtn)
        
        // anchor right button
        leftBtn.constraint(
            top: nil,
            left: leftView.leftAnchor,
            bottom: nil,
            right: nil,
            topConstant: 0,
            leftConstant: 4,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 17,
            heightConstant: 17)
        
        leftBtn.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        // set the rightView property on the text
        tf.leftView = leftView
        tf.leftViewMode = .always
        
        
        return tf
        
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setImage(UIImage(named: "camera-icon"), for: .normal)
        rightBtn.translatesAutoresizingMaskIntoConstraints = false
        rightBtn.addTarget(self, action: #selector(cameraBtnAction), for: .touchUpInside)
        
        
        return rightBtn
    }()
    
    @objc func cameraBtnAction(_ sender: Any) {
//        output.capturePhoto(with: AVCapturePhotoSettings(),
//                            delegate: self)
        
        let alert = UIAlertController.init(title: "Pinterest would like to access the camera!", message: "Please allow to take a photo.", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (_) in
            }))

            alert.addAction(UIAlertAction.init(title: "Settings", style: .default, handler: { (_) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }))

            present(alert, animated: true)
        
        
        print("Button tapped")
     }
    
    // add chat button
    lazy var chatBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "chatbubble"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(chatbubbleButton), for: .touchUpInside)
        
        
        return btn
    }()
    
    @objc func chatbubbleButton() {
        
        let vc = ChatViewController()
        self.navigationController?.pushViewController(vc,animated:true)
        
        print("Button tapped")
     }
    
    
    // call a method here
    let posts = PostProvider.GetPosts()
    
    override func viewDidLoad() {
        checkCameraPermissions()
        initializedLocationServices()
//        view.layer.addSublayer(previewLayer)
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // set the collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupNavBar()
        
        // add the collectionView as a subview
        view.addSubview(collectionView)
        
//        func promptForAuthorization() {
//            let alert = UIAlertController(title: "Location access is needed to get your current location",
//                                          message: "Please allow location access",
//                                          preferredStyle: .alert)
//            let settingsAction = UIAlertAction(title: "Settings",
//                                               style: .default) { _ in
//                UIApplication.shared.openURL(UIApplication.openSettingsURLString), options:
//                [:], completionHandler:nil)
//
//            }
//
//            let cancelAction = UIAlertAction(title: "Cancel",
//                                             style: .default) { [weak self] _ in
//                self?.locationServicesNeededState()
//            }
//
//            alert.addAction(settingsAction)
//            alert.addAction(cancelAction)
//
//            alert.preferredAction = settingsAction
//
//            present(alert, animated: true, completion: nil
//        })
                    
        collectionView.constraint(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            topConstant: 0,
            leftConstant: 0,
            bottomConstant: 0,
            rightConstant: 0,
            widthConstant: 0,
            heightConstant: 0)
        
        
    // navBar into separate function
    func setupNavBar() {
        
        guard let navBar = navigationController?.navigationBar else { return }
        
        navBar.isTranslucent = false
        navBar.backgroundColor = .red
        
        // add search as subview
        navBar.addSubview(searchTF)
        navBar.addSubview(chatBtn)
        navBar.addSubview(rightBtn)
        
        
        rightBtn.constraint(
            top: nil,
            left: navBar.leftAnchor,
            bottom: nil,
            right: nil,
            topConstant: 0,
            leftConstant: 5,
            bottomConstant: 0,
            rightConstant: 5,
            widthConstant: 25,
            heightConstant: 25)
        rightBtn.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        
        
        chatBtn.constraint(
            top: nil,
            left: nil,
            bottom: nil,
            right: navBar.rightAnchor,
            topConstant: 0,
            leftConstant: 5,
            bottomConstant: 0,
            rightConstant: 10,
            widthConstant: 25,
            heightConstant: 25)
        chatBtn.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        
        searchTF.constraint(
            top: navBar.topAnchor,
            left: rightBtn.leftAnchor,
            bottom: navBar.bottomAnchor,
            right: chatBtn.leftAnchor,
            topConstant: 5,
            leftConstant: 30,
            bottomConstant: 5,
            rightConstant: 5,
            widthConstant: 0,
            heightConstant: 0)
                
        }
                    
//    func locationServicesNeededState() {
//        self.statusLabel.text
//
//        }
    }
    // Configuring Location services
    private func initializedLocationServices() {
        // Set FeedViewController as delegate of core location manager
        locationServices.delegate = self
        // Enable background updates
        locationServices.allowsBackgroundLocationUpdates = true
        // Let user know the app is retrieving location information while in background
        locationServices.showsBackgroundLocationIndicator = true
        
        // Check if location services in enable
        guard CLLocationManager.locationServicesEnabled() else {
            // if its not enable then return
            return
        }
        // Request locationServices
        locationServices.requestAlwaysAuthorization()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Take up the entire view of phone
//        previewLayer.frame = view.bounds
        
    }
    
    // Request permission for the camera
 func checkCameraPermissions() {
     switch AVCaptureDevice.authorizationStatus(for: .video) {
     case .notDetermined:
         // Request access
         AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
             guard granted else {
                 return
             }
             // If it was granted then call setUpCamera on the main thread
             DispatchQueue.main.async {
                 // adjust the UI here
                 self?.setUpCamera()
             }
         }
     case .restricted:
         break
     case .denied:
         break
     case .authorized:
         setUpCamera()
     default:
         break
     }

 }
    func setUpCamera() {
        let session = AVCaptureSession()
        // Try to get the device we want to add
        if let device = AVCaptureDevice.default(for: .video) {
            // if we get device try and add it
            do {
                // create input from device
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                    
                }
                // add output
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                // add session to preview layer
//                previewLayer.videoGravity = .resizeAspectFill
//                previewLayer.session = session
                // start session
                session.startRunning()
                // retain session into global
                self.session = session
                
            }
            // After we have the device
            catch {
                // error handling
                print(error)
                
            }
        }
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as?
            PinterestCell {
            // get all the post 
            cell.mainImgView.image = posts[indexPath.row].image
            return cell
        }
        // otherwise return cell cause of error
        return UICollectionViewCell()
    }
    // add new method
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // create new variable
        let vc = DetailViewController()
        
        if let pinterestCell = collectionView.cellForItem(at: indexPath) as? PinterestCell {
            vc.cc_setZoomTransition(originalView: pinterestCell.mainImgView)
            
            let i : UIImage = posts[indexPath.row].image
            // define the image from detailView
            let resizedImage = i.resizeImage(newSize: CGSize(width: UIScreen.main.bounds.width - 36, height: (UIScreen.main.bounds.width - 36) * (i.size.height / i.size.width)))
            
            // set post for viewcontroller
            vc.post = Post(image: resizedImage,
                           title: posts[indexPath.row].title,
                           description: posts[indexPath.row].description)
            
        }
        
        self.present(vc, animated: true, completion: nil)
        
        return false
    }
}

// conform to layoutDelegate
extension FeedViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return posts[indexPath.row].image.size.height / 4
    }
}

extension FeedViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        // Convert to data back from photo
        guard let data = photo.fileDataRepresentation() else {
            
            return
        }
        // Add to the UI to see the captured photo
        let image = UIImage(data: data)
        
        // Created a single image view
        let imageView = UIImageView(image: image)
        
        // assign the contentMode
        imageView.contentMode = .scaleAspectFit
        
        // Add a frame
        imageView.frame = view.bounds
        
        // add to subview
        view.addSubview(imageView)
    }
    
}

extension FeedViewController: CLLocationManagerDelegate {
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Retrieve the authoratization status
        let CLLocationManager = manager.authorizationStatus
        
        switch CLLocationManager {
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
            // An alert prompting the user about the location services
//            promptForAuthorization()
        case .authorizedAlways:
            print("authorizedAlways")
            // Update the location
            locationServices.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .authorized:
            print("authorized")
        default:
            print("unknown")
        }
        
    }
    // Location information
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
}










