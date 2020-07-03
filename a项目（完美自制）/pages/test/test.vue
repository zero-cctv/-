<template>
	<view>
		<!-- {{this.uid}} -->
		
	
		<button @click="getUser()"></button>
			{{this.data}}
	</view>
</template>

<script>

  
	var __self;
	
  export default {
 
    data() {
      return {
		  username:"",
		  userID:"",
		  uid:"",
		  data:"",
		  icon:""
	  };
    },
	onShow:function() {
		
			 uni.startPullDownRefresh({});
		/*从本地缓存中获取uid*/		            			
						// __self.uid=__self.$getStorage("uid").toString();
						// __self.userID="uid:"+__self.uid.substr(0,5);
						// __self.username=__self.$getStorage("username");
						// __self.icon=__self.$getStorage("icon");

		      //            uni.removeStorage({key: 'uid'});
						  // uni.removeStorage({key: 'username'});
		      
	},
	onLoad:function(){
		__self=this;
	},	
	onPullDownRefresh() {
	       //监听下拉刷新动作的执行方法，每次手动下拉刷新都会执行一次
	       console.log('refresh');
		   __self.uid=__self.$getStorage("uid").toString();
 		 
			// __self.getUser();
	       setTimeout(function () {
	           uni.stopPullDownRefresh();  //停止下拉刷新动画
	       }, 500);
	   },
    methods: {
		sendGurl(surl, str,p) {
				uni.request({
					url: surl,
					method: 'GET',
					data: p,
					success: res => {
						console.log('发送网址:' + surl);
						this.data = res;
						
					},
					fail: () => {
						console.log('this is fail');
					},
					complete: () => {
						this.requestafter(str);
					}
				});
			
		},
		sendPurl(curl, str, p) {
			uni.request({
				url: curl,
				method: 'POST',
				data: p,
				header:{"Content-Type":"application/x-www-form-urlencoded"}, 				
				success: res => {
					console.log('发送网址:' + curl);
					console.log('send:' + p);
					this.data = res;
					
				},
				fail: () => {
					console.log('this is fail');
				},
				complete: () => {
					this.requestafter(str);
				}
			});
		},
		requestafter(str) {
			console.log(this.data);
			if(str=='getUser'){
				uni.showToast({
				    icon: 'none',
					position: 'bottom',
				    title: '获取成功'
				});
				// this.username=this.data.data.username;
				// let str=this.data.data.uid;
				// str=str.toString().substr(0,5);
				// this.userID=str;
				
			}
		},
		
		/*获取用户信息*/
		getUser(){
			this.uid='54119476701aba676f1599aa09101415'
			console.log(this.uid);
			if(this.uid){
				var url=this.$api.user.imglist;
				console.log(url);
				
				var p={'uid':this.uid}
				this.sendGurl(url,'getUser',p);
				
			}
		},

  
    }
  }
</script>

<style>

</style>
