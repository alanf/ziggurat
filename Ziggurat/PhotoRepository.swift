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
    
    private let photoLibrary: PhotoLibrary

    init(photoLibrary: PhotoLibrary) {
        self.photoLibrary = photoLibrary
    }
    
    func saveImage(image: UIImage, completion: (NSError?) -> ()) {
        if photoLibrary.authorizationStatus() == .NotDetermined {
            photoLibrary.requestAuthorization({ _ in
                self.saveImage(image, completion: completion)
            })
        } else if photoLibrary.authorizationStatus() == .Authorized {
            photoLibrary.performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromImage(image)
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
    
    func requestAuthorization(handler: ((PHAuthorizationStatus) -> Void)!){
        PHPhotoLibrary.requestAuthorization(handler)
    }
    
    func performChanges(changeBlock: dispatch_block_t!, completionHandler: ((Bool, NSError?) -> Void)?) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock, completionHandler: completionHandler)
    }
    
    func performChangesAndWait(changeBlock: dispatch_block_t) throws {
        try PHPhotoLibrary.sharedPhotoLibrary().performChangesAndWait(changeBlock)
    }
}
