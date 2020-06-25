<template>
	<view class="index">
		<view class="grid">
			<view class="grid-c-06" v-for="item in respongs" :key="item.id">
				<view class="panel" >
					<image class="card-img card-list2-img" @click="goDetail(item)" :src="item.cover" :mode="mode"></image>
					
					<view class="card-bottm row">
						<view class="car-title-view row">
							<text class="card-title card-list2-title">{{item.name}}</text>
						</view>
						<view @click="share(item)" class="card-share-view"></view>
					</view>
				</view>
			</view>
		</view>
		<text class="loadMore">加载中...</text>
	</view>
</template>

<script>
	var __self
	export default {
	data() {
			return {
				mode: 'aspectFit',
				login: false,
				avatarUrl: '/static/ico/user.png',
				uerInfo: {},
				respongs:[],
				
			}
		},
		onLoad:function(){
			__self=this,
		
			__self.getData();
			 uni.startPullDownRefresh({
			            success:function(res){
							__self.getData();
			                 
			            }
			        }); 
		},
		onPullDownRefresh() {
		       //监听下拉刷新动作的执行方法，每次手动下拉刷新都会执行一次
		       console.log('refresh');
		       setTimeout(function () {
		           uni.stopPullDownRefresh();  //停止下拉刷新动画
		       }, 1000);
		   },
		methods: {
			getData:function(){
				uni.request({
					url: 'http://service.picasso.adesk.com/v1/vertical/category',
					method: 'GET',
					data: {},
					success: res => {
						__self.respongs=res.data.res.category;
					},
					fail: () => {
						console.log("this is fail");
					},
					complete: () => {}
				});
				
			}
			,
			goDetail:function(e){
				uni.navigateTo({
					url: '/pages/item/item?categoryid='+encodeURIComponent(JSON.stringify(e.id))
				});
			},
			imageError: function(e) {
			            console.error('image发生error事件，携带值为' + e.detail.errMsg)
			        },

			
			share:function(e){
				uni.showModal({
				    title: 'title',
				    content: '确定分享',
				    success: function (res) {
				        if (res.confirm) {
				            console.log('用户点击确定');
				        } else if (res.cancel) {
				            console.log('用户点击取消');
				        }
				    }
				});
			}
		}
		
		
		
		}
</script>

<style>
	page,
	view {
		display: flex;
		
	}
	page {
		display: flex;
		min-height: 100%;
		background-color: #EFEFEF;
	}

	template {
		display: flex;
		flex: 1;
	}	
	
</style>
