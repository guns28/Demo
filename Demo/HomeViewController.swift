//
//  HomeViewController.swift
//  Demo
//
//  Created by Ahmed Karmous on 04/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var toDoTableView: UITableView!
    //popup add
    @IBOutlet var toDoView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var backgroundView = UIView()
    var toDoArray : Results<ToDoList>!
    let uiRealm = try! Realm()
    var isEditingMode = false
    var listToBeUpdated = ToDoList()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toDoTableView.register(UINib(nibName:"ToDoTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoTableViewCell")

    }

    override func viewWillAppear(_ animated: Bool) {
        reloadTasks()
    }

    func reloadTasks(){
        toDoArray = uiRealm.objects(ToDoList.self)
        toDoTableView.setEditing(false, animated: true)
        toDoTableView.reloadData()
    }

    @IBAction func editMode(_ sender: Any) {
//        toDoTableView.setEditing(true, animated: true)
    }

    // MARK: tableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell") as! ToDoTableViewCell
        let item = toDoArray[indexPath.row]
        cell.toDoName.text = item.name
        cell.dateLabel.text = Utilities.getStringFromDate(item.date, format: "dd-MM-yyyy HH:mm")
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = TaskViewController (nibName: "TaskViewController", bundle: nil)
        viewController.selectedList = toDoArray[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Delete") { (deleteAction, indexPath) -> Void in


            //request user to activate location
            let alertController = UIAlertController(title: "ToDo-List", message: "Do you really want to remove this ToDoList ?", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "NO", style: .cancel) { (action:UIAlertAction!) in
                print("you have pressed the No button");
            }
            alertController.addAction(cancelAction)

            let OKAction = UIAlertAction(title: "YES", style: .default) { (action:UIAlertAction!) in
                print("you have pressed Yes button");
                //Deletion will go here
                let listToBeDeleted = self.toDoArray[indexPath.row]
                do {
                    try
                        self.uiRealm.write({ () -> Void in
                            self.uiRealm.delete(listToBeDeleted)
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

        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.normal, title: "Edit") { (editAction, indexPath) -> Void in
            self.listToBeUpdated = self.toDoArray[indexPath.row]
            self.nameTextField.text = self.listToBeUpdated.name
            self.datePicker.date = self.listToBeUpdated.date
            self.isEditingMode = true
            self.openPopupView()
        }

        return [deleteAction, editAction]
    }

    @IBAction func addToDoList(_ sender: Any) {
        isEditingMode = false
        self.nameTextField.text = ""
        self.datePicker.date = Date()
        openPopupView()
    }

    func openPopupView()  {
        backgroundView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        backgroundView.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.6)
        self.view.addSubview(backgroundView)
        toDoView.center = self.view.center
        self.view.addSubview(toDoView)
    }

    @IBAction func cancelAdd(_ sender: Any) {
        hideAddView()
    }

    @IBAction func confirmAdd(_ sender: Any) {

        if isEditingMode {

            do {
                try
                    uiRealm.write { () -> Void in
                        self.listToBeUpdated.setValue(self.nameTextField.text!, forKey: "name")
                        self.listToBeUpdated.setValue(self.datePicker.date, forKey: "date")
                        self.reloadTasks()
                }
            }
            catch _ {
                // Error handling
                print("error")
            }
        }else{

            let list = ToDoList()
            list.name = nameTextField.text!
            list.date = datePicker.date

            do {
                try
                    uiRealm.write { () -> Void in
                        uiRealm.add(list)
                        self.reloadTasks()
                }
            }
            catch _ {
                // Error handling
                print("error")
            }
        }
        hideAddView()
    }

    func hideAddView()  {
        backgroundView.removeFromSuperview()
        toDoView.removeFromSuperview()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
