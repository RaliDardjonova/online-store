# online-store

## Пускане на приложението

- `bundle install` - инсталира необходимите библиотеки
- `bundle exec rake db:setup` - създава базата от данни и таблиците
- `bundle exec ruby app.rb` - стартиране на development сървър
- `bundle exec rspec` - Пуска автоматизираните тестове
- Админинистратор може да стане потребител само когато друг администратор го напарви такъв.
В базата данни се пази информация за администратор с потребителско име 'admin' и парола 'admin123'.