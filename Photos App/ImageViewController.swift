//
//  ImageViewController.swift
//  Photos App
//
//  Created by Armando Silveira on 3/7/17.
//  Copyright © 2017 Armando Silveira. All rights reserved.
//

import UIKit
import Photos

class ImageViewController : UIViewController {

    @IBOutlet weak var imageView:UIImageView!
    var asset: PHAsset!
    
    // presentation
    static func present(for asset: PHAsset, in navigationController: UINavigationController?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "image") as! ImageViewController
        
        controller.asset = asset
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    // view setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PHImageManager.default().requestImage(for: asset, targetSize: self.imageView.frame.size, contentMode: .aspectFit, options: nil, resultHandler: {
            image, options in
            
            self.imageView.image = image
        })
    }
    
    
}
