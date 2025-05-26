import SwiftUI

struct ContentView: View {
    @State private var timeElapsed: TimeInterval = 0
    @State private var timerRunning = false
    @State private var lastResultIsEven = false
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 40) {
            ZStack(alignment: .topTrailing) {
                Text(timeString(timeElapsed))
                    .font(.system(size: 64, weight: .bold, design: .monospaced))
                    .padding()
                if lastResultIsEven {
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 10, height: 10)
                        .offset(x: -10, y: 10)
                        .accessibilityLabel("Even result indicator")
                }
            }

            HStack(spacing: 40) {
                Button(timerRunning ? "Stop" : "Start") {
                    timerRunning.toggle()
                    if !timerRunning {
                        lastResultIsEven = Int(timeElapsed * 100) % 2 == 0
                    }
                }
                .font(.title2)
                .frame(width: 100, height: 50)
                .background(timerRunning ? Color.red : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("Reset") {
                    timeElapsed = 0
                    lastResultIsEven = false
                    timerRunning = false
                }
                .font(.title2)
                .frame(width: 100, height: 50)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .onReceive(timer) { _ in
            if timerRunning {
                timeElapsed += 0.01
            }
        }
    }

    func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time - floor(time)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}