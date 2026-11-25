import SwiftUI

private enum AppTheme {
    static let background = Color(red: 0.035, green: 0.045, blue: 0.075)
    static let card = Color(red: 0.075, green: 0.09, blue: 0.13)
    static let accent = Color(red: 0.25, green: 0.95, blue: 0.72)
    static let muted = Color(red: 0.58, green: 0.64, blue: 0.73)
}

struct ContentView: View {
    @AppStorage("playerName") private var playerName = "Yordan"
    @AppStorage("cameraSensitivity") private var cameraSensitivity = 68.0
    @AppStorage("aimSensitivity") private var aimSensitivity = 54.0
    @AppStorage("highContrast") private var highContrast = false
    @AppStorage("reduceMotion") private var reduceMotion = true
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    header
                    profileCard
                    if selectedTab == 0 {
                        sensitivityCard
                        appearanceCard
                    } else {
                        aboutCard
                    }
                    footer
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 28)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) { tabBar }
        .tint(AppTheme.accent)
    }

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 5) {
                Text("YORDAN MODZ")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .tracking(2.4)
                    .foregroundStyle(AppTheme.accent)
                Text(selectedTab == 0 ? "Tu panel" : "Acerca de")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            Spacer()
            HStack(spacing: 7) {
                Circle().fill(AppTheme.accent).frame(width: 8, height: 8)
                Text("LISTO")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .tracking(1)
                    .foregroundStyle(AppTheme.accent)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(AppTheme.accent.opacity(0.1), in: Capsule())
            .overlay(Capsule().stroke(AppTheme.accent.opacity(0.25), lineWidth: 1))
        }
    }

    private var profileCard: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 18).fill(AppTheme.accent.opacity(0.14))
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(AppTheme.accent)
            }
            .frame(width: 58, height: 58)
            VStack(alignment: .leading, spacing: 5) {
                Text("PERFIL")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .tracking(1.5)
                    .foregroundStyle(AppTheme.muted)
                TextField("Tu nombre", text: $playerName)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .accessibilityLabel("Nombre del perfil")
            }
            Spacer(minLength: 0)
            Image(systemName: "pencil")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(AppTheme.muted)
        }
        .padding(16)
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 22))
    }

    private var sensitivityCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionHeading("Sensibilidad", subtitle: "Ajustes personales guardados en este iPhone", icon: "slider.horizontal.3")
            sensitivitySlider(title: "Cámara", value: $cameraSensitivity)
            Rectangle().fill(.white.opacity(0.07)).frame(height: 1)
            sensitivitySlider(title: "Mira", value: $aimSensitivity)
            HStack {
                Label("Se guarda automáticamente", systemImage: "checkmark.circle.fill")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(AppTheme.muted)
                Spacer()
                Button("Restablecer") {
                    cameraSensitivity = 68
                    aimSensitivity = 54
                }
                .font(.system(size: 12, weight: .semibold, design: .rounded))
            }
        }
        .padding(18)
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 22))
    }

    private func sensitivitySlider(title: String, value: Binding<Double>) -> some View {
        VStack(spacing: 10) {
            HStack {
                Text(title).font(.system(size: 15, weight: .semibold, design: .rounded)).foregroundStyle(.white)
                Spacer()
                Text("\(Int(value.wrappedValue))")
                    .font(.system(size: 14, weight: .bold, design: .rounded).monospacedDigit())
                    .foregroundStyle(AppTheme.accent)
                    .frame(minWidth: 34, alignment: .trailing)
            }
            Slider(value: value, in: 0...100, step: 1)
                .accessibilityLabel("Sensibilidad de \(title.lowercased())")
        }
    }

    private var appearanceCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeading("Apariencia", subtitle: "Preferencias de esta aplicación", icon: "sparkles")
            preferenceRow(title: "Alto contraste", subtitle: "Resalta textos y elementos", icon: "circle.lefthalf.filled", isOn: $highContrast)
            Rectangle().fill(.white.opacity(0.07)).frame(height: 1)
            preferenceRow(title: "Reducir movimiento", subtitle: "Animaciones más discretas", icon: " მთლიან", isOn: $reduceMotion)
        }
        .padding(18)
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 22))
        .environment(\.accessibilityReduceMotion, reduceMotion)
    }

    private func preferenceRow(title: String, subtitle: String, icon: String, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(AppTheme.accent)
                .frame(width: 34, height: 34)
                .background(AppTheme.accent.opacity(0.1), in: RoundedRectangle(cornerRadius: 11))
            VStack(alignment: .leading, spacing: 3) {
                Text(title).font(.system(size: 14, weight: .semibold, design: .rounded)).foregroundStyle(.white)
                Text(subtitle).font(.system(size: 11, weight: .regular, design: .rounded)).foregroundStyle(AppTheme.muted)
            }
            Spacer()
            Toggle(title, isOn: isOn).labelsHidden().tint(AppTheme.accent)
        }
    }

    private var aboutCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeading("Uso seguro", subtitle: "Configuración independiente", icon: "checkmark.shield")
            Text("Esta app guarda tu perfil, tus valores de sensibilidad personal y preferencias visuales en el dispositivo. No se conecta a juegos ni altera otras aplicaciones.")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(AppTheme.muted)
                .fixedSize(horizontal: false, vertical: true)
            Rectangle().fill(.white.opacity(0.07)).frame(height: 1)
            Label("Datos almacenados localmente", systemImage: "iphone")
                .font(.system(size: 13, weight: .medium, design: .rounded))
                .foregroundStyle(AppTheme.accent)
        }
        .padding(18)
        .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 22))
    }

    private func sectionHeading(_ title: String, subtitle: String, icon: String) -> some View {
        HStack(alignment: .top, spacing: 11) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(AppTheme.accent)
                .frame(width: 36, height: 36)
                .background(AppTheme.accent.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.system(size: 17, weight: .bold, design: .rounded)).foregroundStyle(.white)
                Text(subtitle).font(.system(size: 11, weight: .regular, design: .rounded)).foregroundStyle(AppTheme.muted)
            }
            Spacer(minLength: 0)
        }
    }

    private var footer: some View {
        Text("YORDAN MODZ · CONFIGURACIÓN PERSONAL")
            .font(.system(size: 9, weight: .bold, design: .rounded))
            .tracking(1.3)
            .foregroundStyle(AppTheme.muted.opacity(0.7))
            .frame(maxWidth: .infinity)
            .padding(.top, 2)
    }

    private var tabBar: some View {
        HStack(spacing: 0) {
            tabButton(title: "Panel", icon: "square.grid.2x2.fill", index: 0)
            tabButton(title: "Acerca de", icon: "info.circle", index: 1)
        }
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(AppTheme.background.opacity(0.97))
        .overlay(alignment: .top) { Rectangle().fill(.white.opacity(0.08)).frame(height: 1) }
    }

    private func tabButton(title: String, icon: String, index: Int) -> some View {
        Button { selectedTab = index } label: {
            VStack(spacing: 5) {
                Image(systemName: icon).font(.system(size: 17, weight: .semibold))
                Text(title).font(.system(size: 10, weight: .semibold, design: .rounded))
            }
            .foregroundStyle(selectedTab == index ? AppTheme.accent : AppTheme.muted)
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(selectedTab == index ? .isSelected : [])
    }
}

#Preview {
    ContentView()
}
