require 'httpbl'
RflUrlShortener::Application.config.middleware.use HttpBL, api_key: HTTPBL_CONFIG['api_key'],
    deny_types: [1, 2, 4], thread_level_threshold: 0, age_threshold: 30,
    blocked_search_engines: [0], memcached_server: "127.0.0.1:11211",
    memcached_options: {namespace: 'rflurlshortener'}
