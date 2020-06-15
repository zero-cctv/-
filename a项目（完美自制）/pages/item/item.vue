<template>
	<view display="block" class="center">
		<view  v-for="item in respongs" :key="item.id">
		<view ><image :src="item.wp" class="xxx" mode="aspectFit"></image></view>
		</view> 
	</view>
</template>

<script>
	var __self
	export default {
		data(){
			return{
			mode: 'aspectFit',
			imgpath:"",
			respongs:[],
			autoplay:true,
			interval:10000,
			duration:1000,
			}
		},
		onLoad:function(e){
			__self=this;
			// console.log(e);
			var data = JSON.parse(decodeURIComponent(e.categoryid));
			uni.request({
				url:'http://service.picasso.adesk.com/v1/vertical/category/'+data+'/vertical',
				method:"GET",
				success:res => {
				
					__self.respongs=res.data.res.vertical;
					
				},
				fail: () => {
					console.log("this is fail");
				},
			});
			
			},
		methods: {
				
			}
		}
	
</script>

<style>
	
	.center{
		text-align: center;
	}
	
	.swiper {
		height: 200rpx;
		width: 100%;
	}
	
	.swiper-item {
		height: 200rpx;
		width: 100%;
		background-color: #007AFF;
	}
	
	.content {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}
	
	.logo {
		height: 200rpx;
		width: 200rpx;
		margin-top: 200rpx;
		margin-left: auto;
		margin-right: auto;
		margin-bottom: 50rpx;
	}
	
	.text-area {
		display: inline-block;
		justify-content: center;
		width: 300rpx;
		height: 40rpx;
		background-color: #4CD964
	}
	
	.sv {
		display: flex;
		flex-wrap: nowrap;
		white-space: nowrap;
		width: 100%;
		height: 40rpx;
	
	}
	
	.title {
		font-size: 36rpx;
		color: #8f8f94;
	}
	page , view{
	display: block;
	background-color: #000000;
	}
	.xxx{
		width: 500rpx;
		height: 500rpx;
	}
</style>
