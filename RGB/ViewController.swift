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
    
    var color: UIColor!
    var delegate: SetColorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupInitialState()
        addToolBar()
        setBackgroundOfView()
    }
    
    @IBAction func slidersChanged(_ sender: UISlider) {
        view.endEditing(true)

        let roundColor = string(from: sender)

        switch sender {
        case redSlider:
            redLabel.text = roundColor
            redTF.text = roundColor
        case greenSlider:
            greenLabel.text = roundColor
            greenTF.text = roundColor
        case blueSlider:
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
        
        switch sender {
        case redTF:
            redSlider.value = Float(color)
            redLabel.text = string(from: redSlider)
        case greenTF:
            greenSlider.value = Float(color)
            greenLabel.text = string(from: greenSlider)
        case blueTF:
            blueSlider.value = Float(color)
            blueLabel.text = string(from: blueSlider)
        default:
            return
        }
        setBackgroundOfView()
    }
    
    private func setupInitialState(){
        //Слушатели для клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
       
        let colors = CIColor(color: color)

        redSlider.value = Float(colors.red)
        greenSlider.value = Float(colors.green)
        blueSlider.value = Float(colors.blue)
        
        let redRoundColor = string(from: redSlider)
        let greenRoundColor = string(from: greenSlider)
        let blueRoundColor = string(from: blueSlider)
        
        redLabel.text = redRoundColor
        greenLabel.text = greenRoundColor
        blueLabel.text = blueRoundColor
        
        redTF.text = redRoundColor
        greenTF.text = greenRoundColor
        blueTF.text = blueRoundColor
    }

    func setBackgroundOfView(){
        color = UIColor(red: CGFloat(redSlider.value),
                        green: CGFloat(greenSlider.value),
                        blue: CGFloat(blueSlider.value),
                        alpha: 1)
        rgbView.backgroundColor = color
        delegate?.setColor(color)
    }
    //Кол-во после запятой для label и TF
    private func string(from slider: UISlider) -> String{
        return String(format: "%.2f", slider.value)
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
    
    //Чтоб контент двигался вместе с клавиатурой (неправильная реализация)
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
