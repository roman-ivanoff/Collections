//
//  DictionaryViewController.swift
//  Collections
//
//  Created by Roman Ivanov on 30.06.2022.
//

import UIKit

class DictionaryViewController: UIViewController {
    var navigationItemNumber: Int!
    var model: DictionaryModel!
    let numberOfSections = 2
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

}
