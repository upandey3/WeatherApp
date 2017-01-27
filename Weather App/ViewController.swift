//
//  ViewController.swift
//  Weather App
//
//  Created by Utkarsh Pandey on 1/6/17.
//  Copyright © 2017 Utkarsh Pandey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    
    
    
    @IBAction func submitButton(_ sender: Any) {
        
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + cityField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest"){
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                var message = ""
                if error != nil{
                    print(error!)
                    //self.labelResult.text = "The weather was not found there. Please check the spelling and enter a city."
                }else{
                    if let unwrappedData = data{
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        //print (dataString)
                        
                        var stringSeparator = "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator){
                            
                            if contentArray.count > 1 {
                                
                                stringSeparator = "</span>"
                                
                                let contentArray2 = contentArray[1].components(separatedBy: stringSeparator)
                                
                                if contentArray2.count > 1 {
                                    
                                    message = contentArray2[0].replacingOccurrences(of: "&deg;", with: "°" )
                                    
                                    print(message)
                                }
                            }
                        }
                    }
                }
                if message == ""{
                    message = "The weather there could not be found. Please try again."
                }
                DispatchQueue.main.sync(execute: {
                    
                    self.labelResult.text = message
                    
                })
            }
            task.resume()
        }
        else{
            labelResult.text = "The weather there could not be found. Please try again."
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

