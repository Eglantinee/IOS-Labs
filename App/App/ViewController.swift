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
    
    @IBOutlet weak var Test: UILabel!

    
    @IBOutlet weak var choiceSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Test.text = "new phrase"
    }
}


class Draw: UIView {
    override func draw(_ rect: CGRect) {
      let path = UIBezierPath(ovalIn: rect)
      UIColor.green.setFill()
      path.fill()
    }
}
