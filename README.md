# db-user-haskell

Haskell practice: Command line database tool. 

**Work in progress**

## Configuration file
You must have a configuration file named `app.config` with all the information to connect to a PostgreSQL database. The format of the contents is simple is appears below:

```
# Application configuration file
host = "<host name>"
database = "<database name>"
port = "<port number>"
username = "<user name>"
password = "<password>"
```

## Database files
Script files for the database for contained in the `db` folder. `db_tables.sql` creates a `User` table. `db_seed.sql` seeds the table with realistic mock data.

### Notes

It's probably you will need to have PostgreSQL installed to build. `pg_config` is a requirement for the build.