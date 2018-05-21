//
//  HeroesViewController.swift
//  CoordinatorsExample
//
//  Created by David Levi on 5/20/18.
//  Copyright © 2018 CodeTank Labs LLC. All rights reserved.
//

import UIKit

protocol HeroesViewControllerDelegate: class {
    func didLogout(heroesViewController: HeroesViewController)
    func loginAgain(heroesViewController: HeroesViewController)
    func didSelect(heroesViewController: HeroesViewController, hero: String)
}

class HeroesViewController: UIViewController {

    weak var delegate: HeroesViewControllerDelegate? = nil

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var logoutButton: UIBarButtonItem!
    @IBOutlet var loginButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.logoutButton
        self.navigationItem.rightBarButtonItem = self.loginButton
    }

    @IBAction func logout(_ sender: Any) {
        self.delegate?.didLogout(heroesViewController: self)
    }
    
    @IBAction func login(_ sender: Any) {
        self.delegate?.loginAgain(heroesViewController: self)
    }
    
}

extension HeroesViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCellID", for: indexPath)
        cell.textLabel?.text = Heroes[indexPath.row]
        return cell
    }
    
}

extension HeroesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect(heroesViewController: self, hero: Heroes[indexPath.row])
    }
}
