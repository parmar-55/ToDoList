//
//  ViewController.swift
//  ContactList
//
//  Created by Demo 01 on 05/04/23.
//  Copyright © 2023 scs. All rights reserved.
//

import UIKit

struct Contact
{
    var firstName:String
    var lastName:String
   
}


class ViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    
    var contactArray = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureation()
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
      
        contactConfiguration(isadd: true, index: 0)

   }
    
}


extension ViewController
{
    func configureation()
    {
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
    contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        
    }
    
    func contactConfiguration(isadd:Bool, index : Int)
    {
        let alertControll = UIAlertController(title: isadd ?  "Add Contact" : "Update Contact", message: isadd ? "Please enter contact details " : "Please Update your detail", preferredStyle: .alert)
        
        let save = UIAlertAction(title: isadd ? "Save":"Update", style: .default) { _ in
            if let firstName = alertControll.textFields?.first?.text,
                let lastName = alertControll.textFields?[1].text{

                let contact = Contact(firstName: firstName, lastName: lastName)
                if isadd{
                     self.contactArray.append(contact)
                }else{
                    self.contactArray[index] = contact
                }
                self.contactsTableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
        
        alertControll.addTextField { firstNameField in
            firstNameField.placeholder = isadd ? "Enter first name" : self.contactArray[index].firstName
        }
        alertControll.addTextField { lastNameField in
            lastNameField.placeholder = isadd ? "Enter last name" : self.contactArray[index].lastName
        }
        alertControll.addAction(save)
        alertControll.addAction(cancel)
        present(alertControll, animated: true)
    }
}


extension ViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = contactsTableView.dequeueReusableCell(withIdentifier:"cell") else {
            return UITableViewCell()
        }
        cell = UITableViewCell(style: .subtitle, reuseIdentifier:"cell")
        
        cell.textLabel?.text = contactArray[indexPath.row].firstName + " " + contactArray[indexPath.row].lastName
        
        return cell
    }


}

extension ViewController:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            self.contactConfiguration(isadd: false, index: indexPath.row)

        }
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            self.contactArray.remove(at: indexPath.row)
            self.contactsTableView.reloadData()
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete,edit])
        return swipeConfiguration
    }
}



// Add
/*
 
 //        let alertControll = UIAlertController(title: "Add Contact", message: "Please enter contact details ", preferredStyle: .alert)
 //
 //        let save = UIAlertAction(title: "Save", style: .default) { _ in
 //            if let firstName = alertControll.textFields?.first?.text,
 //                let lastName = alertControll.textFields?[1].text{
 //               // let mobileNo = alertControll.textFields?[2].text {
 //
 //                let contact = Contact(firstName: firstName, lastName: lastName)
 //                self.contactArray.append(contact)
 //                self.contactsTableView.reloadData()
 //            }
 //        }
 //        alertControll.addTextField{
 //            firstNameField in
 //            firstNameField.placeholder = "Enter first name"
 //        }
 //        alertControll.addTextField{
 //            lastNameField in
 //            lastNameField.placeholder = "Enter last name"
 //        }
 ////        alertControll.addTextField{
 ////            mobileNumberField in
 ////            mobileNumberField.placeholder = "Enter mobile number"
 ////        }
 //
 //        let cancel = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
 //        alertControll.addAction(save)
 //        alertControll.addAction(cancel)
 //        present(alertControll, animated: true)
 */



// Edit
/*
 //            let alertControll = UIAlertController(title: "Update Contact", message: "Please Update contact details ", preferredStyle: .alert)
 //
 //            let save = UIAlertAction(title: "Save", style: .default) { _ in
 //                if let firstName = alertControll.textFields?.first?.text,
 //                    let lastName = alertControll.textFields?[1].text{
 //
 //                    let contact = Contact(firstName: firstName, lastName: lastName)
 //                    self.contactArray[indexPath.row] = contact
 //                    self.contactsTableView.reloadData()
 //                }
 //            }
 //            alertControll.addTextField{firstNameField in
 //                firstNameField.placeholder = self.contactArray[indexPath.row].firstName
 //            }
 //            alertControll.addTextField{lastNameField in
 //                lastNameField.placeholder = self.contactArray[indexPath.row].lastName
 //            }
 //
 //            let cancel = UIAlertAction(title: "Cancel", style:.cancel, handler: nil)
 //            alertControll.addAction(save)
 //            alertControll.addAction(cancel)
 //           self.present(alertControll, animated: true)*/
