//
//  MainVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    // Create a property for our timer, we will initialize it in viewDidLoad
    var timer: Timer?
    
    // ADDED BY ME
    var gTime = 5
    var aTime = 2
    var previousState = "guess"
    var currentStreak = 0
    var totalStreak = 0
    var scoreF = 0
    var answerStreak: [String] = ["none","none","none"]
    var answer1: String?
    
    enum State {
        case guess, pause, stats, showAnswer
    }
    
    var currState: State = State.guess
    
    // MARK: STEP 7: UI Customization
    // Action Items:
    // - Customize your imageView and buttons.
    
    let imageView: UIImageView = {
        let view = UIImageView()
        
        // MARK: >> Your Code Here <<
        view.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1.0)
        view.layer.borderWidth = 5
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    

    
    let buttons: [UIButton] = {
        return (0..<4).map { index in
            let button = UIButton()

            // Tag the button its index
            button.tag = index
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 5
            button.layer.borderColor = .init(red: 102/255, green: 102/255, blue: 255/255, alpha: 1.0)
            // MARK: >> Your Code Here <<
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }
        
    }()
    
    // MARK: STEP 10: Stats Button
    // Action Items:
    // - Follow the examples you've seen so far, create and
    // configure a UIButton for presenting the StatsVC. Only the
    // callback function `didTapStats(_:)` was written for you.
    
    // MARK: >> Your Code Here <<
    let statButton: UIButton = {
        let stat = UIButton()
        stat.setTitle("STATS", for: .normal)
        stat.setTitleColor(.black, for: .normal)
        
        stat.translatesAutoresizingMaskIntoConstraints = false
        
        return stat
    }()
    
    let scoreLabel: UILabel = {
        let scoreLab = UILabel()
        scoreLab.textColor = .black
        
        scoreLab.translatesAutoresizingMaskIntoConstraints = false
        
        return scoreLab
    }()
    
    let pauseButton: UIButton = {
        let pauseB = UIButton()
        pauseB.setTitleColor(.black, for: .normal)
        pauseB.setTitle("PAUSE", for: .normal)
        
        pauseB.translatesAutoresizingMaskIntoConstraints = false
        
        return pauseB
    }()
    
    let timerLabel: UILabel = {
        let timerB = UILabel()
        timerB.textColor = .black
        timerB.text = "Guessing Time Left: 5"
        
        timerB.translatesAutoresizingMaskIntoConstraints = false
        
        return timerB
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        
        // MARK: STEP 6: Adding Subviews and Constraints
        // Action Items:
        // - Add imageViews and buttons to the root view.
        // - Create and activate the layout constraints.
        // - Run the App
        
        // Additional Information:
        // If you don't like the default presentation style,
        // you can change it to full screen too! However, in this
        // case you will have to find a way to manually to call
        // dismiss(animated: true, completion: nil) in order
        // to go back.
        //
        // modalPresentationStyle = .fullScreen
        
        // MARK: >> Your Code Here <<
        getNextQuestion()
        startTimer()
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -340),
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        for i in 0..<4 {
            view.addSubview(buttons[i])
                
            NSLayoutConstraint.activate([
                buttons[i].topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: CGFloat((i * 60) + 50)),
                
                buttons[i].bottomAnchor.constraint(equalTo: buttons[i].topAnchor, constant: 50),
                
                buttons[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75),
                
                buttons[i].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75)
                ])
        }
        
        view.addSubview(statButton)
        
        NSLayoutConstraint.activate([
            statButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            statButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
        
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            scoreLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
        
        view.addSubview(pauseButton)
        
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            pauseButton.leadingAnchor.constraint(equalTo: scoreLabel.trailingAnchor, constant: 50),
            
            pauseButton.trailingAnchor.constraint(equalTo: statButton.leadingAnchor, constant: -50)
            
        ])
        
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
            
        ])
        
        // MARK: STEP 9: Bind Callbacks to the Buttons
        // Action Items:
        // - Bind the `didTapAnswer(_:)` function to the buttons.
        
        // MARK: >> Your Code Here <<
        for i in 0..<4 {
            buttons[i].addAction(UIAction(handler: { action in
                self.tapAnswerHandler(action)
            }), for: .touchUpInside)
            
        }
        
        
        
        // MARK: STEP 10: Stats Button
        // See instructions above.
        
        // MARK: >> Your Code Here <<
        statButton.addAction(UIAction(handler: { action in
            self.tapStatsHandler(action)
        }), for: .touchUpInside)
        
        pauseButton.addAction(UIAction(handler: { action in
            self.tapPauseButton(action)
        }), for: .touchUpInside)
    }
    
    // What's the difference between viewDidLoad() and
    // viewWillAppear()? What about viewDidAppear()?
    override func viewWillAppear(_ animated: Bool) {
        // MARK: STEP 13: Resume Game
        
        // MARK: >> Your Code Here <<
    }
    
    func getNextQuestion() {
        // MARK: STEP 5: Data Model
        // Action Items:
        // - Get a question instance from `QuestionProvider`
        // - Configure the imageView and buttons with information from
        //   the question instance
        
        // MARK: >> Your Code Here <<
        let question = QuestionProvider.shared.nextQuestion()
        imageView.image = question?.image
        answer1 = question?.answer
        for i in 0..<4 {
            buttons[i].setTitle(question?.choices[i], for: .normal)
            buttons[i].backgroundColor = .black
        }
        scoreLabel.text = "SCORE: \(scoreF)"
        
    }
    
    // MARK: STEP 8: Buttons and Timer Callback
    // You don't have to
    // Action Items:
    // - Complete the callback function for the 4 buttons.
    // - Complete the callback function for the timer instance
    // - Call `startTimer()` where appropriate
    //
    // Additional Information:
    // Take some time to plan what should be in here.
    // The 4 buttons should share the same callback.
    //
    // Add instance properties and/or methods
    // to the class if necessary. You may need to come back
    // to this step later on.
    //
    // Hint:
    // - Checkout `UIControl.addAction(_:for:)`
    //      (`UIButton` subclasses `UIControl`)
    // - You can use `sender.tag` to identify which button is pressed.
    // - The timer will invoke the callback every one second.
    func startTimer() {
        // Create a timer that calls timerCallback() every one second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    @objc func timerCallback() {
        // MARK: >> Your Code Here <<
        switch currState {
        case .guess:
            gTime -= 1
            timerLabel.text = "Guessing Time Left: \(gTime)"
            if gTime <= 0 {
                gTime = 5
                answerStreak.append("LOSS")
                timerLabel.text = "WRONG!!! Answer Display Time: 2"
                for i in 0..<4 {
                    if buttons[i].currentTitle == answer1 {
                        buttons[i].backgroundColor = .green
                    } else {
                        buttons[i].backgroundColor = .red
                    }
                }
    
                currState = .showAnswer
            }
        case .pause:
            break
        case .stats:
            break
        case .showAnswer:
            aTime -= 1
            timerLabel.text = "Answer Display Time: \(aTime)"
            if aTime <= 0 {
                aTime = 2
                gTime = 5
                currState = .guess
                timerLabel.text = "Guessing Time Left: 5"
                getNextQuestion()
            }
        }
            
    }
    
    func tapPauseButton(_ action: UIAction) {
        if currState == .pause {
            pauseButton.setTitle("PAUSE", for: .normal)
            if previousState == "guess" {
                currState = .guess
            } else if previousState == "showAnswer" {
                currState = .showAnswer
            }
        } else {
            if currState == .guess {
                previousState = "guess"
            } else if currState == .showAnswer {
                previousState = "showAnswer"
            }
            scoreF = 0
            scoreLabel.text = "SCORE: \(scoreF)"
            currState = .pause
            pauseButton.setTitle("RESUME", for: .normal)
        }
    }
    
    func tapAnswerHandler(_ action: UIAction) {
        // MARK: >> Your Code Here <<
        guard let sender = action.sender as? UIButton else {
            return
        }
        if buttons[sender.tag].currentTitle == answer1 {
            buttons[sender.tag].backgroundColor = .green
//            // update stats
            currentStreak += 1
            scoreF += 1
            if currentStreak > totalStreak {
                totalStreak = currentStreak
            }
            answerStreak.append("WIN")
            aTime = 2
            timerLabel.text = "CORRECT!!! Answer Display Time: \(aTime)"
            currState = .showAnswer
        }
        else {
            buttons[sender.tag].backgroundColor = .red
//            // update stats
            for i in 0..<4 {
                if buttons[i].currentTitle == answer1 {
                    buttons[i].backgroundColor = .green
                } 
            }
            answerStreak.append("LOSS")
            currentStreak = 0
            aTime = 2
            timerLabel.text = "WRONG!!! Answer Display Time: \(aTime)"
            currState = .showAnswer
        }
    }
    
    func tapStatsHandler(_ action: UIAction) {
        
        let vc = StatsVC(long: totalStreak, streak: answerStreak)
            if currState == .guess {
                previousState = "guess"
            } else if currState == .showAnswer {
                previousState = "showAnswer"
            }
            currState = .pause
        pauseButton.setTitle("RESUME", for: .normal)
        
        // MARK: STEP 11: Going to StatsVC
        // When we are navigating between VCs (e.g MainVC -> StatsVC),
        // we often need a mechanism for transferring data
        // between view controllers. There are many ways to achieve
        // this (initializer, delegate, notification center,
        // combined, etc.). We will start with the easiest one today,
        // which is custom initializer.
        //
        // Action Items:
        // - Pause the game when stats button is tapped i.e. stop the timer

        
        // - Read the example in StatsVC.swift, and replace it with
        //   your custom init for `StatsVC`
        // - Update the call site here on line 139
        present(vc, animated: true, completion: nil)
        
    }
}
