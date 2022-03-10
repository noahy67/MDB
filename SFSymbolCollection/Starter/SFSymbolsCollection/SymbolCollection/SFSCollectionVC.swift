//
//  SFSCollectionVC.swift
//  SFSCollectionVC
//
//  Created by Michael Lin on 9/26/21.
//

import UIKit

class SFSCollectionVC: UIViewController {
    
    // TODO: Collection View
    let collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 30
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // without this line, ui has no knowledge of what kind of cell we are going to use, need to register cell which establishes for collection view that you will need to access this cell
        // allows collection to have lots of different types of cells in collection pool
        cv.register(SFSCollectionCell.self, forCellWithReuseIdentifier: SFSCollectionCell.reuseIdentifier)

        return cv
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1B 1D 1F
        view.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1058823529, blue: 0.1098039216, alpha: 1)
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 88, left: 30, bottom: 0, right: 30))
        collectionView.backgroundColor = .clear
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        // assisgns SFSCollectionVC to BE the DATA SOURCE
        // this is how collectionView knows who to ask, calls data source routine and gets collectionView
        collectionView.dataSource = self
        // TODO: Delegate
    }
}

extension SFSCollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SymbolProvider.symbols.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let symbol = SymbolProvider.symbols[indexPath.item]
        // return cell
        // dequeue reusablecell will help get rid of choppy screen
        // will move cells out of sight to the bottom
        
        // COLLECTION -> DATA SOURCE -> DISPLAY -> COLLECTION POOL
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! SFSCollectionCell
        cell.symbol = symbol
        return cell
    }
}

//extension SFSCollectionVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 80, height: 100)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//        let symbol = SymbolProvider.symbols[indexPath.item]
//
//        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
//            return SFSPreviewVC(symbol: symbol)
//        }) { _ in
//            let okItem = UIAction(title: "OK", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) { _ in }
//            return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let symbol = SymbolProvider.symbols[indexPath.item]
//        print("Selected \(symbol.name)")
//    }
//}
