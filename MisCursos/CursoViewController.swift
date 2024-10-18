//
//  CursoViewController.swift
//  MisCursos
//
//  Created by Jorge Salas on 15/10/24.
//

import UIKit

class CursoViewController: UIViewController {
    

    @IBOutlet weak var promedioPracticasLabel: UILabel!
    @IBOutlet weak var promedioLaboratoriosLabel: UILabel!
    @IBOutlet weak var promedioFinalLabel: UILabel!
    @IBOutlet weak var cursoLabel: UILabel!
    var curso:Curso? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let curso = curso {
            let promedioFinalCalculado = (0.3 * curso.promedioPractica) + (0.7 * curso.promedioLaboratorio)
            
            cursoLabel.text = curso.nombre
            
            promedioPracticasLabel.text = String(format: "%.2f", curso.promedioPractica)
            promedioLaboratoriosLabel.text = String(format: "%.2f", curso.promedioLaboratorio)
            promedioFinalLabel.text = String(format: "%.2f", promedioFinalCalculado)
        }
    }
    
    func actualizarCurso(){
        if let curso = curso{
            let promedioFinalCalculado = (0.3 * curso.promedioPractica) + (0.7 * curso.promedioLaboratorio)
            cursoLabel.text = curso.nombre!
            promedioPracticasLabel.text = String(format: "%.2f", curso.promedioPractica)
            promedioLaboratoriosLabel.text = String(format: "%.2f", curso.promedioLaboratorio)
            promedioFinalLabel.text = String(format: "%.2f", promedioFinalCalculado)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actualizarCurso()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "actualizarCursoSegue") {
            let siguienteVC = segue.destination as! EditarCursoViewController
            siguienteVC.curso = curso
        }
    }
}
