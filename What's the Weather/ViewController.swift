//
//  ViewController.swift
//  What's the Weather
//
//  Created by Ryan Lim on 7/13/16.
//  Copyright © 2016 Ryan Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func findWeather(sender: AnyObject) {
        var wasSuccessful = false
        let attemptedURL  = NSURL(string: "http://www.weather-forecast.com/locations/\(cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-"))/forecasts/latest")
        if let url = attemptedURL {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                print(webContent)
                let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                if websiteArray.count > 1 {
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    if weatherArray.count > 1  {
                        wasSuccessful = true
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        dispatch_async(dispatch_get_main_queue(), {
                            self.resultLabel.text = weatherSummary
                        })
                    }
                    
                    
                }
                
            }
            if wasSuccessful == false {
                self.resultLabel.text = "Couldn't find the weather for that city. Please try again."
            }
        }
        task.resume()
        } else {
            self.resultLabel.text = "Couldn't find the weather for that city. Please try again."
        }
    }
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

