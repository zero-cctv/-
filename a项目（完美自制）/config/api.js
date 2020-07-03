let apiRoot='http://127.0.0.10:1080/Home/'
// let apiRoot='http://192.168.120.1:8080/'
// let apiRoot='http://10.22.43.157:8080/'
// http://127.0.0.10:1080/Home/file/upload
let api={
	user:{
		getCode:apiRoot+"Login/getCode",
		register:apiRoot+"Login/register",
		login:apiRoot+"Login/login",
		info:apiRoot+'Login/getUser',
		upload:apiRoot+'file/upload',
		/*获取name,url,uid*/
		imglist:apiRoot+'file/imgshow'
	}
}
export default api;