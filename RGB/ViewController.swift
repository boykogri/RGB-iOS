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
        
        addToolBar()
        setBackgroundOfView()
    }
    
    @IBAction func slidersChanged(_ sender: UISlider) {
        view.endEditing(true)
        let roundColor = getRoundValue(Double(sender.value))
        let color = CGFloat(Double(sender.value))
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
        guard var color1 = Double(sender.text!) else { return }
        if color1 < 0 { color1 = 0 }
        else if color1 > 1{ color1 = 1 }
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
    
    private func getRoundValue(_ value: Double) -> Double{
        return round(value*100)/100
    }
    private func setBackgroundOfView(){
        rgbView.backgroundColor = UIColor(displayP3Red: redColor,
                                          green: greenColor,
                                          blue: blueColor,
                                          alpha: 1)
    }
    
    
}

extension ViewController: UITextFieldDelegate{
    //Скрываем клавиатуру за пределами клавиатуры
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    //Закончили ввод текста
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redTF:
            textField.text = redLabel.text
        case greenTF:
            textField.text = greenLabel.text
        case blueTF:
            textField.text = blueLabel.text
        default:
           break
        }
        
    }
}
extension ViewController{
    private func addToolBar(){
        let toolBar = UIToolbar()
        redTF.inputAccessoryView = toolBar
        greenTF.inputAccessoryView = toolBar
        blueTF.inputAccessoryView = toolBar
        //Под ширину экрана
        toolBar.sizeToFit()
        
        let barItem = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(didTapDone))
        let flexBarItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexBarItem, barItem]
    }
    @objc private func didTapDone(){
        view.endEditing(true)
    }
}
