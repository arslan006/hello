var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'pubNubios', 'coolMethod', arg0);
};

exports.pubNubHereNowForChannel = function (arg0, success, error) {
    exec(success, error, 'pubNubios', 'pubNubHereNowForChannel', arg0);
};

exports.publishMessage = function (arg0, success, error) {
    exec(success, error, 'pubNubios', 'publishMessage', arg0);
};


