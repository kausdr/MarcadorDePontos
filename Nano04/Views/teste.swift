import SwiftUI

struct teste: View {
    let items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10", "Item 10", "Item 10", "Item 10", "Item 10"]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 50), spacing: 16),
                GridItem(.adaptive(minimum: 50), spacing: 16),
                GridItem(.adaptive(minimum: 50), spacing: 16)
            ], spacing: 16) {
                ForEach(0..<items.count, id: \.self) { index in
                    if index % 5 == 0 && index != 0 {
                        Spacer() // Add a spacer to move to the next column
                    }
                    Text(items[index])
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .background(Color.blue) // Optional background color for visibility
                }
            }
            .padding()
        }
    }
}

struct teste_Previews: PreviewProvider {
    static var previews: some View {
        teste()
    }
}
