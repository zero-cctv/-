<template>
	<view>
		<view v-if="refresh" class="">更新了{{all}}条歌</view>
	<view>
		
		 <view class="setwidth">
			 
		               <scroll-view  scroll-y="true" class="scroll-Y" disable-touch="true">		           
							<view v-for="item in respongs" :key="item.id" >
								 <audio  style="text-align: left" :src="item.url" :poster="item.imgUrl" :name="item.songName" :author="item.singerName" :action="audioAction" controls class="set"></audio>
							
							</view>
		                  	
		           
		                </scroll-view>
		  </view>
		   
	</view></view>
</template>

<script>
	var __self
	export default {
	    data() {
			
	        return {
				all:0,
				string:"歌单",
				data:"",
				refresh:false,
				freshtime:0,
				right:true,
				agree:true,
				i:0,
				musics:{},
				array:[1,2,3,
				,4,5],
				musicsss:{},
				musics2:[],
				respongs:[],
				test2:"",
				test:[],
				}
				},
				onLoad:function(e) {
					__self=this;
					__self.musicread(e);
					
					
			},
			onPullDownRefresh(e) {
			       //监听下拉刷新动作的执行方法，每次手动下拉刷新都会执行一次
				   __self.all=0;
				   __self.refresh=true;
				   __self.freshtime=__self.freshtime+1;
				   __self.musicread(e);			   
			       setTimeout(function () {
			           uni.stopPullDownRefresh();  //停止下拉刷新动画
			       }, 2000);
				   setTimeout(function () {
				       __self.refresh=false;  //停止下拉刷新动画
				   }, 3000);
				      
					  
			   },
		
				methods: {	
					
						musicread:function(e){
							
							if(__self.refresh==false)
							{
							__self.data = JSON.parse(decodeURIComponent(e.categoryid));												
							uni.request({
								url:"http://m.kugou.com/plist/list/"+__self.data+"?json=true",
								method: 'GET',
								data: {},
								success: res => {								
									__self.musics2=res.data.list.list.info;	
								
									var i,z;
									if(__self.musics2.length>10){
										z=10;
									}else{
										z=__self.musics2.length;
									}
									for(i=0;i<z;i++){
										__self.getsong(__self.musics2[i]);
										
									}	
													
												
								},
								fail: () => {
									console.log("this is fail");
								},
							});
							}else{
								var i,z,t;
								i=__self.freshtime*10;
								t=(__self.freshtime+1)*10;
								if(__self.musics2.length>t){
									z=t;
									__self.all=z-i;
									for(i;i<z;i++){
										
										__self.getsong(__self.musics2[i]);											
									}
								}else if(__self.musics2.length>i&&__self.musics2<t)
								{
									
									z=__self.musics2.length;
									__self.all=z-i;
									for(i;i<z;i++){
										__self.getsong(__self.musics2[i]);											
									}
								}															
							}
						},
						show:function(e){
							Console.log(e);
						},
						imgurltry:function(e){
							// uni.request({
							// 	url:e.imgUrl,
							// 	method: 'GET',
							// 	data: {},
							// 	success: res => {	
							// 		if(res.statusCode!=200){__self.right=false;}
							// 		else{__self.right=true;}
							// 	},
							// 	fail: () => {
							// 		console.log("this is fail");
							// 		__self.right=false;
							// 	},
							// 	complete() {								
									
							// 	}
							// });
							
							
						},
						getsong:function(e){
							uni.request({
								url:"http://m.kugou.com/app/i/getSongInfo.php?cmd=playInfo&hash="+e.hash,
								method: 'GET',
								data: {},
								success: res => {							
									__self.musics=res.data;									
									__self.musics.imgUrl="../../static/ico/404.png";																								
									__self.respongs.push(__self.musics);									
								},
								fail: () => {
									console.log("this is fail");
								},
							});
							if(__self.i>=5){
								__self.agree=false;
							}
							__self.i=__self.i+1;
							
						},
																       
							choseitem:function(e){
								uni.navigateTo({
									url: '/pages/music/music_list?categoryid='+encodeURIComponent(JSON.stringify(e))
								});
							},
							
							imageError: function(e) {
							            console.error('image发生error事件，携带值为' + e.detail.errMsg)
							        }
							} 
					
				}
				

</script>

<style>
	
	.setwidth{
		
	}
	.set{
		width: 90%;
	}
	.setTiti{
		display: block;
		
	}
	page , view{
		display: block;
	
	}
	page {
		display: block;
		background-color: #4CD964;
	}
</style>
