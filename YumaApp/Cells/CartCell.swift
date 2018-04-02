//
//  CartCell.swift
//  YumaApp
//
//  Created by Yuma Usa on 2018-03-13.
//  Copyright © 2018 Yuma Usa. All rights reserved.
//

import UIKit


class CartCell: UIView
{
	let prodImage: UIImageView =
	{
		let iv = UIImageView(/*frame: CGRect(x: 0, y: 0, width: 253, height: 100)*/)
		iv.translatesAutoresizingMaskIntoConstraints = false
		//iv.sizeToFit()
		return iv
	}()
	let prodName: UILabel =
	{
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.isUserInteractionEnabled = false
		lbl.lineBreakMode = NSLineBreakMode.byTruncatingHead
		//lbl.adjustsFontSizeToFitWidth = true
		lbl.textAlignment = .center
		lbl.font = UIFont.init(name: "AvenirNext-Bold", size: 14)//.boldSystemFont(ofSize: 25)
		lbl.textColor = R.color.YumaRed
		lbl.shadowColor = R.color.YumaYel
		lbl.shadowOffset = CGSize(width: 1, height: 1)
		lbl.shadowRadius = 4.0
		//lbl.shadowOpacity = 1
		//lbl.sizeToFit()
		return lbl
	}()
	//	let prodPrice: UILabel =
	//	{
	//		let lbl = UILabel()
	//		lbl.translatesAutoresizingMaskIntoConstraints = false
	//		lbl.font = UIFont.systemFont(ofSize: 21)
	//		lbl.textAlignment = .center
	//		return lbl
	//	}()
	private let imageView: UIView =
	{
		let view = UIView(/*frame: CGRect(x: 0, y: 0, width: 253, height: 100)*/)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	//	let imageFrame: UIView =
	//	{
	//		let view = UIView()
	//		view.translatesAutoresizingMaskIntoConstraints = false
	//		return view
	//	}()
	let prodGap: UIView =
	{
		let view = UIView(/*frame: CGRect(x: 0, y: 136, width: 253, height: 3)*/)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	let prodLine: UIView =
	{
		let view = UIView(/*frame: CGRect(x: 0, y: 139, width: 253, height: 1)*/)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	private let prodQtyView: UIView =
	{
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = R.color.YumaYel
		view.cornerRadius = 10//view.frame.width/3
		//view.justRound(corners: [UIRectCorner.bottomRight], radius: 10)//view.frame.width/3)
		return view
	}()
	let prodQty: UILabel =
	{
		let view = UILabel()//UITextView(/*frame: CGRect(x: 0, y: 0, width: 20, height: 20)*/)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.isUserInteractionEnabled = false
		view.lineBreakMode = NSLineBreakMode.byTruncatingTail
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 10)
		view.textColor = R.color.YumaRed
		view.shadowColor = R.color.YumaDRed
		view.shadowOffset = CGSize(width: 1, height: 1)
		view.shadowRadius = 3
		return view
	}()
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		/*
		<stackView opaque="NO" contentMode="scaleToFill" axis="vertical" translatesAutoresizingMaskIntoConstraints="NO" id="OrY-J5-o4Z">
		<rect key="frame" x="0.0" y="0.0" width="253" height="140"/>
		<subviews>
		<label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" text="Product Name" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="MWg-BM-dGP">
		<rect key="frame" x="0.0" y="0.0" width="253" height="20"/>
		<constraints>
		<constraint firstAttribute="height" constant="20" id="pEl-gc-z2l"/>
		</constraints>
		<fontDescription key="fontDescription" name="AvenirNext-Bold" family="Avenir Next" pointSize="16"/>
		<color key="textColor" red="0.66666666669999997" green="0.0" blue="0.094117647060000004" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
		<nil key="highlightedColor"/>
		<color key="shadowColor" red="0.99942404029999998" green="0.98555368190000003" blue="0.0" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
		<size key="shadowOffset" width="1" height="1"/>
		</label>
		<view contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="JwO-40-pYO">
		<rect key="frame" x="0.0" y="20" width="253" height="116"/>
		<subviews>
		<textField opaque="NO" contentMode="scaleToFill" insetsLayoutMarginsFromSafeArea="NO" contentHorizontalAlignment="left" contentVerticalAlignment="center" placeholder="qty" textAlignment="center" minimumFontSize="14" translatesAutoresizingMaskIntoConstraints="NO" id="hTt-6S-6TU">
		<rect key="frame" x="0.0" y="0.0" width="20" height="20"/>
		<constraints>
		<constraint firstAttribute="height" constant="20" id="lFK-PS-sJh"/>
		<constraint firstAttribute="width" constant="20" id="q2L-Bu-wUa"/>
		</constraints>
		<color key="textColor" white="0.33333333329999998" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
		<fontDescription key="fontDescription" type="system" pointSize="14"/>
		<textInputTraits key="textInputTraits"/>
		</textField>
		<imageView userInteractionEnabled="NO" contentMode="scaleAspectFit" horizontalHuggingPriority="251" verticalHuggingPriority="251" insetsLayoutMarginsFromSafeArea="NO" translatesAutoresizingMaskIntoConstraints="NO" id="t89-0h-gy4">
		<rect key="frame" x="0.0" y="0.0" width="253" height="100"/>
		<constraints>
		<constraint firstAttribute="height" constant="100" id="N8t-qg-NZe"/>
		</constraints>
		</imageView>
		</subviews>
		<color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
		<constraints>
		<constraint firstAttribute="trailing" secondItem="t89-0h-gy4" secondAttribute="trailing" id="5Rx-Vx-XSu"/>
		<constraint firstItem="hTt-6S-6TU" firstAttribute="top" secondItem="JwO-40-pYO" secondAttribute="top" id="GRp-9e-JP2"/>
		<constraint firstItem="t89-0h-gy4" firstAttribute="top" secondItem="JwO-40-pYO" secondAttribute="top" id="KBl-PX-ShJ"/>
		<constraint firstItem="t89-0h-gy4" firstAttribute="leading" secondItem="JwO-40-pYO" secondAttribute="leading" id="TJ2-Gt-HLc"/>
		<constraint firstItem="hTt-6S-6TU" firstAttribute="leading" secondItem="JwO-40-pYO" secondAttribute="leading" id="XAi-j5-y1y"/>
		</constraints>
		</view>
		<view contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="GtZ-w8-waL" userLabel="View gap">
		<rect key="frame" x="0.0" y="136" width="253" height="3"/>
		<color key="backgroundColor" white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
		<constraints>
		<constraint firstAttribute="height" constant="3" id="vsW-xo-Cfk"/>
		</constraints>
		</view>
		<view contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="aXH-h9-HXf" userLabel="View line">
		<rect key="frame" x="0.0" y="139" width="253" height="1"/>
		<color key="backgroundColor" white="0.84999999999999998" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
		<constraints>
		<constraint firstAttribute="height" constant="1" id="lbk-uA-lIv"/>
		</constraints>
		</view>
		</subviews>
		</stackView>
		*/
		imageView.addSubview(prodImage)
		prodQtyView.addSubview(prodQty)
		imageView.addSubview(prodQtyView)
		NSLayoutConstraint.activate([
			prodImage.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
			prodImage.topAnchor.constraint(equalTo: imageView.topAnchor),
			prodImage.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			prodImage.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),

			prodQty.leadingAnchor.constraint(equalTo: prodQtyView.leadingAnchor),
			prodQty.topAnchor.constraint(equalTo: prodQtyView.topAnchor),
			prodQty.trailingAnchor.constraint(equalTo: prodQtyView.trailingAnchor),
			prodQty.bottomAnchor.constraint(equalTo: prodQtyView.bottomAnchor),
			
			prodQtyView.topAnchor.constraint(equalTo: imageView.topAnchor),
			prodQtyView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
			prodQtyView.widthAnchor.constraint(equalToConstant: 20),
			prodQtyView.heightAnchor.constraint(equalToConstant: 20),
			])

		prodGap.heightAnchor.constraint(equalToConstant: 3).isActive = true
		prodLine.backgroundColor = UIColor(hex: "#DCDCDC", alpha: 1)
		prodLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		let stack = UIStackView(arrangedSubviews: [prodName, imageView, /*prodGap,*/ prodLine])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		
		self.addSubview(stack)
		NSLayoutConstraint.activate([
			prodName.topAnchor.constraint(equalTo: stack.topAnchor),
			prodName.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
			prodName.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
			prodName.heightAnchor.constraint(equalToConstant: 20),
//			prodName.bottomAnchor.constraint(equalTo: imageView.topAnchor),
			
			imageView.topAnchor.constraint(equalTo: prodName.bottomAnchor),
			imageView.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
//			imageView.bottomAnchor.constraint(equalTo: prodGap.topAnchor),
			imageView.bottomAnchor.constraint(equalTo: prodLine.topAnchor),
			//imageView.heightAnchor.constraint(equalToConstant: stack.frame.height-prodGap.frame.height-prodLine.frame.height-prodName.frame.height),
			
//			prodGap.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
			//prodGap.topAnchor.constraint(equalTo: stack.topAnchor),
//			prodGap.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
			
			prodLine.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
			//prodLine.topAnchor.constraint(equalTo: stack.topAnchor),
			prodLine.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
			prodLine.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
			
			stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			stack.topAnchor.constraint(equalTo: self.topAnchor),
			stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
			stack.widthAnchor.constraint(equalTo: self.widthAnchor/*, constant: -20*/),
			
			//prodImage.heightAnchor.constraint(lessThanOrEqualToConstant: stack.frame.height),
			])
		//print("gap=\(prodGap.bounds.height), line=\(prodLine.bounds.height), name=\(prodName.bounds.height)")
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}
