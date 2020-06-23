//
//  SentMemeDetailViewController.swift
//  MemeMeV2.0
//
//  Created by Adeeb alsuhaibani on 27/10/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation
import UIKit

// MARK: - SentMemeDetailViewController: UIViewController

class SentMemeDetailViewController: UIViewController {
    
    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
