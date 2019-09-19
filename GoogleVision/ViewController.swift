//
//  ViewController.swift
//  GoogleVision
//
//  Created by moon on 19/09/2019.
//  Copyright © 2019 Bugking. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let gv = GoogleVision.init(apiKey: "")
        let img = UIImage(named: "Image")
        gv.run(image:img) { (text, err) in
            guard let text = text, err == nil else {
                print(err?.localizedDescription)
                return
            }
            
            print(text)
        }
    }


}

