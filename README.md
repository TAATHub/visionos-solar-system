# Solar System VR

A immersive solar system exploration app built for Apple Vision Pro using RealityKit and SwiftUI.

## Demo Video

[![Solar System VR Demo](https://img.shields.io/badge/Demo-Video-blue)](https://drive.google.com/file/d/1a0lbPCwFUPL1qoG5rxmv61nrmJKsPYLy/view?usp=sharing)

[🎥 Watch Demo Video](https://drive.google.com/file/d/1a0lbPCwFUPL1qoG5rxmv61nrmJKsPYLy/view?usp=sharing)

## Features

### 🌌 Immersive Solar System Experience
- Full-scale 3D solar system with realistic planetary positions
- Interactive celestial bodies with detailed information in Japanese
- Immersive space mode with Milky Way skybox
- Mixed reality mode for AR experience

### 🪐 Interactive Planets
- Tap any planet to view detailed information
- Real-time planetary rotation and orbital motion
- Accurate scale representation with enhanced visibility
- Saturn with authentic ring system

### ⚙️ Customizable Settings
- Toggle between Mixed and Full immersion modes
- Show/hide orbital paths
- Intuitive settings interface

### 🎯 Technical Features
- Built with RealityKit's Entity Component System (ECS)
- Custom OrbitSystem for realistic planetary motion
- RotationSystem for authentic celestial body rotation
- Efficient collision detection for touch interaction

## Architecture

### ECS Components
- **OrbitComponent**: Handles planetary orbital mechanics
- **RotationComponent**: Manages celestial body rotation
- **InputTargetComponent**: Enables touch interaction

### ECS Systems
- **OrbitSystem**: Updates planetary positions along their orbits
- **RotationSystem**: Handles rotation of celestial bodies

### Key Classes
- **SolarSystemModel**: Core model managing the solar system entities
- **SolarSystemData**: Contains astronomical data for all celestial bodies
- **AppModel**: Application state management

## Requirements

- Apple Vision Pro
- visionOS 1.0+
- Xcode 15.0+
- Swift 5.9+

## Getting Started

1. Clone the repository
2. Open `SolarSystem.xcodeproj` in Xcode
3. Build and run on Apple Vision Pro or Vision Pro Simulator

## Project Structure

```
SolarSystem/
├── SolarSystemApp.swift          # Main app entry point
├── ContentView.swift             # Main window interface
├── ImmersiveView.swift           # VR immersive experience
├── SolarSystemModel.swift        # Core solar system logic
├── SolarSystemData.swift         # Astronomical data
├── OrbitSystem.swift            # ECS orbital motion system
├── RotationSystem.swift         # ECS rotation system
├── OrbitComponent.swift         # Orbital mechanics component
├── RotationComponent.swift      # Rotation component
├── Entity+Extension.swift       # RealityKit entity extensions
├── SettingsView.swift           # Settings interface
├── AppModel.swift               # Application state
└── Assets.xcassets/             # 3D textures and assets
```

## Technologies Used

- **RealityKit**: 3D rendering and physics simulation
- **SwiftUI**: User interface framework
- **visionOS**: Apple's mixed reality platform
- **Entity Component System**: Modular architecture pattern

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE). 