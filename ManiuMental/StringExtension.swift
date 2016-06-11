//
//  NSAttributedStringExtension.swift
//  ManiuMental
//
//  Created by Khadir Baaoua on 10/06/2016.
//  Copyright © 2016 Atlastic. All rights reserved.
//

import Foundation
import UIKit

extension String {
    init(htmlEncodedString: String) {
        do {
            let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding)!
            let attributedOptions : [String: AnyObject] = [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
            ]
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self.init(attributedString.string)
        } catch {
            fatalError("Unhandled error: \(error)")
        }
    }
}