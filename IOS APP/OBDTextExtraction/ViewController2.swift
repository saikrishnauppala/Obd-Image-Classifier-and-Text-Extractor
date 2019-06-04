//
//  ViewController2.swift
//  OBDTextExtraction
//
//  Created by Invenst PhoneFour on 4/30/19.
//  Copyright © 2019 Invenst PhoneFour. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var lab4: UILabel!
    
    @IBOutlet weak var lab8: UILabel!
    @IBOutlet weak var lab7: UILabel!
    @IBOutlet weak var lab6: UILabel!
    @IBOutlet weak var lab5: UILabel!
    @IBOutlet weak var lab3: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var lab1: UILabel!
    var finalName=""
    @IBOutlet weak var Proto: UITextField!
    @IBOutlet weak var Ignition: UITextField!
    @IBOutlet weak var DataStream: UITextField!
    @IBOutlet weak var ReadinessNotCom: UITextField!
    @IBOutlet weak var ReadinessComplete: UITextField!
    @IBOutlet weak var ReadinessSupported: UITextField!
    @IBOutlet weak var Dtc: UITextField!
    @IBOutlet weak var Mil: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //let result = self.finalName.split(separator: " ")
        print(self.finalName)
        /*if(result[0] != "*")
        {
            self.Mil.text = String(result[0])
            
        }
        if(result[1] != "*")
        {
            self.Dtc.text = String(result[1])
            
        }
        if(result[2] != "*")
        {
            self.ReadinessSupported.text = String(result[2])
            
        }
        if(result[3] != "*")
        {
            self.ReadinessComplete.text = String(result[3])
            
        }
        if(result[4] != "*")
        {
            self.ReadinessNotCom.text = String(result[4])
            
        }
        if(result[5] != "*")
        {
            self.DataStream.text = String(result[5])
            
        }
        if(result[6] != "*")
        {
            self.Ignition.text = String(result[6])
            
        }
        if(result[7] != "*")
        {
            self.Proto.text = String(result[7])
            
        }*/
        
        
    }
    

    

}
