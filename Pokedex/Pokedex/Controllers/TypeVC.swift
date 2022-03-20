//
//  TypeVC.swift
//  Pokedex
//
//  Created by Noah Yin on 3/19/22.
//

import UIKit

class TypeVC: UIViewController {
    var filtered: [Pokemon] = []
    
    var typeColor: [String: UIColor] = ["Grass": #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), "Dark": #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), "Ground": #colorLiteral(red: 0.7884706259, green: 0.3518863916, blue: 0, alpha: 1), "Dragon": #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), "Ice": #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), "Electric": #colorLiteral(red: 0.9966529012, green: 1, blue: 0, alpha: 1), "Normal": #colorLiteral(red: 0.6951308846, green: 0.4658972621, blue: 0.6436214447, alpha: 1), "Fairy": #colorLiteral(red: 0.9537460208, green: 0.5270368457, blue: 0.7791104913, alpha: 1), "Poison": #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), "Fighting": #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), "Psychic": #colorLiteral(red: 0.9791921973, green: 0.3354279995, blue: 0.5399469137, alpha: 1), "Fire": #colorLiteral(red: 1, green: 0.3136056066, blue: 0, alpha: 1), "Rock": #colorLiteral(red: 0.4287654161, green: 0.09344018251, blue: 0, alpha: 1), "Flying": #colorLiteral(red: 0.1503745914, green: 0.4267224073, blue: 0.6114747524, alpha: 1), "Steel": #colorLiteral(red: 0.1663994491, green: 0.551825583, blue: 0.3688330054, alpha: 1), "Ghost": #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), "Water": #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), "Unknown": #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]
    
    var typeName: [String] = ["Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water", "Unknown"]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(filter: [Pokemon]) {
        super.init(nibName: nil, bundle: nil)
        self.filtered = filter
    }
    
    let buttons: [UIButton] = {
        return (0..<18).map { index in
            let button = UIButton()

            // Tag the button its index
            button.tag = index
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 5
            button.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.5)
            
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        for i in 0..<18 {
            buttons[i].setTitle(typeName[i], for: .normal)
            buttons[i].backgroundColor = typeColor["\(typeName[i])"]
        }
        
        
        for i in 0..<18 {
            view.addSubview(buttons[i])
                
            NSLayoutConstraint.activate([
                buttons[i].topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat((i * 40) + 10)),
                
                buttons[i].bottomAnchor.constraint(equalTo: buttons[i].topAnchor, constant: 40),
                
                buttons[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
                
                buttons[i].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
                ])
        }
        
        for i in 0..<18 {
            buttons[i].addTarget(self, action: #selector(typeCallback(_:)), for: .touchUpInside)
            
        }
    }
    
    
    
    @objc func typeCallback (_ sender: UIButton) {
        for poke in PokemonGenerator.shared.getPokemonArray() {
            if sender.currentTitle?.isEqual("\(poke.types[0])") == true  {
                filtered.append(poke)
            }
           
        
        }
//        PokedexVC.shared.filteredPokemon = filtered
        
        let vc = PokedexVC()
        vc.setFilter(filtered: filtered)
        present(vc, animated: true, completion: nil)
    }
    
}
