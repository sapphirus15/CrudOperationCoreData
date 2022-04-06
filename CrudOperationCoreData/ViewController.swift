//
//  ViewController.swift
//  CrudOperationCoreData
//
//  Created by Ryan on 2022/04/06.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addToTask()
//        addToTask()
//        fetchTaskFromCoreDate()
//        deleteTaskFromCoreData()
        addTodoTaskWithObjectOrientedWay()
        fetchTaskFromCoreDataWithObjectOrientedStyle()
//        deleteTaskFromCoreDataWithObjectOrientedWay()
    }

    

}

/// Object Oriented Style CRUD
extension ViewController {
    func addTodoTaskWithObjectOrientedWay() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let todoObject = Task(context: managedObjectContext)
        todoObject.name = "2nd Item"
        todoObject.details = "2nd Item Description"
        todoObject.id = 2
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchTaskFromCoreDataWithObjectOrientedStyle() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for data in tasks {
                print(data.details ?? "No Data found")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteTaskFromCoreDataWithObjectOrientedWay() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for task in tasks {
                managedObjectContext.delete(task)
            }
            
            do {
                try  managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

/// Simple CRUD func
extension ViewController {
    func addToTask() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let todoEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedObjectContext)!
        
        let todo = NSManagedObject(entity: todoEntity, insertInto: managedObjectContext)
        
        todo.setValue("First Item", forKey: "name")
        todo.setValue("First Item Description", forKey: "details")
        todo.setValue(1, forKey: "id")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func fetchTaskFromCoreDate() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for data in tasks {
                print(data.value(forKey: "details") ?? "No Data found")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteTaskFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            for data in tasks {
                managedObjectContext.delete(data)
            }
            
            do {
                try  managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
