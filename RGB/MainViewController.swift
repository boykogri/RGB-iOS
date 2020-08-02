//
//  MainViewController.swift
//  RGB
//
//  Created by Григорий Бойко on 01.08.2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
       
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if let vc = segue.source as? ViewController {
            vc.setBackgroundOfView()
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? ViewController{
            dvc.color = view.backgroundColor
            dvc.delegate = self
        }
    }
    

}
extension MainViewController: SetColorDelegate{
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }

}

