/*
 * @Date: 2022-08-25 14:43:53
 * @LastEditors: StavinLi 495727881@qq.com
 * @LastEditTime: 2022-09-21 14:37:02
 * @FilePath: /Workflow-Vue3/src/plugins/axios.js
 */
"use strict";

import axios from "axios";

// Full config:  https://github.com/axios/axios#request-config
// axios.defaults.baseURL = process.env.baseURL || process.env.apiUrl || '';
// axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;
// axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
let config = {
    baseURL: import.meta.env.MODE == 'production' ? (window.location.origin + window.location.pathname + "api/v1") : (import.meta.env.VITE_PUBLIC_URL + "/api/v1"),
    timeout: 60 * 1000, // Timeout
    withCredentials: false, // Check cross-site Access-Control
};

const _axios = axios.create(config);

_axios.interceptors.request.use(
    function (config) {
        if (sessionStorage.token) {
            config.headers['token'] = sessionStorage.token;
        }
        return config;
    },
    function (error) {
        // Do something with request error
        return Promise.reject(error);
    }
);

// Add a response interceptor
_axios.interceptors.response.use(
    function (response) {
        // Do something with response data
        return response.data;
    },
    function (error) {
        // Do something with response error
        return Promise.reject(error);
    }
);

export default _axios;
