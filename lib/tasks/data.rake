namespace :data do
  desc "Fill in missing api_keys.secret"
  task backfill_secrets: :environment do
    ApiKey.where(secret: nil).find_each do |key|
      key.update secret: SecureRandom.hex(24)
    end
  end

  desc "Generate a bunch of fake gameplay data"
  task seed_gameplay: :environment do
    games = Game.limit(2)
    machines = ArcadeMachine.where(id: [3,6])

    plays = (7.days.ago.to_date..Date.today).map do |date|
      sessions = rand(10)

      sessions.times.map do

        start = date.to_time + rand(60 * 60 * 23).seconds
        stop  = start + (rand(20) + 1).minutes

        Play.create! game: games.sample,
           arcade_machine: machines.sample,
                    start: start,
                     stop: stop

      end
    end

  end
end
