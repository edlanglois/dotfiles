#!/usr/bin/env python
"""Get the OpenWeatherMap API ID of a city."""

import argparse
import configparser
import itertools
import json
import os.path
import sys
import urllib.parse
import urllib.request


def parse_args():
    """Parse command-line arguments.

    Returns:
        An `argparse.Namespace` object containing the parsed arguments.
    """
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('name', nargs='+', help=(
        'City name for lookup. Optionally include state/province and country.'
    ))
    parser.add_argument(
        '-c', '--config', type=str,
        default=None,
        help=('Configurtion file containing OpenWeatherMap API key. '
              'Defaults to user.cfg.'))
    parser.add_argument(
        '-k', '--key', type=str,
        help=('OpenWeatherMap API key. '
              'Read from the user config file if not specified.'))

    return parser.parse_args()


def main():
    args = parse_args()
    name = ' '.join(args.name)

    if args.key is not None:
        key = args.key
    else:
        if args.config is not None:
            config_file_name = args.config
        else:
            config_file_name = os.path.join(
                os.path.dirname(os.path.dirname(os.path.realpath(__file__))),
                'user.cfg')

        config_parser = configparser.ConfigParser()
        with open(config_file_name, 'r') as lines:
            lines = itertools.chain(('[main]\n',), lines)
            config_parser.read_file(lines)

        KEY_NAME = 'OPEN_WEATHER_MAP_API_KEY'
        try:
            key = config_parser['main'][KEY_NAME]
        except KeyError:
            sys.exit('Could not find key {} in file {}'.format(
                KEY_NAME, config_file_name))

    url = 'https://api.openweathermap.org/data/2.5/weather'
    values = {'q': name, 'appid': key}
    full_url = '{}?{}'.format(url, urllib.parse.urlencode(values))
    try:
        with urllib.request.urlopen(full_url) as f:
            response = json.load(f)
    except urllib.error.HTTPError as e:
        if e.code == 404:
            sys.exit('No city found matching "{}"'.format(name))
        elif e.code == 401:
            sys.exit('Unauthorized with API key "{}"'.format(key))
        else:
            raise

    row_fmt = '{city:<15s} {country:<7s} {id_:}'
    print(row_fmt.format(city='City', country='Country', id_='ID'))
    print(row_fmt.format(city=response['name'],
                         country=response['sys']['country'],
                         id_=response['id']))


if __name__ == '__main__':
    main()
