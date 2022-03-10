//
//  StatsVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import UIKit

class StatsVC: UIViewController {
    
    // MARK: STEP 11: Going to StatsVC
    // Read the instructions in MainVC.swift
    
    let dataExample: String
    var longScore = 0
    var streak: [String] = []
    
    
    init(data: String) {
        self.dataExample = data
        // Delegate rest of the initialization to super class
        // designated initializer.
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: >> Your Code Here <<
    init(long: Int, streak: [String]) {
        self.longScore = long
        self.streak = streak
        self.dataExample = ""
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // MARK: STEP 12: StatsVC UI
    // Action Items:
    // - Initialize the UI components, add subviews and constraints
    
    // MARK: >> Your Code Here <<
    
    private let LS: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let StreakS1: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let StreakS2: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let StreakS3: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let StreakT: UILabel = {
        let label = UILabel()
        label.text = "Result of Last 3 Questions:"
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        LS.text = "Longest Win Streak: \(longScore)"
        StreakS1.text = streak[streak.endIndex - 1]
        StreakS2.text = streak[streak.endIndex - 2]
        StreakS3.text = streak[streak.endIndex - 3]
        
        view.addSubview(LS)
        
        NSLayoutConstraint.activate([
            LS.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            LS.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            
            LS.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])
        
        view.addSubview(StreakT)
        
        NSLayoutConstraint.activate([
            StreakT.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            StreakT.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            
            StreakT.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
        ])
        
        view.addSubview(StreakS1)
        
        NSLayoutConstraint.activate([
            StreakS1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            
            StreakS1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50)
            
        ])
        
        view.addSubview(StreakS2)
        
        NSLayoutConstraint.activate([
            StreakS2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            
            StreakS2.leadingAnchor.constraint(equalTo: StreakS1.trailingAnchor, constant: 20)
            
        ])
        
        view.addSubview(StreakS3)
        
        NSLayoutConstraint.activate([
            StreakS3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            
            StreakS3.leadingAnchor.constraint(equalTo: StreakS2.trailingAnchor, constant: 20)
        ])
        // MARK: >> Your Code Here <<
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "BACK", style: .plain, target: self, action: nil)
    }
}
