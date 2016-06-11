//
//  MonumentHelper.swift
//  ManiuMental
//
//  Created by Khadir Baaoua on 09/06/2016.
//  Copyright © 2016 Atlastic. All rights reserved.
//

import Foundation
import CoreLocation

class MonumentHelper {
    
    static func loadCSVData(contentsOfURL: NSURL, encoding: NSStringEncoding, error: NSErrorPointer) -> [(name:String, latitude:String, longitude: String)]? {
        var items:[(name:String, latitude:String, longitude:String)]?
        let delimiter = ";"
        
        if let data = NSData(contentsOfURL: contentsOfURL) {
            if let content = NSString(data: data, encoding: NSUTF8StringEncoding) {
            items = []
            let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()) as [String]
            
            for line in lines {
                var values:[String] = []
                if line != "" {
                    // For a line with double quotes
                    // we use NSScanner to perform the parsing
                    if line.rangeOfString("\"") != nil {
                        var textToScan:String = line
                        var value:NSString?
                        var textScanner:NSScanner = NSScanner(string: textToScan)
                        while textScanner.string != "" {
                            
                            if (textScanner.string as NSString).substringToIndex(1) == "\"" {
                                textScanner.scanLocation += 1
                                textScanner.scanUpToString("\"", intoString: &value)
                                textScanner.scanLocation += 1
                            } else {
                                textScanner.scanUpToString(delimiter, intoString: &value)
                            }
                            
                            // Store the value into the values array
                            values.append(value as! String)
                            
                            // Retrieve the unscanned remainder of the string
                            if textScanner.scanLocation < textScanner.string.characters.count {
                                textToScan = (textScanner.string as NSString).substringFromIndex(textScanner.scanLocation + 1)
                            } else {
                                textToScan = ""
                            }
                            textScanner = NSScanner(string: textToScan)
                        }
                        
                        // For a line without double quotes, we can simply separate the string
                        // by using the delimiter (e.g. comma)
                    } else  {
                        values = line.componentsSeparatedByString(delimiter)
                    }
                    
                    // Put the values into the tuple and add it to the items array
                    let item = (name: values[0], latitude: values[1], longitude: values[2])
                    items?.append(item)
                }
                }
            }
        }
        return items
    }
    
    //1. FOURSQUARE : RETRIEVE Monuments around coordinates
    // https://api.foursquare.com/v2/venues/search?ll=48.858933,%202.293468&categoryId=%204bf58dd8d48988d12d941735&radius=500&oauth_token=RMZVYBUOGUJAQLK4N1YLEJDIJ2JAPVIKPJ2ZNY4GMAZ4PNK1&v=20160610
    
    //2. Wikipedia : get sections of page 
    // https://fr.wikipedia.org/w/api.php?format=json&action=parse&prop=sections&format=json&page=Tour+Eiffel
    
    //3. 
    
    
}
