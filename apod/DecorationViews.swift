//
//  DecorationViews.swift
//  apod
//
//  Created by ohhyung kwon on 9/6/2022.
//

import UIKit

class DecorationView:UIView {
    let backColor = UIColor.init(named: "AppColor")!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setNeedsDisplay()
    }
}

// top quarter circle design and title view
class TitleView: DecorationView{
    
    override func draw(_ rect: CGRect) {
        
        // clear background
        UIColor.systemBackground.setFill()
        UIBezierPath(rect: rect).fill()
        
        // fill background
        let path = UIBezierPath()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY-30), controlPoint: CGPoint(x: rect.midX, y: rect.minY+rect.height))
        
        path.close()
        
        backColor.set()
        path.fill()
        
        // draw app Title
        let leftMargin = 20.0
        
        let title1 = NSLocalizedString("Things", comment: "app title").uppercased()
        let attrs1 = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle), NSAttributedString.Key.foregroundColor:UIColor.white]
        let textSize1 = title1.size(withAttributes: attrs1)
        
        title1.draw(with: CGRect(x: rect.minX+leftMargin, y: rect.minY+textSize1.height, width: rect.width, height: textSize1.height), attributes: attrs1, context: nil)
        
        // draw sub title
        let title2 = NSLocalizedString("The App", comment: "app title2")
        let attrs2 = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1), NSAttributedString.Key.foregroundColor:UIColor.white]
        let textSize2 = title2.size(withAttributes: attrs2)

        title2.draw(with: CGRect(x: rect.minX+leftMargin, y: rect.minY+textSize1.height+textSize2.height, width: rect.width, height: textSize2.height), attributes: attrs2, context: nil)
    }
}

// bottom design of ListViewController(first scene)
class LeftRoundBottomView: DecorationView{
    
    override func draw(_ rect: CGRect) {
        
        // clear background
        UIColor.systemBackground.setFill()
        UIBezierPath(rect: rect).fill()
        
        // fill background
        let path = UIBezierPath()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY+30), controlPoint: CGPoint(x: rect.midX, y: rect.maxY-rect.height))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.close()
        
        backColor.set()
        path.fill()
    }
}

// bottom design of SelectionViewController(second scene)
class RightRoundBottomView: DecorationView{
    
    override func draw(_ rect: CGRect) {
        
        // clear background
        UIColor.systemBackground.setFill()
        UIBezierPath(rect: rect).fill()
        
        // fill background
        let path = UIBezierPath()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY+30))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY-30), controlPoint: CGPoint(x: rect.midX, y: rect.maxY-rect.height))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.close()
        
        backColor.set()
        path.fill()
    }
}
