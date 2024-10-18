//
//  ViewController.swift
//  MisCursos
//
//  Created by Jorge Salas on 15/10/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cursos:[Curso] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cursos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cursoCell")
        let curso = cursos[indexPath.row]
        
        let promedioFinalCalculado = (0.3 * curso.promedioPractica) + (0.7 * curso.promedioLaboratorio)
        
        if promedioFinalCalculado >= 13 {
            cell.backgroundColor = .green
            cell.textLabel?.text = curso.nombre
            cell.detailTextLabel?.text = """
                Promedio Final: \(String(format: "%.2f", promedioFinalCalculado))
                """
        }else {
            cell.backgroundColor = .red
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = curso.nombre
            cell.detailTextLabel?.textColor = .white
            cell.detailTextLabel?.text = """
                Promedio Final: \(String(format: "%.2f", promedioFinalCalculado))
                """
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curso = cursos[indexPath.row]
        performSegue(withIdentifier: "cursoSeleccionadoSegue", sender: curso)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func agregarCursos(_ sender: Any) {
        performSegue(withIdentifier: "agregarCursoSegue", sender: nil)
    }
    
    func obtenerCursos() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            cursos = try context.fetch(Curso.fetchRequest()) as! [Curso]
        } catch {
            print("Error al leer la entidad de CORE DATA")
        }
    }
    
    // Habilita el estilo de edición en las celdas
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
    // Maneja la eliminación de la celda y del objeto en Core Data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Obtén el contexto de Core Data
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // Obtén el objeto a eliminar
            let cursoAEliminar = cursos[indexPath.row]
            
            // Elimina el objeto de Core Data
            context.delete(cursoAEliminar)
            
            // Guarda los cambios en Core Data
            do {
                try context.save()
                
                // Elimina el objeto del arreglo y la celda de la tabla
                cursos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            } catch {
                print("Error al eliminar el curso de Core Data: \(error)")
            }
        }
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        obtenerCursos()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cursoSeleccionadoSegue") {
            let siguienteVC = segue.destination as! CursoViewController
            siguienteVC.curso = sender as? Curso
        }
    }
}
