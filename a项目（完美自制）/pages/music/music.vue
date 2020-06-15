<template>
<view>
	<view >
	    <view style="text-align: center;">
	        <audio style="text-align: left" :src="current.src" :poster="current.poster" :name="current.name" :author="current.author" :action="audioAction" controls></audio>
	    </view>
		<view style="text-align: center;">
		    <audio style="text-align: left" :src="musics.url" :poster="musics.imgUrl" :name="musics.songName" :author="musics.singerName" :action="audioAction" controls></audio>
		</view>
	</view>
	<view>
		 <view>
		               <scroll-view :scroll-top="scrollTop" scroll-y="true" class="scroll-Y" @scrolltoupper="upper" @scrolltolower="lower"
		                @scroll="scroll">
		                  <view v-for="item in respongs" :key="item.slid">
		                  	<view class="iterm">
		                  		<view><image :src="item.user_avatar" mode="aspectFit" class="iterm_img" :id="item.slid" v-on:click="choseitem(item.specialid)"></image>{{item.specialname}} </view>
		                  	
		                  	</view>
		                  	
		                  </view>
		                </scroll-view>
		  </view>
	</view>
	

</view>
</template>

<script>

		var __self
		export default {
		    data() {
				
		        return {
					scrollTop: 0,
					old: { scrollTop: 0},
					musics:{},
					array:[1,2,3,
					,4,5],
					musicsss:{},
					musics2:{},
					respongs:[],
					test2:"",
					test:[],
		             current: {
		                            poster: 'https://img-cdn-qiniu.dcloud.net.cn/uniapp/audio/music.jpg',
		                            name: '致爱丽丝',
		                            author: '暂无',
		                            src: 'https://img-cdn-qiniu.dcloud.net.cn/uniapp/audio/music.mp3',
		                        },
		              audioAction: {
		                            method: 'pause'
		                        }
					
					}              
		        
		    },
			onLoad:function() {
				__self=this,
			
				__self.music_all();
				
			},
			onPullDownRefresh() {
			       //监听下拉刷新动作的执行方法，每次手动下拉刷新都会执行一次
			       console.log('refresh');
			       setTimeout(function () {
			           uni.stopPullDownRefresh();  //停止下拉刷新动画
			       }, 1000);
			   },
			methods: {
				
			
		
			
					music_all:function(res) {
						uni.request({
							url:"http://m.kugou.com/plist/index&json=true",
							method: 'GET',
							data: {},
							success: res => {
								// console.log(res);
								__self.musicsss=res.data.plist.list;
								__self.respongs=__self.musicsss.info;
								__self.musics2=__self.musicsss.info[0];
							
							},
							fail: () => {
								console.log("this is fail");
							},
						});
						uni.request({
							url:"http://m.kugou.com/plist/list/"+__self.musics2.specialid+"?json=true",
							method: 'GET',
							data: {},
							success: res => {
								// console.log(res);
							},
							fail: () => {
								console.log("this is fail");
							},
						});
						uni.request({
							url:"http://m.kugou.com/app/i/getSongInfo.php?cmd=playInfo&hash=CB7EE97F4CC11C4EA7A1FA4B516A5D97",
							method: 'GET',
							data: {},
							success: res => {
								// console.log(res);
								__self.musics=res.data;
								__self.musics.imgUrl="../../static/ico/music.png";
								// __self.imgurltry();														
							},
							fail: () => {
								console.log("this is fail");
							},
						});
						
					},
			        error(e) {
			            console.log(e.detail);
			        },
					choseitem:function(e){
						uni.navigateTo({
							url: '/pages/music/music_list?categoryid='+encodeURIComponent(JSON.stringify(e))
						});
					},
					imgurltry:function(){
						uni.request({
							url:__self.musics.imgUrl,
							method: 'GET',
							data: {},
							success: res => {
								// console.log(res);	
								if(res.statusCode!=200){__self.musics.imgUrl="../../static/ico/music.png";}																						
							},
							fail: () => {
								console.log("this is a bug");
							},
						});
					},
					imageError: function(e) {
					            console.error('image发生error事件，携带值为' + e.detail.errMsg)
					        }
					} 
			
		}

</script>

<style>
	page,
	view {
		display: block;
	},
	.iterm{
		height: 200rpx;
		margin-bottom: 20rpx;
		margin-top: 20rpx;
		font-size: 30rpx;
		padding-bottom: 10rpx;
		padding-top: 10rpx;
		padding-left: 10rpx;
		background-color: #FFFFFF;
		
	}
	.tex{
		
		text-align: center;
	}
	.iterm_img{
		
		height: 150rpx;
		width: 150rpx;
	}
	
</style>
