//
//  UserDetailsVC.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import UIKit

class UserDetailsVC: UIViewController, UITableViewDelegate,UITableViewDataSource {

    // MARK: - Members
    var userDetailVM = UserDetailsVM()
    var userListArray:UserDetail?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var userDetailsTV:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "User Details"
        
        //Utils.shared.showIndicator(controller: self)
        userDetailVM.getUser { result in
           
            DispatchQueue.main.async {
                if result {
                    self.userListArray = self.userDetailVM.userArray
                    
                        self.userDetailsTV.reloadData()
                        //Utils.shared.hideIndicator(controller: self)
                }
                else {
                    
                }
            }
        }
    }

    //MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "TVReusableIdentifire", for: indexPath)
        cell = userDetailVM.generateCell(index: indexPath.row, cell: cell)
        return cell
    }
    
    @IBAction func mapBtnAction(sender:CustomButton) {
        
        userDetailVM.openMap(index: sender.index, currentRef: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
