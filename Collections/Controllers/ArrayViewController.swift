//
//  ArrayViewController.swift
//  Collections
//
//  Created by Roman Ivanov on 29.06.2022.
//

import UIKit

class ArrayViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var navigationItemNumber: Int!
    var model: ArrayModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Array: \(navigationItemNumber!)"
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "arrayCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ArrayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model.array.isEmpty ? 1 : 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : model.arrayOperations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()

        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "arrayCell", for: indexPath) as? CustomCollectionViewCell {
            customCell.indicator.hidesWhenStopped = true
            customCell.indicator.stopAnimating()

            switch indexPath.section {
            case 0:
                switch model.arrayGeneration {
                case .idle:
                    customCell.labelCell.text = "Create Int array with 10_000_000 elements"
                case .execution:
                    customCell.indicator.startAnimating()
                case let .finished(time):
                    customCell.labelCell.text = String(format: "Array generation time: %.02f", time)
                }
            default:
                let operation = model.arrayOperations[indexPath.item]
                switch operation.state {
                case .idle:
                    customCell.labelCell.text = operation.title
                case .execution:
                    customCell.labelCell.text = ""
                    customCell.indicator.startAnimating()
                case let .finished(time):
                    customCell.labelCell.text = String(format: "Execution time: %.02f", time)

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

        if indexPath.section == 0 {
            guard model.array.isEmpty else { return }
            model.generateArray { [weak collectionView] in
                collectionView?.reloadItems(at: [indexPath])
            } completion: { [weak collectionView] in
                collectionView?.reloadData()
            }
        } else {
            let operation = model.arrayOperations[indexPath.item]

            guard !operation.isCompleted else { return }
            model.perform(operation: operation) { [weak collectionView] in
                collectionView?.reloadItems(at: [indexPath])
            } completion: { [weak collectionView] in
                collectionView?.reloadItems(at: [indexPath])
            }

        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            var size = CGSize()

            switch indexPath.section {
                case 0:
                    size = CGSize(width: UIScreen.main.bounds.width - 2, height: 100)
                default:
                    size = CGSize(width: (collectionView.frame.width - 1) / 2, height: 100)
            }

            return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0.0, bottom: 0, right: 0.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(1)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(1)
    }
}

