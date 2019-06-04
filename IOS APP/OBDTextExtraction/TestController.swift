//
//  TestController.swift
//  OBDTextExtraction
//
//  Created by Invenst PhoneFour on 5/1/19.
//  Copyright © 2019 Invenst PhoneFour. All rights reserved.
//

import UIKit
import Firebase

class TestController: UIViewController {

    var temp = ""
    var vehicle_id = ""
    
    var ref = DatabaseReference.init()
    
    @IBOutlet weak var TestText: UITextField!
    
    @IBOutlet weak var DTC: UITextField!
    
    
    @IBOutlet weak var Readiness_Supported: UITextField!
    
    @IBOutlet weak var Readiness_Complete: UITextField!
    
    
    @IBOutlet weak var Readiness_NS: UITextField!
    
    @IBOutlet weak var DataStreamSup: UITextField!
    
    
    @IBOutlet weak var Ignition_supp: UITextField!
    
    
    @IBOutlet weak var Protocol_Type: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var res = temp.split(separator: " ")
        TestText.text = String(res[0])
        DTC.text = String(res[1])
        Readiness_Supported.text = String(res[2])
        Readiness_Complete.text = String(res[3])
        Readiness_NS.text = String(res[4])
        DataStreamSup.text = String(res[5])
        Ignition_supp.text = String(res[6])
        Protocol_Type.text = String(res[7])
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebutton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolbar.setItems([donebutton], animated: false)
        TestText.inputAccessoryView = toolbar
        DTC.inputAccessoryView = toolbar
        Readiness_Supported.inputAccessoryView = toolbar
        Readiness_Complete.inputAccessoryView = toolbar
        Readiness_NS.inputAccessoryView = toolbar
        DataStreamSup.inputAccessoryView = toolbar
        Ignition_supp.inputAccessoryView = toolbar
        Protocol_Type.inputAccessoryView = toolbar
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func doneClicked()
    {
        
        
        view.endEditing(true)
    }
    
    
    @IBAction func submit_btn(_ sender: Any) {
        
        self.ref = Database.database().reference()

        let dict = ["MIL Status":TestText.text!,"DTC in this ECU":DTC.text!,"Readiness Supported":Readiness_Supported.text!,"Readiness Complete":Readiness_Complete.text!,"Readiness Not Supported":Readiness_NS.text!,"Datastream Supported":DataStreamSup.text!,"Ignition":Ignition_supp.text!,"Protocol Type":Protocol_Type.text!,"Vehicle ID": vehicle_id] as! [String:Any]
        self.ref.child(vehicle_id + "default").childByAutoId().setValue(dict)
        self.showToast(message: "Details Updated")
        print("Success")
        
    }
    
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
    

}


    

