module.exports = {
    /**
     * Application configuration section
     * http://pm2.keymetrics.io/docs/usage/application-declaration/
     */
    apps : [
        {
            name            : "SERVER",
            script          : "./app.js",
            watch           : true,
            ignore_watch    : ["node_modules"],
            env: {
                "NODE_ENV": "development"
            },
            env_production : {
                "NODE_ENV": "production"
            }
        }
    ]
};
