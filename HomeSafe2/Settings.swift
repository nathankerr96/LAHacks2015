//
//  Settings.swift
//  HomeSafe2
//
//  Created by Alexander Seto on 4/5/15.
//  Copyright (c) 2015 Alexander Seto. All rights reserved.
//


import UIKit



class Settings: UIViewController, UIApplicationDelegate, UIAppearanceContainer {
    
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var number: UITextField!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var firstNameTemp: NSString
                        var lastNameTemp: NSString
                        var numberTemp: NSString
        
        
                        if(defaults.stringForKey("homesafeFirstName") != nil)
                        {
                            firstNameTemp = defaults.stringForKey("homesafeFirstName")!

                            firstName.setValue(firstNameTemp, forKey: "Placeholder")
                        }
                        if(defaults.stringForKey("homesafeLastName") != nil)

                        {
                            lastNameTemp = defaults.stringForKey("homesafeLastName")!

                            lastName.setValue(lastNameTemp, forKey: "Placeholder")
                        }
                        if(defaults.stringForKey("homesafeNumber") != nil)
                        {
                            numberTemp = defaults.stringForKey("homesafeNumber")!

                            number.setValue(numberTemp, forKey: "Placeholder")
                        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func done(sender: AnyObject) {
        

            
        
                            defaults.setObject(firstName, forKey: "homesafeFirstName")
            
        
            
                        if(lastName != nil)
                        {
                            defaults.setObject(lastName, forKey: "homesafeLastName")
                        }
            
                        if(number != nil)
                        {
                            defaults.setObject(number, forKey: "homesafeNumber")
                        }
                        defaults.synchronize()
            


        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
