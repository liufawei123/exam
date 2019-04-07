//
//  ContactsVC.swift
//  exam
//
//  Created by Liu Fan Wei on 7/4/19.
//  Copyright © 2019 Liu Fan Wei. All rights reserved.
//

import UIKit


class ContactsVC: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    
    private var contacts = [ContactModel]()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "ContactTableViewCell", bundle: Bundle.main);
        contactTableView.register(nib, forCellReuseIdentifier: "ContactTableViewCell")
        contactTableView.rowHeight = UITableView.automaticDimension
        contactTableView.refreshControl = refreshControl
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        fetchContactData()
    }
    
    // MARK: - event
    @IBAction func onAddClicked(_ sender: Any) {
        performSegue(withIdentifier: "contactDetail", sender: nil);
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        fetchContactData()
        print("klsdkl", sender)
        contactTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ContactDetailsVC else {
            return
        }
        if let indexPath = sender as? IndexPath {
            vc.model = contacts[indexPath.row]
            vc.indexPath = indexPath
        }
        vc.saveBlock = { [weak self] model, indexPath   in
            guard let strongSelf = self else { return }
            strongSelf.contactTableView.beginUpdates()
            if (indexPath == nil) {
                strongSelf.contacts.append(model)
                strongSelf.contactTableView.insertRows(at: [IndexPath.init(row: strongSelf.contacts.count-1, section: 0)], with: UITableView.RowAnimation.fade)
            }else{
                strongSelf.contactTableView.reloadRows(at: [indexPath!], with: UITableView.RowAnimation.fade)
            }
            strongSelf.contactTableView.endUpdates()
        }
    }
    
    // MARK: - support
    private func fetchContactData() {
        guard let filePath = Bundle.main.path(forResource: "data", ofType: "json"), let data = NSData(contentsOfFile: filePath) else {
            return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
            guard let data = json as? [Dictionary<String, String>] else {
                return
            }
            contacts = data.map { (item) -> ContactModel in
                return ContactModel(json: item)
            }
        }
        catch {
            //Handle
        }
    }
}

extension ContactsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath)
        guard let contactTableViewCell  = cell as? ContactTableViewCell else {
            return cell
        }
        contactTableViewCell.setData(contacts[indexPath.row])
        return contactTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "contactDetail", sender: indexPath)
    }
}
