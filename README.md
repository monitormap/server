# README

## Requirement
- Postgresql
- Node (with npm)

### Postgresql - Database
##### Install Postgresql
```
sudo apt-get install postgresql
sudo systemctl start postgresql
sudo systemctl enable postgresql
```
##### Create Database
```
sudo -u postgres -H createdb monitormap
```
## Installation

### For Development

```bash
npm install;
ln -s config_example.json config.json;
cd tests;
ln -s config_example.json config.json;
```

### For Productive


```bash
npm install --production;
cp config_example.json config.json;
```

Edit `config.json`

## Run

```bash
npm start
```

## API-Tests

```bash
npm test
```

# Pushdaemon

## alfred
Install as cronjob:
```
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
*/3 * * * * root /root/monitorMap/node_modules/.bin/coffee/root/monitorMap/pushdaemon/alfred.coffee

```
