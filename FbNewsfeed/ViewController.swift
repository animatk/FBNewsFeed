//
//  ViewController.swift
//  FbNewsfeed
//
//  Created by Alejandro St on 6/25/16.
//  Copyright © 2016 Alejandro St. All rights reserved.
//

import UIKit

let cellId = "cellId"

class MainController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

	override func viewDidLoad() {
		super.viewDidLoad()
		//color de fondo de la vista de inicio
		collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
		
		//titulo de la barra de navegacion
		navigationItem.title = "Facebook Feed"
		
		//se crean los metodos que soportaran la collectionView que es como una especie de tabla que contiene
		// unos elementos que denominaremos celdas (filas)  que son un elemento que se puede repetir varias veces como una especie de simbolo
		// el primer metodo (numberOfItemsInSection) retorna el numero de elementos que se repetiran
		// el segundo (cellForItemAtIndexPath) define la numeracion o identificador de cada celda (fila)
		
		//en este paso se agrega las celdas (filas) a la colectionView (tabla)
		//para ello se crea la estructura de la celda, dicha estructura es una nueva clase que se instancia
		
		collectionView?.registerClass(LaCelda.self, forCellWithReuseIdentifier: cellId)
		
		//agregar la capacidad para que la view se pudea arrastrar (scroll)
		collectionView?.alwaysBounceVertical = true;
		
	}
	// metodo numberOfItemsInSection
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	// metodo cellForItemAtIndexPath
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		return collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
	}
	
	//una vez creadas las celdas, estas tienen forma libre y se arman como un cuadro pequeño una al lado de la otra
	//lo que vamos a hacer es volverlas de un tamaño del 100% de la pantalla para eso esxtendemos el presente controller
	//trallendo la clase , UICollectionViewDelegateFlowLayout y le aplicamos el nuevo tamaño con el siguiente metodo
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout
	, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(view.frame.width, 320)
	}

}

/*
	Clase que representara la celda (fila) de la presente colectionView
*/

class LaCelda: UICollectionViewCell {
	//inicializar clase..
	override init(frame: CGRect){
		super.init(frame: frame)
		
		setupViews()
	}
	
	//en caso de error
	required init?(coder aDecoder: NSCoder){
		fatalError("init(coder:) no esta implementado")
	}
	
	//se crea un label de texto que se agregara a cada una de las celdas creadas
	//primero se declara con sus caracteristicas y luego dentro de la funcion setupViews se declara la posicion y alineacion 
	//mediante los constraints
	let nameLabel: UILabel = {
		let label = UILabel()
		//vamos a darle al label un formato de 2 lineas, ambas con caracteristicas diferentes (fuente, color, tamaño)
		//la primera el nombre de la persona, y la segunda los detalles de fecha y hora de publicacion
		label.numberOfLines = 2
        //primera parte del texto con tamaño 14
        let attributedText = NSMutableAttributedString(string: "Mark Zucaritas", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)])
        //segundo bloque de texto con respectivos atributos tañano 12 color gris
        attributedText.appendAttributedString(NSAttributedString(string: "\nAgosto 18  •  Bogotá  •  "
		, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName:
            UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)]))
        //espacio entre lineas
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
		
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        //agregar imagen en la linea de texto
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_small")
        attachment.bounds = CGRectMake(0, -2, 12, 12)
        attributedText.appendAttributedString(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
		
		return label
	}()
	
	//agregaremos una imagen a la celda al lado del label de texto del mismo modo que el label ... declaramos y agregamos constraints para posicion
	let profileImageView : UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "mark-zucaritas")
		imageView.contentMode = .ScaleAspectFit //mantener proporcion
		imageView.backgroundColor = UIColor.grayColor()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
		
	}()
	
	//Label de texto que representa el post realizado por el usuuario
	let statusTextView: UITextView = {
		let textView = UITextView()
		textView.text = "Que Gran foto  tomada con mi iPhone!"
		textView.font = UIFont.systemFontOfSize(14)
		return textView
	}()
	
	//agregaremos una imagen  a modo de imagen de estado
	let statusImageView : UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "playa-mar")
		imageView.contentMode = .ScaleAspectFill //mantener proporcion, se adapta al 100 del la celda... para evitarlo se usa lo siguiente
		imageView.layer.masksToBounds = true
		return imageView
		
	}()
	
	let likesLabelView : UILabel = {
		let likesLabel = UILabel()
		likesLabel.text = "489 Likes   10.8K Comments"
		likesLabel.font = UIFont.systemFontOfSize(12)
		return likesLabel
	}()
	
	//definicion del la celda, atributos
	func setupViews() {
    	backgroundColor = UIColor.whiteColor()
		//agregando el label de texto (nameLabel) dentro de la celda
		addSubview(nameLabel)
		//agregando subview de la imagen a la celda
		addSubview(profileImageView)
		addSubview(statusTextView)
		addSubview(statusImageView)
		addSubview(likesLabelView)
		
		//llamado a la extencion que permite crear constraints segun formato
		addConstraintsWithFormat("H:|-8-[v0(44)]-8-[v1]|", views:  profileImageView, nameLabel)
		addConstraintsWithFormat("H:|-4-[v0]-4-|", views: statusTextView)
		addConstraintsWithFormat("V:|-12-[v0]", views:  nameLabel)
		addConstraintsWithFormat("H:|-12-[v0]|", views: likesLabelView)
		addConstraintsWithFormat("H:|[v0]|", views: statusImageView)
		addConstraintsWithFormat("V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-8-[v3(24)]-8-|", views: profileImageView, statusTextView, statusImageView, likesLabelView)
		
	}
}

extension UIView{
	//extersion creada para limpiar y optimizar el proceso de asignar constraints
	//cada UIview creada necesita adaptarse mediante constraints pero la creacion de estos puede simplificarse mendiante esta extension
	func addConstraintsWithFormat(format : String, views : UIView...){
		//como el listado de views es un listado separado por comas vamos a recorrerlo para crear un diccionario (arreglo) y declarar las keys 
		var viewsDictionary = [String: UIView]()
		for(index, view) in views.enumerate(){
			let key = "v\(index)"
			viewsDictionary[key] = view
			view.translatesAutoresizingMaskIntoConstraints = false
		}
		
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
	
	}
}
