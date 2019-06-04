//
//  ViewController.swift
//  OBDTextExtraction
//
//  Created by Invenst PhoneFour on 4/9/19.
//  Copyright © 2019 Invenst PhoneFour. All rights reserved.
//


import UIKit
import Firebase

class ViewController: UIViewController{
    
    var ref = DatabaseReference.init()
    var img_url: URL!
    // MARK :Properties
    @IBOutlet weak var img_view: UIImageView!
    var imagePicker: ImagePicker!
    var sendData=""
    var receiveData = ""
    
    @IBOutlet weak var vehicleID: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

// code for image picker
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self as! ImagePickerDelegate)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    
        
        // code to done
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolbar.setItems([donebutton], animated: false)
        vehicleID.inputAccessoryView = toolbar
    
    
    
    }
    @objc func doneClicked()
    {
        
        
        view.endEditing(true)
    }
    

    @IBAction func uploadButton(_ sender: UIButton) {
       
        self.savefirdata()
        self.showToast(message: "Please wait")
       
    }
    
     // code to display a toast when the upload button is clicked

    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //MARK: Action
    @IBAction func defaultButton(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
        
    
    }
    


    // This part of code sends the selected image to the server
    func savefirdata(){
            self.uploadImage(self.img_view.image!){ url in
            //print(url!)
             self.img_url = url
             print(self.img_url!)
            
            self.saveImage(profileURL: url!){ success in
                
                if success != nil {
                    print("Done..!")
                    
                }
            }
            
            // Server URL 
            let final_url_string = "http://3.80.145.49/default/" + url!.absoluteString
            print(final_url_string)
            guard let final_url = URL(string:final_url_string) else {return}
            let session = URLSession.shared
            session.dataTask(with: final_url) { (data, response, error) in
                if(error != nil)
                {
                    return
                }
                if let response = response
                {
                    print("response")
                    print(response)
                }
                
                if let data = data
                {
                       let finaldata = String(data: data, encoding: .utf8)
                       // print(finaldata!)
                       //self.receiveData = finaldata!
                    
                    
                }
                 self.receiveData = String(data: data!, encoding: .utf8) ?? ""
                
                OperationQueue.main.addOperation {
                   self.performSegue(withIdentifier: "name2", sender: self)
                }
            }.resume()
            
            
        }
        
       
    }

// A segue is used to pass the obtained results onto the next view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("In segue")
        print(self.receiveData)
        var vc = segue.destination as! TestController
        vc.temp = self.receiveData
        vc.vehicle_id = self.vehicleID.text!
        
    }
    
    
}

extension ViewController{
    
    func uploadImage(_ image:UIImage,completion: @escaping((_ url:URL?)->())){
        var mystr = String(self.vehicleID.text!) + ".jpg"
       // print(mystr)
        let storageRef = Storage.storage().reference().child(mystr)
        
        let imageData = img_view.image!.pngData()
        //let imageData = myimageview.image?.pngData()
        /* if imageData != nil{
         print(" not nil..!")
         }
         
         let metaData = StorageMetadata()
         metaData.contentType = "image/png"
         */
        
        storageRef.putData(imageData!, metadata: nil) {(metaData,error) in
            if error == nil{
                print("Success")
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                    //print(url?.absoluteString)
                    //self.img_url = url
                    print("URL -")
                    //print(self.img_url)
    
                    
                })
            }
            else{
                
                print("Error in uploading an image...!")
                completion(nil)
            }
            
        }
    }
    
    func saveImage(profileURL:URL, completion: @escaping((_ url : URL?)->())){
        
        let dict = ["name":"OBD","profileURL":profileURL.absoluteString] as! [String:Any]
        self.ref.child("chat").childByAutoId().setValue(dict)
    }
    
    }


extension ViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.img_view.image = image
        
        
    }
}

