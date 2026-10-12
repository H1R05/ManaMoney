import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @State private var income = 0
    @State private var expenses = 0

    var balance: Int {
        income - expenses
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
        }
    }
}
#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
