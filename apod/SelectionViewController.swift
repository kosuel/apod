//
//  SelectionViewController.swift
//  apod
//
//  Created by ohhyung kwon on 9/6/2022.
//

import UIKit

class SelectionViewController: UIViewController {
    @IBOutlet weak var previousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previousButton.fill(background: .white, text: .label)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}


// MARK: - Button actions
extension SelectionViewController {

}


