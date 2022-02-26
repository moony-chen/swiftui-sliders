import SwiftUI

public struct ValueSlider: View {
    @Environment(\.valueSliderStyle) private var style
    @State private var dragOffset: CGFloat?
    @State private var pressed: Bool = false
    
    private var configuration: ValueSliderStyleConfiguration
    
    public var body: some View {
        self.style.makeBody(configuration:
            self.configuration.with(
              dragOffset: self.$dragOffset,
              pressed: self.$pressed
            )
        )
    }
}

extension ValueSlider {
    init(_ configuration: ValueSliderStyleConfiguration) {
        self.configuration = configuration
    }
}

extension ValueSlider {
  public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, showThumb: Bool = true, onEditingChanged: @escaping (V?) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        
        self.init(
            ValueSliderStyleConfiguration(
                value: Binding(get: { CGFloat(value.wrappedValue) }, set: { value.wrappedValue = V($0) }),
                bounds: CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound),
                step: CGFloat(step),
                onEditingChanged: { editingValue in onEditingChanged(editingValue.map(V.init)) },
                dragOffset: .constant(0),
                pressed: .constant(false),
                showThumb: showThumb
            )
        )
    }
}

extension ValueSlider {
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 1, showThumb: Bool = true, onEditingChanged: @escaping (V?) -> Void = { _ in }) where V : BinaryInteger, V.Stride : BinaryInteger {
        self.init(
            ValueSliderStyleConfiguration(
                value: Binding(get: { CGFloat(value.wrappedValue) }, set: { value.wrappedValue = V($0) }),
                bounds: CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound),
                step: CGFloat(step),
                onEditingChanged: { editingValue in onEditingChanged(editingValue.map(V.init)) },
                dragOffset: .constant(0),
                pressed: .constant(false),
                showThumb: showThumb
            )
        )
    }
}
