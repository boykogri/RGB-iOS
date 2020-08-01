//
//  MainViewController.swift
//  RGB
//
//  Created by Григорий Бойко on 01.08.2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    private var redColor: CGFloat!
    private var greenColor: CGFloat!
    private var blueColor: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorScreen()
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if let vc = segue.source as? ViewController {
            redColor = vc.redColor
            blueColor = vc.blueColor
            greenColor = vc.greenColor
            
            setupColorScreen()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? ViewController{
            dvc.redColor = redColor
            dvc.greenColor = greenColor
            dvc.blueColor = blueColor
        }
    }
    
    private func setupColorScreen(){
        if let red = redColor, let blue = blueColor, let green = greenColor{
            colorView.backgroundColor = UIColor(red: red,
                                                green: green,
                                                blue: blue,
                                                alpha: 1)
        }else {
            redColor = 1
            greenColor = 1
            blueColor = 1
            colorView.backgroundColor = UIColor(red: redColor,
                                                green: greenColor,
                                                blue: blueColor,
                                                alpha: 1)
        }
        
    }

}


