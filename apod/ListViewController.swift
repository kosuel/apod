//
//  ViewController.swift
//  apod
//
//  Created by ohhyung kwon on 9/6/2022.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.fill(background: .white, text: .label)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // send over apod data selection
        if let _ = segue.destination as? SelectionViewController {
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

// MARK: - Tableview data source and delegate
extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

// MARK: - Button actions
extension ListViewController {
    
    @IBAction func nextAction(_ sender: Any) {
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue){
        // do nothing
    }
}
