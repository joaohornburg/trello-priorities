# trello-priorities
Takes all cards in a Trello list and prefixes them with their position in that list

# how to use it

Make sure you have ruby installed on your machine.

Install dependencies:

```shell
bundle install
```

Run it:

```shell
bundle exec ruby trello_priorities.rb
```

## how to change stored config

TrelloPriorities stores auth credentials and board_id in `config.yml`.

Best way to change boardId is to edit it in `config.yml`.

If you need to regenerate your authentication credentials, simply delete `config.yml` before runnuing trello_priorities.
