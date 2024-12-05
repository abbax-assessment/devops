'use strict';

exports.handler = async (event) => {
    const request = event.Records[0].cf.request;
    const uri = request.uri;

    // Rewrite requests to index.html if they don't match a file or folder
    if (!uri.match(/\.\w+$/)) {
        request.uri = '/index.html';
    }

    return request;
};