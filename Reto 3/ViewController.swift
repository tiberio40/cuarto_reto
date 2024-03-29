//
//  ViewController.swift
//  Reto 3
//
//  Created by Laurent castañeda ramirez on 9/10/19.
//  Copyright © 2019 Laurent castañeda ramirez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button_0: ButtonStyle!
    @IBOutlet var button_1: ButtonStyle!
    @IBOutlet var button_2: ButtonStyle!
    @IBOutlet var button_3: ButtonStyle!
    @IBOutlet var button_4: ButtonStyle!
    @IBOutlet var button_5: ButtonStyle!
    @IBOutlet var button_6: ButtonStyle!
    @IBOutlet var button_7: ButtonStyle!
    @IBOutlet var button_8: ButtonStyle!
    
    @IBOutlet var message: UILabel!
    @IBOutlet var pointMessage: UILabel!
    
    var humanPoint: Int = 0
    var iOSPoint: Int = 0
    
    
    
    var array: [Play] = []
    var arrayPlay: [[Int]] = []
    var plays: Int = 0
    var lvlDifficulty: Int = 1
    
    var arrayUI: [[ButtonStyle]] = []
    
    
    override func viewDidLoad() {
        
        arrayPlay.append([0, 0, 0])
        arrayPlay.append([0, 0, 0])
        arrayPlay.append([0, 0, 0])
        
        arrayUI.append([button_0, button_1, button_2])
        arrayUI.append([button_3, button_4, button_5])
        arrayUI.append([button_6, button_7, button_8])
        
        for _ in 0...8{
            array.append(Play(state: 0))
        }
        print(self.array)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeApp(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func changeDifficulty(_ sender: Any) {
        let alert = UIAlertController(title: "Nivel de Dificultad", message: "Por favor escoge un nivel de dificultad", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Facil", style: .default, handler: { (_) in
            self.lvlDifficulty = 1
            self.setPointMessage()
        }))
        
        alert.addAction(UIAlertAction(title: "Mediano", style: .default, handler: { (_) in
            self.lvlDifficulty = 2
            self.setPointMessage()
        }))
        
        alert.addAction(UIAlertAction(title: "Experto", style: .default, handler: { (_) in
            self.lvlDifficulty = 3
            self.setPointMessage()
        }))
        
        alert.addAction(UIAlertAction(title: "Salir", style: .cancel, handler: { (_) in

        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func newGame(_ sender: Any) {
        self.message.text = "Tú Turno"
        for row in 0...2{
            for column in 0...2{
                arrayUI[row][column].isEnabled = true
                arrayUI[row][column].setImage(nil, for: .normal)
                arrayPlay[row][column] = 0
            }
        }
    }
    
    @IBAction func ResetPoint(_ sender: Any) {
        self.humanPoint = 0
        self.iOSPoint = 0
        self.setPointMessage()
    }
    
    
    
    @IBAction func userEvent(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        if(self.Human(button: button)){
            self.statusButton(status: false)
            let humanWinning: Bool = self.CheckForWinning(player: 1)
            if(humanWinning){
                self.message.text = "Tu ganaste"
                self.humanPoint += 1
                self.setPointMessage()
            }
            if(!humanWinning){
                if(self.GameOver()){
                    self.message.text = "Turno de iOS"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.Machine()
                        if(self.CheckForWinning(player: 2)){
                            self.message.text = "iOS ganó"
                            self.iOSPoint += 1
                            self.setPointMessage()
                        }else{
                            self.statusButton(status: true)
                            self.message.text = "Tú Turno"
                        }
                    }
                }else{
                    self.message.text = "Partida Terminada - Empate"
                }
            }
        }
    }
    
    func Human(button: UIButton) -> Bool{
        let image = UIImage(named: "cross") as UIImage?
        var isValid: Bool = false
        switch button.tag {
        case 0:
            if(self.arrayPlay[0][0] == 0){
                self.button_0.setImage(image, for: .normal)
                self.arrayPlay[0][0] = 1
                isValid = true
            }
        case 1:
            if(self.arrayPlay[0][1] == 0){
                self.button_1.setImage(image, for: .normal)
                self.arrayPlay[0][1] = 1
                isValid = true
            }
        case 2:
            if(self.arrayPlay[0][2] == 0){
                self.button_2.setImage(image, for: .normal)
                self.arrayPlay[0][2] = 1
                isValid = true
            }
            
        case 3:
            if(self.arrayPlay[1][0] == 0){
                self.button_3.setImage(image, for: .normal)
                self.arrayPlay[1][0] = 1
                isValid = true
            }
            
        case 4:
            if(self.arrayPlay[1][1] == 0){
                self.button_4.setImage(image, for: .normal)
                self.arrayPlay[1][1] = 1
                isValid = true
            }
            
        case 5:
            if(self.arrayPlay[1][2] == 0){
                self.button_5.setImage(image, for: .normal)
                self.arrayPlay[1][2] = 1
                isValid = true
            }
            
        case 6:
            if(self.arrayPlay[2][0] == 0){
                self.button_6.setImage(image, for: .normal)
                self.arrayPlay[2][0] = 1
                isValid = true
            }
            
        case 7:
            if(self.arrayPlay[2][1] == 0){
                self.button_7.setImage(image, for: .normal)
                self.arrayPlay[2][1] = 1
                isValid = true
            }
            
        case 8:
            if(self.arrayPlay[2][2] == 0){
                self.button_8.setImage(image, for: .normal)
                self.arrayPlay[2][2] = 1
                isValid = true
            }
            
        default:
            print(button.tag)
        }
        
        return isValid
    }
    
    func Machine(){
        var move: Bool = false
        
        if(self.lvlDifficulty ==  1 ){
            getRandomMove()
        }
        
        if(self.lvlDifficulty == 2){
            move = self.getWinningMove()
            if(!move){
                 getRandomMove()
            }
        }
        if(self.lvlDifficulty == 3){
            move = self.getWinningMove()
            if(!move){
                move = self.getBlockingMove()
            }
            if(!move){
                getRandomMove()
            }
            
        }
    }
    
    func getRandomMove(){
        var therePlays: [String] = []
        
        for i in 0...2{
            for j in 0...2{
                if (arrayPlay[i][j] == 0){
                    therePlays.append(String(i) + ";" + String(j))
                }
            }
        }
        
        if(therePlays.count > 0){
            let image = UIImage(named: "circle") as UIImage?
            let count = therePlays.count
            let number = Int.random(in: 0..<count)
            
            let array = therePlays[number].split(separator: ";")
            
            let row = Int(array[0])
            let column = Int(array[1])
            self.arrayPlay[row!][column!] = 2
            
            self.arrayUI[row!][column!].setImage(image, for: .normal)
        }
    }
    
    
    func CheckForWinning(player: Int) -> Bool{
        var winning: Bool = false
        var isWinning: Int = 0
        
        for row in 0...2{
            for column in 0...2{
                if(arrayPlay[row][column] == player){
                    isWinning+=1
                }
            }
            if(isWinning == 3){
                winning = true
                break
            }else{
                isWinning = 0
            }
        }
        
        if(!winning){
            isWinning = 0
            
            for column in 0...2{
                for row in 0...2{
                    if(arrayPlay[row][column] == player){
                        isWinning+=1
                    }
                }
                if(isWinning == 3){
                    winning = true
                    break
                }else{
                    isWinning = 0
                }
            }
        }
        
        
        if(!winning && arrayPlay[0][0] == player && arrayPlay[1][1] == player && arrayPlay[2][2] == player ){
            winning = true
        }
        
        if(!winning && arrayPlay[0][2] == player && arrayPlay[1][1] == player && arrayPlay[2][0] == player ){
            winning = true
        }
        
        return winning
        
    }
    
    func statusButton(status: Bool){
        for row in 0...2{
            for column in 0...2{
                arrayUI[row][column].isEnabled = status
            }
        }
    }
    
    func getWinningMove() -> Bool{
        var canWin: Int = 0
        let image = UIImage(named: "circle") as UIImage?
        
        //First see if there's a move O can make to win
        for row in 0...2{
            for column in 0...2{
                if (arrayPlay[row][column] == 2 || arrayPlay[row][column] == 0){
                    if (arrayPlay[row][column] == 2){
                        canWin += 1
                    }
                }else{
                    canWin -= 1
                }
            }
            if(canWin == 2){
                for column in 0...2{
                    arrayPlay[row][column] = 2
                    self.arrayUI[row][column].setImage(image, for: .normal)
                }
                break;
            }else{
                canWin = 0
            }
        }
        
        if (canWin != 2){
            for column in 0...2{
                for row in 0...2{
                    if (arrayPlay[row][column] == 2 || arrayPlay[row][column] == 0){
                        if (arrayPlay[row][column] == 2){
                            canWin += 1
                        }
                    }
                    else{
                        canWin -= 1
                    }
                }
                if(canWin == 2){
                    for row in 0...2{
                        arrayPlay[row][column] = 2
                        self.arrayUI[row][column].setImage(image, for: .normal)
                    }
                    break;
                }else{
                    canWin = 0
                }
            }
        }
        
        //Diagonal
        
        if (canWin != 2){
            for row in 0...2{
                if (arrayPlay[row][row] == 2 || arrayPlay[row][row] == 0){
                    if(arrayPlay[row][row] == 2){
                        canWin += 1
                    }
                }
                else{
                    canWin -= 1
                }
            }
            if(canWin == 2){
                for row in 0...2{
                    arrayPlay[row][row] = 2
                    self.arrayUI[row][row].setImage(image, for: .normal)
                }
                
            }else{
                canWin = 0
            }
        }
        
        if (canWin != 2){
            var column = 0
            for row in (0...2).reversed(){
                if (arrayPlay[row][column] == 2 || arrayPlay[row][column] == 0){
                    if(arrayPlay[row][column] == 2){
                        canWin += 1
                    }
                }
                else{
                    canWin -= 1
                }
                 column += 1
            }
            if(canWin == 2){
                var column = 0
                for row in (0...2).reversed(){
                    arrayPlay[row][column] = 2
                    self.arrayUI[row][row].setImage(image, for: .normal)
                    column += 1
                }
            }
        }
        
        if(canWin == 2){
            return true
        }else{
            return false
        }
    }
    
    func getBlockingMove() -> Bool{
        var canWin: Int = 0
        let image = UIImage(named: "circle") as UIImage?
        
        //First see if there's a move O can make to win
        for row in 0...2{
            for column in 0...2{
                if (arrayPlay[row][column] == 1 || arrayPlay[row][column] == 0){
                    if (arrayPlay[row][column] == 1){
                        canWin += 1
                    }
                }
                else{
                    canWin -= 1
                }
            }
            if(canWin == 2){
                for column in 0...2{
                    if(arrayPlay[row][column] == 0){
                        arrayPlay[row][column] = 2
                        self.arrayUI[row][column].setImage(image, for: .normal)
                    }
                }
                break;
            }else{
                canWin = 0
            }
        }
        
        if (canWin != 2){
            for column in 0...2{
                for row in 0...2{
                    let xx = arrayPlay[row][column]
                    if (arrayPlay[row][column] == 1 || arrayPlay[row][column] == 0){
                        if (arrayPlay[row][column] == 1){
                            canWin += 1
                        }
                    }else{
                        canWin -= 1
                    }
                }
                if(canWin == 2){
                    for row in 0...2{
                        if(arrayPlay[row][column] == 0){
                            arrayPlay[row][column] = 2
                            self.arrayUI[row][column].setImage(image, for: .normal)
                        }
                    }
                    break;
                }else{
                    canWin = 0
                }
            }
        }
        //Diagonal
        if (canWin != 2){
            for row in 0...2{
                if (arrayPlay[row][row] == 1){
                    canWin += 1
                }
                if (arrayPlay[row][row] == 2){
                    canWin -= 1
                }
            }
            if(canWin == 2){
                for row in 0...2{
                    if(arrayPlay[row][row] == 0){
                        arrayPlay[row][row] = 2
                        self.arrayUI[row][row].setImage(image, for: .normal)
                    }
                }
                
            }else{
                canWin = 0
            }
        }
        
        if (canWin != 2){
            var column = 0
            for row in (0...2).reversed(){
                if (arrayPlay[row][column] == 1){
                    canWin += 1
                }
                if(arrayPlay[row][column] == 2){
                    canWin -= 1
                }
                column += 1
            }
            if(canWin == 2){
                column = 0
                for row in (0...2).reversed(){
                    if(arrayPlay[row][column] == 0){
                        arrayPlay[row][column] = 2
                        self.arrayUI[row][column].setImage(image, for: .normal)
                    }
                    column += 1
                }
                
            }else{
                canWin = 0
            }
        }
        
        if(canWin == 2){
            return true
        }else{
            return false
        }
    }
    
    func setPointMessage(){
        var difficulty: String = ""
        switch lvlDifficulty {
        case 1:
            difficulty = "Facil"
            break
        case 2:
            difficulty = "Mediano"
             break
        case 3:
            difficulty = "Experto"
             break
        default:
            difficulty = "Facil"
             break
        }
        
        self.pointMessage.text = "Humano " + String(self.humanPoint) + " | Partida " + String(self.humanPoint + self.iOSPoint) + " | iOS " + String(self.iOSPoint) + " | " + difficulty
    }
    
    func GameOver()-> Bool{
        var isEnd: Bool = true
        for row in 0...2{
            for column in 0...2{
                if(arrayPlay[row][column] == 0){
                    isEnd = false
                }
            }
        }
        if(isEnd){
            for row in 0...2{
                for column in 0...2{
                    arrayUI[row][column].isEnabled = false
                }
            }
        }
        return !isEnd
    }
    
}

