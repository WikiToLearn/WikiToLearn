// for mw-ocg-service
module.exports = function(config) {
  // change the port here if you are running parsoid on a different port
  config.backend.bundler.parsoid_api = "http://localhost:8000";
  // the prefix here should match $wgDBname in your LocalSettings.php
  config.backend.bundler.parsoid_prefix = "localhost";
  // Use the Parsoid "v1" API
  // config.backend.bundler.additionalArgs = [ '--api-version=parsoid1' ];
}
