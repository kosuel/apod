//
//  ChosenView.swift
//  apod
//
//  Created by ohhyung kwon on 10/6/2022.
//

import UIKit

class ChosenView: UIView{
 
    private let titleLabel = UILabel()
    private let label = UILabel()
    private let questionMark = UIImageView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)

        // title label set up
        titleLabel.text = NSLocalizedString("Chosen Thing", comment: "")
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        // description label set up
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        
        layer.cornerRadius = 10
        
        // set questin mark
        
        questionMark.image = UIImage(systemName: "questionmark.app")
        questionMark.tintColor = UIColor.init(named: "AppColor")!
        questionMark.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 80)
        addSubview(questionMark)
        
        questionMark.translatesAutoresizingMaskIntoConstraints = false
        questionMark.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        questionMark.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        // initial status
        label.isHidden = true
    }
    
    func update(with apod:Apod?, color:UIColor?){
        if let apod = apod {
            label.text = apod.title
            
            backgroundColor = color ?? .clear
            
            label.isHidden = false
            questionMark.isHidden = true
        }
        else{
            label.isHidden = true
            questionMark.isHidden = false
            
            backgroundColor = .clear
        }
    }
}
