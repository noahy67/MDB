//
//  PokePreviewVC.swift
//  Pokedex
//
//  Created by Noah Yin on 3/12/22.
//

import UIKit

class PokePreviewVC: UIViewController {
    
    private let imageView = UIImageView()

    override func viewDidLoad() {
        view.addSubview(imageView)
        let width = 110
        let height = 110
        preferredContentSize = CGSize(width: width, height: height)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    init(symbol: Pokemon) {
        super.init(nibName: nil, bundle: nil)

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        if let imageD = try? Data(contentsOf: symbol.imageUrl!) {
            if let currI = UIImage(data: imageD) {
                imageView.image = currI
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

