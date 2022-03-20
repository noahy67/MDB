//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Noah Yin on 3/12/22.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = String(describing: PokemonCell.self)
    
    var symbol: Pokemon? {
        didSet {
            
            let completion: (UIImage) -> Void = { image in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
                
            }
        
            DispatchQueue.global(qos: .utility).async { [self] in
                guard let url = symbol?.imageUrl else {return}
                guard let data = try? Data(contentsOf: url) else {return}
                completion(UIImage(data: data)!)
            }
            let name = symbol?.name
            let id = symbol!.id
            titleView.text = name
            idView.text = String(describing: id)
            
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let idView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.7493669391, green: 0.03352469951, blue: 0.02629736625, alpha: 1)
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        contentView.addSubview(idView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            idView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            idView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            idView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
