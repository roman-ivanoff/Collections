//
//  ViewController.swift
//  Collections
//
//  Created by Roman Ivanov on 24.06.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let setId = "setsId"
    let arrayId = "arraysId"
    let dictionaryId = "dictionarysId"
    let arrayModel = ArrayModel()
    let setModel = SetModel()
    let dictionaryModel = DictionaryModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)

        tableView.delegate = self
        tableView.dataSource = self
    }

    func getRundomNumber() -> Int {
        return Int.random(in: 0 ..< 10_000)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width - 32, height: 50))

        let label = UILabel(frame: CGRect(x: 16, y: 0, width: header.frame.size.width, height: header.frame.size.height))
        header.addSubview(label)

        label.text = "Collections"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectionsCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)

        switch(indexPath.row) {
            case 0:
                cell.textLabel?.text = "Array"
            case 1:
                cell.textLabel?.text = "Set"
            case 2:
                cell.textLabel?.text = "Dictionary"
            default:
                break
        }

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }

        switch(indexPath.row) {
            case 0:
                performSegue(withIdentifier: arrayId, sender: arrayModel)
            case 1:
                performSegue(withIdentifier: setId, sender: setModel)
            case 2:
                performSegue(withIdentifier: dictionaryId, sender: dictionaryModel)
            default:
                break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
            backItem.title = "Collections"
            navigationItem.backBarButtonItem = backItem

        if segue.identifier == arrayId, let model = sender as? ArrayModel {
            let destController = segue.destination as! ArrayViewController
            destController.navigationItemNumber = getRundomNumber()
            destController.model = model
        } else if segue.identifier == setId, let model = sender as? SetModel {
            let destController = segue.destination as! SetViewController
            destController.navigationItemNumber = getRundomNumber()
            destController.model = model
        } else if segue.identifier == dictionaryId, let model = sender as? DictionaryModel {
            let destController = segue.destination as! DictionaryViewController
            destController.navigationItemNumber = getRundomNumber()
            destController.model = model
        }
    }
}
