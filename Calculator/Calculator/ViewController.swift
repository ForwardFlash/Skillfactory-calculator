//
//  ViewController.swift
//  Calculator
//
//  Created by ForwardFlash on 21.03.2021.
//
import UIKit

class ViewController: UIViewController {
  // инициализация переменных для операндов и операций
  @IBOutlet weak var displayResultLabel: UILabel!
  var stillTyping = false
  var firstOperand: Double = 0
  var secondOperand: Double = 0
  var operationSign: String = ""
  var dotIsPlaced = false
    
  // получаем текущий ввод
  var currentInput: Double {
    get {
      return Double(displayResultLabel.text!) ?? firstOperand
    } set {
      let value = "\(newValue)"
      let valueArray = value.components(separatedBy: ".")
      if valueArray[1] == "0" {
        displayResultLabel.text = "\(valueArray[0])"
      } else {
        displayResultLabel.text = "\(newValue)"
      }
      stillTyping = false
    }
  }
  // обрабатываем кол-во введенных знаков и выводим в лейбл
  @IBAction func pressNumber(_ sender: UIButton) {
    let number = sender.currentTitle!
    if stillTyping {
      if displayResultLabel.text!.count < 10 {
      displayResultLabel.text = displayResultLabel.text! + number
      }
    } else {
      displayResultLabel.text = number
      stillTyping = true
    }
  }
  // получаем текущую операцию
  @IBAction func twoOperandOperation(_ sender: UIButton) {
    operationSign = sender.currentTitle!
    firstOperand = currentInput
    stillTyping = false
    dotIsPlaced = false
  }
  // посылаем на обработку все операции с операндами кроме ошибочной
  func operateWithTowOperands(operation: (Double, Double) -> Double) {
    if secondOperand == 0 && operationSign == "/" {
      displayResultLabel.text = "Делить на 0 нельзя!"
    } else {
      currentInput = operation(firstOperand, secondOperand)
    }
    stillTyping = false
  }
  // Сброс данных с лейбла и инициализация переменных
  @IBAction func clearButtonPressed(_ sender: UIButton) {
    currentInput = 0
    firstOperand = 0
    secondOperand = 0
    displayResultLabel.text = ""
    stillTyping = false
    operationSign = ""
    dotIsPlaced = false
  }
  // устанавливаем знак '-' перед введенным операндом
  @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
    currentInput = -currentInput
  }
  // производим операцию вычисления процентов
  @IBAction func percentButtonPressed(_ sender: UIButton) {
    if firstOperand == 0 {
      currentInput = currentInput / 100
    } else {
      secondOperand = firstOperand * currentInput / 100
    }
    stillTyping = false
  }
  // добавляем в строку точку
  @IBAction func dotButtonPressed(_ sender: UIButton) {
    if stillTyping && !dotIsPlaced {
      displayResultLabel.text = displayResultLabel.text! + "."
      dotIsPlaced = true
    } else if !stillTyping && !dotIsPlaced {
      displayResultLabel.text = "0."
      stillTyping = true
    }
  }
  // итоги вычислений: выполняем операции
  @IBAction func equalitySingPresed(_ sender: UIButton) {
    if stillTyping {
      secondOperand = currentInput
      }
      dotIsPlaced = false
     //
      switch operationSign {
      case "+":
        operateWithTowOperands {$0 + $1}
      case "-":
        operateWithTowOperands {$0 - $1}
      case "/":
        operateWithTowOperands {$0 / $1}
      case "x":
        operateWithTowOperands {$0 * $1}
      default:
        break
      }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
}

