
//
//
//  FirstViewController.swift
//  HomeSafe
//
//  Created by Alexander Seto on 4/5/15.
//  Copyright (c) 2015 Alexander Seto. All rights reserved.
//

import UIKit
import AudioToolbox

class FirstViewController: UIViewController {
    
    
    let twilioAccountSID = "AC4fdba9d3259fc430ab2d8d3929cf24bc"
    let twilioAuthToken = "fdf5cda8546f1ee6d3d410f1440092a3"
    let twilioPhoneNumber = "%2B17606385144"
    let emergencyPhoneNumber = "%2B17608518298"
    let friendPhoneNumber = "%2B17752873244"
    let firstName = "First-Name"
    let lastName = "LAST-NAME"
    let location = "University-of-california-los-angeles"
    
    
    
    
    var timer = NSTimer()
    var timerRunning = false
    var timercount = 0
    
    func makeCall(){
        println("CALL")
        var url = "https://pure-everglades-8108.herokuapp.com/?location=" + firstName + "--" + lastName + "--" + location
        if let baseURL = NSURL(string: "https://api.twilio.com/2010-04-01/Accounts/" + twilioAccountSID + "/Calls") {
            var urlRequest = NSMutableURLRequest(URL: baseURL)
            urlRequest.HTTPMethod = "POST"
            var queryParams = [
                "To" : emergencyPhoneNumber,
                "From": twilioPhoneNumber,
                "Url": url,
                "Method":"GET",
                "FallbackMethod": "GET",
                "StatusCallbackMethod": "GET",
                "Record":"false"
            ]
            var queryString : String?
            for (key, value) in queryParams {
                if queryString != nil {
                    queryString! += "&"
                } else {
                    queryString = ""
                }
                queryString! += String(key + "=" + value)
            }
            println(url)
            println(queryString)
            urlRequest.HTTPBody = queryString?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            let urlConnection = NSURLConnection(request: urlRequest, delegate: self, startImmediately: true)
        }
        
    }
    
    func callEvent(){
        
        timercount++
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        println(timercount)
        
        if(timercount == 4)
        {
            makeCall()
            UIApplication.sharedApplication().idleTimerDisabled = false
        }
        
    }
    
    func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
        let credentials = NSURLCredential(user: twilioAccountSID, password: twilioAuthToken, persistence: NSURLCredentialPersistence.ForSession)
        challenge.sender.useCredential(credentials, forAuthenticationChallenge: challenge)
    }
    
    
    @IBAction func goSettings(sender: AnyObject) {
        performSegueWithIdentifier("Settings", sender: sender)
    }
    
    
    @IBAction func releaseButton(sender: AnyObject) {
        if(timerRunning == false)
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "callEvent", userInfo: nil, repeats: true)
            UIApplication.sharedApplication().idleTimerDisabled = true
            timerRunning = true
        }
        println("UP")
        
    }
    
    
    
    
    @IBAction func pushDown(sender: AnyObject) {
        if(timerRunning == true)
        {
            timercount = 0;
            timer.invalidate()
            UIApplication.sharedApplication().idleTimerDisabled = false
            timerRunning = false
        }
        println("DOWN")
        
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        
        if(timerRunning == true)
        {
            timercount = 0
            timer.invalidate()
            UIApplication.sharedApplication().idleTimerDisabled = false
            timerRunning = false
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
        
    }
    
    @IBAction func call(sender: AnyObject) {
        callEvent()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let firstTimeLoggingIn: Bool? = userDefaults.objectForKey("firstTimeLogin") as? Bool
        
        if (firstTimeLoggingIn == nil) {
            userDefaults.setBool(true, forKey: "firstTimeLogin")
            alertForFirstLogin()
        }
    }
    func alertForFirstLogin() {
        let firstAlert: UIAlertController = UIAlertController(title: "First Time Configuration", message: "We need to know a little more about you before you can use HomeSafe, please configure your settings.", preferredStyle: UIAlertControllerStyle.Alert)
        let callActionHandler = { (action:UIAlertAction!) -> Void in self.performSegueWithIdentifier("FirstLaunchSegue", sender: self)
        }
        let action1: UIAlertAction = UIAlertAction(title: "Go to Settings", style: .Default, handler: callActionHandler)
        firstAlert.addAction(action1)
        presentViewController(firstAlert, animated: true, completion:nil)
    }
    
    //
    //    override func viewDidDisappear(animated: Bool) {
    //        if(timerRunning == true)
    //        {
    //            timer.invalidate()
    //            timercount = 0
    //            UIApplication.sharedApplication().idleTimerDisabled = false
    //        }
    //    }
    
}


