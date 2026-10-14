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
            if isIncome {
                income += number
            }else {
                expenses += number
            }
            amountInput = ""
        }
    }
    
    @State private var accountName = ""
    
    @State private var accounts: [Account] = [
        Account(
            id: UUID(),
            name: "Conto principale",
            type: .checking,
            currencyCode: "EUR",
            openingBalanceCents: 125050
        ),
        Account(
            id: UUID(),
            name: "Carta Prepagata",
            type: .prepaidCard,
            currencyCode: "EUR",
            openingBalanceCents: 8575
        )
    ]
    
    func printAccounts() {
        for account in accounts {
            print(account.name, account.openingBalanceCents)
        }
    }
    
    func formatBalance(cents: Int64) -> String {
        let amount = Decimal(cents) / 100
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.locale = Locale(identifier: "it_IT")
        let number = NSDecimalNumber(decimal: amount)
        if let formatted = formatter.string(from: number) {
            return formatted
        }
        return "\(amount)"
    }
    
    
    var body: some View {
        TabView {
            
            // SCHERMATA HOME
            NavigationStack {
                ScrollView {
                    VStack(spacing: 12) {
                        
                        Text("ManaMoney")
                            .font(.largeTitle)
                            .bold()
                        
                        Text("L'app per le finanze personali")
                            .italic()
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        
                        Text("Conti disponibili: \(accounts.count)")
                        
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
                        
                        TextField(
                            "Inserisci importo",
                            text: $amountInput
                        )
                        .keyboardType(.numberPad)
                        
                        HStack {
                            Button("Registra entrata") {
                                registerTransaction(isIncome: true)
                            }
                            
                            Button("Registra uscita") {
                                registerTransaction(isIncome: false)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            // SCHERMATA CONTI
            NavigationStack {
                List {
                    Section("I tuoi conti") {
                        ForEach(accounts, id: \.id) { account in
                            HStack {
                                Text(account.name)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text(
                                    formatBalance(
                                        cents: account.openingBalanceCents
                                    )
                                )
                            }
                        }
                    }
                    
                    Section("Aggiungi conto") {
                        TextField(
                            "Nome del conto",
                            text: $accountName
                        )
                        
                        Button("Aggiungi Conto") {
                            let trimmedName =
                            accountName.trimmingCharacters(
                                in: .whitespacesAndNewlines
                            )
                            
                            if !trimmedName.isEmpty {
                                let newAccount = Account(
                                    id: UUID(),
                                    name: trimmedName,
                                    type: .cash,
                                    currencyCode: "EUR",
                                    openingBalanceCents: 5000
                                )
                                
                                accounts.append(newAccount)
                                accountName = ""
                            }
                        }
                    }
                }
                .navigationTitle("Conti")
            }
            .tabItem {
                Label("Conti", systemImage: "wallet.pass")
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
