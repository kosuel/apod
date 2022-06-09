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
    @IBOutlet weak var appendButton: UIButton! // append custom date button
    
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
//        appendButton.setImage(UIImage.init(named: "plus.circle"), for: .normal)
        
        activityIndicator.isHidden = true

        // start fetch data
        let today = Date().start.addDays(-1)
        let oneWeekBefore = today.addDays(-5)

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


extension ListViewController: DatePickerViewControllerDelegate{
    func dateSelected(from vc: UIViewController, on date: Date) {

        // if there is a photo on the date, just return
        guard apods.contains(where:{ $0.date.isSameDate(to: date) }) == false else {
            
            let alert = UIAlertController(title: NSLocalizedString("Photo already exists on date", comment: ""), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default))
            
            present(alert, animated: true)
            
            return
        }
        
        Apod.fetchApod(of: date) { [weak self] apod in
            guard let self = self,
            let apod = apod else { return }
            
            var apods = self.apods
            apods.append(apod)
            
            apods.sort { $0.date < $1.date }
            
            self.apods = apods
            
            self.tableView.reloadData()
        }
    }
}

// MARK: - Button actions
extension ListViewController {
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue){
        // do nothing
    }
    
    @IBAction func appendUserDateAction(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DatePicker") as! DatePickerViewController
        vc.delegate = self
        
        // good reference about UIPopoverPresentationController
        //
        // http://www.thomashanning.com/uipopoverpresentationcontroller/
        vc.modalPresentationStyle = .popover;
        
        let popoverPresentationController = vc.popoverPresentationController!;
        popoverPresentationController.delegate = self
        popoverPresentationController.sourceRect = sender.frame;
        popoverPresentationController.sourceView = self.view;
        popoverPresentationController.permittedArrowDirections = [.down, .up];

        present(vc, animated: true)
    }
}

    
extension ListViewController: UIPopoverPresentationControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        adaptivePresentationStyle(for: controller)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // iPhone에서도 popover를 보여준다.
        .none
    }
}
