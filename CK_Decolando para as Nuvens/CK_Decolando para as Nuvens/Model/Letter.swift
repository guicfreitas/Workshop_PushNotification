//
//  Letter.swift
//  CK_Decolando para as Nuvens
//
//  Created by João Guilherme on 03/12/20.
//

import Foundation
import CloudKit

struct Letter{
    var name: String
    var content: String
    var RecordId : CKRecord.ID? = nil
    
    var container: CKContainer {
        return CKContainer(identifier: "iCloud.br.com.WorkshopCK-Test")
    }
    
    func createRecord(completionHandler: @escaping (Error?)->()){
        let record = CKRecord(recordType: "Letter")
        
        record["name"] = self.name as CKRecordValue
        record["content"] = self.content as CKRecordValue
    
        container.publicCloudDatabase.save(record) { _, error in
            if let error = error {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func readRecords(completionHandler: @escaping ([Letter]?,Error?)->()){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Letter", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var letterRecords: [Letter] = []
        
        operation.recordFetchedBlock = { record in
            
            let letter = Letter(name: record["name"] as! String, content: record["content"] as! String, RecordId: record.recordID)
            
            letterRecords.append(letter)
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            
            if error == nil {
                completionHandler(letterRecords,nil)
            } else {
                
                completionHandler(nil,error)
            }
        }
        
        container.publicCloudDatabase.add(operation)
    }
    
    func deleteRecord(completionHandler: @escaping (Error?)->()){
        container.publicCloudDatabase.delete(withRecordID: self.RecordId!){
            (_,error) in
            if error == nil{
                completionHandler(nil)
            }else{
                completionHandler(error)
            }
        }
    }
    
    func updateRecord(name:String, content:String, completionHandler: @escaping (Error?)->()){
        container.publicCloudDatabase.fetch(withRecordID: self.RecordId!){
            (record,error) in
            guard let record = record,error == nil else{
                completionHandler(error!)
                return
            }
            
            record["name"] = name as CKRecordValue
            record["content"] = content as CKRecordValue
            
            container.publicCloudDatabase.save(record) { _, error in
                
                if let error = error {
                    completionHandler(error)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
    
    func createSubscription(completionHandler: @escaping (Error?)->()){
        //CODE HERE!
    }
}
