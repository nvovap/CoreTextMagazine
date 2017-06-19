//
//  CTView.swift
//  CoreTextMagazine
//
//  Created by Vladimir Nevinniy on 6/19/17.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import UIKit

class CTView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        guard let contex = UIGraphicsGetCurrentContext() else {
            return
        }
        
        contex.textMatrix = CGAffineTransform.identity
        contex.translateBy(x: 0, y: bounds.size.height)
        contex.scaleBy(x: 1.0, y: -1.0)
        
        let path = CGMutablePath()
        path.addRect(bounds)
        
        let attrString = NSAttributedString(string: "Hello world")
               
        
        let framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
        
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, nil)
        
        CTFrameDraw(frame, contex)
        
    }
    

}
