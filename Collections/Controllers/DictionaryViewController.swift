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

        indicator.hidesWhenStopped = true
        if model.array.isEmpty && model.dictionary.isEmpty {
            model.generateData { [weak self] in
                guard let self = self else { return }
                self.view.bringSubviewToFront(self.indicator)
                self.indicator.startAnimating()
            } completion: { [weak self] in
                guard let self = self else { return }
                self.indicator.stopAnimating()
                self.collectionView.performBatchUpdates({
                    let indexSet = Array(0 ..< self.numberOfSections).map { IndexSet(integer: $0) }
                    self.collectionView.insertSections(indexSet[0])
                    self.collectionView.insertSections(indexSet[1])
                    let indexPathsFirstSection = Array(0 ..< 2).map { IndexPath(item: $0, section: 0) }
                    let indexPathsSecondSection = Array(0 ..< self.model.operations.count).map { IndexPath(item: $0, section: self.numberOfSections - 1) }
                    self.collectionView.insertItems(at: indexPathsFirstSection)
                    self.collectionView.insertItems(at: indexPathsSecondSection)
                })
            }
        }

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Dictionary: \(navigationItemNumber!)"
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dictionaryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DictionaryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model.array.isEmpty && model.dictionary.isEmpty ? 0 : 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 2 : model.operations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()

        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dictionaryCell", for: indexPath) as? CustomCollectionViewCell {
            customCell.indicator.hidesWhenStopped = true
            customCell.indicator.stopAnimating()
            switch indexPath.section {
            case 0:
                if indexPath.item == 0 {
                    customCell.viewCell.backgroundColor = .white
                    customCell.labelCell.text = "Array"
                } else {
                    customCell.viewCell.backgroundColor = .white
                    customCell.labelCell.text = "Dictionary"
                }
            default:
                collectionView.backgroundColor = .lightGray
                let operation = model.operations[indexPath.item]
                switch operation.state {
                case .idle:
                    customCell.labelCell.text = operation.title
                case .execution:
                    customCell.labelCell.text = ""
                    customCell.indicator.startAnimating()
                case .finished(time: let time, number: let number):
                    customCell.labelCell.text = String(format: "Search time: %.02f ms. Result number: %@", time, number)
                }
            }

            cell = customCell
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer {
            collectionView.deselectItem(at: indexPath, animated: true)
        }

        if indexPath.section != 0 {
            let operation = model.operations[indexPath.item]
            guard !operation.isCompleted else { return }
            model.perform(operation: operation) { [weak collectionView] in
                collectionView?.reloadItems(at: [indexPath])
            } completion: { [weak collectionView] in
                collectionView?.reloadItems(at: [indexPath])
            }

        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize
        let width = (collectionView.frame.width - 1) / 2

        switch indexPath.section {
        case 0:
            size = CGSize(width: width, height: 50)
        default:
            size = CGSize(width: width, height: 100)
        }

        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(1)
    }

}
