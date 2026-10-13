import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @State private var income = 0
    @State private var expenses = 0
    
    @State private var amountInput = ""

    var balance: Int {
        income - expenses
    }
    
    func registerTransaction(isIncome: Bool) {
        if let number = Int(amountInput), number > 0 {
            if isIncome == true {
                income += number
            }else {
                expenses += number
            }
            amountInput = ""
        }
    }
    
    let mainAccount = Account(
        id: UUID(),
        name: "Conto principale",
        type: .checking,
        currencyCode: "EUR",
        openingBalanceCents: 125050
    )
    
    let prepaidAccount = Account(
        id: UUID(),
        name: "Carta Prepagata",
        type: .prepaidCard,
        currencyCode: "EUR",
        openingBalanceCents: 8575
    )
    
    var accounts: [Account] {
        [mainAccount ,prepaidAccount]
    }


    
    var body: some View {
        VStack (spacing: 12) {
            
            Text("ManaMoney")
                .font(.largeTitle)
                .bold()
            Text("L'app per le finanze personali")
                .italic()
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text("Saldo Disponibile:")
            Text("\(balance)")
                .bold()
            
            HStack {
                Text("Entrate")
                Text("\(income)")
                    .foregroundStyle(.green)
                Spacer()
                Button("+50") {
                    income += 50
                }
                
            }
            HStack {
                Text("Uscite")
                Text("\(expenses)")
                    .foregroundStyle(.red)
                Spacer()
                Button("+25") {
                    expenses += 25
                }
            }
                TextField("Inserisci importo", text: $amountInput)
                    .keyboardType(.numberPad)
            HStack {
                
                Button("Registra entrata") {
                    registerTransaction(isIncome: true)
                    print(accounts.count)
                }
            
                Button("Registra uscita") {
                    registerTransaction(isIncome: false)
                }
            }
         }
    }
}
#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
