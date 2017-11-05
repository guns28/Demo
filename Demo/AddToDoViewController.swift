//
//  AddToDoViewController.swift
//  Demo
//
//  Created by Ahmed Karmous on 04/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import UIKit
import RealmSwift

class AddToDoViewController: UIViewController {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    let uiRealm = try! Realm()
    var selectedList : ToDoList!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    @IBAction func addToDoItem(_ sender: Any) {
                let item = ToDo()
                item.name = nameTextField.text!
                item.notes = descriptionTextView.text
                item.priority = segmentView.selectedSegmentIndex

                do {
                    try
                        uiRealm.write { () -> Void in
                            self.selectedList.tasks.append(item)
                            self.navigationController?.popViewController(animated: true)
                    }
                }
                catch _ {
                    print("error")
                }
    }

    @IBAction func returnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
