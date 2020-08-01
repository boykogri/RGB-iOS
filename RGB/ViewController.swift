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
    
    @IBOutlet var doneButton: UIButton!
    
    var redColor: CGFloat!
    var greenColor: CGFloat!
    var blueColor: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialState()
        addToolBar()
        setBackgroundOfView()
    }
    
    @IBAction func slidersChanged(_ sender: UISlider) {
        view.endEditing(true)

        let roundColor = CGFloat(sender.value).format(2)
        let color = CGFloat(sender.value)
        switch sender {
        case redSlider:
            redColor = color
            redLabel.text = roundColor
            redTF.text = roundColor
        case greenSlider:
            greenColor = color
            greenLabel.text = roundColor
            greenTF.text = roundColor
        case blueSlider:
            blueColor = color
            blueLabel.text = roundColor
            blueTF.text = roundColor
        default:
            return
        }
        setBackgroundOfView()
    }
    @IBAction func TFChanged(_ sender: UITextField) {
        guard var color = Double(sender.text!) else { return }
        if color < 0 { color = 0 }
        else if color > 1{ color = 1 }
        let roundColor = CGFloat(color).format(2)
        
        switch sender {
        case redTF:
            redColor = CGFloat(color)
            redLabel.text = roundColor
            redSlider.value = Float(roundColor)!
        case greenTF:
            greenColor = CGFloat(color)
            greenLabel.text = roundColor
            greenSlider.value = Float(roundColor)!
        case blueTF:
            blueColor = CGFloat(color)
            blueLabel.text = roundColor
            blueSlider.value = Float(roundColor)!
        default:
            return
        }
        setBackgroundOfView()
    }
    
    private func setupInitialState(){
        redSlider.value = Float(redColor)
        greenSlider.value = Float(greenColor)
        blueSlider.value = Float(blueColor)
        
        let redRoundColor = CGFloat(redSlider.value).format(2)
        print("red: \(redSlider.value)")
        print(String(format: "%.2f", redSlider.value))
        print("redRound: \(redRoundColor)")
        let greenRoundColor = CGFloat(greenSlider.value).format(2)
        let blueRoundColor = CGFloat(blueSlider.value).format(2)
        
        redLabel.text = redRoundColor
        greenLabel.text = greenRoundColor
        blueLabel.text = blueRoundColor
        
        redTF.text = redRoundColor
        greenTF.text = greenRoundColor
        blueTF.text = blueRoundColor
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
        let flexBarItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        toolBar.items = [flexBarItem, barItem]
    }
    @objc private func didTapDone(){
        view.endEditing(true)
    }
}
//Кол-во после запятой
extension CGFloat{
    func format(_ numberOfDecimal: Int) -> String{
        return String(format: "%.\(numberOfDecimal)f", self)
    }
}
