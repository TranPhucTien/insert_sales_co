## Project setup

1. Clone this repo

```
git clone https://github.com/TranPhucTien/insert_sales_co.git
```

2. Environment variables setup

```
# Go to `.env` file

# The port you want to start the server, for ex: 5000, 5555, 5050, 8080,... (Default: 5001)
PORT=<your-port>

# Your host
DB_HOST=localhost

# Your user (Default user of mysql: root)
DB_USER=<database_user>

# Your password (Default password of mysql: "" <blank>)
DB_PASSWORD=<database_password>

# Your database name
DB_NAME=<database_name>
```

3. Install all dependencies

```
# Goto the `insert_sales_co` directory
cd insert_sales_co

# Install all dependencies
npm i
```

4. Run project

```
# Run project
npm start
> ⚡️[server]: Server is running at 5000

# Goto the /src/index.js, uncomment `insert*` functions. And `Ctrl S to run`
# Note: Run only one function each time
```
