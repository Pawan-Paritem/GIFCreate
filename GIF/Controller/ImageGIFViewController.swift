//
//  ImageGIFViewController.swift
//  GIF
//
//  Created by Pawan  on 14/10/2020.
//

import UIKit
import ImageIO
import MobileCoreServices
import Photos


class ImageGIFViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
        
    @IBOutlet weak var imgCollectionView: UICollectionView!
    @IBOutlet weak var showGIFimage: UIImageView!
    
    var Arrayimg = [#imageLiteral(resourceName: "Man"),#imageLiteral(resourceName: "Sun"),#imageLiteral(resourceName: "Wallpaper"),#imageLiteral(resourceName: "0"),#imageLiteral(resourceName: "Wallpaper")]
    var path = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   // Function GIF Images
    @IBAction func showGifImage(_ sender: UIButton) {
        
        //assign image array and create gif file and in photo library
        if generateGif(photos: Arrayimg, filename: "/mygif.gif") {
            PHPhotoLibrary.shared().performChanges({
                let request = PHAssetCreationRequest.forAsset()
                request.addResource(with: .photo, fileURL:URL(fileURLWithPath: self.path) ,options: nil)
            }) { (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("GIF has saved")
                    
                    DispatchQueue.main.async {
                        self.showGIFimage.image = UIImage.gif(url: URL(fileURLWithPath: self.path).absoluteString)
                    }
                    
                }
            }
            print("Create")
            
        }else{
            print("Sorry")
        }
    }
    
    @IBAction func openButton(_ sender: UIButton) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        present(myPickerController, animated: true)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Success", message: "Gif File saved to photo library", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    //create path for gif file
    func generateGif(photos: [UIImage], filename: String) -> Bool {
        let documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
         path = documentsDirectoryPath.appending(filename)
        print(path)
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]
        print(fileProperties)
        let gifProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: 0.125]]
        print(gifProperties)
        let cfURL = URL(fileURLWithPath: path) as CFURL
        if let destination = CGImageDestinationCreateWithURL(cfURL, kUTTypeGIF, photos.count, nil) {
                CGImageDestinationSetProperties(destination, fileProperties as CFDictionary?)
                for photo in photos {
                    CGImageDestinationAddImage(destination, photo.cgImage!, gifProperties as CFDictionary?)
                }
                return CGImageDestinationFinalize(destination)
            }
        return false
    }
}

