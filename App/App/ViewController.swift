//
//  ViewController.swift
//  App
//
//  Created by Ivan on 11.02.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class DrawingViewController: UIViewController {


    @IBOutlet weak var choiceSegment: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(M_PI) / 180.0
    }
}
//@IBDesidddddgnable
class Draw: UIView {
    override func draw(_ rect: CGRect) {
//      let path = UIBezierPath()
//        path.addArc(withCenter: center, radius: 50, startAngle: CGFloat(0), endAngle: CGFloat(120).toRadians(), clockwise: true)
//      var fillColor = UIColor.red
//                fillColor.setFill()
//                // stroke
//                path.lineWidth = 1.0
//                var strokeColor = UIColor.blue
//                strokeColor.setStroke()
//                // fill and stroke the path (always do these last)
//                path.fill()
//                path.stroke()
////        let part3 = UIBezierPath()
////        let part2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
////                                radius: self.frame.size.height/2,
////                                startAngle: CGFloat(0).toRadians(),
////                                endAngle: CGFloat(360).toRadians(),
////                                clockwise: false)
//        let part3 = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width/2, y:self.frame.size.height/2) , radius:self.frame.size.height/2, startAngle: CGFloat(270).toRadians(), endAngle: CGFloat(0).toRadians(), clockwise: true)
//        fillColor = UIColor.green
//        fillColor.setFill()
//        strokeColor = UIColor.blue
//        strokeColor.setStroke()
////        part2.fill()
////        part2.stroke()
//        part3.fill()
//        part3.stroke()
//    }
//    func drawGraph() -> UIBezierPath{




        // this is about drowing plot
//        let path = UIBezierPath()
//        path.move(to: center)
//        for angle in stride(from: 5.0, through: 360.0, by: 0.5){
//            let x = center.x + CGFloat(angle/360) * 30
//            let y = center.y - CGFloat(sin(angle/180 * Double.pi)) * 30
//            path.addLine(to: CGPoint(x:x, y:y))
//        }
//        UIColor.black.setStroke()
//        path.stroke()
//        return path




//        hole.addClip()

        func showDiagram(){
            var parameters = ["60": UIColor.green, "30": UIColor.blue, "10": UIColor.red]
            var currentAngle = 0;
            let amplifier = 3.6
            let path = UIBezierPath()
            let bigRadius = 70
            let smallRadius = 40
            for (key, value) in parameters{
                path.move(to: center)
                let endAngle = currentAngle + (Int(key) ?? 0) * amplifier
                path.addArc(withCenter: center, radius: bigRadius, startAngle: CGFloat(currentAngle).toRadians(), endAngle: CGFloat(endAngle).toRadians(), clockwise: true)
                path.addArc(withCenter: center, radius: smallRadius, startAngle: CGFloat(currentAngle).toRadians(), endAngle: CGFloat(endAngle).toRadians(), clockwise: true)
                path.move(to: CGPoint(x: center.x + smallRadius * cos(startAngle/ 180 * Double.pi, y: center.y + smallRadius * sin(startAngle/ 180 * Double.pi)))
                path.move(to: CGPoint(x: center.x + bigRadius * cos(startAngle/ 180 * Double.pi, y: center.y + bigRadius * sin(startAngle/ 180 * Double.pi)))
                path.move(to: CGPoint(x: center.x + smallRadius * cos(endAngle/ 180 * Double.pi, y: center.y + smallRadius * sin(endAngle / 180 * Double.pi)))
                path.move(to: CGPoint(x: center.x + bigRadius * cos(endAngle/ 180 * Double.pi, y: center.y + bigRadius * sin(endAngle / 180 * Double.pi)))
                value.setFill()
                path.fill()



        }

        let path = UIBezierPath()
        path .move(to: center)
        path.addArc(withCenter: center, radius: 70, startAngle: CGFloat(270).toRadians(), endAngle: CGFloat(360).toRadians(), clockwise: true)
        path.addLine(to: CGPoint(x:center.x + 70, y:center.y))
        path.move(to: center)
        path.addLine(to: CGPoint(x:center.x, y:center.y + 70))
        UIColor.red.setFill()
        path.fill()

        let hole = UIBezierPath()
        hole.addArc(withCenter: center, radius: 30, startAngle: CGFloat(180).toRadians(), endAngle: CGFloat(360).toRadians(), clockwise: true)


        UIColor.white.setFill()

    }
}
