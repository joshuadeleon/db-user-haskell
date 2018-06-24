module Main where

import Data.ByteString as B
import qualified Data.Configurator as C
import qualified Data.Configurator.Types as CT
import qualified Data.Text as T
import qualified Data.Text.Encoding as E
import Database.PostgreSQL.Simple
import GHC.Generics
import System.IO

-- | File path of the application configuration
configPath :: FilePath
configPath = "app.config"

-- | Loads the application configuration into memory
appConfig :: IO AppConfig
appConfig = do
  config <- C.load [C.Required configPath]
  chost <- C.lookupDefault "" config "host" :: IO (T.Text)
  cport <- C.lookupDefault "" config "port" :: IO (T.Text)
  cdatabase <- C.lookupDefault "" config "database" :: IO (T.Text)
  cusername <- C.lookupDefault "" config "username" :: IO (T.Text)
  cpassword <- C.lookupDefault "" config "password" :: IO (T.Text)
  return (AppConfig chost cport cdatabase cusername cpassword)

-- | The postgres database connection
db :: IO Connection
db = connectPostgreSQL =<< E.encodeUtf8 <$> connectionString <$> appConfig

-- | Creates a postgres database connection string
connectionString :: AppConfig -> T.Text
connectionString config =
  T.concat
    [ "sslmode=require host="
    , host config
    , " dbname="
    , database config
    , " user="
    , user config
    , " password="
    , password config
    ]

-- | Applicaiton configuration
data AppConfig
  = Blank
  | AppConfig { host :: T.Text
              , port :: T.Text
              , database :: T.Text
              , user :: T.Text
              , password :: T.Text }
  deriving (Show)

-- | User Entity
data User = User
  { id :: Int
  , firstname :: T.Text
  , lastname :: T.Text
  , username :: T.Text
  , email :: T.Text
  } deriving (Show, Generic)

first5user :: Connection -> IO [User]
first5user db =
  query_
    db
    "SELECT id, firstname, lastname, username, email FROM public.user LIMIT 5"

get5user :: IO [User]
get5user = first5user =<< db

instance FromRow User

main :: IO ()
main = print =<< get5user
