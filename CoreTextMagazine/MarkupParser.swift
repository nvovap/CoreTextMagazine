//
//  MarkupParser.swift
//  CoreTextMagazine
//
//  Created by Vladimir Nevinniy on 6/19/17.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import UIKit
import CoreText

class MarkupParser: NSObject {
    
    // MARK: - Properties
    var color: UIColor = .black
    var fontName: String = "Arial"
    var attrString: NSMutableAttributedString!
    var images: [[String: Any]] = []
    
    // MARK: - Initializers
    override init() {
        super.init()
    }
    
    // MARK: - Internal
    func parseMarkup(_ markup: String) {
        //1
        attrString = NSMutableAttributedString(string: "")
        //2
        do {
            let regex = try NSRegularExpression(pattern: "(.*?)(<[^>]+>|\\Z)",
                                                options: [.caseInsensitive,
                                                          .dotMatchesLineSeparators])
            //3
            let chunks = regex.matches(in: markup,
                                       options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                       range: NSRange(location: 0,
                                                      length: markup.characters.count))
            
            
            let defaultFont: UIFont = .systemFont(ofSize: UIScreen.main.bounds.size.height / 40)
            //1
            for chunk in chunks {
                //2
                guard let markupRange = markup.range(from: chunk.range) else { continue }
                //3
                let parts = markup.substring(with: markupRange).components(separatedBy: "<")
                //4
                let font = UIFont(name: fontName, size: UIScreen.main.bounds.size.height / 40) ?? defaultFont
                //5
                let attrs = [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.font: font] as [NSAttributedStringKey : Any]
                let text = NSMutableAttributedString(string: parts[0], attributes: attrs)
                attrString.append(text)
                
            }
            
            
        } catch _ {
        }
    }
    
    

}


// MARK: - String
extension String {
    func range(from range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex,
                                       offsetBy: range.location,
                                       limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) else {
                return nil
        }
        
        return from ..< to
    }
}
