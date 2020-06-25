let apiRoot='http://127.0.0.10:1080/Home/'
// http://127.0.0.10:1080/Home/Login/getCode
let api={
	user:{
		getCode:apiRoot+"Login/getCode",
		register:apiRoot+"Login/register",
		login:apiRoot+"Login/login"
	}
}
export default api;