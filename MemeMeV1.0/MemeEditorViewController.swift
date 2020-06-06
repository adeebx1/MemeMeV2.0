//
//  MemeEditorViewController.swift
//  MemeMeV1.0
//
//  Created by Adeeb alsuhaibani on 26/09/1441 AH.
//  Copyright © 1441 Adeebx1. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Properties
    
    let topTextDelegate = TextDelegate(text: "TOP")
    let BottomTextDelegate = TextDelegate(text: "BOTTOM")
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UIToolbar!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = imagePickerView.image != nil
        
        textFieldStyle(textfiled: topText, withText: "TOP")
        textFieldStyle(textfiled: bottomText, withText: "BOTTOM")
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topText.delegate = self.topTextDelegate
        self.bottomText.delegate = self.BottomTextDelegate
    }
    func textFieldStyle(textfiled: UITextField , withText text: String ){
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth:  -3,
            NSAttributedString.Key.paragraphStyle: paragraph
        ]
        
        textfiled.defaultTextAttributes = memeTextAttributes
        textfiled.backgroundColor = UIColor.clear
        textfiled.borderStyle = .none
        textfiled.text = text
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled = imagePickerView.image != nil
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        let input = sender as! UIBarButtonItem
        let PickerController = UIImagePickerController()
        PickerController.delegate = self
        PickerController.sourceType =  input.tag == 0 ? .camera : .photoLibrary
        present(PickerController, animated: true, completion: nil)
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification:Notification){
        guard bottomText.isEditing else {
            return
        }
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    func save() {
        // Create the meme
        _ = Meme(topTextField: topText.text!, bottomTextField: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
    }
    
    func hideBars (_ Hidden:Bool){
        navBar.isHidden = Hidden
        toolBar.isHidden = Hidden
    }
    
    func generateMemedImage() -> UIImage {
        
        hideBars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideBars(false)
        
        return memedImage
    }
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityVController = UIActivityViewController(activityItems: [memedImage] , applicationActivities: nil)
        
        activityVController.completionWithItemsHandler = {_, completed, _, _ in
            if !completed {
                self.dismiss(animated: true, completion: nil)
            }
            self.save()
        }
        
        present(activityVController, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        imagePickerView.image = nil
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        shareButton.isEnabled = imagePickerView.image != nil
        
        
    }
    
    
    
}


