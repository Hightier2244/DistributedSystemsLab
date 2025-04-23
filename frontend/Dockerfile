FROM ruby:3.4.2

# Setze das Arbeitsverzeichnis
WORKDIR /app

# Kopiere das Gemfile und die Lock-Datei
COPY Gemfile Gemfile.lock ./

# Installiere die Abhängigkeiten
RUN bundle install

# Kopiere den gesamten Projektcode
COPY . .

# Exponiere den Port für den Frontend-Server
EXPOSE 4000

# Startbefehl für den Frontend-Server
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "4000"]