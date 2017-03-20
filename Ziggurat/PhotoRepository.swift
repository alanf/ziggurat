//
//  PhotoRepository.swift
//  Register
//
//  Created by Alan Fineberg on 11/5/15.
//  Copyright 2015 Square, Inc.
//

import Foundation
import Photos

/// Repository for saving images to a photo library.
/// Not used in the app, just an example of what a Repository is used for (i/o).
class PhotoRepository {
  
  fileprivate let photoLibrary: PhotoLibrary
  
  init(photoLibrary: PhotoLibrary) {
    self.photoLibrary = photoLibrary
  }
  
  func saveImage(_ image: UIImage, completion: @escaping (NSError?) -> ()) {
    if photoLibrary.authorizationStatus() == .notDetermined {
      photoLibrary.requestAuthorization({ _ in
        self.saveImage(image, completion: completion)
      })
    } else if photoLibrary.authorizationStatus() == .authorized {
      photoLibrary.performChanges({
        PHAssetChangeRequest.creationRequestForAsset(from: image)
      }, completionHandler: { (_, error) in
        completion(error)
      })
    } else {
      // Skipped error handling
    }
  }
}


/// Wrapper around PHPhotoLibrary to enable dependency injection.
class PhotoLibrary {
  
  // MARK: - Initialization
  
  init() {}
  
  // MARK: - Public Methods
  
  func authorizationStatus() -> PHAuthorizationStatus {
    return PHPhotoLibrary.authorizationStatus()
  }
  
  func requestAuthorization(_ handler: ((PHAuthorizationStatus) -> Void)!){
    PHPhotoLibrary.requestAuthorization(handler)
  }
  
  func performChanges(_ changeBlock: @escaping ()->()!, completionHandler: ((Bool, NSError?) -> Void)?) {
    PHPhotoLibrary.shared().performChanges(changeBlock as! () -> Void, completionHandler: completionHandler as! ((Bool, Error?) -> Void)?)
  }
  
  func performChangesAndWait(_ changeBlock: @escaping ()->()) throws {
    try PHPhotoLibrary.shared().performChangesAndWait(changeBlock)
  }
}
