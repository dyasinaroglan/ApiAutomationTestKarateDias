function fn() {
    var env = karate.env; // get system property 'karate.env'
    karate.log('karate.env system property was:', env);
    if (!env) {
        env = 'dev';
    }
    var config = {
        env: env,
        baseApiUrl : 'https://restful-booker.herokuapp.com',
        username : 'admin',
        password : 'password123',

        autHeader : 'Basic YWRtaW46cGFzc3dvcmQxMjM='
    }
    if (env == 'dev') {
        // customize
        // e.g. config.foo = 'bar';
    } else if (env == 'e2e') {
        // customize
    }
    return config;
}