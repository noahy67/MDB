//
//  RollCallVC.swift
//  CalHacksDemo
//
//  Created by Michael Lin on 8/26/20.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import UIKit

class RollCallVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var presentButton: UIButton! {
        didSet {
            var config = UIButton.Configuration.tinted()
            config.title = "Present"
            config.image = UIImage(systemName: "checkmark.circle.fill")
            config.baseForegroundColor = .systemGreen
            config.baseBackgroundColor = .systemGreen
            config.imagePadding = 10
            config.buttonSize = .large
            
            // assign configs to be active configuration of button
            presentButton.configuration = config
            presentButton.addAction(UIAction(handler: { [unowned self] _ in
                Roster.main.addName(toPresent: self.currentName)
                self.showNextNameOrResult()
            }), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var absentButton: UIButton! {
        didSet {
            var config = UIButton.Configuration.tinted()
            config.title = "Absent"
            config.image = UIImage(systemName: "xmark.circle.fill")
            config.baseForegroundColor = .systemRed
            config.baseBackgroundColor = .systemRed
            config.imagePadding = 10
            config.buttonSize = .large
        
            // assign configs to be active configuration of button
            absentButton.configuration = config
            absentButton.addAction(UIAction(handler: { [unowned self] _ in
                Roster.main.addName(toAbsent: self.currentName)
                self.showNextNameOrResult()
            }), for: .touchUpInside)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel.text = Roster.main.getNextName()
    }
    
    // Read only
    // add a set to make it not read only
    // Computed property
    var currentName: String! {
        get {
            return nameLabel.text
        }
    }
    
    private func showNextNameOrResult() {
        if let name = Roster.main.getNextName() {
            setUserInteractionEnabled(to: false)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.nameLabel.alpha = 0
            }, completion: { _ in
                self.nameLabel.text = name
                self.setUserInteractionEnabled(to: true)
                UIView.animate(withDuration: 0.3, animations: {
                    self.nameLabel.alpha = 1
                })
            })
        } else {
            performSegue(withIdentifier: "toResults", sender: nil)
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as: ResultVC
//
//    }
    
    private func setUserInteractionEnabled(to value: Bool) {
        presentButton.isUserInteractionEnabled = value
        absentButton.isUserInteractionEnabled = value
    }
}
