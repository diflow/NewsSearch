//
//  SearchViewController.swift
//  NewsTask
//
//  Created by ivan on 14.11.2020.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var buttonGoogleNewsIsActive = false
    var buttonCnnIsActive = false
    var searchBar = UISearchBar()
    let searchController = UISearchController(searchResultsController: nil)
    let constants = Constants()
    var list = [String]()
    var change = true
    var sources = ""
    
    @IBOutlet weak var sourceGoogleNewsBt: UIButton!
    @IBOutlet weak var sourceCnnBt: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var textSearchTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDown.isHidden = true
        
    }
    
    // Проверка нажаты ли фильтры Source
    func checkSource() {
        if buttonCnnIsActive || buttonGoogleNewsIsActive {
            categoryLabel.isEnabled = false
            categoryTF.isEnabled = false
            categoryTF.text = ""
            
            countryTF.isEnabled = false
            countryLabel.isEnabled = false
            countryTF.text = ""
            
            if buttonCnnIsActive, buttonGoogleNewsIsActive {
                self.sources = constants.googleNews + "," + constants.cnn
            }
            if buttonCnnIsActive, !buttonGoogleNewsIsActive {
                self.sources = constants.cnn
            }
            if !buttonCnnIsActive, buttonGoogleNewsIsActive {
                self.sources = constants.googleNews
            }
            
        } else {
            categoryLabel.isEnabled = true
            categoryTF.isEnabled = true
            countryTF.isEnabled = true
            countryLabel.isEnabled = true
            self.sources = ""
        }
    }
    
    // Визуальное представление нажат ли фильтр Source(CNN)
    @IBAction func sourceCnnPressed(_ sender: UIButton) {
        
        if buttonCnnIsActive {
                UIView.animate(withDuration: 0.2) {
                    sender.backgroundColor = #colorLiteral(red: 0.9490495324, green: 0.9486485124, blue: 0.9695821404, alpha: 1)
                    sender.setTitleColor(UIColor.black, for: .normal)
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    sender.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
                    sender.layer.cornerRadius = 5
                    sender.setTitleColor(UIColor.white, for: .normal)
                }
            }
        buttonCnnIsActive = !buttonCnnIsActive
        checkSource()
    }
    
    // Визуальное представление нажат ли фильтр Source(GoogleNews)
    @IBAction func sourceGoogleNewsPressed(_ sender: UIButton) {
        if buttonGoogleNewsIsActive {
                UIView.animate(withDuration: 0.2) {
                    sender.backgroundColor = #colorLiteral(red: 0.9490495324, green: 0.9486485124, blue: 0.9695821404, alpha: 1)
                    sender.setTitleColor(UIColor.black, for: .normal)
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    sender.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
                    sender.layer.cornerRadius = 5
                    sender.setTitleColor(UIColor.white, for: .normal)
                }
            }
        buttonGoogleNewsIsActive = !buttonGoogleNewsIsActive
        checkSource()
    }
    
    // Взаимодействие с выпадающим списком при нажатие на определенный textField
    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.countryTF {
            change = true
            list = constants.countryList
            dropDown.reloadAllComponents()
            self.searchButton.isHidden = true
            self.dropDown.isHidden = false
            textField.endEditing(true)
        }
        if textField == self.categoryTF {
            change = false
            list = constants.categoryList
            dropDown.reloadAllComponents()
            self.searchButton.isHidden = true
            self.dropDown.isHidden = false
            textField.endEditing(true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.dropDown.isHidden = true
        self.searchButton.isHidden = false
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if change == true {
            self.countryTF.text = self.list[row]
        } else {
            self.categoryTF.text = self.list[row]
        }
        self.dropDown.isHidden = true
        self.searchButton.isHidden = false
    }
    
    //Поиск по выбранным фильтрам (при выборе фильтра Source становятся недоступны фильтры Country и Category). При нажатии открывается таблица по виду ячеек SearchTableViewCell, которые описаны кодом
    @IBAction func searchPressed(_ sender: Any) {
        
        let vc: SearchNewsViewController = SearchNewsViewController()
        
        if let textSearch = textSearchTF.text, textSearch != "" {
            vc.navigationItem.title = textSearch
            let farmattedText = textSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            if farmattedText == "" {
                vc.textSearch = ""
            } else {
                vc.textSearch = "q=\(farmattedText)&"
            }
        }
        
        if sources != "" {
            vc.sources = "sources=\(sources)&"
            vc.category = ""
            vc.country = ""
            self.show(vc, sender: self)
        } else {
            
            if let category = categoryTF.text, category != "" {
                vc.category = "category=\(category)&"
            }
            if let country = countryTF.text, country != "" {
                vc.country = "country=\(country)&"
            }
            vc.sources = ""
            self.show(vc, sender: self)
        }
    }
}
