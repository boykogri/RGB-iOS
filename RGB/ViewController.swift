//
//  ViewController.swift
//  RGB
//
//  Created by Григорий Бойко on 04/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    
    @IBOutlet var blueTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var redTF: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    
    @IBOutlet var rgbView: UIView!
    
    private var redColor: CGFloat = 0
    private var greenColor: CGFloat = 0
    private var blueColor: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redColor = CGFloat(redSlider.value)
        greenColor = CGFloat(greenSlider.value)
        blueColor = CGFloat(blueSlider.value)
        
        setBackgroundOfView()
    }
    @IBAction func slidersChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redColor = CGFloat(redSlider.value)
            let roundRedColor = round(redSlider.value*100)/100
            redLabel.text = "\(roundRedColor)"
            redTF.text = "\(roundRedColor)"
        case greenSlider:
            greenColor = CGFloat(greenSlider.value)
            let roundGreenColor = round(greenSlider.value*100)/100
            greenLabel.text = "\(roundGreenColor)"
            greenTF.text = "\(roundGreenColor)"
        case blueSlider:
            blueColor = CGFloat(blueSlider.value)
            let roundBlueColor = round(blueSlider.value*100)/100
            blueLabel.text = "\(roundBlueColor)"
            blueTF.text = "\(roundBlueColor)"
        default:
            return
        }
         setBackgroundOfView()
    }
    private func setBackgroundOfView(){
        rgbView.backgroundColor = UIColor(displayP3Red: redColor, green: greenColor, blue: blueColor, alpha: 1)
    }
    
    
}

