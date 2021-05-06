//
//  PickerListVC.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import UIKit

protocol ListPickerVCDelegate {
    func didSelectRow(selectedValue:String)
}

class PickerListVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var topBarTitle: UILabel!
    @IBOutlet weak var listPickerView: UIPickerView!

    var pickerTag:Int = 0
    var delegate:ListPickerVCDelegate?
    var listArray:Array<String>!
    var barTitle:String!
    var selectedValue:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.topBarTitle.text = barTitle
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if listArray.count > 0 {
            listPickerView.reloadAllComponents()
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        
        self.dismiss(animated: true) {}
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        
        self.delegate?.didSelectRow(selectedValue: self.selectedValue)
        self.dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return listArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedValue = listArray[row]
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
