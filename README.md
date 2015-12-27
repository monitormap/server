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
