//
//  PhotoViewController.swift
//  apod
//
//  Created by ohhyung kwon on 10/6/2022.
//

import UIKit

class PhotoViewController: UIViewController{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageViewer: UIImageView!
    
    var imageUrl:URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = title
        
        if let url = imageUrl {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

                guard let data = data, error == nil else {
                    return
                }

                DispatchQueue.main.async {

                    guard let self = self else {
                        return
                    }

                    if let image = UIImage(data: data) {
                        self.imageViewer.image = image
                    }
                }
                
            }.resume()
        }
    }
}
