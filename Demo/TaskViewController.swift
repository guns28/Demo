//
//  TaskViewController.swift
//  Demo
//
//  Created by Ahmed Karmous on 05/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var tasksListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var selectedList : ToDoList!
    var toDoListTasks : Results<ToDo>!
    let uiRealm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tasksListTableView.register(UINib(nibName:"TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadTasks()
    }

    func reloadTasks(){
        toDoListTasks  = self.selectedList.tasks.filter("isCompleted = false")
//        tasksListTableView.setEditing(false, animated: true)
        tasksListTableView.reloadData()
    }

    // MARK: tableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as! TaskTableViewCell
        let item = toDoListTasks[indexPath.row]
        print(item)
        cell.taskNameLabel.text = item.name

        switch item.priority {
        case 0:
            cell.priorityLabel.text = "LOW"
            cell.priorityLabel.textColor = UIColor.green
            break
        case 1:
            cell.priorityLabel.text = "MEDIUM"
            cell.priorityLabel.textColor = UIColor.orange
            break
        case 2:
            cell.priorityLabel.text = "HIGH"
            cell.priorityLabel.textColor = UIColor.red
            break
        default:
            break
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailsViewController (nibName: "DetailsViewController", bundle: nil)
        viewController.item = toDoListTasks[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        print("triggered!")

        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete") { (deleteAction, indexPath) -> Void in


            //request user to activate location
            let alertController = UIAlertController(title: "ToDo-List", message: "Do you really want to remove this item ?", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "NO", style: .cancel) { (action:UIAlertAction!) in
                print("you have pressed the No button");
            }
            alertController.addAction(cancelAction)

            let OKAction = UIAlertAction(title: "YES", style: .default) { (action:UIAlertAction!) in
                print("you have pressed Yes button");
                //Deletion will go here
                let toDo = self.toDoListTasks[indexPath.row]
                do {
                    try
                        self.uiRealm.write({ () -> Void in
                            self.uiRealm.delete(toDo)
                            self.reloadTasks()
                        })
                }
                catch _ {
                    // Error handling
                    print("error")
                }
            }
            alertController.addAction(OKAction)

            self.present(alertController, animated: true, completion:nil)
        }

        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Completed") { (editAction, indexPath) -> Void in

            let toDo = self.toDoListTasks[indexPath.row]

            try! self.uiRealm.write{
                toDo.isCompleted = true
                self.reloadTasks()
            }
        }

        return [deleteAction, editAction]
    }

    @IBAction func returnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func addNewToDo(_ sender: Any) {
        let viewController = AddToDoViewController (nibName: "AddToDoViewController", bundle: nil)
        viewController.selectedList = selectedList
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func sortData(_ sender: Any) {
        let alertController = UIAlertController(title: "ToDo-List", message: "SORT BY", preferredStyle: .actionSheet)

        let priorityAction = UIAlertAction(title: "PRIORITY", style: .default) { (action:UIAlertAction!) in
            self.toDoListTasks = self.toDoListTasks.sorted(byKeyPath: "priority")
            self.tasksListTableView.reloadData()

        }
        alertController.addAction(priorityAction)

        let nameAction = UIAlertAction(title: "NAME", style: .default) { (action:UIAlertAction!) in
            self.toDoListTasks = self.toDoListTasks.sorted(byKeyPath: "name")
            self.tasksListTableView.reloadData()

        }
        alertController.addAction(nameAction)

        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel) { (action:UIAlertAction!) in

        }
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion:nil)
    }

    // MARK: - Search bar

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.characters.count == 0 {
             toDoListTasks  = self.selectedList.tasks.filter("isCompleted = false")
        }else{
            let predicate = NSPredicate(format: "name contains[c] %@", searchBar.text!)
            toDoListTasks  = self.selectedList.tasks.filter(predicate)
        }
        tasksListTableView.reloadData()
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
