//
//  ViewController.swift
//  Photos App
//
//  Created by Armando Silveira on 3/7/17.
//  Copyright © 2017 Armando Silveira. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    var assets:PHFetchResult<PHAsset>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { _ in
                
                DispatchQueue.main.sync {
                    self.loadImagesIfPossible()
                }
                
            }
        } else {
            loadImagesIfPossible()
        }
    }

    
    func loadImagesIfPossible() {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            return
        }
        
        self.assets = PHAsset.fetchAssets(with: .image, options: nil)
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath)
        
        if let imageCell = cell as? ImageCell,
            let asset = self.assets?.object(at: indexPath.item) {
            
            imageCell.decorate(for: asset)
            //asset.
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets?.countOfAssets(with: .image) ?? 0
    }
    
    
    //Mark:: - Collectino Vie wDelegate
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalWidth = self.view.frame.width - 2
        let cellWidth = totalWidth / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //MARK: - User INteraction
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let asset = self.assets?.object(at: indexPath.item) {
            ImageViewController.present(for: asset, in: self.navigationController)
        }
    }
    
    

}



class ImageCell : UICollectionViewCell {
    @IBOutlet weak var photoView: UIImageView!
    
    func decorate(for asset: PHAsset) {
        PHImageManager.default().requestImage(for: asset, targetSize: self.frame.size, contentMode: .aspectFill, options: nil, resultHandler: { image, options in
            
            //DispatchQueue.main.sync {
                self.photoView.image = image
            //}
            
        })
    }
    
    
}




