//
//  MateriaTableViewController.swift
//  MackTIA
//
//  Created by Joaquim Pessôa Filho on 8/23/15.
//  Copyright (c) 2015 Mackenzie. All rights reserved.
//

import UIKit

class FaltasTableViewController: UITableViewController {
    
    var faltas:Array<Falta> = TIAManager.sharedInstance.todasFaltas()

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "faltasErro:", name: TIAManager.FaltasErroNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "novasFaltas", name: TIAManager.FaltasRecuperadasNotification, object: nil)
        TIAManager.sharedInstance.atualizarFaltas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Metodos da Notificacao
    func novasFaltas() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.faltas = TIAManager.sharedInstance.todasFaltas()
            self.tableView.reloadData()
        })
    }
    
    func faltasErro(notification:NSNotification){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            if let let dict = notification.userInfo as? Dictionary<String,String> {
                
                let alert = UIAlertView(title: "Acesso Negado", message: dict[TIAManager.DescricaoDoErro], delegate: self, cancelButtonTitle: "OK")
                alert.show()
            } else {
                let alert = UIAlertView(title: "Erro", message: "Não foi possível carregar as faltas, entre em contato com o helpdesk se o erro persistir", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.faltas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("faltaCell", forIndexPath: indexPath) as! FaltaTableViewCell
        cell.falta = self.faltas[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
}
