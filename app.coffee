# Module dependencies.
express = require 'express'
routes = require './routes'
api = require './routes/api'
http = require 'http'
path = require 'path'

app = express()

# all environments
app.set 'port', process.env.PORT || 3000
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon('public/favicon.ico')
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static path.join __dirname, 'public'

# development only
if 'development' == app.get 'env'
  app.use express.errorHandler()

app.get '/partials/:page', routes.partials

for resource in api.resources
    resource.resourceForApp app

app.get '*', routes.index


http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')
