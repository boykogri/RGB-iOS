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
        
        let toolBar = UIToolbar()
        let barItem = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(view.endEditing))
        toolBar.setItems([barItem], animated: false)
        toolBar.sizeToFit()
        
        redTF.inputAccessoryView = toolBar
        greenTF.inputAccessoryView = toolBar
        blueTF.inputAccessoryView = toolBar
        
        setBackgroundOfView()
    }
    @IBAction func hideKeyboard() {
        view.endEditing(true)
    }
    @IBAction func slidersChanged(_ sender: UISlider) {
        hideKeyboard()
        //view.endEditing(true)
        let roundColor = getRoundValue(Double(sender.value))
        let color = CGFloat(roundColor)
        switch sender {
        case redSlider:
            redColor = color
            redLabel.text = "\(roundColor)"
            redTF.text = "\(roundColor)"
        case greenSlider:
            greenColor = color
            greenLabel.text = "\(roundColor)"
            greenTF.text = "\(roundColor)"
        case blueSlider:
            blueColor = color
            blueLabel.text = "\(roundColor)"
            blueTF.text = "\(roundColor)"
        default:
            return
        }
        setBackgroundOfView()
    }
    @IBAction func TFChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard let color1 = Double(text) else { return }
        let roundColor = getRoundValue(color1)
        let color = CGFloat(roundColor)
        
        switch sender {
        case redTF:
            redColor = color
            redLabel.text = "\(roundColor)"
            redSlider.value = Float(roundColor)
        case greenTF:
            greenColor = color
            greenLabel.text = "\(roundColor)"
            greenSlider.value = Float(roundColor)
        case blueTF:
            blueColor = color
            blueLabel.text = "\(roundColor)"
            blueSlider.value = Float(roundColor)
        default:
            return
        }
        
        setBackgroundOfView()
    }
    @IBAction func TFWasPressed(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard let color1 = Double(text) else { return }
        sender.text = String(round(color1*100)/100)
    }
    private func getRoundValue(_ value: Double) -> Double{
        return round(value*100)/100
    }
    private func setBackgroundOfView(){
        rgbView.backgroundColor = UIColor(displayP3Red: redColor, green: greenColor, blue: blueColor, alpha: 1)
    }
    
    
}
