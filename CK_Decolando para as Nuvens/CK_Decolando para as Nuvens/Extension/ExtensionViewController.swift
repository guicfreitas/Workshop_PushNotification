//
//  File.swift
//  CK_Decolando para as Nuvens
//
//  Created by Rebeca Pacheco on 26/11/20.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            return
        }
        
        let letter = letters[indexPath.row]
        if segue.identifier == "editCell"{
            
            let editLetterViewController = segue.destination as! EditLetterViewController
            
            editLetterViewController.letter = letter
            editLetterViewController.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return letters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! ListTableViewCell
        
        tableCell.nameList.text = letters[indexPath.row].name
        tableCell.detailsList.text = letters[indexPath.row].content
        
        switch colorChanger{
        
        case 0:
            tableCell.backgroundColor = UIColor(red: 0.29, green: 0.60, blue: 0.53, alpha: 1.00)
            colorChanger = 1

        case 1:
            tableCell.backgroundColor = UIColor(red: 0.77, green: 0.27, blue: 0.25, alpha: 1.00)
            colorChanger = 2
            
        case 2:
            tableCell.backgroundColor = UIColor(red: 0.82, green: 0.90, blue: 0.93, alpha: 1.00)
            colorChanger = 0
        default:
            tableCell.backgroundColor = UIColor(red: 0.29, green: 0.60, blue: 0.53, alpha: 1.00)
        }
        
        return tableCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            letters[indexPath.row].deleteRecord(){
                error in
                
                if error != nil{
                    print("error in CloudKit Delete operation",error!)
                }else{
                    DispatchQueue.main.async {
                        self.letters.remove(at: indexPath.row) // Check this out
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        tableView.reloadData()
                    }
                }
            }
        } else if editingStyle == .insert {
            //
        }
    }
}
