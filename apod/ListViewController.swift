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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! // show when fetching...
    
    var isFetching = true {
        didSet{
            
            activityIndicator.isHidden = !isFetching
            tableView.isHidden = isFetching
        }
    }
    
    var apods = [Apod]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.fill(background: .white, text: .label)
        
        activityIndicator.isHidden = true

        // start fetch data
        let today = Date().start.addDays(-1)
        let oneWeekBefore = today.addDays(-8)

        isFetching = true
        Apod.fetchApods(from: oneWeekBefore, to: today) { [weak self] apods in
            
            guard let self = self else { return}
            
            self.apods = apods ?? []
            
            self.tableView.reloadData()
            
            self.isFetching = false
        }
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
    
    enum CellIdentifier: String{
        case basicCell = "Cell"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        apods.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.basicCell.rawValue, for: indexPath)
        let dateLabel = cell.contentView.viewWithTag(100) as? UILabel
        let titleLabel = cell.contentView.viewWithTag(101) as? UILabel
        let image = cell.contentView.viewWithTag(102)
        
        let apod = apods[indexPath.section]
        
        dateLabel?.text = DateFormatter.localizedString(from: apod.date, dateStyle: .medium, timeStyle: .none)
        titleLabel?.text = apod.title
        image?.alpha = apod.isSelected ? 1.0 : 0.0
        
        let colors = UIColor.cellColors
        let colorIndex = indexPath.section % colors.count
        
        cell.backgroundColor = colors[colorIndex]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        apods[indexPath.section].isSelected = !apods[indexPath.section].isSelected

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
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
