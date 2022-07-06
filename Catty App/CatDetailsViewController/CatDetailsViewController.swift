//
//  CatDetailsViewController.swift
//  Catty App
//
//  Created by Vladimir Alyoshkin on 02.12.21.
//

import UIKit

class CatDetailsViewController: UIViewController {
    @IBOutlet weak var catsImageView: UIImageView!
    
    private var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.catsImageView.image = image
        self.navigationItem.title = "Catty image"
    }
    
    func configure(image: UIImage?) {
        self.image = image
        
        if let imageView = catsImageView {
            imageView.image = image
            
          }
        }
    }

