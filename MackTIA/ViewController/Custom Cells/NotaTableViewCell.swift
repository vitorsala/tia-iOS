//
//  NotaTableViewCell.swift
//  MackTIA
//
//  Created by Joaquim Pessôa Filho on 9/5/15.
//  Copyright (c) 2015 Mackenzie. All rights reserved.
//

import UIKit

private class Tuple {
    var titulo:String = ""
    var nota:String = ""
}


class NotaTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var nomeDisciplina: UILabel!
    @IBOutlet weak var formula: UILabel!
    @IBOutlet weak var notasFinaisCollectionView: UICollectionView!
    @IBOutlet weak var notasIntermediariasCollectionView: UICollectionView!
    @IBOutlet weak var conteudoView: UIView!
    private var notasIntermediariasNaoVazias:Array<Tuple>!
    
    var nota:Nota? {
        didSet{
            if nota != nil {
                self.nomeDisciplina.text = nota!.disciplina
                self.formula.text = "Fórmula: \(nota!.formula.stringByRemovingPercentEncoding?.lowercaseString)"
//                stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!.lowercaseString)"
                
                self.notasIntermediariasCollectionView.reloadData()
                self.notasFinaisCollectionView.reloadData()
                
                if nota!.a != "-" {
                    let n = Tuple()
                    n.titulo = "A"
                    n.nota = nota!.a
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.b != "-" {
                    let n = Tuple()
                    n.titulo = "B"
                    n.nota = nota!.b
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.c != "-" {
                    let n = Tuple()
                    n.titulo = "C"
                    n.nota = nota!.c
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.d != "-" {
                    let n = Tuple()
                    n.titulo = "D"
                    n.nota = nota!.d
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.e != "-" {
                    let n = Tuple()
                    n.titulo = "E"
                    n.nota = nota!.e
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.f != "-" {
                    let n = Tuple()
                    n.titulo = "F"
                    n.nota = nota!.f
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.g != "-" {
                    let n = Tuple()
                    n.titulo = "G"
                    n.nota = nota!.g
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.h != "-" {
                    let n = Tuple()
                    n.titulo = "H"
                    n.nota = nota!.h
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.i != "-" {
                    let n = Tuple()
                    n.titulo = "I"
                    n.nota = nota!.i
                    self.notasIntermediariasNaoVazias.append(n)
                }
                if nota!.j != "-" {
                    let n = Tuple()
                    n.titulo = "J"
                    n.nota = nota!.j
                    self.notasIntermediariasNaoVazias.append(n)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.notasFinaisCollectionView.delegate = self
        self.notasFinaisCollectionView.dataSource = self
        self.notasIntermediariasCollectionView.delegate = self
        self.notasIntermediariasCollectionView.dataSource = self
        self.notasIntermediariasNaoVazias = Array<Tuple>()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if self.selected {
            UIView.animateWithDuration(0.3, delay: 0.3, options:[], animations: { () -> Void in
                self.conteudoView.alpha = 1
                }, completion: nil)
        } else {
            self.conteudoView.alpha = 0
        }
    }
    
    // MARK: UICollectionVeiw DataSource and Delegate Methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.nota == nil {
            return 0
        }
        
        //Retorna a quantidade de notas parciais
        if collectionView == notasIntermediariasCollectionView {
            if self.notasIntermediariasNaoVazias.count == 0 {
                collectionView.hidden = true
                return 0
            }
            collectionView.hidden = false
            return self.notasIntermediariasNaoVazias.count
        } else {
            //Retorna aquantidade de notas finais
            return 5
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("notaCell", forIndexPath: indexPath) as! NotaCollectionViewCell
        
        if collectionView == notasIntermediariasCollectionView {
            cell.titulo.text    = notasIntermediariasNaoVazias[indexPath.row].titulo
            cell.nota.text      = notasIntermediariasNaoVazias[indexPath.row].nota
            
            if cell.titulo.text?.lowercaseString == nota?.substituida {
                cell.titulo.text = "\(cell.titulo.text)(SUB)"
            }
        } else {
            switch indexPath.row {
                //Nota Sub
            case 0:
                cell.titulo.text = "SUB"
                cell.nota.text = self.nota?.sub
            case 1:
                cell.titulo.text = "PARTIC"
                cell.nota.text = self.nota?.partic
            case 2:
                cell.titulo.text = "MI"
                cell.nota.text = self.nota?.mi
            case 3:
                cell.titulo.text = "PF"
                cell.nota.text = self.nota?.pf
            case 4:
                cell.titulo.text = "MF"
                cell.nota.text = self.nota?.mf
            default:
                cell.titulo.text = "-"
                cell.nota.text = "-"
            }
        }
        
        return cell
    }
    
}
