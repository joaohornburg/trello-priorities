# trello-priorities

Takes all cards in a Trello list and prefixes them with their position in that list.

Before

![image](https://cloud.githubusercontent.com/assets/343670/25106307/238f4426-239f-11e7-9765-08c2964ae343.png)

After

![image](https://cloud.githubusercontent.com/assets/343670/25106357/739c3366-239f-11e7-9291-2547e048801b.png)

## how to use it

Make sure you have Ruby and Bundler installed on your machine.

Install dependencies:

```shell
bundle install
```

Run it:

```shell
bundle exec ruby trello_priorities.rb
```

### how to change stored config

TrelloPriorities stores auth credentials and board_id in `config.yml`.

Best way to change boardId is to edit it in `config.yml`.

If you need to regenerate your authentication credentials, simply delete `config.yml` before runnuing trello_priorities.
