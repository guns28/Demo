//
//  DetailsViewController.swift
//  Demo
//
//  Created by Ahmed Karmous on 05/11/2017.
//  Copyright © 2017 Ahmed Karmous. All rights reserved.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {


    @IBOutlet weak var nameTextFIeld: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var segmentPriority: UISegmentedControl!
    var item = ToDo()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextFIeld.text = item.name
        detailsTextView.text = item.notes
        segmentPriority.selectedSegmentIndex = item.priority
    }

    @IBAction func returnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
