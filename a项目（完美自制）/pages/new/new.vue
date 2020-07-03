<template>
	<view class="container999"  >
		<!-- 刷新组件需搭配scroll-view使用，并在pages.json中添加 "disableScroll":true-->
		<!-- <refresh ref="refresh" @isRefresh='isRefresh'></refresh> -->
		<view class='nav'>
			<!-- #ifdef H5 -->
				<view style="height: 44px;width: 100%;">边距盒子</view>
			<!-- #endif -->
			<!-- 搜索 -->
			<view class='searchInput999'>
				<view class='searchBox999'>
					<image src='/static/icon-search.png' class='search999'></image>
				</view>
				<input class='input999' placeholder="输入关键词"></input>
			</view>
			<!-- 导航栏 agents导航栏标题 -->
			<navTab ref="navTab" :tabTitle="tabTitle" @changeTab='changeTab'></navTab>
		</view>
		<!-- swiper切换 swiper-item表示一页 scroll-view表示滚动视窗 -->
		<swiper style="min-height: 100vh;" :current="currentTab" @change="swiperTab">
			<swiper-item v-for="(listItem,listIndex) in list" :key="listIndex">
				<scroll-view style="height: 100%;" scroll-y="true" @scrolltolower="lower1" scroll-with-animation :scroll-into-view="toView">
				<view :id="'top'+listIndex" style="width: 100%;height: 180upx;">边距盒子</view>
				<view class='content'>
					<view class='card' v-for="(item,index) in listItem" v-if="listItem.length > 0" :key="index">
						<!-- {{item[listname[listIndex][index]]}} -->
						<view v-for="(items,index) in item[listname[listIndex][index]]" :key="index" :style="{width:50+'%',height:40+'%'}">
							
								<image :src="items.realurl" style=" height: 150rpx; width: 150rpx;"></image>
								
						</view>
						
						<!-- {{index}} -->
						<!-- {{item[listname[listIndex][index]][0]['url']}} -->
						<!-- {{listfile[listIndex][index]}} -->
						
						<view style="bottom: 0rpx;position:absolute">
							uid: {{uid}}
						<hr/>
						{{listname[listIndex][index]}}</view>
						
						<!-- {{listIndex}} -->
					</view>
					<!-- <image></image> -->
				</view>
				<view class='noCard' v-if="listItem.length===0">
					暂无信息
				</view>
				<view style="width: 100%;height: 100upx;opacity:0;">底部占位盒子</view>
				</scroll-view>
			</swiper-item>
		</swiper>
		<!-- <tabBar4 :currentPage="currentPage"></tabBar4> -->
	</view>
</template>

<script>
const util = require('../../static/new_js/util/util.js');
// import refresh from '../../components/new_Plus/refresh.vue';
import navTab from '../../components/new_Plus/navTab.vue';
// import tabBar4 from '../../components/new_Plus/tabBar4.vue';
export default {
	// components: {refresh,navTab},
	components:{navTab},
	data() {
		return {
			currentPage:'index',
			toView:'',//回到顶部id
			tabTitle:['图片','视频','选择三','选择四'], //导航栏格式 --导航栏组件
			currentTab: 0, //sweiper所在页
			pages:[1,1,1,1], //第几个swiper的第几页
			uid:'',
			list: [[1,2,3,4,5,6],['a', 'b', 'c', 'd', 'e', 'f'],[],['2233','4234','13144','324244']], //数据格式
			listname:[[1,2,3,4,5,6],['a', 'b', 'c', 'd', 'e', 'f'],[],['2233','4234','13144','324244']],
			listfile:[[1,2,3,4,5,6],['a', 'b', 'c', 'd', 'e', 'f'],[],['2233','4234','13144','324244']]
		};
	},
	onLoad(e) {

	},
	
	beforeMount(){
		 uni.startPullDownRefresh({});
	},
	onShow() {
	
	},
	onHide() {},
	onPullDownRefresh() {
	       //监听下拉刷新动作的执行方法，每次手动下拉刷新都会执行一次
	       console.log('refresh');
		   this.uid=this.$getStorage("uid").toString();
		  var p={'uid':this.uid};
		  var url=this.$api.user.imglist;
		  this.getData(url,'userimg',p)
	       setTimeout(function () {
	           uni.stopPullDownRefresh();  //停止下拉刷新动画
	       }, 500);
	   },
	methods: {
		getData(surl, str,p) {
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
		requestafter(str) {
				  console.log(this.data);
				  console.log(this.list[0]);
				  this.list=[[]];
				  this.listname=[[]];
				  this.listfile=[[]];
				  if(str=='userimg'){
					  if(this.data!=''){
						  this.data=this.data.data;
						  console.log(this.data);
						
						  this.list[this.currentTab]=this.data;
						  for(var time in this.data){
					 
							  
							  for(var temp in this.data[time]){
								  this.listname[this.currentTab].push(temp)
								  this.listfile[this.currentTab].push(this.data[time][temp])
							  }
							 }
							  // for(var temp in this.data[time]){
								 //  this.list[this.currentTab].push(temp);
								 //  console.log(temp);
								 //  console.log(this.data[time][temp]);
							  // }
						  // }
						// for(var time in this.data.data){
						// 	console.log(time);
						// 	console.log(this.data.data[time]);
						// 	for(var item in this.data.data[time]){
						// 		console.log(this.data.data[time][item]);
						// 	}
						// }
					   // console.log("url:=="+this.data.data.icourl)
					  }
				  }
				  console.log(this.list[0]);
				  },
		toTop(){
			this.toView = ''
			setTimeout(()=>{
				this.toView = 'top' + this.currentTab
			},10)
		},
		changeTab(index){
			this.currentTab = index;
		},
		// 其他请求事件 当然刷新和其他请求可以写一起 多一层判断。
		isRequest() {
			return new Promise((resolve, reject) => {
				this.pages[this.currentTab]++
				var that = this
				setTimeout(() => {
					uni.hideLoading()
					uni.showToast({
						icon: 'none',
						// title: `请求第${that.currentTab + 1 }个导航栏的第${that.pages[that.currentTab]}页数据成功`
						title:'加载成功'
					})
					// let newData = ['新数据1','新数据2','新数据3','4546']
					// resolve(newData)
				}, 1000)
				
			})
		},
		// swiper 滑动
		swiperTab: function(e) {
			var index = e.detail.current //获取索引
			this.$refs.navTab.longClick(index);
		},
		// 加载更多 util.throttle为防抖函数
		lower1: util.throttle(function(e) {
		console.log(`加载${this.currentTab}`)//currentTab表示当前所在页数 根据当前所在页数发起请求并带上page页数
		uni.showLoading({
			title: '加载中',
			mask:true
		})
			this.isRequest().then((res)=>{
				let tempList = this.list
				console.log(res)
				tempList[this.currentTab] = tempList[this.currentTab].concat(res)
				console.log(tempList)
				this.list = tempList
				this.$forceUpdate() //二维数组，开启强制渲染
			})
		}, 300),
		// 刷新touch监听
		// refreshStart(e) {
		// 	this.$refs.refresh.refreshStart(e);
		// },
		// refreshMove(e){
		// 	this.$refs.refresh.refreshMove(e);
		// },
		// refreshEnd(e) {
		// 	this.$refs.refresh.refreshEnd(e);
		// },
		// isRefresh(){
		// 		setTimeout(() => {
		// 			uni.showToast({
		// 				icon: 'success',
		// 				title: '刷新成功'
		// 			})
		// 			// this.$refs.refresh.endAfter() //刷新结束调用
		// 		}, 1000)
		// 		return "asaas"
		// }
	}
};
</script>

<style lang="scss">
	.flex{
		display: flex;
	}
		.container999 {
	  width: 100vw;
	  font-size: 28upx;
	  min-height: 100vh;
	  overflow: hidden;
	  color: #6B8082;
	  position: relative;
	  background-color: #f6f6f6;
	}
	.content {
		width: 100%;
	}
	
	.card {
		width: 90%;
		height: 368upx;
		background-color: white;
		margin: 0 auto 42upx auto;
		background: #FFFFFF;
		box-shadow: 0 0 5px 0 rgba(0, 0, 0, 0.10);
		border-radius: 5px;
		position: relative;
	}
	
	.noCard {
		width: 90%;
		height: 200upx;
		margin: auto;
		background-color: white;
		display: flex;
		align-items: center;
		justify-content: center;
		color: #999999;
		box-shadow: 0 0 10upx 0 rgba(0, 0, 0, 0.10);
		border-radius: 10upx;
	}
	
	
	.nav {
		position: fixed;
		left: 0;
		top: 0;
		color: white;
		width: 100%;
		display: flex;
		flex-direction: column;
		align-items: flex-start;
		justify-content: flex-start;
		font-size: 24upx;
		background-color: #2ac644;
		z-index: 996;
	}
	
	.searchInput999 {
		width: 90%;
		margin: 0 auto;
		background: white;
		border-radius: 30upx;
		display: flex;
		align-items: center;
		justify-content: center;
		height: 56upx;
		margin-top: 20upx;
	}
	
	.search999 {
		width: 32upx;
		height: 32upx;
	}
	
	.searchBox999 {
		width: 56upx;
		height: 56upx;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.input999 {
		color: #999;
		width: 80%;
	}
</style>
