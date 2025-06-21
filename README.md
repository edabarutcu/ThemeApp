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

## Teknolojiler

- SwiftUI
- Combine
- AuthenticationServices (Apple Sign In)
- Core Data (gelecek)


## Mimari

Proje VIPER (View-Interactor-Presenter-Entity-Router) mimarisi kullanır:

- **View**: UI bileşenleri
- **Interactor**: İş mantığı
- **Presenter**: View-Interactor arası köprü
- **Router**: Navigasyon
- **Entity**: Veri modelleri
