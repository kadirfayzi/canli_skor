Flutter Case Study Dokümantasyon

Kullanılan State Management Yöntemi Neden Seçildi?

Uygulamada BLoC yöntemi tercih edilmiştir çünkü iş mantığını ekran tasarımından ayırarak kodu düzenli tutar. match_bloc.dart dosyasındaki stream'ler sayesinde API'den gelen canlı skorlar anında ekrana yansıtılır ve BLoC hata ayıklamayı kolaylaştırır.

Provider veya GetX yerine BLoC seçildi çünkü:
* BLoC, Provider’a kıyasla stream tabanlı yapısıyla gerçek zamanlı veri akışlarını (örneğin, her 10 saniyede bir güncellenen maç skorları) çok daha verimli bir şekilde yönetir. Ayrıca, modüler tasarımı sayesinde kodu ölçeklendirmek ve test etmek BLoC ile daha kolaydır, bu da canlı skor gibi dinamik bir uygulamanın gereksinimlerine daha uygundur.
* GetX, hızlı bir çözüm sunsa da bağımlılık artırır ve kodu karmaşıklaştırabilir. BLoC ise stream tabanlı yapısıyla canlı skor gibi dinamik uygulamalarda daha esnek, ölçeklenebilir ve test edilebilir bir çözüm sunar.


Uygulamada Performans Optimizasyonu Nasıl Sağlandı?

Uygulamanın hızlı çalışması için şu adımlar uygulanmıştır:
* Bağımlılık Yönetimi ile Performans: di.dart dosyasında GetIt kütüphanesi kullanılarak bağımlılıklar (dependency injection) optimize edilmiştir. DioClient, StorageService ve ConnectivityService gibi servisler registerLazySingleton ile yalnızca ihtiyaç duyulduğunda oluşturulur, bu da uygulamanın başlangıç süresini hızlandırır ve bellek kullanımını azaltır. MatchBloc, FavoritesBloc ve NetworkCubit gibi BLoC’lar ise registerFactory ile her seferinde yeni bir örnek oluşturulur, bu da gereksiz durum saklamayı önler ve performansı artırır.
* Stream ile Güncelleme: match_bloc.dart’ta stream kullanılarak sadece veri değiştiğinde ekran yenilenir, bu da performansı artırır.
* Lazy Load: home_screen.dart ve favorites_screen.dart’ta ListView.builder ile sadece görünen maç kartları yüklenir, bellek tasarrufu sağlanır.
* Const ile UI Optimizasyonu: Sabit widget’lar (örneğin, AppBar veya metinler) const ile tanımlanarak (home_screen.dart’ta görüldüğü gibi) gereksiz build engellenir.
* IndexedStack ile Sekme Geçişleri: app.dart’ta IndexedStack kullanılarak, her sekme geçişinde widget’ların yeniden oluşturulması (rebuild) önlenmiştir, bu da geçişlerdeki performansı iyileştirir.
* buildWhen ile Gereksiz Yeniden Oluşturma Önleme: favorites_screen.dart ve home_screen.dart’ta BlocBuilder’ın buildWhen özelliği kullanılarak, sadece ilgili durum değiştiğinde (örneğin, favori listesi veya maç verileri değiştiğinde) widget yeniden oluşturulur, bu da gereksiz rebuild’lerden kaçınılmasını sağlar.
