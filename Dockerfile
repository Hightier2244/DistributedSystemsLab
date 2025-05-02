FROM ruby:3.4.2

# Setze das Arbeitsverzeichnis
WORKDIR /app

# Kopiere das Gemfile und die Lock-Datei
COPY Gemfile Gemfile.lock ./

# Installiere die Abhängigkeiten
RUN bundle install

# Kopiere den gesamten Projektcode
COPY . .

# Exponiere den Port für den Backend-Server
EXPOSE 3000

# Startbefehl für den Backend-Server
CMD ["sh", "-c", "rails db:create db:migrate && rails server -b 0.0.0.0 -p 3000"]