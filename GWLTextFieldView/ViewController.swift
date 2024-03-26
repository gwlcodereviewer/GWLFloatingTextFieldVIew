//
//  ViewController.swift
//  dfsdf
//
//  Created by MAC-51 on 18/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: GWLFloatingLabelTextField!
    @IBOutlet weak var textView: GWLTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionOnerror(_ sender: Any) {
        textField.errorMessage = "Error"
        textView.errorMessage = "Error"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.textField.errorMessage = nil
            self.textView.errorMessage = nil
        }
    }
    
}

