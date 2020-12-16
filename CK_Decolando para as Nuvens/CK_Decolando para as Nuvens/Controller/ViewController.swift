//
//  ViewController.swift
//  CK_Decolando para as Nuvens
//
//  Created by João Guilherme on 24/11/20.
//

import UIKit
protocol EditLetterViewControllerDelegate{
    func updateInModalViewController(sender: EditLetterViewController)
}

class ViewController: UIViewController,EditLetterViewControllerDelegate {
    func updateInModalViewController(sender: EditLetterViewController) {
        self.viewDidAppear(true)
    }
    
    var letters: [Letter] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var colorChanger = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        
        //CHECK SUBSCRIPTION ID HERE!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let letter = Letter(name: "", content: "")
        letter.readRecords(){
            
            fetchedRecords,error in
            
            guard let records = fetchedRecords,error == nil else{
                print("Error in read CloudKit", error as Any)
                return
            }
            
            self.letters = records
        }
    }
}
