//
//  SentMemesTableViewController.swift
//  MemeMeV2.0
//
//  Created by Adeeb alsuhaibani on 27/10/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import Foundation

import UIKit

// MARK: - SentMemesTableViewController: UIViewController , UITableViewDataSource, UITableViewDelegate

class SentMemesTableViewController: UITableViewController {
    
    
    
    
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.tabBarController?.tabBar.isHidden = false
        
        tableView!.reloadData()
    }
    
    
    
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SentMemesTableViewCell")! as! SentMemesTableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
    
        cell.cellImage.image = meme.memedImage
        cell.cellLabel.text = "\(meme.topTextField!) ... \(meme.bottomTextField!)"
        
        //          // If the cell has a detail label, we will put the evil scheme in.
        //          if let detailTextLabel = cell.detailTextLabel {
        //              detailTextLabel.text = "Scheme: \(villain.evilScheme)"
        //          }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "SentMemeDetailViewController") as! SentMemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
