//
//  ViewController.swift
//  my-2048
//
//  Created by syh-hw on 16/11/5.
//  Copyright © 2016年 syh_wzn. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIActionSheetDelegate {
    let backColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
    let textColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    let textColor1 = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
    let screenW = UIScreen.mainScreen().bounds.size.width
    let screenH = UIScreen.mainScreen().bounds.size.height
    
    let numOfLine:CGFloat = 0   //列
    let numOfRow:CGFloat = 0    //行
    let arr1 = ["2","2"]
    var tag = 0
    var type = ""
    let background = UIView()
    var moveNum = 0     //移动次数
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        background.frame = CGRectMake(0, 0, screenW - 40, screenW - 40)
        background.backgroundColor = backColor
        background.center = self.view.center
        self.view.addSubview(background)
        
        
        for a in 0..<4 {    //行
            for b in 0..<4 {   //列
                let view1 = UIButton()
                view1.frame = CGRectMake((10 + (screenW - 40 - 50) / 4) * CGFloat(a) + 10, (10 + (screenW - 40 - 50) / 4) * CGFloat(b) + 10, (screenW - 40 - 50) / 4, (screenW - 40 - 50) / 4)
                view1.layer.cornerRadius = 8
                view1.layer.borderWidth = 2
                view1.tag = 1000 + a + 4 * b + 1
                view1.backgroundColor = textColor
                view1.addTarget(self, action: "sayTagAction:", forControlEvents: .TouchUpInside)
                background.addSubview(view1)
            }
        }
        
        

        
        self.creatBeginTL()
        
        
    
        //左滑
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeGesture(_:)))
        //不设置是右
        swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.Left
        background.addGestureRecognizer(swipeGestureLeft)
        
        //右滑
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeGesture(_:)))
        swipeGestureRight.direction = UISwipeGestureRecognizerDirection.Right
        background.addGestureRecognizer(swipeGestureRight)
        
        
        //上滑
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeGesture(_:)))
        swipeGestureUp.direction = UISwipeGestureRecognizerDirection.Up //不设置是右
        background.addGestureRecognizer(swipeGestureUp)
        
        
        //下滑
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipeGesture(_:)))
        swipeGestureDown.direction = UISwipeGestureRecognizerDirection.Down //不设置是右
        background.addGestureRecognizer(swipeGestureDown)
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func creatBeginTL() {
        for i in 1...2 {
            let label = UILabel()
            var view = UIView()
            let a = Int(arc4random() % 15) + i + 1000
            view = self.view.viewWithTag(a)!
            //view = self.view.viewWithTag(1009)!    测试
            if view.tag == tag && a >= 1016 {
                view = self.view.viewWithTag(a)!
                //view = self.view.viewWithTag(1013)!   测试
            }
            tag = view.tag
            label.text = "2"
            //            label.text = arr1[Int(arc4random() % 2)]
            //label.text = arr1[i]  测试
            label.backgroundColor = UIColor.brownColor()
            label.textColor = UIColor.whiteColor()
            label.textAlignment = .Center
            label.layer.masksToBounds = true
            label.frame = view.frame
            label.tag = view.tag * 2
            label.layer.cornerRadius = 8
            label.layer.borderWidth = 0.1
            background.addSubview(label)
        }
    }
    
    
    
    
    //划动手势
    func handleSwipeGesture(sender: UISwipeGestureRecognizer){
        //划动的方向
        let direction = sender.direction
        //判断是上下左右
        switch (direction){
        case UISwipeGestureRecognizerDirection.Left:
            print("Left")
            self.left()
            break
        case UISwipeGestureRecognizerDirection.Right:
            print("Right")
            self.right()
            break
        case UISwipeGestureRecognizerDirection.Up:
            print("Up")
            self.up()
            break
        case UISwipeGestureRecognizerDirection.Down:
            print("Down")
            self.down()
            break
        default:
            break;
        }
    }
    
    func up() {
        for m in 0..<4 {
            var lineOne = [String]()   //label上的数字（没有给0）
            var linetwo = [String]()   //label上的数字（没有不加）
            var linethree = [Int]()    //label的tag值
            var typeNum = 0     //判断该列有几个数字
            var numOfn = 0      //第几列

            for n in 0..<4 {
                numOfn = n
                if let label = self.view.viewWithTag((1000 + m + 4 * n + 1) * 2) as?UILabel {
                    //print(label.text)
                    lineOne.append(label.text!)
                    linetwo.append(label.text!)
                    linethree.append(label.tag)
                    typeNum += 1
                } else {
                    lineOne.append("0")
                }
            }
            print(lineOne)
            print(linetwo)
            switch typeNum {
            case 0:     //没有
                print("全是零")
            case 1:      //一个
                print("有一个数")
                print(String(m) + "wwwwwwwww")
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                self.moveCommit(1000 + m + 1, text: linetwo[0])
                if lineOne[0] == "0" {
                    moveNum += 1
                }
            case 2:      //两个
                print("有两个数")
                //移除两个label
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                
                if linetwo[0] == linetwo[1] {    //当两个label上的数字相等shi2
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m + 1, text: text)
                    moveNum += 1
                } else {    //当两个label上的数字不相等时
                    self.moveCommit(1000 + m + 1, text: linetwo[0])
                    self.moveCommit(1000 + m + 5, text: linetwo[1])
                    if lineOne[0] == "0" || lineOne[1] == "0" {
                        moveNum += 1
                    }
                }
      
            case 3:    //三个
                print("有三个数")
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                let label2 = self.view.viewWithTag(linethree[2]) as?UILabel
                label2?.removeFromSuperview()
                if linetwo[0] == linetwo[1] && linetwo[1] == linetwo[2] {
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m + 1, text: text)
                    self.moveCommit(1000 + m + 5, text: linetwo[0])
                    moveNum += 1
                } else if linetwo[0] == linetwo[1] {
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m + 1, text: text)
                    self.moveCommit(1000 + m + 5, text: linetwo[2])
                    moveNum += 1
                } else if linetwo[1] == linetwo[2] {
                    let text = String(Int(linetwo[1])! * 2)
                    self.moveCommit(1000 + m + 1, text: linetwo[0])
                    self.moveCommit(1000 + m + 5, text: text)
                    moveNum += 1
                } else {
                    self.moveCommit(1000 + m + 1, text: linetwo[0])
                    self.moveCommit(1000 + m + 5, text: linetwo[1])
                    self.moveCommit(1000 + m + 9, text: linetwo[2])
                    if lineOne[0] == "0" || lineOne[1] == "0" || lineOne[2] == "0" {
                        moveNum += 1
                    }
                }
            case 4:     //四个
                print("有四个数")
                
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                let label2 = self.view.viewWithTag(linethree[2]) as?UILabel
                label2?.removeFromSuperview()
                let label3 = self.view.viewWithTag(linethree[3]) as?UILabel
                label3?.removeFromSuperview()
                if linetwo[0] == linetwo[1] {
                    moveNum += 1
                    if linetwo[2] == linetwo[3] {
                        let text = String(Int(linetwo[0])! * 2)
                        let text1 = String(Int(linetwo[2])! * 2)
                        self.moveCommit(1000 + m + 1, text: text)
                        self.moveCommit(1000 + m + 5, text: text1)
                    } else {
                        let text = String(Int(linetwo[0])! * 2)
                        self.moveCommit(1000 + m + 1, text: text)
                        self.moveCommit(1000 + m + 5, text: linetwo[2])
                        self.moveCommit(1000 + m + 9, text: linetwo[3])
                    }
                } else if linetwo[1] == linetwo[2] {
                    moveNum += 1
                    let text = String(Int(linetwo[1])! * 2)
                    self.moveCommit(1000 + m + 1, text: linetwo[0])
                    self.moveCommit(1000 + m + 5, text: text)
                    self.moveCommit(1000 + m + 9, text: linetwo[3])
                } else if linetwo[2] == linetwo[3] {
                    moveNum += 1
                    let text = String(Int(linetwo[2])! * 2)
                    self.moveCommit(1000 + m + 1, text: linetwo[0])
                    self.moveCommit(1000 + m + 5, text: linetwo[1])
                    self.moveCommit(1000 + m + 9, text: text)
                } else {
                    self.moveCommit(1000 + m + 1, text: linetwo[0])
                    self.moveCommit(1000 + m + 5, text: linetwo[1])
                    self.moveCommit(1000 + m + 9, text: linetwo[2])
                    self.moveCommit(1000 + m + 13, text: linetwo[3])
                }
            default:
                break
            }
        }
        print(moveNum)
        if moveNum != 0 {
            self.creatNewLabel()
            moveNum = 0
        } else {
            print("没移动")
        }
        
    }
    
    func down() {
        for m in 0..<4 {
            var lineOne = [String]()   //label上的数字（没有给0）
            var linetwo = [String]()   //label上的数字（没有不加）
            var linethree = [Int]()    //label的tag值
            var typeNum = 0     //判断该列有几个数字
            var numOfn = 0      //第几列
            for n in 0..<4 {
                numOfn = n
                if let label = self.view.viewWithTag((1000 + m + 4 * n + 1) * 2) as?UILabel {
                    //print(label.text)
                    lineOne.append(label.text!)
                    linetwo.append(label.text!)
                    linethree.append(label.tag)
                    typeNum += 1
                } else {
                    lineOne.append("0")
                }
            }
            //print(lineOne)
            switch typeNum {
            case 0:     //没有
                print("全是零")
            case 1:      //一个
                print("有一个数")
                print(String(m) + "wwwwwwwww")
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                self.moveCommit(1000 + m + 13, text: linetwo[0])
                if lineOne[3] == "0" {
                    moveNum += 1
                }
            case 2:      //两个
                print("有两个数")
                //移除两个label
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                
                if linetwo[0] == linetwo[1] {    //当两个label上的数字相等shi2
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m + 13, text: text)
                    moveNum += 1
                } else {    //当两个label上的数字不相等时
                    self.moveCommit(1000 + m + 13, text: linetwo[1])
                    self.moveCommit(1000 + m + 9, text: linetwo[0])
                    if lineOne[3] == "0" || lineOne[2] == "0" {
                        moveNum += 1
                    }
                }
                
            case 3:    //三个
                print("有三个数")
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                let label2 = self.view.viewWithTag(linethree[2]) as?UILabel
                label2?.removeFromSuperview()
                if linetwo[0] == linetwo[1] && linetwo[1] == linetwo[2] {
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m + 13, text: linetwo[0])
                    self.moveCommit(1000 + m + 9, text: text)
                    moveNum += 1
                } else if linetwo[0] == linetwo[1] {
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m + 13, text: linetwo[2])
                    self.moveCommit(1000 + m + 9, text: text)
                    moveNum += 1
                } else if linetwo[1] == linetwo[2] {
                    let text = String(Int(linetwo[1])! * 2)
                    self.moveCommit(1000 + m + 13, text: text)
                    self.moveCommit(1000 + m + 9, text: linetwo[0])
                    moveNum += 1
                } else {
                    self.moveCommit(1000 + m + 13, text: linetwo[2])
                    self.moveCommit(1000 + m + 9, text: linetwo[1])
                    self.moveCommit(1000 + m + 5, text: linetwo[0])
                    if lineOne[3] == "0" || lineOne[2] == "0" || lineOne[1] == "0" {
                        moveNum += 1
                    }
                }
            case 4:     //四个
                print("有四个数")
                
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                let label2 = self.view.viewWithTag(linethree[2]) as?UILabel
                label2?.removeFromSuperview()
                let label3 = self.view.viewWithTag(linethree[3]) as?UILabel
                label3?.removeFromSuperview()
                if linetwo[0] == linetwo[1] {
                    moveNum += 1
                    if linetwo[2] == linetwo[3] {
                        let text = String(Int(linetwo[0])! * 2)
                        let text1 = String(Int(linetwo[2])! * 2)
                        self.moveCommit(1000 + m + 13, text: text1)
                        self.moveCommit(1000 + m + 9, text: text)
                        
                    } else {
                        let text = String(Int(linetwo[0])! * 2)
                        self.moveCommit(1000 + m + 13, text: linetwo[3])
                        self.moveCommit(1000 + m + 9, text: linetwo[2])
                        self.moveCommit(1000 + m + 5, text: text)
                    }
                } else if linetwo[1] == linetwo[2] {
                    moveNum += 1
                    let text = String(Int(linetwo[1])! * 2)
                    self.moveCommit(1000 + m + 13, text: linetwo[3])
                    self.moveCommit(1000 + m + 9, text: text)
                    self.moveCommit(1000 + m + 5, text: linetwo[0])
                } else if linetwo[2] == linetwo[3] {
                    moveNum += 1
                    let text = String(Int(linetwo[2])! * 2)
                    self.moveCommit(1000 + m + 13, text: text)
                    self.moveCommit(1000 + m + 9, text: linetwo[1])
                    self.moveCommit(1000 + m + 5, text: linetwo[0])
                } else {
                    self.moveCommit(1000 + m + 13, text: linetwo[3])
                    self.moveCommit(1000 + m + 9, text: linetwo[2])
                    self.moveCommit(1000 + m + 5, text: linetwo[1])
                    self.moveCommit(1000 + m + 1, text: linetwo[0])
                    
                }
            default:
                break
            }
        }
        print(moveNum)
        if moveNum != 0 {
            self.creatNewLabel()
            moveNum = 0
        } else {
            print("没移动")
        }

    }
    
    func left() {
        for m in 0..<4 {
            var lineOne = [String]()   //label上的数字（没有给0）
            var linetwo = [String]()   //label上的数字（没有不加）
            var linethree = [Int]()    //label的tag值
            var typeNum = 0     //判断该列有几个数字
            var numOfn = 0      //第几列
            for n in 0..<4 {
                numOfn = n
                if let label = self.view.viewWithTag((1000 + m * 4 + n + 1) * 2) as?UILabel {
                    //print(label.text)
                    lineOne.append(label.text!)
                    linetwo.append(label.text!)
                    linethree.append(label.tag)
                    typeNum += 1
                } else {
                    lineOne.append("0")
                }
            }
            print(lineOne)
            switch typeNum {
            case 0:     //没有
                print("全是零")
            case 1:      //一个
                print("有一个数")
                print(String(m) + "wwwwwwwww")
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                self.moveCommit(1000 + m * 4 + 1, text: linetwo[0])
                if lineOne[0] == "0" {
                    moveNum += 1
                }
            case 2:      //两个
                print("有两个数")
                //移除两个label
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                
                if linetwo[0] == linetwo[1] {    //当两个label上的数字相等shi2
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m * 4 + 1, text: text)
                    moveNum += 1
                } else {    //当两个label上的数字不相等时
                    self.moveCommit(1000 + m * 4 + 1, text: linetwo[0])
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[1])
                    if lineOne[0] == "0" || lineOne[1] == "0" {
                        moveNum += 1
                    }
                }
                
            case 3:    //三个
                print("有三个数")
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                let label2 = self.view.viewWithTag(linethree[2]) as?UILabel
                label2?.removeFromSuperview()
                if linetwo[0] == linetwo[1] && linetwo[1] == linetwo[2] {
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m * 4 + 1, text: text)
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[0])
                    moveNum += 1
                } else if linetwo[0] == linetwo[1] {
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m * 4 + 1, text: text)
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[2])
                    moveNum += 1
                } else if linetwo[1] == linetwo[2] {
                    let text = String(Int(linetwo[1])! * 2)
                    self.moveCommit(1000 + m * 4 + 1, text: linetwo[0])
                    self.moveCommit(1000 + m * 4 + 2, text: text)
                    moveNum += 1
                } else {
                    self.moveCommit(1000 + m * 4 + 1, text: linetwo[0])
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[1])
                    self.moveCommit(1000 + m * 4 + 3, text: linetwo[2])
                    if lineOne[0] == "0" || lineOne[1] == "0" || lineOne[2] == "0" {
                        moveNum += 1
                    }
                }
            case 4:     //四个
                print("有四个数")
                
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                let label2 = self.view.viewWithTag(linethree[2]) as?UILabel
                label2?.removeFromSuperview()
                let label3 = self.view.viewWithTag(linethree[3]) as?UILabel
                label3?.removeFromSuperview()
                if linetwo[0] == linetwo[1] {
                    moveNum += 1
                    if linetwo[2] == linetwo[3] {
                        let text = String(Int(linetwo[0])! * 2)
                        let text1 = String(Int(linetwo[2])! * 2)
                        self.moveCommit(1000 + m * 4 + 1, text: text)
                        self.moveCommit(1000 + m * 4 + 2, text: text1)
                    } else {
                        let text = String(Int(linetwo[0])! * 2)
                        self.moveCommit(1000 + m * 4 + 1, text: text)
                        self.moveCommit(1000 + m * 4 + 2, text: linetwo[2])
                        self.moveCommit(1000 + m * 4 + 3, text: linetwo[3])
                    }
                } else if linetwo[1] == linetwo[2] {
                    moveNum += 1
                    let text = String(Int(linetwo[1])! * 2)
                    self.moveCommit(1000 + m * 4 + 1, text: linetwo[0])
                    self.moveCommit(1000 + m * 4 + 2, text: text)
                    self.moveCommit(1000 + m * 4 + 3, text: linetwo[3])
                } else if linetwo[2] == linetwo[3] {
                    moveNum += 1
                    let text = String(Int(linetwo[2])! * 2)
                    self.moveCommit(1000 + m * 4 + 1, text: linetwo[0])
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[1])
                    self.moveCommit(1000 + m * 4 + 3, text: text)
                } else {
                    self.moveCommit(1000 + m * 4 + 1, text: linetwo[0])
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[1])
                    self.moveCommit(1000 + m * 4 + 3, text: linetwo[2])
                    self.moveCommit(1000 + m * 4 + 4, text: linetwo[3])
                }
            default:
                break
            }
        }
        print(moveNum)
        if moveNum != 0 {
            self.creatNewLabel()
            moveNum = 0
        } else {
            print("没移动")
        }

    }
    
    
    func right() {
        for m in 0..<4 {
            var lineOne = [String]()
            var linetwo = [String]()
            var linethree = [Int]()
            var typeNum = 0
            for n in 0..<4 {
                if let label = self.view.viewWithTag((1000 + m * 4 + n + 1) * 2) as?UILabel {
                    //print(label.text)
                    lineOne.append(label.text!)
                    linetwo.append(label.text!)
                    linethree.append(label.tag)
                    typeNum += 1
                } else {
                    lineOne.append("0")
                }
            }
            print(lineOne)
            switch typeNum {
            case 0:     //没有
                print("全是零")
            case 1:      //一个
                print("有一个数")
                print(String(m) + "wwwwwwwww")
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                self.moveCommit(1000 + m * 4 + 4, text: linetwo[0])
                if lineOne[3] == "0" {
                    moveNum += 1
                }
            case 2:      //两个
                print("有两个数")
                //移除两个label
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                
                if linetwo[0] == linetwo[1] {    //当两个label上的数字相等shi2
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m * 4 + 4, text: text)
                    moveNum += 1
                } else {    //当两个label上的数字不相等时
                    self.moveCommit(1000 + m * 4 + 4, text: linetwo[1])
                    self.moveCommit(1000 + m * 4 + 3, text: linetwo[0])
                    if lineOne[3] == "0" || lineOne[2] == "0" {
                        moveNum += 1
                    }
                }
                
            case 3:    //三个
                print("有三个数")
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                let label2 = self.view.viewWithTag(linethree[2]) as?UILabel
                label2?.removeFromSuperview()
                if linetwo[0] == linetwo[1] && linetwo[1] == linetwo[2] {
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m * 4 + 4, text: linetwo[0])
                    self.moveCommit(1000 + m * 4 + 3, text: text)
                    moveNum += 1
                } else if linetwo[0] == linetwo[1] {
                    let text = String(Int(linetwo[0])! * 2)
                    self.moveCommit(1000 + m * 4 + 4, text: linetwo[2])
                    self.moveCommit(1000 + m * 4 + 3, text: text)
                    moveNum += 1
                } else if linetwo[1] == linetwo[2] {
                    let text = String(Int(linetwo[1])! * 2)
                    self.moveCommit(1000 + m * 4 + 4, text: text)
                    self.moveCommit(1000 + m * 4 + 3, text: linetwo[0])
                    moveNum += 1
                } else {
                    self.moveCommit(1000 + m * 4 + 4, text: linetwo[2])
                    self.moveCommit(1000 + m * 4 + 3, text: linetwo[1])
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[0])
                    if lineOne[3] == "0" || lineOne[2] == "0" || lineOne[1] == "0" {
                        moveNum += 1
                    }
                }
            case 4:     //四个
                print("有四个数")
                
                let label = self.view.viewWithTag(linethree[0]) as?UILabel
                label?.removeFromSuperview()
                let label1 = self.view.viewWithTag(linethree[1]) as?UILabel
                label1?.removeFromSuperview()
                let label2 = self.view.viewWithTag(linethree[2]) as?UILabel
                label2?.removeFromSuperview()
                let label3 = self.view.viewWithTag(linethree[3]) as?UILabel
                label3?.removeFromSuperview()
                if linetwo[0] == linetwo[1] {
                    moveNum += 1
                    if linetwo[2] == linetwo[3] {
                        let text = String(Int(linetwo[0])! * 2)
                        let text1 = String(Int(linetwo[2])! * 2)
                        self.moveCommit(1000 + m * 4 + 4, text: text1)
                        self.moveCommit(1000 + m * 4 + 3, text: text)
                    } else {
                        let text = String(Int(linetwo[0])! * 2)
                        self.moveCommit(1000 + m * 4 + 4, text: linetwo[3])
                        self.moveCommit(1000 + m * 4 + 3, text: linetwo[2])
                        self.moveCommit(1000 + m * 4 + 2, text: text)
                    }
                } else if linetwo[1] == linetwo[2] {
                    moveNum += 1
                    let text = String(Int(linetwo[1])! * 2)
                    self.moveCommit(1000 + m * 4 + 4, text: linetwo[3])
                    self.moveCommit(1000 + m * 4 + 3, text: text)
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[0])
                } else if linetwo[2] == linetwo[3] {
                    moveNum += 1
                    let text = String(Int(linetwo[2])! * 2)
                    self.moveCommit(1000 + m * 4 + 4, text: text)
                    self.moveCommit(1000 + m * 4 + 3, text: linetwo[1])
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[0])
                } else {
                    self.moveCommit(1000 + m * 4 + 4, text: linetwo[3])
                    self.moveCommit(1000 + m * 4 + 3, text: linetwo[2])
                    self.moveCommit(1000 + m * 4 + 2, text: linetwo[1])
                    self.moveCommit(1000 + m * 4 + 1, text: linetwo[0])
                }
            default:
                break
            }
        }
        print(moveNum)
        if moveNum != 0 {
            self.creatNewLabel()
            moveNum = 0
        } else {
            print("没移动")
        }
    }
    
  //在空白处创建一个新的label
    func creatNewLabel() {
        var nullArr = [Int]()
        //获取空的view的tag值
        for i in 1...16 {
            if let label = self.view.viewWithTag((1000 + i) * 2) {
                print(label.tag)
            } else {
                 nullArr.append((1000 + i) * 2)
            }
        }
        if nullArr.count == 0 {
            self.alertView("已经不能移动了，开启下一把，好吗？")
            self.beginGame()
            return
        }
        
        //在空的view中随机选一个添加2或者4
        
            let num = UInt32(nullArr.count)
            let b = Int(arc4random() % num)
            let view1 = self.view.viewWithTag(nullArr[b] / 2)
            let label1 = UILabel()
            label1.text = arr1[Int(arc4random() % 2)]
            label1.backgroundColor = UIColor.brownColor()
            label1.textAlignment = .Center
            label1.textColor = UIColor.whiteColor()
            label1.frame = (view1?.frame)!
            label1.center = (view1?.center)!
            label1.tag = (view1?.tag)! * 2
            print("oishdfojaslkdfjlashflkjaskldfjoaskjhf9;joijjlkj" + String(label1.tag))
            background.addSubview(label1)
            return

      
        

    }
    
    
    
    //移动后得到的数据
    func moveCommit(tag:Int,text:String){
        let label = UILabel()
        let view = self.view.viewWithTag(tag)
        label.text = text
        switch text {
        case "2":
            label.backgroundColor = UIColor.brownColor()
        case "4":
            label.backgroundColor = UIColor.brownColor()
        case "8":
            label.backgroundColor = UIColor.brownColor()
        case "16":
            label.backgroundColor = UIColor.brownColor()
        case "32":
            label.backgroundColor = UIColor.brownColor()
        case "64":
            label.backgroundColor = UIColor.brownColor()
        case "128":
            label.backgroundColor = UIColor.brownColor()
        case "256":
            label.backgroundColor = UIColor.brownColor()
        case "512":
            label.backgroundColor = UIColor.brownColor()
        case "1024":
            label.backgroundColor = UIColor.brownColor()
        case "2048":
            label.backgroundColor = UIColor.brownColor()
        case "4096":
            label.backgroundColor = UIColor.brownColor()
        case "8192":
            label.backgroundColor = UIColor.brownColor()
        default:
            break
        }
        
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.layer.masksToBounds = true
        label.frame = view!.frame
        label.tag = (view?.tag)! * 2
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 0.1
        background.addSubview(label)
    }
    
    
    func sayTagAction(sender:UIButton) {
        //print(sender.tag)
    }
    
    func beginGame() {
        for i in 1...16 {
            let a = (i + 1000) * 2
            let label = self.view.viewWithTag(a) as!UILabel
            label.removeFromSuperview()
        }
        self.creatBeginTL()
        
        
    }
    
    
    func alertView(text:String) {
        let alert = UIAlertView.init(title: "温馨提示", message: text, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

