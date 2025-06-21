# ThemeApp

Tema satın alma ve yönetme uygulaması. Kullanıcılar tema satın alabilir, widget'ları yönetebilir ve kişiselleştirilmiş deneyimler yaşayabilir.

## Özellikler

- 🎨 Tema marketi
- 📱 Widget yönetimi
- 👤 Kullanıcı profili
- 🛒 Satın alınan temalar
- 🌍 Çoklu dil desteği (Türkçe/İngilizce)

## Localization (Çoklu Dil Desteği)

Uygulama otomatik olarak telefon bölgesine göre dil seçimi yapar:

- **Türkiye (TR)**: Türkçe
- **Diğer bölgeler**: İngilizce

### Desteklenen Diller

- 🇹🇷 Türkçe (tr)
- 🇺🇸 İngilizce (en)

### Localization Dosyaları

- `ThemeApp-/Resources/tr.lproj/Localizable.strings` - Türkçe çeviriler
- `ThemeApp-/Resources/en.lproj/Localizable.strings` - İngilizce çeviriler
- `ThemeApp-/Common/Utils/LocalizationHelper.swift` - Localization helper sınıfı
- `ThemeApp-/Common/Utils/LocalizationKeys.swift` - Type-safe localization keys

### Kullanım (Enum-based System)

```swift
// Type-safe kullanım (Önerilen)
Text(L10n.Navigation.market.localized)
Text(L10n.Auth.signInWithApple.localized)
Text(L10n.Theme.buy.localized)

// Format ile kullanım
Text("\(count) \(L10n.Widget.widgetSelected.localized)")

// Eski string-based kullanım (Hala destekleniyor)
Text("market_title".localized)
```

### Localization Keys Yapısı

```swift
enum L10n {
    enum Navigation {
        static let market = "market_title"
        static let purchased = "purchased_title"
        static let profile = "profile_title"
    }
    
    enum Auth {
        static let signInWithApple = "sign_in_with_apple"
        static let signOut = "sign_out"
        // ...
    }
    
    enum Theme {
        static let buy = "buy"
        static let preview = "preview"
        // ...
    }
    
    // ... diğer kategoriler
}
```

### Avantajlar

✅ **Type-safe**: Compile-time error checking  
✅ **IntelliSense**: Xcode otomatik tamamlama  
✅ **Refactoring**: Güvenli yeniden adlandırma  
✅ **Organized**: Kategorilere ayrılmış keys  
✅ **Maintainable**: Kolay bakım  

## Teknolojiler

- SwiftUI
- Combine
- AuthenticationServices (Apple Sign In)
- Core Data (gelecek)

## Kurulum

1. Projeyi klonlayın
2. Xcode'da açın
3. Gerekli bağımlılıkları yükleyin
4. Build edin ve çalıştırın

## Mimari

Proje VIPER (View-Interactor-Presenter-Entity-Router) mimarisi kullanır:

- **View**: UI bileşenleri
- **Interactor**: İş mantığı
- **Presenter**: View-Interactor arası köprü
- **Router**: Navigasyon
- **Entity**: Veri modelleri

## Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit edin (`git commit -m 'Add amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır.
