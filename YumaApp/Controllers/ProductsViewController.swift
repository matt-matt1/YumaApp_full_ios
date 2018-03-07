//
//  ProductsViewController.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-06.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UIScrollViewDelegate
{
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var navTitle: UINavigationItem!
	@IBOutlet weak var navClose: UIBarButtonItem!
	@IBOutlet weak var navHelp: UIBarButtonItem!
	@IBOutlet weak var topImage: UIImageView!
	@IBOutlet weak var leftLabel: UILabel!
	@IBOutlet weak var centerLabel: UILabel!
	@IBOutlet weak var rightLabel: UILabel!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var add2CartBtn: GradientButton!
	var pageTitle: String = ""
	var pageImage = UIImage()
	let store = DataStore.sharedInstance
	
	
	override func viewDidLoad()
	{
        super.viewDidLoad()

		scrollView.delegate = self
		scrollView.isPagingEnabled = true
		navTitle.title = pageTitle
		topImage.image = pageImage
		navBar.applyNavigationGradient(colors: [R.color.YumaDRed, R.color.YumaRed], isVertical: true)
		navClose.title = FontAwesome.close.rawValue
		centerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(refresh)))
		refresh()
	}

	
	func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		if scrollView == scrollView
		{
			self.pageControl.currentPage = scrollView.tag - 10
		}
	}
	
	@objc func refresh()//(_ sender: Any)
	{
		let sv = UIViewController.displaySpinner(onView: self.view)
		leftLabel.text = ""
		centerLabel.text = "\(R.string.updating) ..."
		rightLabel.text = ""
		pageControl.isHidden = true
		let completeionFunc: (Any) -> Void =
		{
			(products) in
			
			OperationQueue.main.addOperation
				{
					UIViewController.removeSpinner(spinner: sv)
					self.leftLabel.text = " \(R.string.updated)"
					self.centerLabel.text = FontAwesome.repeat.rawValue
					self.centerLabel.font = R.font.FontAwesomeOfSize(pointSize: 21)
					let date = Date()
					let df = DateFormatter()
					df.locale = Locale(identifier: "en_CA")
					df.dateFormat = "dd MMM YYYY  h:mm:ss a"
					self.rightLabel.text = "\(df.string(from: date)) "
					self.pageControl.isHidden = false
					self.pageControl.numberOfPages = self.store.products.count
					print("found \(self.store.products.count) products")
					self.scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(self.store.products.count)
					self.insertData()
			}
		}
		switch navTitle.title
		{
		case R.string.printers?:
			store.callGetPrinters(completion: completeionFunc)
			break
		case R.string.laptops?:
			store.callGetLaptops(completion: completeionFunc)
			break
		case R.string.toners?:
			store.callGetToners(completion: completeionFunc)
			break
		case R.string.services?:
			store.callGetServices(completion: completeionFunc)
			break
		default:
			print("bad instantantion of products VC")
		}
	}
	
	@IBAction func navCloseAct(_ sender: Any)
	{
		self.dismiss(animated: false, completion: nil)
	}
	@IBAction func add2CartBtnAct(_ sender: Any)
	{
		let prod = sender
		let row = OrderRow(id: "\(prod)", productId: "", productAttributeId: "", productQuantity: "", productName: "", productReference: "", productEan13: "", productIsbn: "", productUpc: "", productPrice: "", unitPriceTaxIncl: "", unitPriceTaxExcl: "")
		store.myOrder.append(row)
	}
	
	func getImageFromUrl(url: URL, session: URLSession, completion: @escaping (Data?, URLResponse?, Error?) -> ())
	{
		let task = session.dataTask(with: url)
		{
			(data, response, error) in
			
			if let e = error
			{
				print("Error Occurred: \(e)")
			}
			else
			{
				if (response as? HTTPURLResponse) != nil
				{
					if let _ = data
					{
						completion(data, response, error)
					}
					else
					{
						print("Image file is currupted")
					}
				}
				else
				{
					print("No response from server")
				}
			}
		}
		task.resume()
	}

	
	func insertData()
	{
		var i = 0
		for prod in store.products
		{
			let view = CustomView(frame: CGRect(x: 10 + (self.scrollView.frame.width * CGFloat(i)), y: 0, width: self.scrollView.frame.width - 20, height: self.scrollView.frame.height))
			view.prodName.text = prod.name![0].value
			view.prodName.tag = prod.id!
			if prod.showPrice == "1"
			{
				view.prodPrice.text = prod.price
			}
			else
			{
				view.prodPrice.text = R.string.noPrice
			}
			view.prodImage.contentMode = UIViewContentMode.scaleAspectFit
			let imgName = prod.associations?.images?[0].id
			var imageName = "\(R.string.URLbase)img/p"
			for ch in imgName!
			{
				imageName.append("/\(ch)")
			}
			imageName.append("/\(imgName ?? "").jpg")
			getImageFromUrl(url: URL(string: imageName)!, session: URLSession(configuration: .default), completion:
				{
					(data, response, error) in
					
					guard let data = data, error == nil else { return }
					DispatchQueue.main.async()
					{
						view.prodImage.image = UIImage(data: data)
					}
			})
			view.detailsBtn.text = R.string.details
			view.tag = i + 10
			self.scrollView.addSubview(view)
			i += 1
		}
	}
}


class CustomView: UIView
{
	let prodImage: UIImageView =
	{
		let iv = UIImageView()
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	let prodName: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.textAlignment = .center
		lbl.font = UIFont.boldSystemFont(ofSize: 25)
		return lbl
	}()
	let prodPrice: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.font = UIFont.systemFont(ofSize: 21)
		lbl.textAlignment = .center
		return lbl
	}()
	let detailsBtn: UILabel =
	{
		let btn = UILabel()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.textColor = .white
		btn.backgroundColor = .red
		btn.textAlignment = .center
		return btn
	}()
	let detailsView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let imageView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let imageFrame: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	
	override init(frame: CGRect)
	{
		super.init(frame: frame)

		detailsView.addSubview(detailsBtn)
		NSLayoutConstraint.activate([
			detailsBtn.topAnchor.constraint(equalTo: detailsView.topAnchor),
			detailsBtn.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor),//, constant: 5),
			detailsBtn.leadingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: -80),
			detailsBtn.heightAnchor.constraint(equalToConstant: 21),
			])
		
//		imageFrame.shadowColor = UIColor.gray
//		imageFrame.shadowOffset = CGSize(width: 1, height: 1)
//		imageFrame.shadowRadius = 5
//		imageFrame.shadowOpacity = 1
		imageFrame.addSubview(prodImage)
		NSLayoutConstraint.activate([
			prodImage.topAnchor.constraint(equalTo: imageFrame.topAnchor/*, constant: 5*/),
			prodImage.trailingAnchor.constraint(equalTo: imageFrame.trailingAnchor/*, constant: -5*/),
			prodImage.leadingAnchor.constraint(equalTo: imageFrame.leadingAnchor/*, constant: 5*/),
			prodImage.bottomAnchor.constraint(equalTo: imageFrame.bottomAnchor/*, constant: -5*/),
			])
		
//		imageView.shadowColor = UIColor.red
//		imageView.shadowOffset = CGSize(width: 1, height: 1)
//		imageView.shadowRadius = 5
//		imageView.shadowOpacity = 1
		imageView.addSubview(imageFrame)
		NSLayoutConstraint.activate([
			imageFrame.topAnchor.constraint(equalTo: imageView.topAnchor/*, constant: 5*/),
			imageFrame.trailingAnchor.constraint(equalTo: imageView.trailingAnchor/*, constant: -5*/),
			imageFrame.leadingAnchor.constraint(equalTo: imageView.leadingAnchor/*, constant: 5*/),
			imageFrame.bottomAnchor.constraint(equalTo: imageView.bottomAnchor/*, constant: -5*/),
			])
		
		let stack = UIStackView(arrangedSubviews: [imageView, prodName, prodPrice, detailsView])
		stack.axis = .vertical
		stack.spacing = (self.frame.height > 400) ? (self.frame.height > 800) ? 15 : 10 : 5
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.distribution = UIStackViewDistribution.fill
		//stack.alignment = UIStackViewAlignment.center
		stack.backgroundColor = .gray

		NSLayoutConstraint.activate([
			prodImage.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),//),//
			prodImage.topAnchor.constraint(equalTo: stack.topAnchor),
			prodImage.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),

			prodName.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),
			prodName.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),
			prodName.heightAnchor.constraint(equalToConstant: 30),

			prodPrice.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),
			prodPrice.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),
			prodPrice.heightAnchor.constraint(equalToConstant: 25),

			detailsView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),//, constant: 5),
			detailsView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),//, constant: 5),
			detailsView.heightAnchor.constraint(equalToConstant: 20),
			])

		self.addSubview(stack)
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stack.topAnchor.constraint(equalTo: self.topAnchor),
			stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
			stack.widthAnchor.constraint(equalTo: self.widthAnchor/*, constant: -20*/),
			])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
