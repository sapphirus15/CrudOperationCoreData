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
//        addTodoTaskWithObjectOrientedWay()
//        fetchTaskFromCoreDataWithObjectOrientedStyle()
//        deleteTaskFromCoreDataWithObjectOrientedWay()
//        addUser()
//        addTwoUsers()
//        fetchUserFromCoreDataWithPredicate()
        addThreeUsers()
        fetchUserFromCoreDataWithSortDescriptor()
        
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
    
    func addUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let user = User(context: managedObjectContext)
        user.secondName = "User Second Name"
        print("User First Name \(String(describing: user.firstName))")
        user.userId = 123
        user.firstName = "Text Contain More Than 12 Characters "
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addTwoUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let user = User(context: managedObjectContext)
        user.secondName = "User One Second name"
        user.firstName = "ali"
        
        let secondUser = User(context: managedObjectContext)
        secondUser.secondName = "User Second second name"
        secondUser.firstName = "Not ali"
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchUserFromCoreDataWithPredicate() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        userFetchRequest.predicate = NSPredicate(format: "firstName == %@", "ali")
        
        do {
            let users = try managedObjectContext.fetch(userFetchRequest)
            print("Users Count \(users.count)")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func addThreeUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let user = User(context: managedObjectContext)
        user.secondName = "Vijay"
        user.firstName = "Kumar"
        
        let secondUser = User(context: managedObjectContext)
        secondUser.secondName = "Subhan"
        secondUser.firstName = "Ali"
        
        let thirdUser = User(context: managedObjectContext)
        thirdUser.secondName = "Akhtar"
        thirdUser.firstName = "Ali"
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchUserFromCoreDataWithSortDescriptor() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let userFetchRequest = NSFetchRequest<User>(entityName: "User")
        
        let sortByFirstName = NSSortDescriptor.init(key: "firstName", ascending: true)
        let sortBySecondName = NSSortDescriptor.init(key: "secondName", ascending: true)
        
        userFetchRequest.sortDescriptors = [sortByFirstName, sortBySecondName]
        
        do {
            let users = try  managedObjectContext.fetch(userFetchRequest)
            
            for user in users {
                print("User First Name \(String(describing: user.firstName ?? "Default value"))")
                print("User Second Name \(String(describing: user.secondName ?? "Default value"))")
                print("\n\n\n")
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
