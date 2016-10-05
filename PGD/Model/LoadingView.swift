//
//  LoadingView.swift
//  PGD
//
//  Created by Pedro Oliveira on 29/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    init(_ view:UIView) {
        super.init(frame: view.frame)
        self.frame = view.frame
        self.center = view.center
        self.backgroundColor = UIColor(colorLiteralRed: 65/255.0, green: 131/255.0, blue: 215/255.0, alpha: 0.8)
        do {
            let loadingView = UIImageView()
            loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 150, height: 81)
            loadingView.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            //todo: fix loading gif from bundle
            //let gifImage = try UIImage.animatedImage(withAnimatedGIFData: NSData(contentsOf:Bundle.main.urlForResource("loading", withExtension: "gif")!) as Data)
            
//            loadingView.animationImages = gifImage.images
//            loadingView.animationDuration = gifImage.duration
//            loadingView.animationRepeatCount = -1//infinite
//            loadingView.image = gifImage.images?.last
//            loadingView.startAnimating()
//            self.addSubview(loadingView)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
