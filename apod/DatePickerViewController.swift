//
//  DatePickerViewController.swift
//  apod
//
//  Created by ohhyung kwon on 10/6/2022.
//

import UIKit

protocol DatePickerViewControllerDelegate: AnyObject {
    func dateSelected(from vc:UIViewController, on date:Date)
}

class DatePickerViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var okButton: UIButton!

    weak var delegate: DatePickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let appColor = UIColor.init(named: "AppColor")!
        okButton.fill(background: appColor, text: .white)
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }

        // fit viewcontroller size
        preferredContentSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
    @IBAction func okayAction(_ sender: Any) {
        guard let delegate = delegate else {
            dismiss(animated: true)
            return
        }

        dismiss(animated: true)
        delegate.dateSelected(from: self, on: datePicker.date)
    }
    
}
