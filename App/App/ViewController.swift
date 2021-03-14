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
    
    @IBOutlet weak var segmentedContorl: UISegmentedControl!
    
    @IBOutlet weak var plotView: Draw!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func changePlot(_ sender: UISegmentedControl) {
    
            switch segmentedContorl.selectedSegmentIndex{
        case 0: plotView.state = 1
                plotView.setNeedsDisplay()
        case 1: plotView.state = 2
            plotView.setNeedsDisplay()
        default: break;
        }
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}


class Draw: UIView {
    public var state: Int = 1
    override func draw(_ rect: CGRect) {
    func drawGraph(){
        let axis = UIBezierPath()
        axis.move(to: CGPoint(x: center.x, y: center.y + 140))
        axis.addLine(to: CGPoint(x: center.x, y: center.y - 140))
        axis.addLine(to: CGPoint(x: center.x - 10, y: center.y - 130))
        axis.move(to: CGPoint(x: center.x, y: center.y - 140))
        axis.addLine(to: CGPoint(x: center.x + 10, y: center.y - 130))
        
        axis.move(to: CGPoint(x: center.x - 140, y: center.y))
        axis.addLine(to: CGPoint(x: center.x + 140, y: center.y))
        axis.addLine(to: CGPoint(x: center.x + 130, y: center.y + 10))
        axis.move(to: CGPoint(x: center.x + 140, y: center.y))
        axis.addLine(to: CGPoint(x: center.x + 130, y: center.y - 10))

        UIColor.blue.setStroke()
        axis.stroke()

        let path = UIBezierPath()
        let x = center.x + CGFloat(-3) * 5
        let y = center.y - CGFloat(-3 * -3 * -3) * 5
        path.move(to: CGPoint(x: x, y: y))
        for angle in stride(from: -3.0, through: 3.0, by: 0.1){
            let x = center.x + CGFloat(angle) * 5
            let y = center.y - CGFloat(angle * angle * angle) * 5
            path.addLine(to: CGPoint(x:x, y:y))
        }
        UIColor.black.setStroke()
        path.stroke()
        
    }


        func showDiagram(){
            let parameters = ["15": UIColor.yellow, "25": UIColor.brown, "45": UIColor.gray, "10": UIColor.red, "5": UIColor.purple]
            var startAngle = CGFloat(0)
            let amplifier = CGFloat(3.6)
            let bigRadius = CGFloat(70)
            for (key, value) in parameters{
                let path = UIBezierPath()
                let endAngle = startAngle + CGFloat(Int(key) ?? 0) * amplifier
                path.addArc(withCenter: center, radius: bigRadius, startAngle: CGFloat(startAngle).toRadians(), endAngle: CGFloat(endAngle).toRadians(), clockwise: true)
                value.setStroke()
                path.lineWidth = 30
                path.stroke()
                startAngle = endAngle
                }
        }
        if (state == 1){showDiagram()}
        else {drawGraph()}

    }
}
