//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController {
    var filter: Bool = false
    var config: Bool = true
    var filteredPokemon: [Pokemon] = []
    var pokemons = PokemonGenerator.shared.getPokemonArray()
    let searchController = UISearchController(searchResultsController: nil)
    
//    static let shared = PokedexVC()
    
    
    
//    init(filtered: [Pokemon]) {
//        super.init(nibName: nil, bundle: nil)
//        self.filteredPokemon = filtered
//    }
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.reuseIdentifier)
        return collectionView
    }()
    
    let pokemonTitle: UILabel = {
        let label = UILabel()
        label.text = "POKEDEX"
        label.textColor = .red
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitle("SEARCH", for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.isSpringLoaded = true
//        button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESET", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.text = "FIND POKEMON HERE!"
        search.backgroundColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        search.barStyle = .default
        //search.layer.borderWidth = 1
        search.showsScopeBar = true
//        search.isTranslucent = true
        search.searchTextField.borderStyle = .roundedRect
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private let typeButton: UIButton = {
        let button = UIButton()
        button.setTitle("TYPE SELECT", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let configButton: UIButton = {
        let button = UIButton()
        button.setTitle("GRID", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

//        // 1
//        searchController.searchResultsUpdater = self
//        // 2
//        searchController.obscuresBackgroundDuringPresentation = false
//        // 3
//        searchController.searchBar.placeholder = "FIND POKE"
//        // 4
//        navigationItem.searchController = searchController
//        // 5
//        definesPresentationContext = true
        
        view.addSubview(collectionView)
        // Do any additional setup after loading the view.
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 175, left: 30, bottom: 0, right: 30))
        collectionView.backgroundColor = .clear
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.dataSource = self
        // both data source and delegate are part of the delegate design, once you assign it UICollectionViewDelegateFlowLayout will be active
        collectionView.delegate = self
        
        view.addSubview(pokemonTitle)
        view.addSubview(searchBar)
        view.addSubview(searchButton)
        view.addSubview(resetButton)
        view.addSubview(typeButton)
        view.addSubview(configButton)
        setConstraints()
        
        
        configButton.addTarget(self, action: #selector(configCallback(_:)), for: .touchUpInside)
        
        searchButton.addTarget(self, action: #selector(searchCallback(_:)), for: .touchUpInside)
        
        resetButton.addTarget(self, action: #selector(resetCallback(_:)), for: .touchUpInside)
        
        typeButton.addTarget(self, action: #selector(typeCallback(_:)), for: .touchUpInside)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            pokemonTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            pokemonTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            pokemonTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
            ])
        
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75).isActive = true
    
        searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 100).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -100).isActive = true
        
        typeButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        typeButton.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 10).isActive = true
        typeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        resetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 5).isActive = true
        
        configButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        configButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        configButton.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10).isActive = true
    }

    public func setFilter (filtered: [Pokemon]) {
        self.filteredPokemon = filtered
        filter = true
        collectionView.reloadData()
    }

    @objc func searchCallback (_ sender: UIButton) {
        filter = true
        filteredPokemon = []
        for poke in PokemonGenerator.shared.getPokemonArray() {
            if poke.name.contains(searchBar.text!) == true {
                filteredPokemon.append(poke)
            }
        }
        collectionView.reloadData()
    }
    
    @objc func resetCallback (_ sender: UIButton) {
        filter = false
        filteredPokemon = []
        collectionView.reloadData()
    }
    
    @objc func typeCallback (_ sender: UIButton) {
        let vc = TypeVC(filter: filteredPokemon)
        modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func configCallback (_ sender: UIButton) {
        if config == true {
            config = false
            configButton.setTitle("ROW", for: .normal)
        } else {
            config = true
            configButton.setTitle("GRID", for: .normal)
        }
        collectionView.reloadData()
    }
    
}

//
//extension PokedexVC: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        filterContentForSearchText(searchBar.text!)
//
//      }
//}


extension PokedexVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filter {
            return filteredPokemon.count
        } else {
        return pokemons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
        if filter {
            symbol = filteredPokemon[indexPath.item]
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.reuseIdentifier, for: indexPath) as! PokemonCell
        cell.symbol = symbol
        return cell
    }
}

extension PokedexVC: UICollectionViewDelegateFlowLayout {
    
    // must implement this function so the cell sizing doesn't go back to default
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if config == true {
                return CGSize(width: 100, height: 125)
            } else {
                return CGSize(width: 500, height: 125)
            }
            
        }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
        if filter {
            symbol = filteredPokemon[indexPath.item]
        }
        
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return PokePreviewVC(symbol: symbol)
        }) { _ in
            let okItem = UIAction(title: "OK", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) { _ in }
            return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
        }
    }
    
    // Callback function you have to implement for when you click on the cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
        
        if filter {
            symbol = filteredPokemon[indexPath.item]
        }
        let vc = StatsVC(symbol: symbol)
        present(vc, animated: true, completion: nil)
    }
}
