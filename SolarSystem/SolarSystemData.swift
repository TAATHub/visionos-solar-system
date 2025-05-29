import Foundation
import RealityKit

/// 天体の情報を格納する構造体
struct CelestialBody {
    let name: String
    let radius: Float // 太陽を基準とした相対サイズ
    let orbitRadius: Float // 太陽からの距離（AU単位を基に調整）
    let orbitPeriod: Float // 地球を1.0とした相対的な公転周期
    let rotationPeriod: Float // 自転周期（時間）
    let axialTilt: Float // 軸の傾斜（度）
    let color: SIMD3<Float> // RGB色
}

/// 太陽系の天体データ
struct SolarSystemData {
    static let earthOrbitPeriod: Float = 10.0 // 地球の公転周期を1秒に設定
    static let earthRotationPeriod: Float = 1.0 // 地球の自転周期を0.1秒に設定
    
    static let celestialBodies: [CelestialBody] = [
        // 太陽
        CelestialBody(
            name: "Sun",
            radius: 1.0,
            orbitRadius: 0.0,
            orbitPeriod: 0.0,
            rotationPeriod: earthRotationPeriod * 25.4, // 太陽の自転周期：約25.4日
            axialTilt: 7.25,
            color: SIMD3<Float>(1.0, 0.8, 0.0) // 黄色
        ),
        
        // 水星
        CelestialBody(
            name: "Mercury",
            radius: 0.383,
            orbitRadius: 1.5,
            orbitPeriod: earthOrbitPeriod * 0.24,
            rotationPeriod: earthRotationPeriod * 58.6,
            axialTilt: 0.03,
            color: SIMD3<Float>(0.7, 0.7, 0.7) // グレー
        ),
        
        // 金星
        CelestialBody(
            name: "Venus",
            radius: 0.949,
            orbitRadius: 2.0,
            orbitPeriod: earthOrbitPeriod * 0.62,
            rotationPeriod: earthRotationPeriod * 243.0,
            axialTilt: 177.4,
            color: SIMD3<Float>(1.0, 0.8, 0.4) // 淡い黄色
        ),
        
        // 地球
        CelestialBody(
            name: "Earth",
            radius: 1.0,
            orbitRadius: 2.5,
            orbitPeriod: earthOrbitPeriod,
            rotationPeriod: earthRotationPeriod,
            axialTilt: 23.4,
            color: SIMD3<Float>(0.2, 0.5, 1.0) // 青
        ),
        
        // 火星
        CelestialBody(
            name: "Mars",
            radius: 0.532,
            orbitRadius: 3.0,
            orbitPeriod: earthOrbitPeriod * 1.88,
            rotationPeriod: earthRotationPeriod * 1.03,
            axialTilt: 25.2,
            color: SIMD3<Float>(0.8, 0.3, 0.1) // 赤
        ),
        
        // 木星
        CelestialBody(
            name: "Jupiter",
            radius: 11.21,
            orbitRadius: 4.5,
            orbitPeriod: earthOrbitPeriod * 11.86,
            rotationPeriod: earthRotationPeriod * 0.41,
            axialTilt: 3.1,
            color: SIMD3<Float>(0.9, 0.7, 0.4) // オレンジ茶色
        ),
        
        // 土星
        CelestialBody(
            name: "Saturn",
            radius: 9.45,
            orbitRadius: 6.0,
            orbitPeriod: earthOrbitPeriod * 29.46,
            rotationPeriod: earthRotationPeriod * 0.45,
            axialTilt: 26.7,
            color: SIMD3<Float>(0.9, 0.9, 0.7) // 淡い黄色
        ),
        
        // 天王星
        CelestialBody(
            name: "Uranus",
            radius: 4.01,
            orbitRadius: 7.5,
            orbitPeriod: earthOrbitPeriod * 84.01,
            rotationPeriod: earthRotationPeriod * 0.72,
            axialTilt: 97.8,
            color: SIMD3<Float>(0.4, 0.8, 0.9) // 青緑
        ),
        
        // 海王星
        CelestialBody(
            name: "Neptune",
            radius: 3.88,
            orbitRadius: 9.0,
            orbitPeriod: earthOrbitPeriod * 164.8,
            rotationPeriod: earthRotationPeriod * 0.67,
            axialTilt: 28.3,
            color: SIMD3<Float>(0.2, 0.3, 0.9) // 濃い青
        )
    ]
} 
