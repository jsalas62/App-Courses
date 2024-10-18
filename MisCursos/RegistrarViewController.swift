//
//  RegistrarViewController.swift
//  MisCursos
//
//  Created by Jorge Salas on 15/10/24.
//

import UIKit

class RegistrarViewController: UIViewController {
    
    @IBOutlet weak var textFieldCurso: UITextField!
    @IBOutlet weak var textFieldPromedioPracticas: UITextField!
    @IBOutlet weak var textFieldPromedioLaboratorios: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func agregarCurso(_ sender: Any) {
        
        guard let nombre = textFieldCurso.text, !nombre.isEmpty else {
                mostrarAlerta(titulo: "Campo Vacío", mensaje: "El nombre del curso no puede estar vacío.")
                return
            }
            
            guard let promedioPracticaText = textFieldPromedioPracticas.text,
                  let promedioPractica = Double(promedioPracticaText), promedioPractica >= 0 && promedioPractica <= 20 else {
                mostrarAlerta(titulo: "Valor Inválido", mensaje: "El promedio de prácticas debe estar entre 0 y 20.")
                return
            }
            
            guard let promedioLaboratorioText = textFieldPromedioLaboratorios.text,
                  let promedioLaboratorio = Double(promedioLaboratorioText), promedioLaboratorio >= 0 && promedioLaboratorio <= 20 else {
                mostrarAlerta(titulo: "Valor Inválido", mensaje: "El promedio de laboratorio debe estar entre 0 y 20.")
                return
            }

            // Crear y guardar el curso
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let curso = Curso(context: context)
            curso.nombre = nombre
            curso.promedioPractica = promedioPractica
            curso.promedioLaboratorio = promedioLaboratorio

            do {
                try context.save()
                navigationController?.popViewController(animated: true)
            } catch {
                mostrarAlerta(titulo: "Error", mensaje: "Hubo un problema al guardar el curso. Inténtalo nuevamente.")
            }
        }

        func mostrarAlerta(titulo: String, mensaje: String) {
            let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
}
