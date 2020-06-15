<template>
	<view class="center">
			<view class="logo" @click="goLogin" :hover-class="!login ? 'logo-hover' : ''">
				<image class="logo-img" :src="login ? uerInfo.avatarUrl :avatarUrl"></image>
				<view class="logo-title">
					<text class="uer-name">Hi，{{login ? uerInfo.name : '您未登录'}}</text>
					<text class="go-login navigat-arrow" v-if="!login">&#xe65e;</text>
				</view>
			</view>
		{{exports}}
		<view v-for="item in respond" :key="item.android_pic" >
			   
			    <view  class="itemsize">
			                    <button class="text-left" v-on:click="titi(item)"><image :src="item.android_pic" class="item_img" mode="aspectFit"></image>{{item.android_text}}</button>
			   </view>
		</view>
		</view>

</template>

<script>
	var __self
	export default {
	data() {
			return {
				exports:"推送",
				login: false,
				avatarUrl: '/static/ico/user.png',
				uerInfo: {},
				respond:[],
				right:true,
				array:{},
				test:'',
			}
		},
		onLoad:function(e) {
			__self=this;
			__self.readurl(e);
		},
		methods: {
			titi:function(e){
				console.log(e);
				uni.showModal({
				    title: '提示',
				    content: "Sorry,I don't know",
				    success: function (res) {
				        if (res.confirm) {
				            console.log('用户点击确定');
				        } else if (res.cancel) {
				            console.log('用户点击取消');
				        }
				    }
				});
			},
			  ios(e) {
			            var UIApplication = plus.ios.import('UIApplication');
			            var NSURL = plus.ios.import('NSURL');
			            var setting = NSURL.URLWithString('weixin://');
			            var application = UIApplication.sharedApplication();
			            application.openURL(setting);
			            plus.ios.deleteObject(setting);
			            plus.ios.deleteObject(application);
			        },
			readurl:function(e){
			
				
				uni.request({
					url:"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.adv.showlist",
					method: 'GET',
					data: {},
					success: res => {
						console.log(res);
						if(res.statusCode!=200){__self.right=false;}
						else{__self.right=true;}
						__self.array=res.data.result;
						console.log(__self.array);
						var i,z;
						z=__self.array.length;
						for(i=0;i<z;i++){
							__self.respond.push(__self.array[i]);
							
						}
						console.log(__self.respond);
						
					},
					fail: () => {
						console.log("this is fail");
						__self.right=false;
					},
				});
			},
			goLogin() {
				if (!this.login) {
					uni.navigateTo({
						url: '/pages/login/login'
					});
				}
			},
			goAbout() {
				uni.navigateTo({
					url: '/pages/about/about'
				});
			}
		}
	}
</script>

<style>
	
	.layout{
		display: flex;
	}
	.itemsize{
		height: 50rpx;
		margin-bottom: 10rpx;
		margin-top: 10rpx;
		text-align: left;
	}
	.item_img{
		
		height: 50rpx;
		width: 50rpx;
	}
	.text-left{
		text-align: left;
	}
</style>
