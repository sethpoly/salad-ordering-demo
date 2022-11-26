import SwiftUI

struct Tappable: ViewModifier {
    @State private var tap = false
    let onTap: () -> Void
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(tap ? 1.05 : 1)
            .contentShape(Rectangle())
            .onTapGesture {
                tap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.4, dampingFraction: 1)) {
                        tap = false
                    }
                }
                onTap()
            }
    }
}
