import Vue from 'vue'
import App from './App'
import api from './config/api'
Vue.config.productionTip = false
App.mpType = 'app'
Vue.prototype.$api = api
Vue.prototype.$getStorage = function(key){
var userParam = uni.getStorageSync(key);
if (userParam != null && userParam != "" && userParam!= undefined) {
    return userParam;
}else{
    return null;
}        
}

const app = new Vue({
    ...App
})
app.$mount()
