[![CI](https://github.com/kamiyuzu/twitch_api_scraper/workflows/CI/badge.svg)](https://github.com/kamiyuzu/twitch_api_scraper/actions/workflows/elixir.yml/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/kamiyuzu/twitch_api_scraper/badge.svg?branch=main)](https://coveralls.io/github/kamiyuzu/twitch_api_scraper?branch=main)

# TwitchApiScraper

This projects scrapes the website for the [Twitch API](https://dev.twitch.tv/docs/api/reference). The project provides a json with a more human readable interface. API library creators can get all the methods and models without having to write them all manually.

Also this helps the developers to update their libraries to the last Twitch API easily!

## Local development environment

- Install elixir/erlang using `asdf`

Information to install asdf can be found [here](https://github.com/asdf-vm/asdf)

```bash
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
```

```bash
asdf install
```

or install Erlang and Elixir on your machine.

## API JSON

In this repository you can find two JSON files being exported:

- Minimum JSON: [https://raw.githubusercontent.com/kamiyuzu/twitch_api_scraper/master/lib/fixtures/json/twitch_api.json](https://raw.githubusercontent.com/kamiyuzu/twitch_api_scraper/master/lib/fixtures/json/twitch_api.json)
  This json is the least bytes possible, perfect to be consumed by the libraries.

- Pretty JSON: [https://raw.githubusercontent.com/kamiyuzu/twitch_api_scraper/master/lib/fixtures/json/twitch_api_pretty.json](https://raw.githubusercontent.com/kamiyuzu/twitch_api_scraper/master/lib/fixtures/json/twitch_api_pretty.json)
  This json is the same as the minimum json, but prettify, so a human can read it better 😄

Also, you can navigate in the json with some viewer, for example: [http://jsonviewer.stack.hu/](http://jsonviewer.stack.hu/)

## Understand the JSON

The JSON have three root fields: `id`, `doc` and `request`, each of this are a list with the defined data, let's see what can have every one of this.

### id

This field stores the id which the [Twitch API](https://dev.twitch.tv/docs/api/reference) references inside its HTML attributes.

### doc

This field provides the information which the [Twitch API](https://dev.twitch.tv/docs/api/reference) gives as example for the [Twitch API](https://dev.twitch.tv/docs/api/reference) requests.

### request

This last field stores all the required information from the [Twitch API](https://dev.twitch.tv/docs/api/reference) for making the actual request.

## Development

This project is written in Elixir and uses Floki as HTML parser to extract the Twitch API information.

All contributions are welcome, if you make a PR and changes some bug or add a feature that changes the final JSON, remember to execute the script `./export.sh` to generate the new JSON files.

## Authors

* **Alberto Revuelta Arribas** - *initial work* [kamiyuzu](https://github.com/kamiyuzu)

## License

* This project is licensed under the License - see the [LICENSE.md](LICENSE.md) file for details.

