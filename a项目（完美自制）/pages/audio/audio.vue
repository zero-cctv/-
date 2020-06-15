<template>
	<view><view  class="uni-input" >
  <input focus placeholder="please into" v-model="intotext" />
  <image class="smallico" src="../../static/ico/search.png" mode="aspectFit"></image>
  </view>
  <view class="displays">
  <button v-for="item in respond" :key="item.songid" @click="chose(item)" class="bsmall"><view class="displays">{{item.songname}}</view></button>
  </view>
  </view>
</template>

<script>
	var __self
	export default {
	data() {
			return {
				respond:[],
				right:true,
				array:{},
				intotext:"输入或者选择下面热门歌名",
				
			}
			
			},
	onLoad:function(){
				__self=this;
				uni.request({
					url:"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.search.catalogSug",
					method: 'GET',
					data: {},
					success: res => {
			 
						if(res.statusCode!=200){__self.right=false;}
						else{__self.right=true;}
						__self.array=res.data.song;
						 
						var i,z;
						z=__self.array.length;
						for(i=0;i<z;i++){
							__self.respond.push(__self.array[i]);
							
						}
						 
						
					},
					fail: () => {
						console.log("this is fail");
						__self.right=false;
					},
				});
				},
	methods: {
		chose:function(e){
			__self.intotext=e.songname;
		}
					}
					
					
					
					}
</script>

<style>
	page ,view{
		display: block;
	}
	.uni-input{
		height: 100rpx;
		font-size: 50rpx;
		color: #808080;
		display: flex;
		background-color: #FFFFFF;
	}
	input{
		height: 100rpx;
		width: 90%;
		
	}
	.bsmall{
		height: 100rpx;	
	}
	.smallico{
		height: 100rpx;
		width: 100rpx;
	}
	.displays{
		
		font-size: 30rpx;
		text-align: left;
		
	}
</style>
